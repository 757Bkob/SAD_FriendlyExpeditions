return PlaceObj('ModDef', {
	'title', "Expeditions can find friends!",
	'description', '[h1]This mod allows survivors the ability to tame animals when on an expedition.[/h1]\n[i]This mod is the closest to the vanilla game as posssible[/i]\n\n[h2][b]This mod adds one permanent expedition, called the Idyllic Field![/b][/h2]\n[h2]It also adds new event chains to the "Hunting ground", "Shrieking noises", and "Loud bang" expeditions.[/h2]\n\nAll of the events in this mod will have the player gain a base game tame-able unit.\nAnd can allow players to receive tames from a region they are not building on!\n(For all you pokedex gotcha catch em all players)\n\nThe animal will spawn as close to the expedition balloon that the colonist left on, but you may find that actual location may be farther away if your buildings are too close.\n[i]Please bear that in mind when choosing where to place your Balloons![/i]\n\nIf an expedition has been edited by this mod, you will see it in the expedition title!\n\nI understand it is not super realistic that a Juno will sit in the very small basket of a hot air balloon for hours to come back to a new life.... but hopefully we can just set that aside for immersion/fun purposes.',
	'image', "Mod/Uqo4QkN/pics or it didn't happen/sample expedition.JPG",
	'last_changes', "1.0 The mod\n<em>SPOILERS BELOW</em>\nRead on if you wish to know the details\n\nHunting ground Expedition:\n- Predator found event now has options to try and tame it. \n- Negative result has a higher change with a low farming skill\n- Can receive a Juno, Shrieker Mother, or Scissorhands Brute\n\nShrieker Expedition:\n- New option to try and tame the shrieker\n- High chance of negative results if combat or farming skill level is low\n- Can receive a baby Shrieker, or Shrieker Mother\n\nLoud Bang:\n- New vignette with stunned animals scattered around\n- High farming lowers negative results.\n- Can receive a Camel, Draka, Shogu, Juno, Ulfen, or Gujo\n\nGrazing Field:\n- Once found, is a permanent expedition\n- Can be found via exploration\n-- It has the same discover chance as the rock formation site\n- Animals can be hunted (High combat lowers risk)\n- Animals can be tamed (High farming lowers risk)\n- Can receive Camels, Shogu, Tecatli, or Gujo \n-- Camels, Shogu, & Tecatli can only be found if you are not on Desertum/Saltu",
	'dependencies', {
		PlaceObj('ModDependency', {
			'id', "sad_commonlib",
			'title', "SAD_CommonLib",
			'version_major', 1,
			'version_minor', 12,
		}),
	},
	'id', "Uqo4QkN",
	'author', "Ark Builder",
	'version_major', 1,
	'version', 10,
	'lua_revision', 233360,
	'saved_with_revision', 373414,
	'code', {
		"Code/ExpeditionEnhancements.lua",
	},
	'has_data', true,
	'saved', 1768061775,
	'code_hash', -1011890456974175294,
	'steam_id', "3643615905",
	'TagActivities', true,
	'TagAnimals', true,
})