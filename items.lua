return {
PlaceObj('ModItemCode', {
	'name', "ExpeditionEnhancements",
	'CodeFileName', "Code/ExpeditionEnhancements.lua",
}),
PlaceObj('ModItemAnimalSpawnDef', {
	FindSpawnLoc = function (self, spawn_class, target, context)
		local def = class and g_Classes[spawn_class]
		if not def then return end
		local pfclass = def.pfclass
		local pos = terrain.FindPassableTile(self.location, const.tfpPassClass, pfclass)
		local radius = self.location:GetRadius()
		local og_radius = radius
		local x,y
		local retry = 5
		local valid_spot
		local playbox = GetPlayBox()
		while retry > 0 and not valid_spot do
			retry = retry - 1
			if not x or not y then
				radius = radius * 2
				local to_print = DivRound(radius,guim)
				print("Increased spawn radius too "..to_print.." meters")
				--GetRandomPlayablePos(start_pos, max_radius, min_radius, seed, pfclass, unit_radius, filter)
				local x, y = GetRandomPlayablePos(pos, radius, guim, self.location:Random(), pfclass)
				if x then
					print("Found maybe point")
					local temp_pos = point(x,y)
					local playbox_check = playbox:Dist2(temp_pos) > 1
					print(playbox_check)
					local under_nest = IsCloser2D(pos, temp_pos, og_radius)
					print(under_nest)
					if playbox_check or under_nest then
						x = nil
					else
						return point(x,y)
					end
				end
			end
		end
	end,
	SpawnClass = "Skarabei",
	id = "spawn_nearby",
	save_in = "Mod/Uqo4QkN",
}),
PlaceObj('ModItemExpeditionPreset', {
	DisableList = {
		PlaceObj('Explanation', {
			'Text', T(644162164523, --[[ModItemExpeditionPreset HuntingGrounds Text]] "Select someone with Combat skill above 0!"),
			'ObjIsKindOf', "Human",
			'Conditions', {
				PlaceObj('CheckSkillLevel', {
					Skill = "Combat",
				}),
			},
		}),
		PlaceObj('Explanation', {
			'Text', T(447199576875, --[[ModItemExpeditionPreset HuntingGrounds Text]] "The ground is frozen and no animals come to graze."),
			'Conditions', {
				PlaceObj('CheckSeason', {
					Season = set( "Winter" ),
				}),
			},
		}),
		PlaceObj('Explanation', {
			'Text', T(798742557866, --[[ModItemExpeditionPreset HuntingGrounds Text]] "A pack of predators has been killing the herbivores. They are scared to visit the pasture for a while."),
			'Conditions', {
				PlaceObj('CheckCooldown', {
					Negate = true,
				}),
			},
		}),
	},
	DisplayImage = "UI/Messages/Expeditions/exp_bow",
	FoundByExploration = true,
	FoundByExplorationDisplayText = T(281595998345, --[[ModItemExpeditionPreset HuntingGrounds FoundByExplorationDisplayText]] "I can see a pasture frequented by herbivores!\n\nIt could prove to be a good hunting ground, so I'll jot down this location for future visits."),
	FoundByExplorationWeight = 60,
	Icon = "UI/Icons/Expeditions/bow",
	NameColor = 4283222070,
	OneInstanceOnly = true,
	Prerequisites = {
		PlaceObj('CheckSeason', {
			Negate = true,
			Season = set( "Winter" ),
		}),
	},
	RelevantSkills = set( "Combat" ),
	StoryBits = {
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "Site_HuntingGrounds_MeatHides",
		}),
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "Site_HuntingGrounds_Injury",
			'Weight', 80,
		}),
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "Site_HuntingGrounds_Predator",
			'Weight', 50,
		}),
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "Site_HuntingGrounds_Nothing",
			'Weight', 15,
		}),
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "Site_HuntingGrounds_Pacifist",
		}),
	},
	Uses = 0,
	description = T(820328298589, --[[ModItemExpeditionPreset HuntingGrounds description]] "A field overgrown with very large plants, Herbivores must be scarce for some reason or another!\n\nSending a survivor with a high Combat or Farming skill will improve the hunting results."),
	display_name = T(324149621143, --[[ModItemExpeditionPreset HuntingGrounds display_name]] "Hunting ground [FFE]"),
	group = "Deposits",
	id = "HuntingGrounds",
	save_in = "Mod/Uqo4QkN",
}),
PlaceObj('ModItemFolder', {
	'name', "HuntingGrounds SBs",
	'NameColor', RGBA(88, 212, 67, 255),
}, {
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		NotificationText = T(732965663433, --[[ModItemStoryBit Site_HuntingGrounds_Predator NotificationText]] "Expedition update: <ExplorationSiteName>"),
		OneTime = false,
		PopupFxAction = "MessagePopup",
		Prerequisites = {
			PlaceObj('CheckSkillInclination', {
				Inclination = "Forbidden",
				Negate = true,
				Skill = "Combat",
				param_bindings = false,
			}),
		},
		ScriptDone = true,
		SelectObject = false,
		Sets = {
			Negative = true,
		},
		Text = T(287185450262, --[[ModItemStoryBit Site_HuntingGrounds_Predator Text]] "I visited the pasture, only to find just a couple of animals grazing there.\n\nI had just found a good ambush spot when I spotted a predator preparing to do pretty much what I was planning to.\nWe can attack one while it's concentrated on the hunt, or take the kill from it."),
		Title = T(300625514328, --[[ModItemStoryBit Site_HuntingGrounds_Predator Title]] "A predator!"),
		UseObjectImage = true,
		group = "Expedition_FollowUP",
		id = "Site_HuntingGrounds_Predator",
		max_reply_id = 17,
		qa_info = PlaceObj('PresetQAInfo', {
			data = {
				{
					action = "Modified",
					time = 1583342170,
					user = "Svetlio",
				},
				{
					action = "Modified",
					time = 1583343860,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1583483931,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1585229761,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1593085279,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1594825884,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1601282702,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1602664512,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1608545552,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609927791,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609932797,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1610034862,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1610376936,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1613048872,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1621517342,
					user = "Bobby",
				},
				{
					action = "Modified",
					time = 1629391685,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629705378,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629819715,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630576903,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630671680,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1630674177,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1631107001,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1643107297,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1649159413,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1654008657,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1663219926,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1664274327,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1665415594,
					user = "Xaerial",
				},
				{
					action = "Modified",
					time = 1693302835,
					user = "Ivan",
				},
			},
			param_bindings = false,
		}),
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(527690183123, --[[ModItemStoryBit Site_HuntingGrounds_Predator CustomOutcomeText]] "low Combat skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(555943227486, --[[ModItemStoryBit Site_HuntingGrounds_Predator Text]] "Go for it."),
			param_bindings = false,
			unique_id = 11,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_House_Bones_Resulution",
					'NoCooldown', true,
					'Weight', 40,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_HuntingGrounds_Predator_Defeat",
					'Weight', 60,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(361681278538, --[[ModItemStoryBit Site_HuntingGrounds_Predator CustomOutcomeText]] "high Combat skill; low risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 5,
					Condition = ">=",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(966020577963, --[[ModItemStoryBit Site_HuntingGrounds_Predator Text]] "Go for it."),
			param_bindings = false,
			unique_id = 12,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_HuntingGrounds_Predator_Victory",
					'NoCooldown', true,
					'Weight', 80,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_HuntingGrounds_Predator_Defeat",
					'NoCooldown', true,
					'Weight', 20,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(568500356420, --[[ModItemStoryBit Site_HuntingGrounds_Predator CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(326507544253, --[[ModItemStoryBit Site_HuntingGrounds_Predator Text]] "Try to Pacify it"),
			param_bindings = false,
			unique_id = 15,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_HuntingGrounds_Predator_Tame_Minor",
					'NoCooldown', true,
					'Weight', 40,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_HuntingGrounds_Predator_Defeat",
					'Weight', 60,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(679139934708, --[[ModItemStoryBit Site_HuntingGrounds_Predator CustomOutcomeText]] "high Farming skill; low risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">=",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(304162595197, --[[ModItemStoryBit Site_HuntingGrounds_Predator Text]] "Try to Pacify it"),
			param_bindings = false,
			unique_id = 17,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_HuntingGrounds_Predator_Tame",
					'NoCooldown', true,
					'Weight', 80,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_HuntingGrounds_Predator_Defeat",
					'NoCooldown', true,
					'Weight', 20,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			HideIfDisabled = true,
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(751423996253, --[[ModItemStoryBit Site_HuntingGrounds_Predator Text]] "Leave it be, it's not worth the risk."),
			param_bindings = false,
			unique_id = 13,
		}),
		PlaceObj('StoryBitReply', {
			HideIfDisabled = true,
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 5,
					Condition = ">=",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(532706080657, --[[ModItemStoryBit Site_HuntingGrounds_Predator Text]] "Leave it be. It has to feed too."),
			param_bindings = false,
			unique_id = 14,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		HasNotification = false,
		NotificationText = T(418019600224, --[[ModItemStoryBit Site_HuntingGrounds_Predator_Tame NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		OneTime = false,
		PopupFxAction = "MessagePopup",
		ScriptDone = true,
		SelectObject = false,
		Text = T(343304395624, --[[ModItemStoryBit Site_HuntingGrounds_Predator_Tame Text]] "I trapped the predator! I actually did it! - laid out torches to drive anything else away.\n\nAfter a few hours and some relatively easy to collect meat, I was able to teach it some basic commands.\nWe now have a new friend."),
		Title = T(857560244569, --[[ModItemStoryBit Site_HuntingGrounds_Predator_Tame Title]] "Victory!"),
		UseObjectImage = true,
		group = "Expedition_FollowUP",
		id = "Site_HuntingGrounds_Predator_Tame",
		max_reply_id = 12,
		qa_info = PlaceObj('PresetQAInfo', {
			data = {
				{
					action = "Modified",
					time = 1583342170,
					user = "Svetlio",
				},
				{
					action = "Modified",
					time = 1583343860,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1583483931,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1585229761,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1593085279,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1594825884,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1601282702,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1602664512,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1608545552,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609927791,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609932797,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1610034862,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1610376936,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1613048872,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1621517342,
					user = "Bobby",
				},
				{
					action = "Modified",
					time = 1629391685,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629705378,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629819715,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630576903,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630671680,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1630674177,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1631107001,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1634909590,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1639739535,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1643102330,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1665415594,
					user = "Xaerial",
				},
			},
			param_bindings = false,
		}),
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			Text = T(932426349419, --[[ModItemStoryBit Site_HuntingGrounds_Predator_Tame Text]] "Wonderful!"),
			param_bindings = false,
			unique_id = 12,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Juno",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shrieker_Mother",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Scissorhands_Brute",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		HasNotification = false,
		NotificationText = T(120030107091, --[[ModItemStoryBit Site_HuntingGrounds_Predator_Tame_Minor NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		OneTime = false,
		PopupFxAction = "MessagePopup",
		ScriptDone = true,
		SelectObject = false,
		Text = T(147837022977, --[[ModItemStoryBit Site_HuntingGrounds_Predator_Tame_Minor Text]] "I laid a trap, but it still must have had my scent on it too much.\nThat being said, after a few hours a weaker predator finally fell for the lure.\n\nIt was surprisingly very food motivated, and it quickly learned I am better alive than dead!\n"),
		Title = T(790976801498, --[[ModItemStoryBit Site_HuntingGrounds_Predator_Tame_Minor Title]] "Victory!"),
		UseObjectImage = true,
		group = "Expedition_FollowUP",
		id = "Site_HuntingGrounds_Predator_Tame_Minor",
		max_reply_id = 13,
		qa_info = PlaceObj('PresetQAInfo', {
			data = {
				{
					action = "Modified",
					time = 1583342170,
					user = "Svetlio",
				},
				{
					action = "Modified",
					time = 1583343860,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1583483931,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1585229761,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1593085279,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1594825884,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1601282702,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1602664512,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1608545552,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609927791,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609932797,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1610034862,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1610376936,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1613048872,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1621517342,
					user = "Bobby",
				},
				{
					action = "Modified",
					time = 1629391685,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629705378,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629819715,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630576903,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630671680,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1630674177,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1631107001,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1634909590,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1639739535,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1643102330,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1665415594,
					user = "Xaerial",
				},
			},
			param_bindings = false,
		}),
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			Text = T(215386322487, --[[ModItemStoryBit Site_HuntingGrounds_Predator_Tame_Minor Text]] "Wonderful!"),
			param_bindings = false,
			unique_id = 13,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Tecatli",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Gujo",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Scissorhands",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	}),
	}),
PlaceObj('ModItemExpeditionPreset', {
	DisplayImage = "UI/Messages/Expeditions/exp_sound_wave",
	Expiration = 3600000,
	Icon = "UI/Icons/Expeditions/sound_wave",
	NameColor = 4281968595,
	OneInstanceOnly = true,
	StoryBits = {
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "Site_Shrieker",
		}),
	},
	UILineColor = 4293083197,
	description = T(922205485638, --[[ModItemExpeditionPreset Shrieker description]] "Weird shrieking noises have been heard from this direction."),
	display_name = T(969647485847, --[[ModItemExpeditionPreset Shrieker display_name]] "Shrieking noises [FFE]"),
	group = "Default",
	id = "Shrieker",
	save_in = "Mod/Uqo4QkN",
}),
PlaceObj('ModItemFolder', {
	'name', "Shrieker Site SBs",
	'NameColor', RGBA(47, 152, 194, 255),
}, {
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Delay = 4000,
		Enabled = true,
		FxAction = "UINotificationExpedition",
		NotificationText = T(831213253315, --[[ModItemStoryBit Site_Shrieker NotificationText]] "Expedition update: <ExplorationSiteName>"),
		PopupFxAction = "MessagePopup",
		ScriptDone = true,
		SelectObject = false,
		SuppressTime = 960000,
		Text = T(194940582683, --[[ModItemStoryBit Site_Shrieker Text]] "A spike-tailed insect has made a small lair between some rocks. It looks to be alone... for now.\n\nThis might be a good chance to observe its kind from a safe distance."),
		Title = T(918761004266, --[[ModItemStoryBit Site_Shrieker Title]] "A spike-tailed insect"),
		UseObjectImage = true,
		group = "Expedition_FollowUP",
		id = "Site_Shrieker",
		max_reply_id = 16,
		qa_info = PlaceObj('PresetQAInfo', {
			data = {
				{
					action = "Modified",
					time = 1583342170,
					user = "Svetlio",
				},
				{
					action = "Modified",
					time = 1583343860,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1583483931,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1585229761,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1593085279,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1594825884,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1601282702,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1602664512,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1608545552,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609927791,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609932797,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1610034862,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1610376936,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1613048872,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1621517342,
					user = "Bobby",
				},
				{
					action = "Modified",
					time = 1629707068,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629885532,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629988993,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630404906,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630671680,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1631092562,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1632729163,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1649159871,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1654009581,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1665415594,
					user = "Xaerial",
				},
				{
					action = "Modified",
					time = 1693303002,
					user = "Ivan",
				},
			},
			param_bindings = false,
		}),
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			Text = T(864320467667, --[[ModItemStoryBit Site_Shrieker Text]] "Observe away! It may be useful."),
			param_bindings = false,
			unique_id = 11,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('ResearchTechEffect', {
					TechId = "FieldShrieker",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(475904398682, --[[ModItemStoryBit Site_Shrieker CustomOutcomeText]] "<TraitName('Pacifist',actor)> - can't fight"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillInclination', {
					Inclination = "Forbidden",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(824555037898, --[[ModItemStoryBit Site_Shrieker Text]] "It would've been better to kill it, but... Just come back."),
			param_bindings = false,
			unique_id = 12,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(855175078649, --[[ModItemStoryBit Site_Shrieker CustomOutcomeText]] "low Combat skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillInclination', {
					Inclination = "Forbidden",
					Negate = true,
					Skill = "Combat",
					param_bindings = false,
				}),
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(387577260573, --[[ModItemStoryBit Site_Shrieker Text]] "No need to know anything about it - kill it!"),
			param_bindings = false,
			unique_id = 13,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_GenericAttack_Defeat",
					'NoCooldown', true,
					'Weight', 60,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_GenericAttack_Victory_Dead",
					'NoCooldown', true,
					'Weight', 40,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(725243675458, --[[ModItemStoryBit Site_Shrieker CustomOutcomeText]] "high Combat skill; low risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillInclination', {
					Inclination = "Forbidden",
					Negate = true,
					Skill = "Combat",
					param_bindings = false,
				}),
				PlaceObj('CheckSkillLevel', {
					Amount = 5,
					Condition = ">=",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(622780258364, --[[ModItemStoryBit Site_Shrieker Text]] "No need to know anything about it - kill it!"),
			param_bindings = false,
			unique_id = 14,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_GenericAttack_Defeat",
					'NoCooldown', true,
					'Weight', 20,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_GenericAttack_Victory_Dead",
					'NoCooldown', true,
					'Weight', 80,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(457723315070, --[[ModItemStoryBit Site_Shrieker CustomOutcomeText]] "low Combat and Farming skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillInclination', {
					Inclination = "Forbidden",
					Negate = true,
					Skill = "Combat",
					param_bindings = false,
				}),
				PlaceObj('CheckOR', {
					Conditions = {
						PlaceObj('CheckSkillLevel', {
							Amount = 5,
							Condition = "<",
							Skill = "Farming",
							param_bindings = false,
						}),
						PlaceObj('CheckSkillLevel', {
							Amount = 5,
							Condition = "<",
							Skill = "Combat",
							param_bindings = false,
						}),
					},
					param_bindings = false,
				}),
			},
			Text = T(195322109083, --[[ModItemStoryBit Site_Shrieker Text]] "I wonder if I can convince it to come home with me?"),
			param_bindings = false,
			unique_id = 15,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_GenericAttack_Defeat",
					'NoCooldown', true,
					'Weight', 80,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_Shrieker_tame_success_minor",
					'Weight', 50,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_Shrieker_tame_success",
					'Weight', 20,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(584168273542, --[[ModItemStoryBit Site_Shrieker CustomOutcomeText]] "high Combat and Farming skill; low risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillInclination', {
					Inclination = "Forbidden",
					Negate = true,
					Skill = "Combat",
					param_bindings = false,
				}),
				PlaceObj('CheckAND', {
					Conditions = {
						PlaceObj('CheckSkillLevel', {
							Amount = 5,
							Condition = ">=",
							Skill = "Farming",
							param_bindings = false,
						}),
						PlaceObj('CheckSkillLevel', {
							Amount = 5,
							Condition = ">=",
							Skill = "Combat",
							param_bindings = false,
						}),
					},
					param_bindings = false,
				}),
			},
			Text = T(840476185687, --[[ModItemStoryBit Site_Shrieker Text]] "I'm sure I can get it to like me"),
			param_bindings = false,
			unique_id = 16,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_Shrieker_tame_success",
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_Shrieker_tame_success_minor",
					'Weight', 50,
				}),
			},
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		HasNotification = false,
		NotificationText = T(268230126443, --[[ModItemStoryBit Site_Shrieker_tame_success NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		OneTime = false,
		PopupFxAction = "MessagePopup",
		ScriptDone = true,
		SelectObject = false,
		Text = T(429396271153, --[[ModItemStoryBit Site_Shrieker_tame_success Text]] "I managed to lure one away from the beaten path.\nAfter a few morsels of super salted meat, I was able to show myself to it.\n\nIt must have enough intelligence to realize I can make them, and it can't.\nBecause it even followed me onto the Balloon back home!\n"),
		Title = T(464625499283, --[[ModItemStoryBit Site_Shrieker_tame_success Title]] "Victory!"),
		UseObjectImage = true,
		group = "Expedition_FollowUP",
		id = "Site_Shrieker_tame_success",
		max_reply_id = 14,
		qa_info = PlaceObj('PresetQAInfo', {
			data = {
				{
					action = "Modified",
					time = 1583342170,
					user = "Svetlio",
				},
				{
					action = "Modified",
					time = 1583343860,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1583483931,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1585229761,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1593085279,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1594825884,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1601282702,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1602664512,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1608545552,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609927791,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609932797,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1610034862,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1610376936,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1613048872,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1621517342,
					user = "Bobby",
				},
				{
					action = "Modified",
					time = 1629391685,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629705378,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629819715,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630576903,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630671680,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1630674177,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1631107001,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1634909590,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1639739535,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1643102330,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1665415594,
					user = "Xaerial",
				},
			},
			param_bindings = false,
		}),
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			Text = T(409601891649, --[[ModItemStoryBit Site_Shrieker_tame_success Text]] "Wonderful!"),
			param_bindings = false,
			unique_id = 14,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shrieker_Manhunting_Mother",
					param_bindings = false,
				}),
			},
			Weight = 150,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shrieker_Manhunting",
					param_bindings = false,
				}),
			},
			Weight = 80,
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		HasNotification = false,
		NotificationText = T(748493668988, --[[ModItemStoryBit Site_Shrieker_tame_success_minor NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		OneTime = false,
		PopupFxAction = "MessagePopup",
		ScriptDone = true,
		SelectObject = false,
		Text = T(455029251107, --[[ModItemStoryBit Site_Shrieker_tame_success_minor Text]] 'After some difficulty (And a wound or two) I managed to lure only one creature away.\nA few nuggets of super salted meat, I chanced showing myself.\n\nAfter a brief "discussion" (And spike in my leg), I managed to convey that I can make it more meat.\nSo even though I\'m limping back, I have a live trophy!'),
		Title = T(283712461137, --[[ModItemStoryBit Site_Shrieker_tame_success_minor Title]] "Victory!"),
		UseObjectImage = true,
		group = "Expedition_FollowUP",
		id = "Site_Shrieker_tame_success_minor",
		max_reply_id = 15,
		qa_info = PlaceObj('PresetQAInfo', {
			data = {
				{
					action = "Modified",
					time = 1583342170,
					user = "Svetlio",
				},
				{
					action = "Modified",
					time = 1583343860,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1583483931,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1585229761,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1593085279,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1594825884,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1601282702,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1602664512,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1608545552,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609927791,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609932797,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1610034862,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1610376936,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1613048872,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1621517342,
					user = "Bobby",
				},
				{
					action = "Modified",
					time = 1629391685,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629705378,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629819715,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630576903,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630671680,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1630674177,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1631107001,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1634909590,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1639739535,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1643102330,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1665415594,
					user = "Xaerial",
				},
			},
			param_bindings = false,
		}),
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			Text = T(746935043979, --[[ModItemStoryBit Site_Shrieker_tame_success_minor Text]] "Wonderful!"),
			param_bindings = false,
			unique_id = 15,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shrieker_Manhunting_Mother",
					param_bindings = false,
				}),
			},
			Weight = 20,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shrieker_Manhunting",
					param_bindings = false,
				}),
			},
			Weight = 80,
			param_bindings = false,
		}),
	}),
	}),
