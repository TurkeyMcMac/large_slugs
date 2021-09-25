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

large_slugs.register_slug("large_slugs:grass_slug", {
	description = S("Grass Slug"),
	texture = "large_slugs_slug.png^[multiply:#696533",
	ground = {
		["default:dirt"] = true,
		["default:dirt_with_grass"] = true,
	},
})

minetest.override_item("large_slugs:grass_slug", {
	on_use = minetest.item_eat(1),
})

large_slugs.register_slug("large_slugs:pine_slug", {
	description = S("Pine Slug"),
	texture = "large_slugs_slug.png^[multiply:#444220",
	ground = {
		["default:dirt"] = true,
		["default:dirt_with_coniferous_litter"] = true,
		["default:pine_tree"] = true,
	},
})

minetest.override_item("large_slugs:pine_slug", {
	on_use = minetest.item_eat(1),
})

large_slugs.register_slug("large_slugs:rainforest_slug", {
	description = S("Rainforest Slug"),
	texture = "large_slugs_slug.png^[multiply:#B5AC44",
	ground = {
		["default:dirt"] = true,
		["default:dirt_with_rainforest_litter"] = true,
		["default:jungletree"] = true,
	},
})

minetest.override_item("large_slugs:rainforest_slug", {
	on_use = minetest.item_eat(2),
})

large_slugs.register_slug("large_slugs:cave_slug", {
	description = S("Cave Slug"),
	texture = "large_slugs_slug.png^[multiply:#555343",
	ground = {
		["default:stone"] = true,
		["default:cobble"] = true,
		["default:mossycobble"] = true,
		["default:stone_with_coal"] = true,
	},
})

minetest.override_item("large_slugs:cave_slug", {
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	type = "shapeless",
	output = "default:coal_lump",
	recipe = {
		"large_slugs:cave_slug",
		"large_slugs:cave_slug",
	},
})

large_slugs.register_slug("large_slugs:iron_slug", {
	description = S("Iron Slug"),
	texture = "large_slugs_slug.png^[multiply:#A0661E",
	ground = {
		["default:stone"] = true,
		["default:cobble"] = true,
		["default:mossycobble"] = true,
		["default:stone_with_iron"] = true,
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

large_slugs.register_slug("large_slugs:mese_slug", {
	description = S("Mese Slug"),
	texture = "large_slugs_slug.png^[multiply:#FFEB00",
	ground = {
		["default:stone"] = true,
		["default:cobble"] = true,
		["default:mossycobble"] = true,
		["default:stone_with_mese"] = true,
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
