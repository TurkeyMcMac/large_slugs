large_slugs.registered_slugs = {}

function large_slugs.register_slug(name, def)
	minetest.register_node(name, {
		description = def.description,
		drawtype = "signlike",
		tiles = {def.texture},
		inventory_image = def.texture,
		selection_box = {
			type = "wallmounted",
			wall_top = {-8/16, 8/16, -8/16, 8/16, 7/16, 8/16},
			wall_bottom = {-8/16, -8/16, -8/16, 8/16, -7/16, 8/16},
			wall_side = {-8/16, -8/16, -8/16, -7/16, 8/16, 8/16},
		},
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "wallmounted",
		groups = {large_slug = 1, dig_immediate = 3, attached_node = 1},
		walkable = false,
		floodable = true,
	})
	large_slugs.registered_slugs[name] = def
end