PlaceObj('ModItemExpeditionPreset', {
	DisplayImage = "UI/Messages/Expeditions/exp_sound_wave",
	Expiration = 3600000,
	Icon = "UI/Icons/Expeditions/sound_wave",
	NameColor = 4289765410,
	OneInstanceOnly = true,
	OneTime = true,
	StoryBits = {
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "Site_LoudBang_CampGraves",
		}),
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "Site_LoudBang_CampExploded",
		}),
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "Site_LoudBang_NestExploded",
		}),
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "Site_LoudBang_Stunned_Wildlife",
		}),
	},
	UILineColor = 4293083197,
	description = T(189963326450, --[[ModItemExpeditionPreset LoudBang description]] "The source of the loud bang should be somewhere around here."),
	display_name = T(461126114505, --[[ModItemExpeditionPreset LoudBang display_name]] "Loud bang [FFE]"),
	group = "Default",
	id = "LoudBang",
	save_in = "Mod/Uqo4QkN",
}),
PlaceObj('ModItemFolder', {
	'name', "loud bang SBs",
	'NameColor', RGBA(177, 165, 73, 255),
}, {
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		HasNotification = false,
		NotificationText = T(569505610178, --[[ModItemStoryBit Site_Loudband_Stunned_Wildlife_Defeat NotificationText]] "Expedition failed: <ExplorationSiteName>"),
		OneTime = false,
		PopupFxAction = "MessagePopup",
		ScriptDone = true,
		SelectObject = false,
		Sets = set( "Negative" ),
		Text = T(659754359609, --[[ModItemStoryBit Site_Loudband_Stunned_Wildlife_Defeat Text]] "I tried to gently break an animal out of it's stupor.... only to be met with aggression!\n\nUnfortunately, I was quite close to the thing... so I'm quite hurt.\n\nI barely escaped with my life!"),
		Title = T(772290214095, --[[ModItemStoryBit Site_Loudband_Stunned_Wildlife_Defeat Title]] "Defeat!"),
		UseObjectImage = true,
		id = "Site_Loudband_Stunned_Wildlife_Defeat",
		max_reply_id = 6,
		qa_info = PlaceObj('PresetQAInfo', {
			Log = "Modified by Svetlio on 2020-Mar-04\nModified by Lina on 2020-Mar-04\nModified by Lina on 2020-Mar-06\nModified by Lina on 2020-Mar-26\nModified by Lina on 2020-Jun-25\nModified by Lina on 2020-Jul-15\nModified by Lina on 2020-Sep-28\nModified by Vihar on 2020-Oct-14\nModified by Ivan on 2020-Dec-21\nModified by Ivan on 2021-Jan-06\nModified by Vihar on 2021-Jan-06\nModified by Gaby on 2021-Jan-07\nModified by Lina on 2021-Jan-11\nModified by Ivan on 2021-Feb-11\nModified by Bobby on 2021-May-20\nModified by Lina on 2021-Aug-23\nModified by Lina on 2021-Aug-24\nModified by Gaby on 2021-Sep-03\nModified by Lina on 2021-Sep-03\nModified by Lina on 2021-Sep-08\nModified by Lina on 2021-Sep-27\nModified by Lina on 2021-Dec-17\nModified by Lina on 2022-Jan-20\nModified by Lina on 2022-Jan-25\nModified by Xaerial on 2022-Oct-10",
			param_bindings = false,
		}),
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			Text = T(990342462277, --[[ModItemStoryBit Site_Loudband_Stunned_Wildlife_Defeat Text]] "Oh my!"),
			param_bindings = false,
			unique_id = 5,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Critical",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Critical",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Stab_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "DislocatedJoint_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Critical",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Stab_Critical",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "DislocatedJoint_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "ShatteredBone_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		HasNotification = false,
		NotificationText = T(541423845372, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife_Tame_minor NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		OneTime = false,
		PopupFxAction = "MessagePopup",
		ScriptDone = true,
		SelectObject = false,
		Text = T(780861652162, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife_Tame_minor Text]] "I tried to gently break an animal out of it's stupor.\nFood was placed in a line away from the site, to hopefully distract it.\n\nUnfortunately, it instead ran off.... so I selected the next best candidiate.\n\nThat one obliged, and I got it alone feeling relatively safe.\nAfter a quick training session, it was listening to commands enough to bring it home!"),
		Title = T(461502133087, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife_Tame_minor Title]] "Victory!"),
		UseObjectImage = true,
		group = "Expedition_FollowUP",
		id = "Site_LoudBang_Stunned_Wildlife_Tame_minor",
		max_reply_id = 21,
		qa_info = PlaceObj('PresetQAInfo', {
			data = {
				{
					action = "Modified",
					time = 1583342170,
					user = "Svetlio",
				},
				{
					action = "Modified",
					time = 1583343860,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1583483931,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1585229761,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1593085279,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1594825884,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1601282702,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1602664512,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1608545552,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609927791,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609932797,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1610034862,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1610376936,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1613048872,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1621517342,
					user = "Bobby",
				},
				{
					action = "Modified",
					time = 1629391685,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629705378,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629819715,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630576903,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630671680,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1630674177,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1631107001,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1634909590,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1639739535,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1643102330,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1665415594,
					user = "Xaerial",
				},
			},
			param_bindings = false,
		}),
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			Text = T(306014779685, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife_Tame_minor Text]] "Wonderful!"),
			param_bindings = false,
			unique_id = 21,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Draka",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shogu",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		HasNotification = false,
		NotificationText = T(854538264277, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife_Tame NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		OneTime = false,
		PopupFxAction = "MessagePopup",
		ScriptDone = true,
		SelectObject = false,
		Text = T(248615547201, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife_Tame Text]] "I tried to gently break an animal out of it's stupor.\nFood was placed in a line away from the site, to hopefully distract it.\n\nThankfully it obliged, and I got it alone feeling relatively safe.\nAfter a quick training session, it was listening to commands enough to bring it home!\n"),
		Title = T(416698324500, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife_Tame Title]] "Victory!"),
		UseObjectImage = true,
		group = "Expedition_FollowUP",
		id = "Site_LoudBang_Stunned_Wildlife_Tame",
		max_reply_id = 21,
		qa_info = PlaceObj('PresetQAInfo', {
			data = {
				{
					action = "Modified",
					time = 1583342170,
					user = "Svetlio",
				},
				{
					action = "Modified",
					time = 1583343860,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1583483931,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1585229761,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1593085279,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1594825884,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1601282702,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1602664512,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1608545552,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609927791,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609932797,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1610034862,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1610376936,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1613048872,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1621517342,
					user = "Bobby",
				},
				{
					action = "Modified",
					time = 1629391685,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629705378,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629819715,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630576903,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630671680,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1630674177,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1631107001,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1634909590,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1639739535,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1643102330,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1665415594,
					user = "Xaerial",
				},
			},
			param_bindings = false,
		}),
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			Text = T(992852798416, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife_Tame Text]] "Wonderful!"),
			param_bindings = false,
			unique_id = 21,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Juno",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Ulfen",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Gujo",
					param_bindings = false,
				}),
			},
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		Category = "Exploration",
		Enabled = true,
		FxAction = "UINotificationExpedition",
		HasNotification = false,
		NotificationText = T(727837464265, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife NotificationText]] "Expedition complete: <ExplorationSiteName>"),
		OneTime = false,
		PopupFxAction = "MessagePopup",
		ScriptDone = true,
		SelectObject = false,
		Text = T(171579766991, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife Text]] "As I landed, I found animals in scattered positions.\nWhen I started walking around, none of them seemed to notice me.\n\nWhatever happened, it must have put these things into a stupor!\nThese would make for easy hunting, or I can try and safely tame one for our base."),
		Title = T(669331576160, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife Title]] "Victory!"),
		UseObjectImage = true,
		group = "Expedition_FollowUP",
		id = "Site_LoudBang_Stunned_Wildlife",
		max_reply_id = 17,
		qa_info = PlaceObj('PresetQAInfo', {
			data = {
				{
					action = "Modified",
					time = 1583342170,
					user = "Svetlio",
				},
				{
					action = "Modified",
					time = 1583343860,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1583483931,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1585229761,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1593085279,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1594825884,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1601282702,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1602664512,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1608545552,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609927791,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1609932797,
					user = "Vihar",
				},
				{
					action = "Modified",
					time = 1610034862,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1610376936,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1613048872,
					user = "Ivan",
				},
				{
					action = "Modified",
					time = 1621517342,
					user = "Bobby",
				},
				{
					action = "Modified",
					time = 1629391685,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629705378,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1629819715,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630576903,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1630671680,
					user = "Gaby",
				},
				{
					action = "Modified",
					time = 1630674177,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1631107001,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1634909590,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1639739535,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1643102330,
					user = "Lina",
				},
				{
					action = "Modified",
					time = 1665415594,
					user = "Xaerial",
				},
			},
			param_bindings = false,
		}),
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			Text = T(721473781992, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife Text]] "Slaughter some and bring back their meat"),
			param_bindings = false,
			unique_id = 15,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionRewardToSurvivor', {
					Amount = 50000,
					Resource = "RawMeatInsect",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionRewardToSurvivor', {
					Amount = 50000,
					Resource = "RawMeat",
					param_bindings = false,
				}),
			},
			Weight = 150,
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(957982269170, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife CustomOutcomeText]] "High Farming skill, low risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 6,
					Condition = ">=",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(334089350437, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife Text]] "Try and tame one"),
			param_bindings = false,
			unique_id = 16,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_LoudBang_Stunned_Wildlife_Tame",
					'NoCooldown', true,
					'Weight', 90,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_LoudBang_Stunned_Wildlife_Tame_minor",
					'Weight', 60,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(247051225866, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife CustomOutcomeText]] "Low Farming skill, moderate risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 6,
					Condition = "<",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(463090604446, --[[ModItemStoryBit Site_LoudBang_Stunned_Wildlife Text]] "Try and tame one"),
			param_bindings = false,
			unique_id = 17,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_LoudBang_Stunned_Wildlife_Tame",
					'NoCooldown', true,
					'Weight', 90,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "Site_LoudBang_Stunned_Wildlife_Tame_minor",
					'Weight', 60,
				}),
			},
			param_bindings = false,
		}),
	}),
	}),
