local MOVE_INTERVAL =
	tonumber(minetest.settings:get("large_slugs_move_interval")) or 5
local MOVE_CHANCE =
	tonumber(minetest.settings:get("large_slugs_move_chance")) or 5
local BIRTH_INTERVAL =
	tonumber(minetest.settings:get("large_slugs_birth_interval")) or 10
local BIRTH_CHANCE =
	tonumber(minetest.settings:get("large_slugs_birth_chance")) or 10
local BIRTH_SPACE =
	tonumber(minetest.settings:get("large_slugs_birth_space")) or 11

local WALLMOUNT_TO_PERP_WALLMOUNTS = {}
WALLMOUNT_TO_PERP_WALLMOUNTS[0] = {4, 2, 5, 3}
WALLMOUNT_TO_PERP_WALLMOUNTS[2] = {4, 0, 5, 1}
WALLMOUNT_TO_PERP_WALLMOUNTS[4] = {2, 0, 3, 1}
WALLMOUNT_TO_PERP_WALLMOUNTS[1] = WALLMOUNT_TO_PERP_WALLMOUNTS[0]
WALLMOUNT_TO_PERP_WALLMOUNTS[3] = WALLMOUNT_TO_PERP_WALLMOUNTS[2]
WALLMOUNT_TO_PERP_WALLMOUNTS[5] = WALLMOUNT_TO_PERP_WALLMOUNTS[4]

local WALLMOUNT_TO_OPP_WALLMOUNT = {
	[0] = 1, [1] = 0, [2] = 3, [3] = 2, [4] = 5, [5] = 4,
}

local function get_move_options(pos, node, include_here)
	local ground_nodes = large_slugs.registered_slugs[node.name].ground

	local wallmount = node.param2 % 6
	local dir = minetest.wallmounted_to_dir(wallmount)

	local rotate_opts = include_here and {}
	local shift_opts = {}
	local rotate_shift_opts = {}

	local perp_wallmounts = WALLMOUNT_TO_PERP_WALLMOUNTS[wallmount]
	for _, perp_wallmount in ipairs(perp_wallmounts) do
		local perp_dir = minetest.wallmounted_to_dir(perp_wallmount)

		local check_pos = vector.add(pos, perp_dir)
		local check_node = minetest.get_node(check_pos)
		if include_here and ground_nodes[check_node.name] then
			rotate_opts[#rotate_opts + 1] = perp_wallmount
		elseif check_node.name == "air" then
			local shift_pos = check_pos
			check_pos = vector.add(check_pos, dir)
			check_node = minetest.get_node(check_pos)
			if ground_nodes[check_node.name] then
				shift_opts[#shift_opts + 1] = shift_pos
			elseif check_node.name == "air" then
				rotate_shift_opts[#rotate_shift_opts + 1] = {
					WALLMOUNT_TO_OPP_WALLMOUNT[
						perp_wallmount],
					check_pos,
				}
			end
		end
	end

	return rotate_opts, shift_opts, rotate_shift_opts
end

local function move_slug(pos, node)
	local rotate_opts, shift_opts, rotate_shift_opts =
		get_move_options(pos, node, true)

	local n_rotate_opts = #rotate_opts
	local n_shift_opts = #shift_opts
	local n_rotate_shift_opts = #rotate_shift_opts
	local n_opts = n_rotate_opts + n_shift_opts + n_rotate_shift_opts
	if n_opts < 1 then return end
	local choice = math.random(n_opts)
	if choice <= n_rotate_opts then
		local chosen_wallmount = rotate_opts[choice]
		node.param2 = node.param2 - node.param2 % 8 + chosen_wallmount
		minetest.swap_node(pos, node)
	elseif choice <= n_rotate_opts + n_shift_opts then
		local chosen_pos = shift_opts[choice - n_rotate_opts]
		minetest.remove_node(pos)
		minetest.set_node(chosen_pos, node)
	else
		local chosen =
			rotate_shift_opts[choice - n_rotate_opts - n_shift_opts]
		minetest.remove_node(pos)
		node.param2 = node.param2 - node.param2 % 8 + chosen[1]
		minetest.set_node(chosen[2], node)
	end
end

local function birth_slug(pos, node)
	if minetest.find_node_near(pos, BIRTH_SPACE, node.name) then return end

	local _rotate_opts, shift_opts, rotate_shift_opts =
		get_move_options(pos, node, false)

	local n_shift_opts = #shift_opts
	local n_rotate_shift_opts = #rotate_shift_opts
	local n_opts = n_shift_opts + n_rotate_shift_opts
	if n_opts < 1 then return end
	local choice = math.random(n_opts)
	if choice <= n_shift_opts then
		local chosen_pos = shift_opts[choice]
		minetest.set_node(chosen_pos, node)
	else
		local chosen = rotate_shift_opts[choice - n_shift_opts]
		node.param2 = node.param2 - node.param2 % 8 + chosen[1]
		minetest.set_node(chosen[2], node)
	end
end

minetest.register_abm({
	label = "Slugs moving",
	nodenames = "group:large_slug",
	interval = MOVE_INTERVAL,
	chance = MOVE_CHANCE,
	catch_up = false,
	action = move_slug,
})

minetest.register_abm({
	label = "Slugs birthing",
	nodenames = "group:large_slug",
	interval = BIRTH_INTERVAL,
	chance = BIRTH_CHANCE,
	catch_up = false,
	action = birth_slug,
})
