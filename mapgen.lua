print("MAPGEN")

local function noise_params(ratio, seed)
	return {
		offset = 0,
		scale = ratio,
		spread = {x = 32, y = 32, z = 32},
		seed = seed,
		octaves = 1,
		persistence = 1,
		lacunarity = 1,
		flags = "absvalue",
	}
end

minetest.register_decoration({
	name = "large_slugs:grass_slug",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	fill_ratio = 0.01,
	y_max = 200,
	y_min = 0,
	decoration = "large_slugs:grass_slug",
	param2 = 1,
})

minetest.register_decoration({
	name = "large_slugs:pine_slug",
	deco_type = "simple",
	place_on = {"default:dirt_with_coniferous_litter"},
	fill_ratio = 0.01,
	y_max = 250,
	y_min = 0,
	decoration = "large_slugs:pine_slug",
	param2 = 1,
})

minetest.register_decoration({
	name = "large_slugs:rainforest_slug",
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter"},
	fill_ratio = 0.01,
	y_max = 200,
	y_min = 0,
	decoration = "large_slugs:rainforest_slug",
	param2 = 1,
})

minetest.register_decoration({
	name = "large_slugs:cave_slug",
	deco_type = "simple",
	place_on = {"default:stone"},
	fill_ratio = 0.012,
	flags = "all_floors",
	y_max = -32,
	y_min = -31000,
	decoration = "large_slugs:cave_slug",
	param2 = 1,
})

minetest.register_decoration({
	name = "large_slugs:iron_slug",
	deco_type = "simple",
	place_on = {"default:stone"},
	fill_ratio = 0.005,
	flags = "all_floors",
	y_max = -128,
	y_min = -31000,
	decoration = "large_slugs:iron_slug",
	param2 = 1,
})

minetest.register_decoration({
	name = "large_slugs:mese_slug",
	deco_type = "simple",
	place_on = {"default:stone"},
	fill_ratio = 0.001,
	flags = "all_floors",
	y_max = -512,
	y_min = -31000,
	decoration = "large_slugs:mese_slug",
	param2 = 1,
})