PlaceObj('ModItemExpeditionPreset', {
	DisplayImage = "UI/Messages/Expeditions/exp_palm_trees",
	FoundByExploration = true,
	FoundByExplorationDisplayText = T(588548889021, --[[ModItemExpeditionPreset GrazingFields FoundByExplorationDisplayText]] "I'm witnessing another eerie mist gliding through the jungle. Its behavior is far from ordinary, it's as if it's leading me somewhere."),
	FoundByExplorationWeight = 50,
	Icon = "UI/Icons/Expeditions/palm_trees",
	NameColor = 4291056650,
	StoryBits = {
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "grazing_fields_camels",
		}),
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "grazing_fields_gujo",
		}),
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "grazing_fields_shogu",
		}),
		PlaceObj('ExpeditionStoryBitWeight', {
			'StoryBit', "grazing_fields_tecatli",
		}),
	},
	UILineColor = 4286036179,
	Uses = 0,
	description = T(640619770653, --[[ModItemExpeditionPreset GrazingFields description]] "A field that is well grazed, it must be safer for herbivores here!\n\nSending a survivor with high Combat or Farming skill will improve the hunting results."),
	display_name = T(647347850229, --[[ModItemExpeditionPreset GrazingFields display_name]] "Idyllic Field [FFE]"),
	id = "GrazingFields",
	new_in = "Jungle",
	save_in = "Mod/Uqo4QkN",
}),
PlaceObj('ModItemFolder', {
	'name', "Grazing Field SBs",
	'NameColor', RGBA(236, 128, 24, 255),
}, {
	PlaceObj('ModItemStoryBit', {
		NotificationTitle = T(334416212883, --[[ModItemStoryBit site_grazing_fields_hunt_failure NotificationTitle]] "Expedition update: <ExplorationSiteName>"),
		Text = T(413130945335, --[[ModItemStoryBit site_grazing_fields_hunt_failure Text]] "The herd seemed quite invested in not letting me get any of them...\nWorst case, they fought back!\n\nI left before I could suffer any major wounds."),
		Title = T(759736986954, --[[ModItemStoryBit site_grazing_fields_hunt_failure Title]] "Failure"),
		id = "site_grazing_fields_hunt_failure",
		max_reply_id = 9,
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(945993897286, --[[ModItemStoryBit site_grazing_fields_hunt_failure CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			Text = T(565086727504, --[[ModItemStoryBit site_grazing_fields_hunt_failure Text]] "Unfortunate"),
			param_bindings = false,
			unique_id = 6,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(678396400677, --[[ModItemStoryBit site_grazing_fields_hunt_failure Text]] "The herd seemed quite invested in not letting me get any of them...\nWorst case, they fought back!\n\nI left before I could suffer any major wounds."),
			Title = T(269195717926, --[[ModItemStoryBit site_grazing_fields_hunt_failure Title]] "Failure"),
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		NotificationTitle = T(173971592982, --[[ModItemStoryBit site_grazing_fields_hunt_success NotificationTitle]] "Expedition update: <ExplorationSiteName>"),
		Text = T(872926454072, --[[ModItemStoryBit site_grazing_fields_hunt_success Text]] "I set a diversion and the herd took the bait.\nThey started running away, and I managed to trip the stragglers.\n\nAs I was butchering and cleaning the body, a very eerie calm descended....\nRegardless we now have some food for the colony!"),
		Title = T(559720591325, --[[ModItemStoryBit site_grazing_fields_hunt_success Title]] "Failure"),
		id = "site_grazing_fields_hunt_success",
		max_reply_id = 11,
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(674751641240, --[[ModItemStoryBit site_grazing_fields_hunt_success CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			Text = T(473087122959, --[[ModItemStoryBit site_grazing_fields_hunt_success Text]] "Great Success"),
			param_bindings = false,
			unique_id = 11,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionRewardToSurvivor', {
					Amount = 50000,
					Resource = "RawMeatInsect",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionRewardToSurvivor', {
					Amount = 50000,
					Resource = "RawMeat",
					param_bindings = false,
				}),
			},
			Text = "",
			Title = "",
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		NotificationTitle = T(231210872623, --[[ModItemStoryBit site_grazing_fields_hunt_failure_large NotificationTitle]] "Expedition update: <ExplorationSiteName>"),
		Text = T(338125021256, --[[ModItemStoryBit site_grazing_fields_hunt_failure_large Text]] "The herd seemed quite invested in not letting me get any of them...\nWorst case, they fought back!\n\nThey caught me and made sure to give me many solid wounds....\nI'm lucky to escape with my life!"),
		Title = T(197883140733, --[[ModItemStoryBit site_grazing_fields_hunt_failure_large Title]] "Failure"),
		id = "site_grazing_fields_hunt_failure_large",
		max_reply_id = 10,
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(968424743903, --[[ModItemStoryBit site_grazing_fields_hunt_failure_large CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			Text = T(151646586364, --[[ModItemStoryBit site_grazing_fields_hunt_failure_large Text]] "Unfortunate"),
			param_bindings = false,
			unique_id = 10,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = "",
			Title = "",
			param_bindings = false,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		NotificationTitle = T(969100372924, --[[ModItemStoryBit grazing_fields_camels NotificationTitle]] "Expedition update: <ExplorationSiteName>"),
		Prerequisites = {
			PlaceObj('CheckRegion', {
				Negate = true,
				Region = set( "Desertum" ),
				param_bindings = false,
			}),
		},
		Text = T(787313851048, --[[ModItemStoryBit grazing_fields_camels Text]] "There are some very mild mannered quadrupedal animals in the area!\n\nToday there seems to be a larger than normal grouping of creatures slightly larger than me, with one or two humps on it's back.\nHow should I proceed?"),
		Title = T(316903059860, --[[ModItemStoryBit grazing_fields_camels Title]] "An Herbivore!"),
		id = "grazing_fields_camels",
		max_reply_id = 6,
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(479667010508, --[[ModItemStoryBit grazing_fields_camels CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(822684039796, --[[ModItemStoryBit grazing_fields_camels Text]] "Try to Pacify it"),
			param_bindings = false,
			unique_id = 1,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(119909718404, --[[ModItemStoryBit grazing_fields_camels Text]] "When I approached the herd, their initial reaction was to defend its members.\n\nAfter a few hits, they calmed down and let me drop food for them.\n\nMultiple feedings later, one of these creatures seemed quite attached to me!"),
			Title = T(392071207583, --[[ModItemStoryBit grazing_fields_camels Title]] "Success?"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
			},
			Text = T(943966769873, --[[ModItemStoryBit grazing_fields_camels Text]] "When I approached the herd, they where initially quite skeptical.\n\nI dropped food for them and made sure to back off.\n\nAfter multiple feedings later, a few of these creatures seemed quite attached to me!"),
			Title = T(734983430068, --[[ModItemStoryBit grazing_fields_camels Title]] "Success"),
			Weight = 50,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(567494826136, --[[ModItemStoryBit grazing_fields_camels Text]] "When I approached the herd, their initial reaction was to defend its members.\nAfter about 20 seconds of not fighting back, I had enough and quickly left.\n\nNo idea what got into them..... but we will need to come back later!"),
			Title = T(569970588689, --[[ModItemStoryBit grazing_fields_camels Title]] "Failure"),
			Weight = 150,
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(143929333911, --[[ModItemStoryBit grazing_fields_camels CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(852582304440, --[[ModItemStoryBit grazing_fields_camels Text]] "Try to Pacify it"),
			param_bindings = false,
			unique_id = 2,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(434020634233, --[[ModItemStoryBit grazing_fields_camels Text]] "When I approached the herd, their initial reaction was to defend its members.\n\nAfter a few hits, they calmed down and let me drop food for them.\n\nMultiple feedings later, one of these creatures seemed quite attached to me!"),
			Title = T(121295382796, --[[ModItemStoryBit grazing_fields_camels Title]] "Success?"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
			},
			Text = T(912723021203, --[[ModItemStoryBit grazing_fields_camels Text]] "When I approached the herd, they where initially quite skeptical.\n\nI dropped food for them and made sure to back off.\n\nAfter multiple feedings later, a few of these creatures seemed quite attached to me!"),
			Title = T(865039954422, --[[ModItemStoryBit grazing_fields_camels Title]] "Success"),
			Weight = 150,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(553284784226, --[[ModItemStoryBit grazing_fields_camels Text]] "When I approached the herd, their initial reaction was to defend its members.\nAfter about 20 seconds of not fighting back, I had enough and quickly left.\n\nNo idea what got into them..... but we will need to come back later!"),
			Title = T(762875452189, --[[ModItemStoryBit grazing_fields_camels Title]] "Failure"),
			Weight = 50,
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(820140252658, --[[ModItemStoryBit grazing_fields_camels CustomOutcomeText]] "low Combat skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(265362703979, --[[ModItemStoryBit grazing_fields_camels Text]] "Try to hunt a few"),
			param_bindings = false,
			unique_id = 5,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure",
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure_large",
					'Weight', 50,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_success",
					'Weight', 25,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(396855829225, --[[ModItemStoryBit grazing_fields_camels CustomOutcomeText]] "high Combat skill; low risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(825275763331, --[[ModItemStoryBit grazing_fields_camels Text]] "Try to hunt a few"),
			param_bindings = false,
			unique_id = 6,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure",
					'Weight', 50,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure_large",
					'Weight', 25,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_success",
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(529510081394, --[[ModItemStoryBit grazing_fields_camels CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			Text = T(216621135801, --[[ModItemStoryBit grazing_fields_camels Text]] "Just leave, that creature doesn't sound useful"),
			param_bindings = false,
			unique_id = 3,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		NotificationTitle = T(528468034178, --[[ModItemStoryBit grazing_fields_shogu NotificationTitle]] "Expedition update: <ExplorationSiteName>"),
		Prerequisites = {
			PlaceObj('CheckRegion', {
				Negate = true,
				Region = set( "Saltu" ),
				param_bindings = false,
			}),
		},
		Text = T(829355721117, --[[ModItemStoryBit grazing_fields_shogu Text]] "There is a herd of rather portly four legged creatures here today.\nTheir noses are round and quite long....\n\nHow should I proceed?"),
		Title = T(614765790325, --[[ModItemStoryBit grazing_fields_shogu Title]] "An Herbivore!"),
		id = "grazing_fields_shogu",
		max_reply_id = 11,
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(564710430922, --[[ModItemStoryBit grazing_fields_shogu CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(520474499130, --[[ModItemStoryBit grazing_fields_shogu Text]] "Try to Pacify it"),
			param_bindings = false,
			unique_id = 7,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(553034894045, --[[ModItemStoryBit grazing_fields_shogu Text]] "When I approached the herd, their initial reaction was to defend its members.\n\nAfter a few hits, they calmed down and let me drop food for them.\n\nMultiple feedings later, one of these creatures seemed quite attached to me!"),
			Title = T(589927185902, --[[ModItemStoryBit grazing_fields_shogu Title]] "Success?"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
			},
			Text = T(545437972129, --[[ModItemStoryBit grazing_fields_shogu Text]] "When I approached the herd, they where initially quite skeptical.\n\nI dropped food for them and made sure to back off.\n\nAfter multiple feedings later, a few of these creatures seemed quite attached to me!"),
			Title = T(453574711933, --[[ModItemStoryBit grazing_fields_shogu Title]] "Success"),
			Weight = 50,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(211746939470, --[[ModItemStoryBit grazing_fields_shogu Text]] "When I approached the herd, they approached right back!\nBut as they started to smell me, something must have spooked them.\n\nBecause all of a sudden I learned that they have tusks in their mouth!\n\nNo idea what got into them..... but I managed to get away with my life"),
			Title = T(839267403040, --[[ModItemStoryBit grazing_fields_shogu Title]] "Failure"),
			Weight = 150,
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(230732728584, --[[ModItemStoryBit grazing_fields_shogu CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(441521213724, --[[ModItemStoryBit grazing_fields_shogu Text]] "Try to Pacify it"),
			param_bindings = false,
			unique_id = 8,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Shogu",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(109903994796, --[[ModItemStoryBit grazing_fields_shogu Text]] "When I approached the herd, their initial reaction was to defend its members.\n\nAfter a few hits, they calmed down and let me drop food for them.\n\nMultiple feedings later, one of these creatures seemed quite attached to me!"),
			Title = T(760339351093, --[[ModItemStoryBit grazing_fields_shogu Title]] "Success?"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Camel",
					param_bindings = false,
				}),
			},
			Text = T(845712111175, --[[ModItemStoryBit grazing_fields_shogu Text]] "When I approached the herd, they approached right back!\nNot sure how something so trusting is still alive, but that's a problem for another day.\n\nA few bites of food and some scratches later, and a few are coming home with me!"),
			Title = T(290717842549, --[[ModItemStoryBit grazing_fields_shogu Title]] "Success"),
			Weight = 150,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(661767275186, --[[ModItemStoryBit grazing_fields_shogu Text]] "When I approached the herd, they approached right back!\nBut as they started to smell me, something must have spooked them.\n\nBecause all of a sudden I learned that they have tusks in their mouth!\n\nNo idea what got into them..... but I managed to get away with my life"),
			Title = T(524474177346, --[[ModItemStoryBit grazing_fields_shogu Title]] "Failure"),
			Weight = 50,
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(387889771613, --[[ModItemStoryBit grazing_fields_shogu CustomOutcomeText]] "low Combat skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(342850582629, --[[ModItemStoryBit grazing_fields_shogu Text]] "Try to hunt a few"),
			param_bindings = false,
			unique_id = 9,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure",
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure_large",
					'Weight', 50,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_success",
					'Weight', 25,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(931456340206, --[[ModItemStoryBit grazing_fields_shogu CustomOutcomeText]] "high Combat skill; low risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(449081728218, --[[ModItemStoryBit grazing_fields_shogu Text]] "Try to hunt a few"),
			param_bindings = false,
			unique_id = 10,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure",
					'Weight', 50,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure_large",
					'Weight', 25,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_success",
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(788373551886, --[[ModItemStoryBit grazing_fields_shogu CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			Text = T(798152193480, --[[ModItemStoryBit grazing_fields_shogu Text]] "Just leave, that creature doesn't sound useful"),
			param_bindings = false,
			unique_id = 11,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		NotificationTitle = T(288172924175, --[[ModItemStoryBit grazing_fields_tecatli NotificationTitle]] "Expedition update: <ExplorationSiteName>"),
		Prerequisites = {
			PlaceObj('CheckRegion', {
				Negate = true,
				Region = set( "Desertum" ),
				param_bindings = false,
			}),
		},
		Text = T(702457560061, --[[ModItemStoryBit grazing_fields_tecatli Text]] "There is a herd of bipedal scaled... animals?\nIt's hard to tell if these things are cold or hot blooded....\n\nBut I do recognize their teeth as sharp and carnivorous...\nOdd they aren't hunting the other species in the area\n\nHow should I proceed?"),
		Title = T(120811058102, --[[ModItemStoryBit grazing_fields_tecatli Title]] "An Herbivore!"),
		id = "grazing_fields_tecatli",
		max_reply_id = 16,
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(868030338575, --[[ModItemStoryBit grazing_fields_tecatli CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(251324879457, --[[ModItemStoryBit grazing_fields_tecatli Text]] "Try to Pacify it"),
			param_bindings = false,
			unique_id = 12,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Tecatli",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(881856333784, --[[ModItemStoryBit grazing_fields_tecatli Text]] "The herd spread out when they first detected me.\nAnd immediately started surrounding me. \n\nThey did not like it when I tried to maneuver away from the surrounding....\nAfter a few puncture wounds, they hit my pack.\nThis food thankfully distracted them, and let me convince one I am a friend\n\nSo we have one of these coming home with us."),
			Title = T(101322916621, --[[ModItemStoryBit grazing_fields_tecatli Title]] "Success?"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Tecatli",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Tecatli",
					param_bindings = false,
				}),
			},
			Text = T(793395406483, --[[ModItemStoryBit grazing_fields_tecatli Text]] "The herd spread out when they first detected me.\nAnd they started to try and surround me. \n\nThey must have deemed me not a threat, because they backed down after a tense staring session.\n\nI offered them both meat and vegetables, and they reacted quite positively.\nWe now have a few of them coming home!"),
			Title = T(631274798054, --[[ModItemStoryBit grazing_fields_tecatli Title]] "Success"),
			Weight = 50,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(930995255242, --[[ModItemStoryBit grazing_fields_tecatli Text]] "When I approached the herd, they responded with immediate aggression!\n\nTheir fangs and behavior told me they are quite quick to defending themselves!\n\nThankfully I tossed what food I had, and it distracted them enough for me to get away."),
			Title = T(735646412531, --[[ModItemStoryBit grazing_fields_tecatli Title]] "Failure"),
			Weight = 150,
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(289535001173, --[[ModItemStoryBit grazing_fields_tecatli CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(697931435562, --[[ModItemStoryBit grazing_fields_tecatli Text]] "Try to Pacify it"),
			param_bindings = false,
			unique_id = 13,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(922020340358, --[[ModItemStoryBit grazing_fields_tecatli Text]] "When I approached the herd, they responded with immediate aggression!\n\nTheir fangs and behavior told me they are quite quick to defending themselves!\n\nThankfully I tossed what food I had, and it distracted them enough for me to get away."),
			Title = T(821124080922, --[[ModItemStoryBit grazing_fields_tecatli Title]] "Failure"),
			Weight = 50,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Tecatli",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Tecatli",
					param_bindings = false,
				}),
			},
			Text = T(174401448422, --[[ModItemStoryBit grazing_fields_tecatli Text]] "The herd spread out when they first detected me.\nAnd they started to try and surround me. \n\nThey must have deemed me not a threat, because they backed down after a tense staring session.\n\nI offered them both meat and vegetables, and they reacted quite positively.\nWe now have a few of them coming home!"),
			Title = T(321437282837, --[[ModItemStoryBit grazing_fields_tecatli Title]] "Success"),
			Weight = 150,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Tecatli",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(238528755805, --[[ModItemStoryBit grazing_fields_tecatli Text]] "The herd spread out when they first detected me.\nAnd immediately started surrounding me. \n\nThey did not like it when I tried to maneuver away from the surrounding....\nAfter a few puncture wounds, they hit my pack.\nThis food thankfully distracted them, and let me convince one I am a friend\n\nSo we have one of these coming home with us."),
			Title = T(797007991404, --[[ModItemStoryBit grazing_fields_tecatli Title]] "Success?"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(149183354217, --[[ModItemStoryBit grazing_fields_tecatli CustomOutcomeText]] "low Combat skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(505833540163, --[[ModItemStoryBit grazing_fields_tecatli Text]] "Try to hunt a few"),
			param_bindings = false,
			unique_id = 14,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure",
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure_large",
					'Weight', 50,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_success",
					'Weight', 25,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(253615866687, --[[ModItemStoryBit grazing_fields_tecatli CustomOutcomeText]] "high Combat skill; low risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(653607563783, --[[ModItemStoryBit grazing_fields_tecatli Text]] "Try to hunt a few"),
			param_bindings = false,
			unique_id = 15,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure",
					'Weight', 50,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure_large",
					'Weight', 25,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_success",
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(423554109007, --[[ModItemStoryBit grazing_fields_tecatli CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			Text = T(856679409833, --[[ModItemStoryBit grazing_fields_tecatli Text]] "Just leave, that creature doesn't sound useful"),
			param_bindings = false,
			unique_id = 16,
		}),
	}),
	PlaceObj('ModItemStoryBit', {
		NotificationTitle = T(378021600463, --[[ModItemStoryBit grazing_fields_gujo NotificationTitle]] "Expedition update: <ExplorationSiteName>"),
		Prerequisites = {
			PlaceObj('CheckRegion', {
				Negate = true,
				Region = set( "Desertum" ),
				param_bindings = false,
			}),
		},
		Text = T(769196165794, --[[ModItemStoryBit grazing_fields_gujo Text]] "As I touched down, I found many many giant birds chasing the regular inhabitants.\n\nThe birds themselves appeared to be in different stages of malnourishment, and they should be quite easy to hunt or tame.\nWhat should I do? "),
		Title = T(126693164697, --[[ModItemStoryBit grazing_fields_gujo Title]] "An Herbivore!"),
		id = "grazing_fields_gujo",
		max_reply_id = 21,
		save_in = "Mod/Uqo4QkN",
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(874118024529, --[[ModItemStoryBit grazing_fields_gujo CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(854360323673, --[[ModItemStoryBit grazing_fields_gujo Text]] "Try to Pacify a bird"),
			param_bindings = false,
			unique_id = 17,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Gujo",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(813879054885, --[[ModItemStoryBit grazing_fields_gujo Text]] "It was quite easy to get the attention of one of the birds, and from the look in it's eyes it wanted blood.\n\nI did my best to distract it with some of my food, but it seems to lack intelligence to tell that a better meal was right next to it.....\n\nIn between it's aggressively pecking of my chest, I shoved my food into it's mouth and that seemed to calm it.\n\nA few morsels later, and now I have a new friend."),
			Title = T(257631550137, --[[ModItemStoryBit grazing_fields_gujo Title]] "Success?"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Gujo",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Gujo",
					param_bindings = false,
				}),
			},
			Text = T(350762703833, --[[ModItemStoryBit grazing_fields_gujo Text]] "It was quite easy to get the attention of one of the birds.\nI managed to pick one that seemed to have eaten recently.\n\nThanks to that, I was able to immediately direct it to some food I had placed on the ground.\nIt took a few tries for it to recognize the non-moving thing as food..... it finally seemed to understand.\n\nA Gujo who has been successful in its hunt randomly saw my new friend, and in it's.... infinite wisdom, decided to follow along.\n\nApparently because of their lack of intelligence, I now have new friends coming home with me"),
			Title = T(151131677367, --[[ModItemStoryBit grazing_fields_gujo Title]] "Success"),
			Weight = 50,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(771339886452, --[[ModItemStoryBit grazing_fields_gujo Text]] "Well I got ones attention......\nOne extremely aggressive, starving, and quick bird.\n\nIt feels like I am now 20 kilos lighter.... but alive.\nWe should be quite cautious with this species in the future."),
			Title = T(458060421549, --[[ModItemStoryBit grazing_fields_gujo Title]] "Failure"),
			Weight = 150,
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(314357636747, --[[ModItemStoryBit grazing_fields_gujo CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">",
					Skill = "Farming",
					param_bindings = false,
				}),
			},
			Text = T(515998099083, --[[ModItemStoryBit grazing_fields_gujo Text]] "Try to Pacify it"),
			param_bindings = false,
			unique_id = 18,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(271948206341, --[[ModItemStoryBit grazing_fields_gujo Text]] "Well I got ones attention......\nOne extremely aggressive, starving, and quick bird.\n\nIt feels like I am now 20 kilos lighter.... but alive.\nWe should be quite cautious with this species in the future."),
			Title = T(827452470173, --[[ModItemStoryBit grazing_fields_gujo Title]] "Failure"),
			Weight = 50,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Gujo",
					param_bindings = false,
				}),
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Gujo",
					param_bindings = false,
				}),
			},
			Text = T(367072099301, --[[ModItemStoryBit grazing_fields_gujo Text]] "It was quite easy to get the attention of one of the birds.\nI managed to pick one that seemed to have eaten recently.\n\nThanks to that, I was able to immediately direct it to some food I had placed on the ground.\nIt took a few tries for it to recognize the non-moving thing as food..... it finally seemed to understand.\n\nA Gujo who has been successful in its hunt randomly saw my new friend, and in it's.... infinite wisdom, decided to follow along.\n\nApparently because of their lack of intelligence, I now have new friends coming home with me"),
			Title = T(916158219598, --[[ModItemStoryBit grazing_fields_gujo Title]] "Success"),
			Weight = 150,
			param_bindings = false,
		}),
		PlaceObj('StoryBitOutcome', {
			Effects = {
				PlaceObj('GiveExpeditionTameRewardToSurvivor', {
					SpawnClass = "Gujo",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Bite_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
				PlaceObj('AddRemoveHealthCondition', {
					HealthCond = "Scratch_Common",
					HealthCondType = "Injury",
					param_bindings = false,
				}),
			},
			Text = T(630111079119, --[[ModItemStoryBit grazing_fields_gujo Text]] "It was quite easy to get the attention of one of the birds, and from the look in it's eyes it wanted blood.\n\nI did my best to distract it with some of my food, but it seems to lack intelligence to tell that a better meal was right next to it.....\n\nIn between it's aggressively pecking of my chest, I shoved my food into it's mouth and that seemed to calm it.\n\nA few morsels later, and now I have a new friend."),
			Title = T(902308910927, --[[ModItemStoryBit grazing_fields_gujo Title]] "Success?"),
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(743518540977, --[[ModItemStoryBit grazing_fields_gujo CustomOutcomeText]] "low Combat skill; high risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = "<=",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(668053610473, --[[ModItemStoryBit grazing_fields_gujo Text]] "Try to hunt a few"),
			param_bindings = false,
			unique_id = 19,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure",
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure_large",
					'Weight', 50,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_success",
					'Weight', 25,
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(352117710093, --[[ModItemStoryBit grazing_fields_gujo CustomOutcomeText]] "high Combat skill; low risk of injury"),
			HideIfDisabled = true,
			OutcomeText = "custom",
			Prerequisites = {
				PlaceObj('CheckSkillLevel', {
					Amount = 4,
					Condition = ">",
					Skill = "Combat",
					param_bindings = false,
				}),
			},
			Text = T(748699632560, --[[ModItemStoryBit grazing_fields_gujo Text]] "Try to hunt a few"),
			param_bindings = false,
			unique_id = 20,
		}),
		PlaceObj('StoryBitOutcome', {
			StoryBits = {
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure",
					'Weight', 50,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_failure_large",
					'Weight', 25,
				}),
				PlaceObj('StoryBitWithWeight', {
					'StoryBitId', "site_grazing_fields_hunt_success",
				}),
			},
			param_bindings = false,
		}),
		PlaceObj('StoryBitReply', {
			CustomOutcomeText = T(560758799202, --[[ModItemStoryBit grazing_fields_gujo CustomOutcomeText]] "low Farming skill; high risk of injury"),
			HideIfDisabled = true,
			Text = T(955042835242, --[[ModItemStoryBit grazing_fields_gujo Text]] "Just leave, that creature doesn't sound useful"),
			param_bindings = false,
			unique_id = 21,
		}),
	}),
	}),
}
