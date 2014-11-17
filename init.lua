
-- to make life a bit easier
bild_pfad          = "default_wood.png"; --"forniture_wood.png";
bild_pfad_s1       = "default_wood.png"; --"forniture_wood_s1.png";
bild_pfad_s2       = "default_wood.png"; --"forniture_wood_s2.png";

leg_front_left     = {-0.5,-0.5,-0.5, -0.4,0.5,-0.4};
leg_front_right    = { 0.4,-0.5,-0.5,  0.5,0.5,-0.4};
leg_back_left      = {-0.5,-0.5, 0.4, -0.4,0.5, 0.5}; 
leg_back_right     = { 0.4,-0.5, 0.4,  0.5,0.5, 0.5}; 

bar_left           = {-0.5, 0.35,-0.4,-0.4, 0.4, 0.4}; 
bar_right          = { 0.4, 0.35,-0.4, 0.5, 0.4, 0.4};
bar_back           = { 0.4, 0.35, 0.4,-0.5, 0.4, 0.5};
bar_front          = { 0.5, 0.35,-0.5,-0.5, 0.4,-0.4};

bar_left_long      = {-0.4, 0.35,-0.5,-0.5, 0.4, 0.5}; 
bar_right_long     = { 0.4, 0.35,-0.5, 0.5, 0.4, 0.5};
bar_front_long     = { 0.5, 0.35,-0.5,-0.5, 0.4,-0.4};

groundplate_small  = {-0.4,-0.45,-0.5,  0.4,-0.4,0.5};
groundplate_corner = {-0.5,-0.45,-0.5,  0.5,-0.4,0.5}; -- slightly larger

local STICK = "default:stick";
local WOOD  = "stairs:slab_wood";
local BASIS = "bridges:bridge_basis";
local RAIL  = "bridges:handrail_middle";
-- people who do not have vines have to replace "vines:vines" with something they do have and which they think might fit
local VINES = "vines:vines"; -- useful for ropes
local ALT   = "default:leaves"; -- alternative for vines

local MAX_BRIDGE_LENGTH = 27; -- this is how far the automatic bridge can extend

