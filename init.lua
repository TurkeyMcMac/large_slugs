local modpath = minetest.get_modpath(minetest.get_current_modname())

dofile(modpath.."/api.lua")

if minetest.settings:get_bool("large_slugs_do_behavior", true) then
	dofile(modpath.."/behavior.lua")
end

dofile(modpath.."/slugs.lua")

dofile(modpath.."/mapgen.lua")
