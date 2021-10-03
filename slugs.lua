--[[
   Copyright (C) 2021  Jude Melton-Houghton

   This file is part of large_slugs. It registers slug nodes/species.

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

local S = minetest.get_translator("large_slugs")

-- Colors

local GRASS_SLUG_COLOR = "#696533"

local PINE_SLUG_COLOR = "#444220"

local RAINFOREST_SLUG_COLOR = "#B5AC44"

local CAVE_SLUG_COLOR = "#555343"

local IRON_SLUG_COLOR = "#A0661E"

local MESE_SLUG_COLOR = "#FFEB00"

-- Slugs

large_slugs.register_slug("large_slugs:grass_slug", {
	description = S("Grass Slug"),
	texture = "large_slugs_slug.png^[multiply:" .. GRASS_SLUG_COLOR,
	ground = {
		["default:dirt"] = true,
		["default:dirt_with_grass"] = true,
	},
})

large_slugs.register_slug("large_slugs:pine_slug", {
	description = S("Pine Slug"),
	texture = "large_slugs_slug.png^[multiply:" .. PINE_SLUG_COLOR,
	ground = {
		["default:dirt"] = true,
		["default:dirt_with_coniferous_litter"] = true,
		["default:pine_tree"] = true,
	},
})

large_slugs.register_slug("large_slugs:rainforest_slug", {
	description = S("Rainforest Slug"),
	texture = "large_slugs_slug.png^[multiply:" .. RAINFOREST_SLUG_COLOR,
	ground = {
		["default:dirt"] = true,
		["default:dirt_with_rainforest_litter"] = true,
		["default:jungletree"] = true,
	},
})

large_slugs.register_slug("large_slugs:cave_slug", {
	description = S("Cave Slug"),
	texture = "large_slugs_slug.png^[multiply:" .. CAVE_SLUG_COLOR,
	ground = {
		["default:stone"] = true,
		["default:cobble"] = true,
		["default:mossycobble"] = true,
		["default:stone_with_coal"] = true,
	},
})

large_slugs.register_slug("large_slugs:iron_slug", {
	description = S("Iron Slug"),
	texture = "large_slugs_slug.png^[multiply:" .. IRON_SLUG_COLOR,
	ground = {
		["default:stone"] = true,
		["default:cobble"] = true,
		["default:mossycobble"] = true,
		["default:stone_with_iron"] = true,
	},
})

large_slugs.register_slug("large_slugs:mese_slug", {
	description = S("Mese Slug"),
	texture = "large_slugs_slug.png^[multiply:" .. MESE_SLUG_COLOR,
	ground = {
		["default:stone"] = true,
		["default:cobble"] = true,
		["default:mossycobble"] = true,
		["default:stone_with_mese"] = true,
	},
})

-- Dishes

minetest.register_craftitem("large_slugs:cooked_grass_slug", {
	description = S("Cooked Grass Slug"),
	inventory_image =
		"large_slugs_cooked_slug.png^[multiply:" .. GRASS_SLUG_COLOR,
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("large_slugs:cooked_pine_slug", {
	description = S("Cooked Pine Slug"),
	inventory_image =
		"large_slugs_cooked_slug.png^[multiply:" .. PINE_SLUG_COLOR,
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("large_slugs:cooked_rainforest_slug", {
	description = S("Cooked Rainforest Slug"),
	inventory_image = "large_slugs_cooked_slug.png^[multiply:" ..
		RAINFOREST_SLUG_COLOR,
	on_use = minetest.item_eat(3),
})

minetest.register_craftitem("large_slugs:cooked_cave_slug", {
	description = S("Cooked Cave Slug"),
	inventory_image =
		"large_slugs_cooked_slug.png^[multiply:" .. CAVE_SLUG_COLOR,
	on_use = minetest.item_eat(3),
})

-- Dish Preparation

minetest.register_craft({
	type = "cooking",
	output = "large_slugs:cooked_grass_slug",
	recipe = "large_slugs:grass_slug",
	cooktime = 3,
})

minetest.register_craft({
	type = "cooking",
	output = "large_slugs:cooked_pine_slug",
	recipe = "large_slugs:pine_slug",
	cooktime = 4,
})

minetest.register_craft({
	type = "cooking",
	output = "large_slugs:cooked_rainforest_slug",
	recipe = "large_slugs:rainforest_slug",
	cooktime = 4,
})

minetest.register_craft({
	type = "cooking",
	output = "large_slugs:cooked_cave_slug",
	recipe = "large_slugs:cave_slug",
	cooktime = 5,
})

-- Resource Extraction

minetest.register_craft({
	type = "shapeless",
	output = "default:coal_lump",
	recipe = {
		"large_slugs:cave_slug",
		"large_slugs:cave_slug",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:iron_lump",
	recipe = {
		"large_slugs:iron_slug",
		"large_slugs:iron_slug",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "default:mese_crystal_fragment",
	recipe = {
		"large_slugs:mese_slug",
		"large_slugs:mese_slug",
		"large_slugs:mese_slug",
	},
})