local BRIDGE_PARTS = {
	-- name, description, node definition, crafting receipe, yield 

	-- the groundplate - essential for bridge building - yields 2 groundplates
	{ "bridge_basis", "groundplate of a bridge",
		{ groundplate_small, },
		{ { VINES, VINES, VINES },{ VINES, WOOD, VINES },{ VINES, VINES, VINES } },
		" 2",
	}, 

        -- the handrail - from which bridges and handrails for staircases can be constructed
	-- one groundplate yiels 4 handrails
	{ "handrail_middle", "handrail for bridges and staircases",
		{ bar_front },
		{ { "", "", "" },{ "", BASIS, "" },{ "", "", "" } },
		" 4",
	},
 
        -- bridges
 	{ "bridge_small", "small bridge",
		{ leg_front_left, leg_front_right, leg_back_left, leg_back_right, bar_right, bar_left, groundplate_small, },
		{ { STICK, "", STICK },{ RAIL, BASIS, RAIL }, { STICK, "", STICK } },
		"" },

	{ "bridge_middle", "middle of a bridge",
		{ bar_right_long, bar_left_long, groundplate_small, },
		{ { "", "", "" },{ RAIL, BASIS, RAIL },{ "", "", "" } },
		"",
	},

	{ "bridge_corner", "corner of a bridge",
		{ leg_front_left, leg_front_right, leg_back_left, leg_back_right, bar_right, bar_back, groundplate_corner, },
		{ { STICK, RAIL,  STICK },{ "",    BASIS, RAIL  },{ STICK, "",    STICK } },
		""
	},

	{ "bridge_t",  "T junction of a bridge",
		{ leg_front_left, leg_front_right, leg_back_left, leg_back_right, bar_back, groundplate_corner, },
		{ { STICK, RAIL,  STICK },{ "",    BASIS, ""    },{ STICK, "",    STICK } },
		"",
	},

	{ "bridge_end", "end of a bridge",
		{ leg_front_left, leg_front_right, leg_back_left, leg_back_right, bar_left, bar_right, bar_back, groundplate_corner, },
		{ { STICK, RAIL, STICK },{ RAIL, BASIS, RAIL },{ STICK, "", STICK } },
		"", 
	},

	-- handrails for the top of starcaises so that people won't fall down
	{ "handrail_post","single post for handrails",
		{ leg_front_left, },
		{ { "", "", "" },{ STICK, "", "" },{ STICK, "", "" } },
		"",
	},

	{ "handrail_runner_lh","running handrail, single rail with one post on left",
		{ leg_front_left, bar_front_long, },
		{ { "", "", "" },{ "", "", "" },{ STICK, RAIL, "" } },
		"",
	},

	{ "handrail_runner_rh","running handrail, single rail with one post on right",
		{ leg_front_right, bar_front_long, },
		{ { "", "", "" },{ "", "", "" },{ "", RAIL, STICK } },
		"",
	},

	{ "handrail_top", "handrail for staircases, one side closed",
		{ leg_front_left, leg_front_right, bar_front, },
		{ { "", "", "" },{ "", "", "" },{ STICK, RAIL, STICK } },
		"",
	},

	{ "handrail_corner", "handrail for staircases, single post with two rails",
		{ leg_front_left, bar_front_long, bar_left_long },
		{ { "", "", "" },{ RAIL, "", "" },{ STICK, RAIL, "" } },
		"",
	},

	{ "handrail_corner1", "handrail for staircases, two posts with two rails",
		{ leg_front_left, leg_front_right, bar_front, bar_left_long },
		{ { "", "", "" },{ RAIL, "", "" },{ STICK, RAIL, STICK } },
		"",
	},

	{ "handrail_corner2", "handrail for staircases, three posts with two rails",
		{ leg_front_left, leg_front_right, leg_back_left, bar_front, bar_left },
		{ { STICK, "", "" }, { RAIL, "", "" },{ STICK, RAIL, STICK } },
		"",
	},

	{ "handrail_closed", "handrail for staircases, three sides closed",
		{ leg_front_left, leg_front_right, bar_front, bar_right, bar_left },
		{ { STICK, RAIL, STICK },{ RAIL, "", "" },{ STICK, RAIL, STICK } },
		"",
	},
}

for i in ipairs( BRIDGE_PARTS ) do
	minetest.register_node("bridges:"..BRIDGE_PARTS[i][1], { 
		description = BRIDGE_PARTS[i][2],
		tiles = {
			bild_pfad, bild_pfad, bild_pfad_s1, bild_pfad_s1, bild_pfad_s2, bild_pfad_s2,
		},
		drawtype = "nodebox",
		sunlight_propagates = true,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = BRIDGE_PARTS[i][3],
		},
		-- flammable so that it can be burned if no longer needed
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	})

	minetest.register_craft({
		output = "bridges:"..BRIDGE_PARTS[i][1]..BRIDGE_PARTS[i][5],
		recipe = BRIDGE_PARTS[i][4],
	})
end

-- alternate receipe for the bridge basis
minetest.register_craft({
	output = "bridges:bridge_basis 2",
	recipe = { 
		{ ALT, ALT, ALT },{ ALT, WOOD, ALT },{ ALT, ALT, ALT },
	}, 
})

-- a bridge which covers 3 nodes in size
minetest.register_node("bridges:bridge_large",
	{ description = 'large bridge',
	tiles = {
		bild_pfad, bild_pfad, bild_pfad_s1, bild_pfad_s1, bild_pfad_s2, bild_pfad_s2,
	},
	drawtype = "nodebox",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			-- the large bridge covers 3 nodes
			{-0.5,-0.5,-0.7, -0.4,0.5,-0.6},
			{ 0.4,-0.5,-0.7,  0.5,0.5,-0.6},
			{-0.5, 0.35,-1.5, -0.4,0.4, 1.5},
			{-0.5,-0.5, 0.6, -0.4,0.5, 0.7},
			{ 0.4,-0.5, 0.6,  0.5,0.5, 0.7},
			{ 0.4, 0.35,-1.5,  0.5,0.4, 1.5},
			{-0.4,-0.45,-1.5,  0.4,-0.4,1.5},
		},
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=2}
})

