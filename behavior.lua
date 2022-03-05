--[[
   Copyright (C) 2021  Jude Melton-Houghton

   This file is part of large_slugs. It implements slug behavior.

   large_slugs is free software: you can redistribute it and/or modify it
   under the terms of the GNU Lesser General Public License as published
   by the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   large_slugs is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public License
   along with large_slugs. If not, see <https://www.gnu.org/licenses/>.
]]

local UPDATE_INTERVAL =
	tonumber(minetest.settings:get("large_slugs_update_interval")) or 5
local UPDATE_CHANCE =
	tonumber(minetest.settings:get("large_slugs_update_chance")) or 5
local BIRTH_CHANCE =
	tonumber(minetest.settings:get("large_slugs_birth_chance")) or 6
local DEATH_CHANCE =
	tonumber(minetest.settings:get("large_slugs_death_chance")) or 6
local UNDERPOPULATION =
	tonumber(minetest.settings:get("large_slugs_underpopulation")) or 1
local OVERPOPULATION =
	tonumber(minetest.settings:get("large_slugs_overpopulation")) or 3
local CHECK_RADIUS =
	tonumber(minetest.settings:get("large_slugs_check_radius")) or 5

-- With the given vectors, computes a = b + c.
local function set_add(a, b, c)
	a.x = b.x + c.x
	a.y = b.y + c.y
	a.z = b.z + c.z
end

-- A map of wallmounted directions to their perpendicular directions.
local WALLMOUNT_TO_PERP_WALLMOUNTS = {}
WALLMOUNT_TO_PERP_WALLMOUNTS[0] = {4, 2, 5, 3}
WALLMOUNT_TO_PERP_WALLMOUNTS[2] = {4, 0, 5, 1}
WALLMOUNT_TO_PERP_WALLMOUNTS[4] = {2, 0, 3, 1}
WALLMOUNT_TO_PERP_WALLMOUNTS[1] = WALLMOUNT_TO_PERP_WALLMOUNTS[0]
WALLMOUNT_TO_PERP_WALLMOUNTS[3] = WALLMOUNT_TO_PERP_WALLMOUNTS[2]
WALLMOUNT_TO_PERP_WALLMOUNTS[5] = WALLMOUNT_TO_PERP_WALLMOUNTS[4]

-- A map of wallmounted directions to their opposites.
local WALLMOUNT_TO_OPP_WALLMOUNT = {
	[0] = 1, [1] = 0, [2] = 3, [3] = 2, [4] = 5, [5] = 4,
}

-- The numbers added to movement added wallmounted values to identify the type
-- of movement:
-- 1. Shifting to an adjacent node without rotation.
-- 2. Rotating to attach to a different node around the same position.
-- 3. Rotating around the node to which the slug is attached.
local SHIFT = 32
local ROTATE = 64
local SHIFT_ROTATE = 96

-- Update a slug, having it randomly try to move, give birth, or die.
local function update_slug(pos)
	local node = minetest.get_node(pos)
	local def = large_slugs.registered_slugs[node.name]
	if not def then return end

	local try_death = math.random(DEATH_CHANCE) == 1
	local try_birth = math.random(BIRTH_CHANCE) == 1
	local area_count = (try_death or try_birth) and
		#minetest.find_nodes_in_area(
			vector.subtract(pos, CHECK_RADIUS),
			vector.add(pos, CHECK_RADIUS), node.name)

	if try_death and area_count >= OVERPOPULATION then
		minetest.remove_node(pos)
		return
	end

	local old_wallmount = node.param2
	local old_dir = minetest.wallmounted_to_dir(old_wallmount)
	if not old_dir then return end

	-- Used in multiple places.
	local check_pos = vector.new(0, 0, 0)

	-- Check that the slug can move on its current surface:
	set_add(check_pos, pos, old_dir)
	local node_under = minetest.get_node(check_pos)
	if not def.ground[node_under.name] then return end

	-- Determine whether this action is a move or a birth:
	local move = not try_birth or area_count > UNDERPOPULATION

	-- Scan for options, looking in directions perpendicular to the current
	-- wallmounted direction of the node.
	local opts = {}
	local n_opts = 0
	local perp_wallmounts = WALLMOUNT_TO_PERP_WALLMOUNTS[old_wallmount]
	for _, perp_wallmount in ipairs(perp_wallmounts) do
		set_add(check_pos,
			pos, minetest.wallmounted_to_dir(perp_wallmount))
		local check_node = minetest.get_node(check_pos)
		if move and def.ground[check_node.name] then
			n_opts = n_opts + 1
			opts[n_opts] = perp_wallmount + ROTATE
		elseif check_node.name == "air" then
			set_add(check_pos, check_pos, old_dir)
			check_node = minetest.get_node(check_pos)
			if def.ground[check_node.name] then
				n_opts = n_opts + 1
				opts[n_opts] = perp_wallmount + SHIFT
			elseif check_node.name == "air" then
				n_opts = n_opts + 1
				opts[n_opts] = perp_wallmount + SHIFT_ROTATE
			end
		end
	end

	if n_opts < 1 then return end

	-- Choose one of the options and move in the way it specifies.
	local chosen = opts[math.random(n_opts)]
	local new_wallmount = chosen % 8
	local chosen_type = chosen - new_wallmount
	if chosen_type == SHIFT then
		if move then minetest.remove_node(pos) end
		set_add(pos, pos, minetest.wallmounted_to_dir(new_wallmount))
		minetest.set_node(pos, node)
	elseif chosen_type == ROTATE then
		node.param2 = new_wallmount
		minetest.swap_node(pos, node)
	else -- SHIFT_ROTATE
		if move then minetest.remove_node(pos) end
		set_add(pos, pos, minetest.wallmounted_to_dir(new_wallmount))
		set_add(pos, pos, old_dir)
		node.param2 = WALLMOUNT_TO_OPP_WALLMOUNT[new_wallmount]
		minetest.set_node(pos, node)
	end
end

-- Maximum number of seconds a slug update can be delayed.
local MAX_DELAY = math.max(0, math.floor(UPDATE_INTERVAL) - 1)

minetest.register_abm({
	label = "Scheduling slug updates",
	nodenames = "group:large_slug",
	interval = UPDATE_INTERVAL,
	chance = UPDATE_CHANCE,
	catch_up = false,
	action = function(pos)
		minetest.after(math.random(0, MAX_DELAY), update_slug, pos)
	end,
})
