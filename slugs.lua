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

large_slugs.register_slug("large_slugs:grass_slug", {
	description = "Grass Slug",
	texture = "large_slugs_slug.png^[multiply:#696533",
	ground = {
		["default:dirt"] = true,
		["default:dirt_with_grass"] = true,
	},
})

large_slugs.register_slug("large_slugs:pine_slug", {
	description = "Pine Slug",
	texture = "large_slugs_slug.png^[multiply:#444220",
	ground = {
		["default:dirt"] = true,
		["default:dirt_with_coniferous_litter"] = true,
		["default:pine_tree"] = true,
	},
})

large_slugs.register_slug("large_slugs:rainforest_slug", {
	description = "Rainforest Slug",
	texture = "large_slugs_slug.png^[multiply:#B5AC44",
	ground = {
		["default:dirt"] = true,
		["default:dirt_with_rainforest_litter"] = true,
		["default:jungletree"] = true,
	},
})

large_slugs.register_slug("large_slugs:cave_slug", {
	description = "Cave Slug",
	texture = "large_slugs_slug.png^[multiply:#555343",
	ground = {
		["default:stone"] = true,
		["default:cobble"] = true,
		["default:mossycobble"] = true,
		["default:stone_with_coal"] = true,
	},
})

large_slugs.register_slug("large_slugs:iron_slug", {
	description = "Iron Slug",
	texture = "large_slugs_slug.png^[multiply:#A0661E",
	ground = {
		["default:stone"] = true,
		["default:cobble"] = true,
		["default:mossycobble"] = true,
		["default:stone_with_iron"] = true,
	},
})

large_slugs.register_slug("large_slugs:mese_slug", {
	description = "Mese Slug",
	texture = "large_slugs_slug.png^[multiply:#FFEB00",
	ground = {
		["default:stone"] = true,
		["default:cobble"] = true,
		["default:mossycobble"] = true,
		["default:stone_with_mese"] = true,
	},
})