minetest.register_craft({
	output = "bridges:bridge_large",
	recipe = {
		{ "", "bridges:bridge_middle", "" },
		{ "", "bridges:bridge_small",  "" },
		{ "", "bridges:bridge_middle", "" },
	}
})

-- special: self-building automatic bridge

minetest.register_node("bridges:bridge_auto", {
	description = "self building bruidge",
	tiles = { "default_chest_top.png" },	-- looks from all sides like the top of a chest
	drawtype = "cube",
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	drop = "",	-- all leftover parts are in the "chest"
	on_construct = function(pos)
		local meta = minetest.env:get_meta(pos);
		meta:set_string("formspec",
			"invsize[8,9;]"..
			"list[current_name;main;0,0;8,4;]"..
			"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Automatic bridge building set - leftover parts")
		local inv = meta:get_inventory();
		inv:set_size("main", 8*4);
	end,
	can_dig = function(pos,player)
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory();
		return inv:is_empty("main");
	end,
	after_place_node = function(pos, placer)
		local n;
		local x_dir;
		local z_dir;
		local p;
		local n;

		-- the bridge ought to unfold in the direction the player is looking
		local dir = placer:get_look_dir();
		local fdir = minetest.dir_to_facedir(dir);

		-- the player is looking more in x- than in z-direction
		if( math.abs( dir.x ) > math.abs( dir.z )) then
			z_dir = 0;
			if( dir.x > 0 ) then
				x_dir = 1;
			else
				x_dir = -1;
			end
		else
			x_dir = 0;

			if( dir.z > 0 ) then
				z_dir = 1;
			else
				z_dir = -1;
			end
		end
 
		-- print ("x_dir: "..tostring( x_dir ).." z_dir: "..tostring( z_dir ));

		-- we have determined the direction in which the bridge may extend - now lets look how far it can go
		local i=1;

		-- how many parts of the bridge remain?
		local rem_small  = math.floor(MAX_BRIDGE_LENGTH/3);  
		local rem_middle = MAX_BRIDGE_LENGTH-rem_small;

		-- extend max. MAX_BRIDGE_LENGTH nodes wide and only if the node needs a bridge (i.e. consists of air)
		while( i < MAX_BRIDGE_LENGTH ) do 

			-- is there space for a bridge?
			p = {x=pos.x+(x_dir*i), y=pos.y, z=pos.z+(z_dir*i)};
			n = minetest.env:get_node(p);
			if( n == nil or n.name ~= "air" ) then
				i = MAX_BRIDGE_LENGTH+1; -- end
				-- print("At length "..tostring(i)..": node at target position not air; no place for bridge: "..tostring(n.name));
			else
				-- one small bridge is followed by two middle parts
				if( i%3 == 1 ) then
					minetest.env:add_node(p, {name="bridges:bridge_small", param1=0, param2=fdir});
					rem_small  = rem_small - 1; -- one small bridge used
					-- print("Placing small bridge at dist "..tostring(i));
				else
					minetest.env:add_node(p, {name="bridges:bridge_middle", param1=0, param2=fdir});
					rem_middle = rem_middle -1; -- one middle part used
					-- print("Placing middle bridge at dist "..tostring(i));
				end

			i = i+1;
			end
		end

		-- do we have to give any leftover parts back?
		local meta = minetest.env:get_meta(pos);
		local inv = meta:get_inventory();
		if( rem_small > 0 ) then
			inv:add_item( "main", "bridges:bridge_small "..tostring( rem_small ));
		end
		if( rem_middle > 0 ) then
			inv:add_item( "main", "bridges:bridge_middle "..tostring( rem_middle ));
		end
	end,
})

minetest.register_craft({
	output = "bridges:bridge_auto",
	recipe = { 
		{ "bridges:bridge_large", "bridges:bridge_large", "bridges:bridge_large" },
		{ "bridges:bridge_large", "bridges:bridge_large", "bridges:bridge_large" },
		{ "bridges:bridge_large", "bridges:bridge_large", "bridges:bridge_large" },
	} 
})
