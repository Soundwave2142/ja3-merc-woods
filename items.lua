return {
	PlaceObj('ModItemFolder', {
		'name', "Defenitions",
		'comment', "Everything related to how the merc is defined in gam",
	}, {
		PlaceObj('ModItemConvertAsset', {
			'name', "ConvertAsset",
			'comment', "Converts from .png to game format",
			'allowedExt', ".png | .jpg | .tga",
			'destFolder', "Mod/iXq5UQs/Images",
		}),
		PlaceObj('ModItemUnitDataCompositeDef', {
			'Group', "MercenariesNew",
			'Id', "Woods",
			'comment', "Holds overall information about merc, from stats to references of other components",
			'object_class', "UnitData",
			'Health', 86,
			'Agility', 80,
			'Dexterity', 83,
			'Strength', 71,
			'Wisdom', 66,
			'Leadership', 42,
			'Marksmanship', 86,
			'Mechanical', 32,
			'Explosives', 51,
			'Medical', 18,
			'Portrait', "Mod/iXq5UQs/Images/woods_portrait_small.png",
			'BigPortrait', "Mod/iXq5UQs/Images/woods_portrait_full.png",
			'IsMercenary', true,
			'Name', T(117779094280, --[[ModItemUnitDataCompositeDef Woods Name]] "Frank Woods"),
			'Nick', T(186885432568, --[[ModItemUnitDataCompositeDef Woods Nick]] "Woods"),
			'AllCapsNick', T(653767947505, --[[ModItemUnitDataCompositeDef Woods AllCapsNick]] "WOODS"),
			'Bio', T(443033985929, --[[ModItemUnitDataCompositeDef Woods Bio]] "He ran away from his home as a young child, forced to rely on street smarts and follow his instincts. Woods quickly learned to be fully independent.\n\nHe served in the United States Marine Corps, during which he had much combat experience fighting in the Korean War. This gained him a reputation that led the CIA to recruit him for their Special Activities Division.\n\nAfter lengthy career and a betrayal he refuses to talk about, Woods found himself on the free market."),
			'Nationality', "USA",
			'Title', T(934935202072, --[[ModItemUnitDataCompositeDef Woods Title]] "YOU CAN'T KILL ME!"),
			'Email', T(634887339728, --[[ModItemUnitDataCompositeDef Woods Email]] "FrankWoods@aim.com"),
			'snype_nick', T(158396975608, --[[ModItemUnitDataCompositeDef Woods snype_nick]] "WOODS"),
			'ExtraPartingWords', {},
			'Offline', {
				PlaceObj('ChatMessage', {
					'Text', T(139388634169, --[[ModItemUnitDataCompositeDef Woods Text Offline ChatMessage voice:Woods]] "Keep going, soldier!"),
				}),
			},
			'GreetingAndOffer', {
				PlaceObj('ChatMessage', {
					'Text', T(445300168799, --[[ModItemUnitDataCompositeDef Woods Text GreetingAndOffer ChatMessage voice:Woods]] "Whatcha need?"),
				}),
			},
			'ConversationRestart', {
				PlaceObj('ChatMessage', {
					'Text', T(304588569694, --[[ModItemUnitDataCompositeDef Woods Text ConversationRestart ChatMessage voice:Woods]] "Yeah, yeah."),
				}),
			},
			'IdleLine', {
				PlaceObj('ChatMessage', {
					'Text', T(709339022582, --[[ModItemUnitDataCompositeDef Woods Text IdleLine ChatMessage voice:Woods]] "What are you looking at?"),
				}),
			},
			'PartingWords', {
				PlaceObj('ChatMessage', {
					'Text', T(412177064544, --[[ModItemUnitDataCompositeDef Woods Text PartingWords ChatMessage voice:Woods]] "Let's get this fucking thing done!"),
				}),
			},
			'RehireIntro', {
				PlaceObj('ChatMessage', {
					'Text', T(554693637023, --[[ModItemUnitDataCompositeDef Woods Text RehireIntro ChatMessage voice:Woods]] "You all need me in this!"),
				}),
			},
			'RehireOutro', {
				PlaceObj('ChatMessage', {
					'Text', T(850529824249, --[[ModItemUnitDataCompositeDef Woods Text RehireOutro ChatMessage voice:Woods]] "Time to do some damage, brother."),
				}),
			},
			'StartingSalary', 2950,
			'SalaryIncrease', 200,
			'SalaryMaxLv', 6000,
			'StartingLevel', 4,
			'Likes', {
				"Raven",
				"Meltdown",
				"Len",
			},
			'LearnToLike', {
				"Raider",
				"Nails",
			},
			'Dislikes', {
				"Ivan",
				"Omryn",
			},
			'LearnToDislike', {
				"Igor",
				"MD",
			},
			'StartingPerks', {
				"WoodsEffect",
				"AutoWeapons",
				"NightOps",
				"Spiritual",
				"OldDog",
				"TakeAim",
				"OpportunisticKiller",
				"Hotblood",
			},
			'AppearancesList', {
				PlaceObj('AppearanceWeight', {
					'Preset', "Woods",
				}),
			},
			'Equipment', {
				"Woods",
			},
			'Tier', "Elite",
			'Specialization', "AllRounder",
			'pollyvoice', "Nicole",
			'gender', "Male",
			'blocked_spots', set(),
			'VoiceResponseId', "Woods",
			'FallbackMissingVR', "Steroid",
			'DaysUntilOnline', 1,
		}),
		PlaceObj('ModItemCharacterEffectCompositeDef', {
			'Group', "Perk-Personal",
			'Id', "WoodsEffect",
			'Parameters', {
				PlaceObj('PresetParamPercent', {
					'Name', "chanceToProc",
					'Value', 50,
					'Tag', "<chanceToProc>%",
				}),
			},
			'comment', "Get Payback on turn start, give to random ally on kill",
			'object_class', "Perk",
			'unit_reactions', {
				PlaceObj('UnitReaction', {
					Event = "OnBeginTurn",
					Handler = function (self, target)
						target:AddStatusEffect("Payback")
					end,
					param_bindings = false,
				}),
				PlaceObj('UnitReaction', {
					Event = "OnUnitKill",
					Handler = function (self, target, killedUnits)
						if target:HasStatusEffect('Payback') then
							local squad = gv_Squads[target.Squad]
							local allies = {}
							
							-- prepare the list of allies
							for _,unitId in pairs(squad.units) do
								if unitId ~= "Woods" then
									allies[#allies+1] = unitId
								end
							end
							
							-- find count to make sure atleast one ally is present then select random ally
							local count = 0
							for _ in pairs(allies) do count = count + 1 end
							
							if count > 0 then
								local allyId = allies[math.random(#allies)]
								local ally = g_Units[allyId]
								-- move from Woods to random ally effect Payback
								target:RemoveStatusEffect("Payback")
								ally:AddStatusEffect("Payback")
								
								-- also roll for chance to become inspired
								local chance = self:ResolveValue("chanceToProc")
								local roll = InteractionRand(100, "WoodsEffectInspired")
								if roll < chance then
									ally:AddStatusEffect("Inspired")
								end
							end
						end
					end,
					param_bindings = false,
				}),
			},
			'DisplayName', T(268564161033, --[[ModItemCharacterEffectCompositeDef WoodsEffect DisplayName]] "WMD"),
			'Description', T(561136195130, --[[ModItemCharacterEffectCompositeDef WoodsEffect Description]] "Receive <color EmStyle>Payback</color> at the start of <color EmStyle>each turn</color>. Upon killing an enemy, move one stack from self to a random ally; that ally has a chance to become <color EmStyle>Inspired</color>.\n\nEach stack of <color EmStyle>Payback</color> increases <color EmStyle>Damage</color> with a higher <color EmStyle>Chance to hit</color> until the end of the combat."),
			'OnAdded', function (self, obj)  end,
			'Icon', "UI/Icons/Perks/HawksEye",
			'Tier', "Personal",
		}),
		PlaceObj('ModItemCharacterEffectCompositeDef', {
			'Group', "System",
			'Id', "Payback",
			'Parameters', {
				PlaceObj('PresetParamPercent', {
					'Name', "damageMod",
					'Value', 5,
					'Tag', "<damageMod>%",
				}),
				PlaceObj('PresetParamPercent', {
					'Name', "hitChanceMod",
					'Value', 5,
					'Tag', "<hitChanceMod>%",
				}),
			},
			'comment', "More accuracy and damage per stack, given by Woods",
			'object_class', "CharacterEffect",
			'unit_reactions', {
				PlaceObj('UnitReaction', {
					Event = "OnCalcDamageAndEffects",
					Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
						if target == attacker then
							local damageBonus = self:ResolveValue("damageMod") * self.stacks
							data.base_damage = MulDivRound(data.base_damage, 100 + damageBonus, 100)
							data.breakdown[#data.breakdown + 1] = { name = self.DisplayName, value = damageBonus }	
						end
					end,
					param_bindings = false,
				}),
				PlaceObj('UnitReaction', {
					Event = "OnCalcChanceToHit",
					Handler = function (self, target, attacker, action, attack_target, weapon1, weapon2, data)
						if target == attacker then
							local chanceBonus = self:ResolveValue("hitChanceMod") * self.stacks
							data.mod_add = data.mod_add + chanceBonus
						end
					end,
					param_bindings = false,
				}),
			},
			'DisplayName', T(183156117080, --[[ModItemCharacterEffectCompositeDef Payback DisplayName]] "Payback"),
			'Description', T(109578663805, --[[ModItemCharacterEffectCompositeDef Payback Description]] "Deal slightly more <em>Damage</em> with a slightly higher <em>Chance to hit</em> until the end of the combat (this effect stacks)."),
			'OnAdded', function (self, obj)  end,
			'Icon', "UI/Hud/Status effects/bloodthirst",
			'max_stacks', 5,
			'RemoveOnEndCombat', true,
			'Shown', true,
			'HasFloatingText', true,
		}),
		PlaceObj('ModItemLootDef', {
			comment = "Holds information about merc's gear on start",
			group = "Mercs",
			id = "Woods",
			loot = "all",
			PlaceObj('LootEntryInventoryItem', {
				Condition = 80,
				RandomizeCondition = true,
				item = "FlakArmor_WeavePadding",
			}),
			PlaceObj('LootEntryUpgradedWeapon', {
				upgrades = {
					"MagLargeFine",
					"StockLight",
				},
				weapon = "M4Commando",
			}),
			PlaceObj('LootEntryInventoryItem', {
				item = "_556_HP",
				stack_max = 60,
				stack_min = 60,
			}),
			PlaceObj('LootEntryInventoryItem', {
				item = "_556_AP",
				stack_max = 30,
				stack_min = 30,
			}),
			PlaceObj('LootEntryInventoryItem', {
				item = "_40mmFragGrenade",
				stack_max = 2,
				stack_min = 2,
			}),
			PlaceObj('LootEntryInventoryItem', {
				item = "HE_Grenade",
				stack_max = 1,
				stack_min = 1,
			}),
			PlaceObj('LootEntryInventoryItem', {
				item = "SmokeGrenade",
				stack_max = 1,
				stack_min = 1,
			}),
			PlaceObj('LootEntryInventoryItem', {
				item = "GlowStick",
				stack_max = 1,
				stack_min = 1,
			}),
		}),
		}),
	PlaceObj('ModItemFolder', {
		'name', "Appearence",
		'comment', "Everything related to how the merc looks",
	}, {
		PlaceObj('ModItemAppearancePreset', {
			ArmorColor = PlaceObj('ColorizationPropSet', {
				'EditableColor1', RGBA(105, 62, 7, 255),
				'EditableColor2', RGBA(120, 200, 43, 255),
				'EditableColor3', RGBA(120, 200, 43, 255),
			}),
			Body = "Body_Woods",
			BodyColor = PlaceObj('ColorizationPropSet', {
				'EditableColor1', RGBA(215, 159, 80, 255),
				'EditableColor2', RGBA(52, 77, 53, 255),
			}),
			ChestColor = PlaceObj('ColorizationPropSet', {
				'EditableColor1', RGBA(0, 0, 0, 255),
				'EditableColor2', RGBA(0, 0, 0, 255),
				'EditableColor3', RGBA(0, 0, 0, 255),
			}),
			HairColor = PlaceObj('ColorizationPropSet', {
				'EditableColor1', RGBA(239, 56, 124, 255),
				'EditableRoughness1', 10,
				'EditableMetallic1', -70,
				'EditableColor2', RGBA(223, 116, 166, 255),
				'EditableRoughness2', -44,
				'EditableMetallic2', -128,
				'EditableColor3', RGBA(232, 122, 163, 255),
				'EditableRoughness3', -25,
				'EditableMetallic3', 127,
			}),
			Hat2 = "",
			Hat2Color = PlaceObj('ColorizationPropSet', {
				'EditableColor1', RGBA(0, 0, 0, 255),
				'EditableColor2', RGBA(0, 0, 0, 255),
				'EditableColor3', RGBA(0, 0, 0, 255),
			}),
			Hat2Spot = "Origin",
			HatAttachOffsetAngle = 0,
			HatAttachOffsetX = 0,
			HatAttachOffsetY = 0,
			HatAttachOffsetZ = 0,
			HatColor = PlaceObj('ColorizationPropSet', {
				'EditableColor1', RGBA(0, 0, 0, 255),
				'EditableRoughness1', 48,
				'EditableMetallic1', -48,
				'EditableColor2', RGBA(0, 0, 0, 255),
				'EditableColor3', RGBA(255, 83, 244, 255),
			}),
			HatSpot = "Origin",
			Head = "Head_Woods",
			HeadColor = PlaceObj('ColorizationPropSet', nil),
			HipColor = PlaceObj('ColorizationPropSet', {
				'EditableColor1', RGBA(69, 58, 39, 255),
				'EditableColor2', RGBA(69, 58, 39, 255),
				'EditableColor3', RGBA(69, 58, 39, 255),
			}),
			Pants = "Pants_Woods",
			PantsColor = PlaceObj('ColorizationPropSet', {
				'EditableColor1', RGBA(52, 77, 53, 255),
				'EditableColor2', RGBA(52, 77, 53, 255),
				'EditableColor3', RGBA(52, 77, 53, 255),
			}),
			Shirt = "",
			ShirtColor = PlaceObj('ColorizationPropSet', {
				'EditableColor1', RGBA(48, 25, 14, 255),
				'EditableColor2', RGBA(48, 25, 14, 255),
				'EditableColor3', RGBA(48, 25, 14, 255),
			}),
			comment = "Definition of the look",
			group = "Mercs",
			id = "Woods",
		}),
		PlaceObj('ModItemEntity', {
			'name', "Head_Woods",
			'class_parent', "CharacterHeadMale",
			'entity_name', "Head_Woods",
		}),
		PlaceObj('ModItemEntity', {
			'name', "Body_Woods",
			'class_parent', "CharacterBodyMale",
			'entity_name', "Body_Woods",
		}),
		PlaceObj('ModItemEntity', {
			'name', "Pants_Woods",
			'class_parent', "CharacterPantsMale",
			'entity_name', "Pants_Woods",
		}),
		}),
	PlaceObj('ModItemFolder', {
		'name', "Voice",
		'comment', "Everything related to what the merc says",
	}, {
		PlaceObj('ModItemConvertAsset', {
			'name', "ConvertAssetSound",
			'comment', "Converts from .wav to game format",
			'assetType', "Sound",
			'allowedExt', ".wav",
			'destFolder', "Mod/iXq5UQs/Sounds/English",
		}),
		PlaceObj('ModItemTranslatedVoices', {
			'name', "TranslatedVoices",
			'comment', "Mounts voices for any locale",
			'language', "Any",
			'translatedVoicesFolder', "Mod/iXq5UQs/Sounds/English",
		}),
		PlaceObj('ModItemVoiceResponse', {
			ActivityFinished = TConcat({
				T(266808901528, --[[ModItemVoiceResponse Woods ActivityFinished VoiceResponse ActivityFinished - SatView activity finished voice:Woods]] "We're clear, Major. Take us home."),
				T(301002499499, --[[ModItemVoiceResponse Woods ActivityFinished VoiceResponse ActivityFinished - SatView activity finished voice:Woods]] "Hey, you can celebrate later."),
				T(212933404846, --[[ModItemVoiceResponse Woods ActivityFinished VoiceResponse ActivityFinished - SatView activity finished voice:Woods]] "Alright boys, I'm buying.")
			}),
			ActivityStarted = TConcat({
				T(460767418905, --[[ModItemVoiceResponse Woods ActivityStarted VoiceResponse ActivityStarted - When an activity is started. Played by the firs merc associated with the task voice:Woods]] "Right. Time to get our hands dirty."),
				T(253278063715, --[[ModItemVoiceResponse Woods ActivityStarted VoiceResponse ActivityStarted - When an activity is started. Played by the firs merc associated with the task voice:Woods]] "Let's get this fucking thing done!"),
				T(773510987715, --[[ModItemVoiceResponse Woods ActivityStarted VoiceResponse ActivityStarted - When an activity is started. Played by the firs merc associated with the task voice:Woods]] "I should crack open a cold one after that.")
			}),
			AimAttack = TConcat({
				T(500067638987, --[[ModItemVoiceResponse Woods AimAttack VoiceResponse AimAttack - When aiming and there is a decent chance of hitting voice:Woods]] "One shot's all I need."),
				T(194507111664, --[[ModItemVoiceResponse Woods AimAttack VoiceResponse AimAttack - When aiming and there is a decent chance of hitting voice:Woods]] "Gonna make a real mess."),
				T(553637501066, --[[ModItemVoiceResponse Woods AimAttack VoiceResponse AimAttack - When aiming and there is a decent chance of hitting voice:Woods]] "Pfft! You're done, dipshit."),
				T(879283218113, --[[ModItemVoiceResponse Woods AimAttack VoiceResponse AimAttack - When aiming and there is a decent chance of hitting voice:Woods]] "Tick-tock, motherfucker!"),
				T(578580417538, --[[ModItemVoiceResponse Woods AimAttack VoiceResponse AimAttack - When aiming and there is a decent chance of hitting voice:Woods]] "Roger that. Have eyes on."),
				T(591506290696, --[[ModItemVoiceResponse Woods AimAttack VoiceResponse AimAttack - When aiming and there is a decent chance of hitting voice:Woods]] "Fire when ready.")
			}),
			AimAttackStealth = TConcat({
				T(436899338141, --[[ModItemVoiceResponse Woods AimAttackStealth VoiceResponse AimAttackStealth - When aiming and there is a decent chance of hitting. Used while Sneaking - voice should be shushed (except Steroid) voice:Woods]] "Gonna see us if we don't shoot first!"),
				T(769873013283, --[[ModItemVoiceResponse Woods AimAttackStealth VoiceResponse AimAttackStealth - When aiming and there is a decent chance of hitting. Used while Sneaking - voice should be shushed (except Steroid) voice:Woods]] "You take one, I'll get the other."),
				T(772027187000, --[[ModItemVoiceResponse Woods AimAttackStealth VoiceResponse AimAttackStealth - When aiming and there is a decent chance of hitting. Used while Sneaking - voice should be shushed (except Steroid) voice:Woods]] "Surprise, bitch!"),
				T(635490067873, --[[ModItemVoiceResponse Woods AimAttackStealth VoiceResponse AimAttackStealth - When aiming and there is a decent chance of hitting. Used while Sneaking - voice should be shushed (except Steroid) voice:Woods]] "Good night, you frosty fuckers.")
			}),
			AimAttack_Low = TConcat({
				T(603525505965, --[[ModItemVoiceResponse Woods AimAttack_Low VoiceResponse AimAttack_Low - When aiming and the CtH is less than 20% voice:Woods]] "F that noise."),
				T(276575966744, --[[ModItemVoiceResponse Woods AimAttack_Low VoiceResponse AimAttack_Low - When aiming and the CtH is less than 20% voice:Woods]] "Need a different spot."),
				T(619714710913, --[[ModItemVoiceResponse Woods AimAttack_Low VoiceResponse AimAttack_Low - When aiming and the CtH is less than 20% voice:Woods]] "Won't fucking work here.")
			}),
			AimAttack_LowStealth = TConcat({
				T(759711566410, --[[ModItemVoiceResponse Woods AimAttack_LowStealth VoiceResponse AimAttack_LowStealth - When aiming and there is very low chance of hitting. Used while Sneaking - voice should be shushed (except Steroid) voice:Woods]] "One shot and done."),
				T(634228265491, --[[ModItemVoiceResponse Woods AimAttack_LowStealth VoiceResponse AimAttack_LowStealth - When aiming and there is very low chance of hitting. Used while Sneaking - voice should be shushed (except Steroid) voice:Woods]] "I got good aim. Real good.")
			}),
			AmmoLow = TConcat({
				T(188490209893, --[[ModItemVoiceResponse Woods AmmoLow VoiceResponse AmmoLow - Played when there is less than 25% of clip size or a full reload cannot be made voice:Woods]] "Who's got ammo?"),
				T(974427716731, --[[ModItemVoiceResponse Woods AmmoLow VoiceResponse AmmoLow - Played when there is less than 25% of clip size or a full reload cannot be made voice:Woods]] "I'm black on ammo."),
				T(728565724345, --[[ModItemVoiceResponse Woods AmmoLow VoiceResponse AmmoLow - Played when there is less than 25% of clip size or a full reload cannot be made voice:Woods]] "Need special ammo")
			}),
			AnimalFound = TConcat({
				T(772165850060, --[[ModItemVoiceResponse Woods AnimalFound VoiceResponse AnimalFound - Enemy animal spotted. voice:Woods]] "Look at that monster."),
				T(630733716133, --[[ModItemVoiceResponse Woods AnimalFound VoiceResponse AnimalFound - Enemy animal spotted. voice:Woods]] "Contact! Unknown threat!")
			}),
			Autofire = TConcat({
				T(629236329065, --[[ModItemVoiceResponse Woods Autofire VoiceResponse Autofire - When using machine gun autofire attacks. Voice is played during the attack and gunfire sounds. voice:Woods]] "Get some!"),
				T(159620138778, --[[ModItemVoiceResponse Woods Autofire VoiceResponse Autofire - When using machine gun autofire attacks. Voice is played during the attack and gunfire sounds. voice:Woods]] "Oh yeah! I'm back in the game, baby!"),
				T(928821715126, --[[ModItemVoiceResponse Woods Autofire VoiceResponse Autofire - When using machine gun autofire attacks. Voice is played during the attack and gunfire sounds. voice:Woods]] "Big gun, big man. Big fucking deal."),
				T(830348780964, --[[ModItemVoiceResponse Woods Autofire VoiceResponse Autofire - When using machine gun autofire attacks. Voice is played during the attack and gunfire sounds. voice:Woods]] "Death Machines down. You can come out now."),
				T(729503487145, --[[ModItemVoiceResponse Woods Autofire VoiceResponse Autofire - When using machine gun autofire attacks. Voice is played during the attack and gunfire sounds. voice:Woods]] "Shit hits the fan, I'll have this.")
			}),
			BandageDownedUnit = TConcat({
				T(389756092201, --[[ModItemVoiceResponse Woods BandageDownedUnit VoiceResponse BandageDownedUnit - When a downed unit is bandaged. Played by the unit that does the bandaging voice:Woods]] "What are you waiting for? Get back in it!"),
				T(864486169343, --[[ModItemVoiceResponse Woods BandageDownedUnit VoiceResponse BandageDownedUnit - When a downed unit is bandaged. Played by the unit that does the bandaging voice:Woods]] "Walk it off."),
				T(366420040269, --[[ModItemVoiceResponse Woods BandageDownedUnit VoiceResponse BandageDownedUnit - When a downed unit is bandaged. Played by the unit that does the bandaging voice:Woods]] "Thank me later."),
				T(487294115227, --[[ModItemVoiceResponse Woods BandageDownedUnit VoiceResponse BandageDownedUnit - When a downed unit is bandaged. Played by the unit that does the bandaging voice:Woods]] "Quit crying, you're fine."),
				T(434340039241, --[[ModItemVoiceResponse Woods BandageDownedUnit VoiceResponse BandageDownedUnit - When a downed unit is bandaged. Played by the unit that does the bandaging voice:Woods]] "Think I'd let you die?"),
				T(621826419796, --[[ModItemVoiceResponse Woods BandageDownedUnit VoiceResponse BandageDownedUnit - When a downed unit is bandaged. Played by the unit that does the bandaging voice:Woods]] "Want mommy to kiss it better?"),
				T(376730356757, --[[ModItemVoiceResponse Woods BandageDownedUnit VoiceResponse BandageDownedUnit - When a downed unit is bandaged. Played by the unit that does the bandaging voice:Woods]] "That barely scratched you.")
			}),
			BecomeHidden = TConcat({
				T(377377891634, --[[ModItemVoiceResponse Woods BecomeHidden VoiceResponse BecomeHidden - Played when entering Sneak mode. Voice should be shushed (except Steroid) voice:Woods]] "I'm going hunting."),
				T(178627112434, --[[ModItemVoiceResponse Woods BecomeHidden VoiceResponse BecomeHidden - Played when entering Sneak mode. Voice should be shushed (except Steroid) voice:Woods]] "I am the fuckin' boogeyman."),
				T(237790408969, --[[ModItemVoiceResponse Woods BecomeHidden VoiceResponse BecomeHidden - Played when entering Sneak mode. Voice should be shushed (except Steroid) voice:Woods]] "Alright, I'm set.")
			}),
			Climbing = TConcat({
				T(149615661692, --[[ModItemVoiceResponse Woods Climbing VoiceResponse Climbing - Emote. When unit is climbing over fences, on cliffs, etc. voice:Woods]] "Huh!"),
				T(391377108457, --[[ModItemVoiceResponse Woods Climbing VoiceResponse Climbing - Emote. When unit is climbing over fences, on cliffs, etc. voice:Woods]] "Huh!"),
				T(373445327253, --[[ModItemVoiceResponse Woods Climbing VoiceResponse Climbing - Emote. When unit is climbing over fences, on cliffs, etc. voice:Woods]] "Huh!")
			}),
			CombatEndEnemiesRemain = TConcat({
				T(758386133056, --[[ModItemVoiceResponse Woods CombatEndEnemiesRemain VoiceResponse CombatEndEnemiesRemain - There are no more aware enemies but there are still enemies in the sector. voice:Woods]] "Tell your fucking friends you ain't welcome."),
				T(737854841839, --[[ModItemVoiceResponse Woods CombatEndEnemiesRemain VoiceResponse CombatEndEnemiesRemain - There are no more aware enemies but there are still enemies in the sector. voice:Woods]] "Yeah, you better run!"),
				T(198352738130, --[[ModItemVoiceResponse Woods CombatEndEnemiesRemain VoiceResponse CombatEndEnemiesRemain - There are no more aware enemies but there are still enemies in the sector. voice:Woods]] "Anyone else?")
			}),
			CombatEndEnemiesRetreated = TConcat({
				T(267145089964, --[[ModItemVoiceResponse Woods CombatEndEnemiesRetreated VoiceResponse CombatEndEnemiesRetreated - All enemies have retreated voice:Woods]] "Get back here, you cowards! We still got a battle on our hands!"),
				T(263370072972, --[[ModItemVoiceResponse Woods CombatEndEnemiesRetreated VoiceResponse CombatEndEnemiesRetreated - All enemies have retreated voice:Woods]] "Yeah, you better run!"),
				T(733961592773, --[[ModItemVoiceResponse Woods CombatEndEnemiesRetreated VoiceResponse CombatEndEnemiesRetreated - All enemies have retreated voice:Woods]] "What? Can't handle a little heat?"),
				T(163006861659, --[[ModItemVoiceResponse Woods CombatEndEnemiesRetreated VoiceResponse CombatEndEnemiesRetreated - All enemies have retreated voice:Woods]] "If you come back, why don't you try growing a pair?"),
				T(939369390365, --[[ModItemVoiceResponse Woods CombatEndEnemiesRetreated VoiceResponse CombatEndEnemiesRetreated - All enemies have retreated voice:Woods]] "You had enough? Thought so.")
			}),
			CombatEndNoEnemies = TConcat({
				T(990499703177, --[[ModItemVoiceResponse Woods CombatEndNoEnemies VoiceResponse CombatEndNoEnemies - All enemies have been killed. voice:Woods]] "I think we're in the clear."),
				T(115154915071, --[[ModItemVoiceResponse Woods CombatEndNoEnemies VoiceResponse CombatEndNoEnemies - All enemies have been killed. voice:Woods]] "That's the last of them, boys. All right."),
				T(410358638763, --[[ModItemVoiceResponse Woods CombatEndNoEnemies VoiceResponse CombatEndNoEnemies - All enemies have been killed. voice:Woods]] "Heh, they weren't so tough."),
				T(474225973204, --[[ModItemVoiceResponse Woods CombatEndNoEnemies VoiceResponse CombatEndNoEnemies - All enemies have been killed. voice:Woods]] "When are they gonna give us a real fucking challenge?"),
				T(518906068135, --[[ModItemVoiceResponse Woods CombatEndNoEnemies VoiceResponse CombatEndNoEnemies - All enemies have been killed. voice:Woods]] "That's the last of those fuckers!"),
				T(460392323873, --[[ModItemVoiceResponse Woods CombatEndNoEnemies VoiceResponse CombatEndNoEnemies - All enemies have been killed. voice:Woods]] "That's all me, baby. All me."),
				T(324461978760, --[[ModItemVoiceResponse Woods CombatEndNoEnemies VoiceResponse CombatEndNoEnemies - All enemies have been killed. voice:Woods]] "That was easy. Kinda.")
			}),
			CombatMovement = TConcat({
				T(683247878093, --[[ModItemVoiceResponse Woods CombatMovement VoiceResponse CombatMovement - When ordering movement in combat. Up to one full sentence or two short ones. voice:Woods]] "That's what they pay me for."),
				T(868404011116, --[[ModItemVoiceResponse Woods CombatMovement VoiceResponse CombatMovement - When ordering movement in combat. Up to one full sentence or two short ones. voice:Woods]] "Received and understood."),
				T(492263124770, --[[ModItemVoiceResponse Woods CombatMovement VoiceResponse CombatMovement - When ordering movement in combat. Up to one full sentence or two short ones. voice:Woods]] "Affirmative."),
				T(611407481270, --[[ModItemVoiceResponse Woods CombatMovement VoiceResponse CombatMovement - When ordering movement in combat. Up to one full sentence or two short ones. voice:Woods]] "On your target!"),
				T(896300668649, --[[ModItemVoiceResponse Woods CombatMovement VoiceResponse CombatMovement - When ordering movement in combat. Up to one full sentence or two short ones. voice:Woods]] "Roger that. Moving to engage."),
				T(869622055714, --[[ModItemVoiceResponse Woods CombatMovement VoiceResponse CombatMovement - When ordering movement in combat. Up to one full sentence or two short ones. voice:Woods]] "Hard copy. Going hot."),
				T(469783809083, --[[ModItemVoiceResponse Woods CombatMovement VoiceResponse CombatMovement - When ordering movement in combat. Up to one full sentence or two short ones. voice:Woods]] "Loud and clear."),
				T(713112004110, --[[ModItemVoiceResponse Woods CombatMovement VoiceResponse CombatMovement - When ordering movement in combat. Up to one full sentence or two short ones. voice:Woods]] "Target acknowledged."),
				T(619666796675, --[[ModItemVoiceResponse Woods CombatMovement VoiceResponse CombatMovement - When ordering movement in combat. Up to one full sentence or two short ones. voice:Woods]] "Copy that. I'm on it.")
			}),
			CombatMovementStealth = TConcat({
				T(522077794406, --[[ModItemVoiceResponse Woods CombatMovementStealth VoiceResponse CombatMovementStealth - When ordering movement while sneaking. Voice should be shushed (except Steroid) voice:Woods]] "Good idea."),
				T(504566071712, --[[ModItemVoiceResponse Woods CombatMovementStealth VoiceResponse CombatMovementStealth - When ordering movement while sneaking. Voice should be shushed (except Steroid) voice:Woods]] "Hmm, smart."),
				T(228635796347, --[[ModItemVoiceResponse Woods CombatMovementStealth VoiceResponse CombatMovementStealth - When ordering movement while sneaking. Voice should be shushed (except Steroid) voice:Woods]] "So, uh, you better go first."),
				T(502103743997, --[[ModItemVoiceResponse Woods CombatMovementStealth VoiceResponse CombatMovementStealth - When ordering movement while sneaking. Voice should be shushed (except Steroid) voice:Woods]] "I'm a goddamn onion, Mason. You should know that."),
				T(245491087238, --[[ModItemVoiceResponse Woods CombatMovementStealth VoiceResponse CombatMovementStealth - When ordering movement while sneaking. Voice should be shushed (except Steroid) voice:Woods]] "Looks good to me.")
			}),
			CombatStartDetected = TConcat({
				T(216435630348, --[[ModItemVoiceResponse Woods CombatStartDetected VoiceResponse CombatStartDetected - When enemy detects a merc who was hiding. voice:Woods]] "Gotta do everything the hard way, don't you?"),
				T(878040052213, --[[ModItemVoiceResponse Woods CombatStartDetected VoiceResponse CombatStartDetected - When enemy detects a merc who was hiding. voice:Woods]] "Fuck, let's move!"),
				T(721203920677, --[[ModItemVoiceResponse Woods CombatStartDetected VoiceResponse CombatStartDetected - When enemy detects a merc who was hiding. voice:Woods]] "Going loud, huh? I like it."),
				T(547460801440, --[[ModItemVoiceResponse Woods CombatStartDetected VoiceResponse CombatStartDetected - When enemy detects a merc who was hiding. voice:Woods]] "Cat's out of the fucking bag now, ain't it?"),
				T(632211559846, --[[ModItemVoiceResponse Woods CombatStartDetected VoiceResponse CombatStartDetected - When enemy detects a merc who was hiding. voice:Woods]] "You're one sneaky son of a bitch.")
			}),
			CombatStartPlayer = TConcat({
				T(382311678868, --[[ModItemVoiceResponse Woods CombatStartPlayer VoiceResponse CombatStartPlayer - When player initiates combat with shot. voice:Woods]] "Draw your weapon. Time to get dirty."),
				T(268989329703, --[[ModItemVoiceResponse Woods CombatStartPlayer VoiceResponse CombatStartPlayer - When player initiates combat with shot. voice:Woods]] "Right. Time to get our hands dirty."),
				T(320778536463, --[[ModItemVoiceResponse Woods CombatStartPlayer VoiceResponse CombatStartPlayer - When player initiates combat with shot. voice:Woods]] "Here we go."),
				T(915206987124, --[[ModItemVoiceResponse Woods CombatStartPlayer VoiceResponse CombatStartPlayer - When player initiates combat with shot. voice:Woods]] "Oh yeah, first blood to me.")
			}),
			CombatTaskCompleted = TConcat({
				T(129103817775, --[[ModItemVoiceResponse Woods CombatTaskCompleted VoiceResponse CombatTaskCompleted - When the Combat Task issued by the merc is completed voice:Woods]] "Let's fucking go."),
				T(775685580596, --[[ModItemVoiceResponse Woods CombatTaskCompleted VoiceResponse CombatTaskCompleted - When the Combat Task issued by the merc is completed voice:Woods]] "We're done here. Time to move."),
				T(947106095050, --[[ModItemVoiceResponse Woods CombatTaskCompleted VoiceResponse CombatTaskCompleted - When the Combat Task issued by the merc is completed voice:Woods]] "That's how I get shit done."),
				T(843648239059, --[[ModItemVoiceResponse Woods CombatTaskCompleted VoiceResponse CombatTaskCompleted - When the Combat Task issued by the merc is completed voice:Woods]] "I'm gonna put that down as another win for me.")
			}),
			CombatTaskFailed = TConcat({
				T(927739439765, --[[ModItemVoiceResponse Woods CombatTaskFailed VoiceResponse CombatTaskFailed - When the Combat Task issued by the merc is failed voice:Woods]] "That's no fucking kind of result.")
			}),
			CombatTaskGiven = TConcat({
				T(329970901182, --[[ModItemVoiceResponse Woods CombatTaskGiven VoiceResponse CombatTaskGiven - When the merc sets the player a new Combat Task voice:Woods]] "Let's get this fucking thing done!")
			}),
			ContractExpired = TConcat({
				T(744383467816, --[[ModItemVoiceResponse Woods ContractExpired VoiceResponse ContractExpired - when the mercs contract expires and the player has not extended it voice:Woods]] "We're done here. Time to move."),
				T(878212316319, --[[ModItemVoiceResponse Woods ContractExpired VoiceResponse ContractExpired - when the mercs contract expires and the player has not extended it voice:Woods]] "That's it, target secured."),
				T(847234987903, --[[ModItemVoiceResponse Woods ContractExpired VoiceResponse ContractExpired - when the mercs contract expires and the player has not extended it voice:Woods]] "Objective is secure. Repeat. Objective is secure."),
				T(598851114425, --[[ModItemVoiceResponse Woods ContractExpired VoiceResponse ContractExpired - when the mercs contract expires and the player has not extended it voice:Woods]] "Close it up, boys. Let's go.")
			}),
			DeathBuddy1 = TConcat({
				T(413888088140, --[[ModItemVoiceResponse Woods DeathBuddy1 VoiceResponse DeathBuddy1 - Played on the death of Raven. voice:Woods]] "Shit! Shit, shit, shit!"),
				T(324915670933, --[[ModItemVoiceResponse Woods DeathBuddy1 VoiceResponse DeathBuddy1 - Played on the death of Raven. voice:Woods]] "No! God damn it!")
			}),
			DeathBuddy2 = TConcat({
				T(399935198685, --[[ModItemVoiceResponse Woods DeathBuddy2 VoiceResponse DeathBuddy2 - Played on the death of Meltdown. voice:Woods]] "Shit! Shit, shit, shit!"),
				T(296270766009, --[[ModItemVoiceResponse Woods DeathBuddy2 VoiceResponse DeathBuddy2 - Played on the death of Meltdown. voice:Woods]] "No! God damn it!")
			}),
			DeathBuddy3 = TConcat({
				T(559515117506, --[[ModItemVoiceResponse Woods DeathBuddy3 VoiceResponse DeathBuddy3 - Played on the death of Len. voice:Woods]] "Shit! Shit, shit, shit!"),
				T(153805133861, --[[ModItemVoiceResponse Woods DeathBuddy3 VoiceResponse DeathBuddy3 - Played on the death of Len. voice:Woods]] "No! God damn it!")
			}),
			DeathDislike1 = TConcat({
				T(702779484995, --[[ModItemVoiceResponse Woods DeathDislike1 VoiceResponse DeathDislike1 - Played on the death of Ivan. voice:Woods]] "Now stay dead."),
				T(898158717429, --[[ModItemVoiceResponse Woods DeathDislike1 VoiceResponse DeathDislike1 - Played on the death of Ivan. voice:Woods]] "The dogs can have what's left of ya.")
			}),
			DeathDislike2 = TConcat({
				T(944532782824, --[[ModItemVoiceResponse Woods DeathDislike2 VoiceResponse DeathDislike2 - Played on the death of Omryn. voice:Woods]] "Now stay dead."),
				T(869644875748, --[[ModItemVoiceResponse Woods DeathDislike2 VoiceResponse DeathDislike2 - Played on the death of Omryn. voice:Woods]] "The dogs can have what's left of ya.")
			}),
			DeathGeneral = TConcat({
				T(985352454631, --[[ModItemVoiceResponse Woods DeathGeneral VoiceResponse DeathGeneral - Played when a character that is neither liked or disliked dies voice:Woods]] "Rest in peace, Chimpy."),
				T(975106743647, --[[ModItemVoiceResponse Woods DeathGeneral VoiceResponse DeathGeneral - Played when a character that is neither liked or disliked dies voice:Woods]] "No! God damn it!"),
				T(679054246991, --[[ModItemVoiceResponse Woods DeathGeneral VoiceResponse DeathGeneral - Played when a character that is neither liked or disliked dies voice:Woods]] "Shit! Shit, shit, shit!")
			}),
			DoorLocked = TConcat({
				T(319084062607, --[[ModItemVoiceResponse Woods DoorLocked VoiceResponse DoorLocked - When a attempting to open locked door voice:Woods]] "Hear that? It's my asshole puckering. Doors like this hide awful shitty things.")
			}),
			Downed = TConcat({
				T(305870960227, --[[ModItemVoiceResponse Woods Downed VoiceResponse Downed - When entering Downed state. Voice should be as if losing consciousness voice:Woods]] "Fuck! I'm down!"),
				T(115454301533, --[[ModItemVoiceResponse Woods Downed VoiceResponse Downed - When entering Downed state. Voice should be as if losing consciousness voice:Woods]] "Medic! Get your ass over here!"),
				T(768339510334, --[[ModItemVoiceResponse Woods Downed VoiceResponse Downed - When entering Downed state. Voice should be as if losing consciousness voice:Woods]] "You all need me in this!")
			}),
			Exhausted = TConcat({
				T(366816830736, --[[ModItemVoiceResponse Woods Exhausted VoiceResponse Exhausted - when the merc becomes Exhausted voice:Woods]] "Hey, come get me!")
			}),
			FriendlyFireBuddy1 = TConcat({
				T(146814101237, --[[ModItemVoiceResponse Woods FriendlyFireBuddy1 VoiceResponse FriendlyFireBuddy1 - Played on friendly fire by the unit hit if the hitting unit is Liked - Raven. voice:Woods]] "Hey! Point it downrange, dick!"),
				T(612136548148, --[[ModItemVoiceResponse Woods FriendlyFireBuddy1 VoiceResponse FriendlyFireBuddy1 - Played on friendly fire by the unit hit if the hitting unit is Liked - Raven. voice:Woods]] "Hey shithead, watch your fucking fire!"),
				T(726986776132, --[[ModItemVoiceResponse Woods FriendlyFireBuddy1 VoiceResponse FriendlyFireBuddy1 - Played on friendly fire by the unit hit if the hitting unit is Liked - Raven. voice:Woods]] "I'm a goddamn friendly!"),
				T(403117369786, --[[ModItemVoiceResponse Woods FriendlyFireBuddy1 VoiceResponse FriendlyFireBuddy1 - Played on friendly fire by the unit hit if the hitting unit is Liked - Raven. voice:Woods]] "Whose damn side are you on?")
			}),
			FriendlyFireBuddy2 = TConcat({
				T(673861310727, --[[ModItemVoiceResponse Woods FriendlyFireBuddy2 VoiceResponse FriendlyFireBuddy2 - Played on friendly fire by the unit hit if the hitting unit is Liked - Meltdown. voice:Woods]] "Hey! Point it downrange, dick!"),
				T(869103217032, --[[ModItemVoiceResponse Woods FriendlyFireBuddy2 VoiceResponse FriendlyFireBuddy2 - Played on friendly fire by the unit hit if the hitting unit is Liked - Meltdown. voice:Woods]] "Hey shithead, watch your fucking fire!"),
				T(768500106688, --[[ModItemVoiceResponse Woods FriendlyFireBuddy2 VoiceResponse FriendlyFireBuddy2 - Played on friendly fire by the unit hit if the hitting unit is Liked - Meltdown. voice:Woods]] "I'm a goddamn friendly!"),
				T(236957149122, --[[ModItemVoiceResponse Woods FriendlyFireBuddy2 VoiceResponse FriendlyFireBuddy2 - Played on friendly fire by the unit hit if the hitting unit is Liked - Meltdown. voice:Woods]] "Whose damn side are you on?")
			}),
			FriendlyFireBuddy3 = TConcat({
				T(193353839217, --[[ModItemVoiceResponse Woods FriendlyFireBuddy3 VoiceResponse FriendlyFireBuddy3 - Played on friendly fire by the unit hit if the hitting unit is Liked - Len. voice:Woods]] "Hey! Point it downrange, dick!"),
				T(989421467391, --[[ModItemVoiceResponse Woods FriendlyFireBuddy3 VoiceResponse FriendlyFireBuddy3 - Played on friendly fire by the unit hit if the hitting unit is Liked - Len. voice:Woods]] "Hey shithead, watch your fucking fire!"),
				T(802226671432, --[[ModItemVoiceResponse Woods FriendlyFireBuddy3 VoiceResponse FriendlyFireBuddy3 - Played on friendly fire by the unit hit if the hitting unit is Liked - Len. voice:Woods]] "I'm a goddamn friendly!"),
				T(919364528208, --[[ModItemVoiceResponse Woods FriendlyFireBuddy3 VoiceResponse FriendlyFireBuddy3 - Played on friendly fire by the unit hit if the hitting unit is Liked - Len. voice:Woods]] "Whose damn side are you on?")
			}),
			FriendlyFireDislike1 = TConcat({
				T(361723972200, --[[ModItemVoiceResponse Woods FriendlyFireDislike1 VoiceResponse FriendlyFireDislike1 - Played on friendly fire by the unit hit if the hitting unit is Disiked - Ivan. voice:Woods]] "Care to explain that shit storm?")
			}),
			FriendlyFireDislike2 = TConcat({
				T(666846914498, --[[ModItemVoiceResponse Woods FriendlyFireDislike2 VoiceResponse FriendlyFireDislike2 - Played on friendly fire by the unit hit if the hitting unit is Disiked - Omryn. voice:Woods]] "You a fucking Blue Falcon?")
			}),
			FriendlyFireGeneral = TConcat({
				T(652660180045, --[[ModItemVoiceResponse Woods FriendlyFireGeneral VoiceResponse FriendlyFireGeneral - Played on friendly fire by the unit hit if the hitting unit is neither Liked or Disliked voice:Woods]] "You a fucking Blue Falcon?"),
				T(329877545247, --[[ModItemVoiceResponse Woods FriendlyFireGeneral VoiceResponse FriendlyFireGeneral - Played on friendly fire by the unit hit if the hitting unit is neither Liked or Disliked voice:Woods]] "Care to explain that shit storm?"),
				T(966260797720, --[[ModItemVoiceResponse Woods FriendlyFireGeneral VoiceResponse FriendlyFireGeneral - Played on friendly fire by the unit hit if the hitting unit is neither Liked or Disliked voice:Woods]] "I oughta fucking kill you myself!"),
				T(128700450083, --[[ModItemVoiceResponse Woods FriendlyFireGeneral VoiceResponse FriendlyFireGeneral - Played on friendly fire by the unit hit if the hitting unit is neither Liked or Disliked voice:Woods]] "Hey shithead, what the fuck are you doing?"),
				T(515545327104, --[[ModItemVoiceResponse Woods FriendlyFireGeneral VoiceResponse FriendlyFireGeneral - Played on friendly fire by the unit hit if the hitting unit is neither Liked or Disliked voice:Woods]] "Hey! Point it downrange, dick!"),
				T(522428717674, --[[ModItemVoiceResponse Woods FriendlyFireGeneral VoiceResponse FriendlyFireGeneral - Played on friendly fire by the unit hit if the hitting unit is neither Liked or Disliked voice:Woods]] "Hey shithead, watch your fucking fire!"),
				T(736937543862, --[[ModItemVoiceResponse Woods FriendlyFireGeneral VoiceResponse FriendlyFireGeneral - Played on friendly fire by the unit hit if the hitting unit is neither Liked or Disliked voice:Woods]] "I'm a goddamn friendly!")
			}),
			FriendlyFireLearnToDislike1 = TConcat({
				T(389542807287, --[[ModItemVoiceResponse Woods FriendlyFireLearnToDislike1 VoiceResponse FriendlyFireLearnToDislike1 - Played on friendly fire by the unit hit if the hitting unit is Disliked - Igor. voice:Woods]] "Hey shithead, what the fuck are you doing?")
			}),
			FriendlyFireLearnToDislike2 = TConcat({
				T(304490435206, --[[ModItemVoiceResponse Woods FriendlyFireLearnToDislike2 VoiceResponse FriendlyFireLearnToDislike2 - Played on friendly fire by the unit hit if the hitting unit is Disliked - MD. voice:Woods]] "I oughta fucking kill you myself!")
			}),
			GasAreaSelection = TConcat({
				T(568077561550, --[[ModItemVoiceResponse Woods GasAreaSelection VoiceResponse GasAreaSelection - Unit receiving gas effect or starting round in one. voice:Woods]] "Gah! Gah! Gah!"),
				T(468279876024, --[[ModItemVoiceResponse Woods GasAreaSelection VoiceResponse GasAreaSelection - Unit receiving gas effect or starting round in one. voice:Woods]] "Gah! Gah! Gah!")
			}),
			GroupOrder = TConcat({
				T(416926092684, --[[ModItemVoiceResponse Woods GroupOrder VoiceResponse GroupOrder - When movement ordered in follow mode or multi selected with other mercs. voice:Woods]] "Let's move!"),
				T(294252625023, --[[ModItemVoiceResponse Woods GroupOrder VoiceResponse GroupOrder - When movement ordered in follow mode or multi selected with other mercs. voice:Woods]] "Hurry up!"),
				T(409029300111, --[[ModItemVoiceResponse Woods GroupOrder VoiceResponse GroupOrder - When movement ordered in follow mode or multi selected with other mercs. voice:Woods]] "That's where we need to go."),
				T(367974572880, --[[ModItemVoiceResponse Woods GroupOrder VoiceResponse GroupOrder - When movement ordered in follow mode or multi selected with other mercs. voice:Woods]] "On me!"),
				T(773747286759, --[[ModItemVoiceResponse Woods GroupOrder VoiceResponse GroupOrder - When movement ordered in follow mode or multi selected with other mercs. voice:Woods]] "Keep it tight!"),
				T(504405511721, --[[ModItemVoiceResponse Woods GroupOrder VoiceResponse GroupOrder - When movement ordered in follow mode or multi selected with other mercs. voice:Woods]] "Close it up, boys. Let's go."),
				T(140281754589, --[[ModItemVoiceResponse Woods GroupOrder VoiceResponse GroupOrder - When movement ordered in follow mode or multi selected with other mercs. voice:Woods]] "Heard and understood.")
			}),
			HealReceived = TConcat({
				T(227519160351, --[[ModItemVoiceResponse Woods HealReceived VoiceResponse HealReceived - Bandaged by a merc or Metvirion used in Inventory voice:Woods]] "Thanks."),
				T(390966847665, --[[ModItemVoiceResponse Woods HealReceived VoiceResponse HealReceived - Bandaged by a merc or Metvirion used in Inventory voice:Woods]] "Appreciate it."),
				T(469662304144, --[[ModItemVoiceResponse Woods HealReceived VoiceResponse HealReceived - Bandaged by a merc or Metvirion used in Inventory voice:Woods]] "Thanks much."),
				T(163896364919, --[[ModItemVoiceResponse Woods HealReceived VoiceResponse HealReceived - Bandaged by a merc or Metvirion used in Inventory voice:Woods]] "I own ya."),
				T(990299700486, --[[ModItemVoiceResponse Woods HealReceived VoiceResponse HealReceived - Bandaged by a merc or Metvirion used in Inventory voice:Woods]] "I'll get you back next time."),
				T(818333154116, --[[ModItemVoiceResponse Woods HealReceived VoiceResponse HealReceived - Bandaged by a merc or Metvirion used in Inventory voice:Woods]] "Thanks, Doc."),
				T(487303868318, --[[ModItemVoiceResponse Woods HealReceived VoiceResponse HealReceived - Bandaged by a merc or Metvirion used in Inventory voice:Woods]] "Much better."),
				T(608782184675, --[[ModItemVoiceResponse Woods HealReceived VoiceResponse HealReceived - Bandaged by a merc or Metvirion used in Inventory voice:Woods]] "Thanks. I mean it.")
			}),
			HealReceivedSatView = TConcat({
				T(575498162802, --[[ModItemVoiceResponse Woods HealReceivedSatView VoiceResponse HealReceivedSatView - When a wound is removed by a Sector Operation. Uses HealReceived if blank. voice:Woods]] "Haha! Get out of hell free card!")
			}),
			HeavilyWoundedSelection = TConcat({
				T(587555463410, --[[ModItemVoiceResponse Woods HeavilyWoundedSelection VoiceResponse HeavilyWoundedSelection - Selected or autoselected with less than 20% health voice:Woods]] "Need some help here!"),
				T(458044583391, --[[ModItemVoiceResponse Woods HeavilyWoundedSelection VoiceResponse HeavilyWoundedSelection - Selected or autoselected with less than 20% health voice:Woods]] "Someone wanna help?"),
				T(456911579981, --[[ModItemVoiceResponse Woods HeavilyWoundedSelection VoiceResponse HeavilyWoundedSelection - Selected or autoselected with less than 20% health voice:Woods]] "Does anyone have my back here?"),
				T(570736883217, --[[ModItemVoiceResponse Woods HeavilyWoundedSelection VoiceResponse HeavilyWoundedSelection - Selected or autoselected with less than 20% health voice:Woods]] "Need an assist.")
			}),
			HeavyBreathing = TConcat({
				T(210622559864, --[[ModItemVoiceResponse Woods HeavyBreathing VoiceResponse HeavyBreathing - During physical exertion voice:Woods]] "Huh... huh... huh."),
				T(922088628790, --[[ModItemVoiceResponse Woods HeavyBreathing VoiceResponse HeavyBreathing - During physical exertion voice:Woods]] "Huh... huh... huh."),
				T(575682328499, --[[ModItemVoiceResponse Woods HeavyBreathing VoiceResponse HeavyBreathing - During physical exertion voice:Woods]] "Huh... huh... huh.")
			}),
			Idle = TConcat({
				T(109111213220, --[[ModItemVoiceResponse Woods Idle VoiceResponse Idle - Play every 4 hours during which a squad has been inactive.. Played by any of the mercs in the squad. voice:Woods]] "Close it up, boys. Let's go.")
			}),
			InteractableFound = TConcat({
				T(225915328165, --[[ModItemVoiceResponse Woods InteractableFound VoiceResponse InteractableFound - A custom interactable (quest related etc), herbs or salvage material found. voice:Woods]] "Be on the lookout for good intel."),
				T(242376357878, --[[ModItemVoiceResponse Woods InteractableFound VoiceResponse InteractableFound - A custom interactable (quest related etc), herbs or salvage material found. voice:Woods]] "There, what's that?"),
				T(569809897822, --[[ModItemVoiceResponse Woods InteractableFound VoiceResponse InteractableFound - A custom interactable (quest related etc), herbs or salvage material found. voice:Woods]] "Hey, anyone use that?"),
				T(375980543847, --[[ModItemVoiceResponse Woods InteractableFound VoiceResponse InteractableFound - A custom interactable (quest related etc), herbs or salvage material found. voice:Woods]] "Investigate that intel."),
				T(684138617567, --[[ModItemVoiceResponse Woods InteractableFound VoiceResponse InteractableFound - A custom interactable (quest related etc), herbs or salvage material found. voice:Woods]] "Intel there.")
			}),
			InterestingSector = TConcat({
				T(654740982646, --[[ModItemVoiceResponse Woods InterestingSector VoiceResponse InterestingSector - Reached a sector that is marked as interesting. There is somethingin there the player should explore. voice:Woods]] "This place gives me the creeps."),
				T(848121164010, --[[ModItemVoiceResponse Woods InterestingSector VoiceResponse InterestingSector - Reached a sector that is marked as interesting. There is somethingin there the player should explore. voice:Woods]] "The hell is this place?")
			}),
			ItemDeteriorates = TConcat({
				T(758577334220, --[[ModItemVoiceResponse Woods ItemDeteriorates VoiceResponse ItemDeteriorates - Played when a piece of equipment deteriotes to the point when it is in the Needs Repair condition voice:Woods]] "I can work with this."),
				T(795065919461, --[[ModItemVoiceResponse Woods ItemDeteriorates VoiceResponse ItemDeteriorates - Played when a piece of equipment deteriotes to the point when it is in the Needs Repair condition voice:Woods]] "Ugh, Soviet engineering at its worst.")
			}),
			ItemInPoorConditionEquipped = TConcat({
				T(562080114929, --[[ModItemVoiceResponse Woods ItemInPoorConditionEquipped VoiceResponse ItemInPoorConditionEquipped - Played in Inventory when player equips weapon/armor that is in Poor Condition voice:Woods]] "You know? I kinda like it.")
			}),
			Jumping = TConcat({
				T(270245319447, --[[ModItemVoiceResponse Woods Jumping VoiceResponse Jumping - When jumping over small obstacles (e.g. puddles) voice:Woods]] "Huh!"),
				T(399434509960, --[[ModItemVoiceResponse Woods Jumping VoiceResponse Jumping - When jumping over small obstacles (e.g. puddles) voice:Woods]] "Huh!"),
				T(870437543444, --[[ModItemVoiceResponse Woods Jumping VoiceResponse Jumping - When jumping over small obstacles (e.g. puddles) voice:Woods]] "Huh!")
			}),
			KillFriendlyFireBuddy1 = TConcat({
				T(356890442290, --[[ModItemVoiceResponse Woods KillFriendlyFireBuddy1 VoiceResponse KillFriendlyFireBuddy1 - Played when a unit kills an ally with friendly fire and the dying unit is Liked - Raven. voice:Woods]] "Shit! Shit, shit, shit!"),
				T(307296841589, --[[ModItemVoiceResponse Woods KillFriendlyFireBuddy1 VoiceResponse KillFriendlyFireBuddy1 - Played when a unit kills an ally with friendly fire and the dying unit is Liked - Raven. voice:Woods]] "Medic! Get your ass over here!"),
				T(971205122329, --[[ModItemVoiceResponse Woods KillFriendlyFireBuddy1 VoiceResponse KillFriendlyFireBuddy1 - Played when a unit kills an ally with friendly fire and the dying unit is Liked - Raven. voice:Woods]] "No! God damn it!")
			}),
			KillFriendlyFireBuddy2 = TConcat({
				T(190674851972, --[[ModItemVoiceResponse Woods KillFriendlyFireBuddy2 VoiceResponse KillFriendlyFireBuddy2 - Played when a unit kills an ally with friendly fire and the dying unit is Liked - Meltdown. voice:Woods]] "Shit! Shit, shit, shit!"),
				T(566625275117, --[[ModItemVoiceResponse Woods KillFriendlyFireBuddy2 VoiceResponse KillFriendlyFireBuddy2 - Played when a unit kills an ally with friendly fire and the dying unit is Liked - Meltdown. voice:Woods]] "Medic! Get your ass over here!"),
				T(164190252874, --[[ModItemVoiceResponse Woods KillFriendlyFireBuddy2 VoiceResponse KillFriendlyFireBuddy2 - Played when a unit kills an ally with friendly fire and the dying unit is Liked - Meltdown. voice:Woods]] "No! God damn it!")
			}),
			KillFriendlyFireBuddy3 = TConcat({
				T(745257736047, --[[ModItemVoiceResponse Woods KillFriendlyFireBuddy3 VoiceResponse KillFriendlyFireBuddy3 - Played when a unit kills an ally with friendly fire and the dying unit is Liked - Len. voice:Woods]] "Shit! Shit, shit, shit!")
			}),
			KillFriendlyFireDislike1 = TConcat({
				T(457612562592, --[[ModItemVoiceResponse Woods KillFriendlyFireDislike1 VoiceResponse KillFriendlyFireDislike1 - Played when a unit kills an ally with friendly fire and the dying unit is Disliked - Ivan. voice:Woods]] "Sorry."),
				T(886353350752, --[[ModItemVoiceResponse Woods KillFriendlyFireDislike1 VoiceResponse KillFriendlyFireDislike1 - Played when a unit kills an ally with friendly fire and the dying unit is Disliked - Ivan. voice:Woods]] "Oh shit, my bad."),
				T(555799195164, --[[ModItemVoiceResponse Woods KillFriendlyFireDislike1 VoiceResponse KillFriendlyFireDislike1 - Played when a unit kills an ally with friendly fire and the dying unit is Disliked - Ivan. voice:Woods]] "My bad, man.")
			}),
			KillFriendlyFireDislike2 = TConcat({
				T(116528179774, --[[ModItemVoiceResponse Woods KillFriendlyFireDislike2 VoiceResponse KillFriendlyFireDislike2 - Played when a unit kills an ally with friendly fire and the dying unit is Disliked - Omryn. voice:Woods]] "Sorry."),
				T(170446045454, --[[ModItemVoiceResponse Woods KillFriendlyFireDislike2 VoiceResponse KillFriendlyFireDislike2 - Played when a unit kills an ally with friendly fire and the dying unit is Disliked - Omryn. voice:Woods]] "Oh shit, my bad."),
				T(464929219906, --[[ModItemVoiceResponse Woods KillFriendlyFireDislike2 VoiceResponse KillFriendlyFireDislike2 - Played when a unit kills an ally with friendly fire and the dying unit is Disliked - Omryn. voice:Woods]] "My bad, man.")
			}),
			KillFriendlyFireGeneral = TConcat({
				T(951368742026, --[[ModItemVoiceResponse Woods KillFriendlyFireGeneral VoiceResponse KillFriendlyFireGeneral - Played when a unit kills an ally with friendly fire and the dying unit is neither Liked nor Disliked voice:Woods]] "Shit! Shit, shit, shit!"),
				T(238150034168, --[[ModItemVoiceResponse Woods KillFriendlyFireGeneral VoiceResponse KillFriendlyFireGeneral - Played when a unit kills an ally with friendly fire and the dying unit is neither Liked nor Disliked voice:Woods]] "Medic! Get your ass over here!"),
				T(668969723600, --[[ModItemVoiceResponse Woods KillFriendlyFireGeneral VoiceResponse KillFriendlyFireGeneral - Played when a unit kills an ally with friendly fire and the dying unit is neither Liked nor Disliked voice:Woods]] "Tacom, I have a friendly down."),
				T(738458618570, --[[ModItemVoiceResponse Woods KillFriendlyFireGeneral VoiceResponse KillFriendlyFireGeneral - Played when a unit kills an ally with friendly fire and the dying unit is neither Liked nor Disliked voice:Woods]] "No! God damn it!")
			}),
			KillFriendlyFireLearnToDislike1 = TConcat({
				T(110910130582, --[[ModItemVoiceResponse Woods KillFriendlyFireLearnToDislike1 VoiceResponse KillFriendlyFireLearnToDislike1 - Played when a unit kills an ally with friendly fire and the dying unit has become Disliked - Igor. voice:Woods]] "Sorry."),
				T(280989868177, --[[ModItemVoiceResponse Woods KillFriendlyFireLearnToDislike1 VoiceResponse KillFriendlyFireLearnToDislike1 - Played when a unit kills an ally with friendly fire and the dying unit has become Disliked - Igor. voice:Woods]] "Oh shit, my bad."),
				T(435290576574, --[[ModItemVoiceResponse Woods KillFriendlyFireLearnToDislike1 VoiceResponse KillFriendlyFireLearnToDislike1 - Played when a unit kills an ally with friendly fire and the dying unit has become Disliked - Igor. voice:Woods]] "My bad, man.")
			}),
			KillFriendlyFireLearnToDislike2 = TConcat({
				T(710918040536, --[[ModItemVoiceResponse Woods KillFriendlyFireLearnToDislike2 VoiceResponse KillFriendlyFireLearnToDislike2 - Played when a unit kills an ally with friendly fire and the dying unit has become Disliked - MD. voice:Woods]] "Sorry."),
				T(496921425702, --[[ModItemVoiceResponse Woods KillFriendlyFireLearnToDislike2 VoiceResponse KillFriendlyFireLearnToDislike2 - Played when a unit kills an ally with friendly fire and the dying unit has become Disliked - MD. voice:Woods]] "Oh shit, my bad."),
				T(507718422023, --[[ModItemVoiceResponse Woods KillFriendlyFireLearnToDislike2 VoiceResponse KillFriendlyFireLearnToDislike2 - Played when a unit kills an ally with friendly fire and the dying unit has become Disliked - MD. voice:Woods]] "My bad, man.")
			}),
			KillFriendlyFireLearnToLike1 = TConcat({
				T(836300443982, --[[ModItemVoiceResponse Woods KillFriendlyFireLearnToLike1 VoiceResponse KillFriendlyFireLearnToLike1 - Played when a unit kills an ally with friendly fire and the dying unit has become Liked - Raider. voice:Woods]] "Tacom, I have a friendly down."),
				T(564422311251, --[[ModItemVoiceResponse Woods KillFriendlyFireLearnToLike1 VoiceResponse KillFriendlyFireLearnToLike1 - Played when a unit kills an ally with friendly fire and the dying unit has become Liked - Raider. voice:Woods]] "Medic! Get your ass over here!")
			}),
			KillFriendlyFireLearnToLike2 = TConcat({
				T(342979294113, --[[ModItemVoiceResponse Woods KillFriendlyFireLearnToLike2 VoiceResponse KillFriendlyFireLearnToLike2 - Played when a unit kills an ally with friendly fire and the dying unit has become Liked - Nails. voice:Woods]] "Tacom, I have a friendly down."),
				T(473214942153, --[[ModItemVoiceResponse Woods KillFriendlyFireLearnToLike2 VoiceResponse KillFriendlyFireLearnToLike2 - Played when a unit kills an ally with friendly fire and the dying unit has become Liked - Nails. voice:Woods]] "Medic! Get your ass over here!")
			}),
			LearnToLike1 = TConcat({
				T(588957110347, --[[ModItemVoiceResponse Woods LearnToLike1 VoiceResponse LearnToLike1 - Played when a character becomes liked - Raider. voice:Woods]] "You're alright.")
			}),
			LearnToLike2 = TConcat({
				T(287316888148, --[[ModItemVoiceResponse Woods LearnToLike2 VoiceResponse LearnToLike2 - Played when a character becomes liked - Nails. voice:Woods]] "You're alright.")
			}),
			LevelUp = TConcat({
				T(167311130730, --[[ModItemVoiceResponse Woods LevelUp VoiceResponse LevelUp - Leveled up or a magazine is read. Only one played if multiple character level up. voice:Woods]] "Big man on campus, huh?"),
				T(536412838762, --[[ModItemVoiceResponse Woods LevelUp VoiceResponse LevelUp - Leveled up or a magazine is read. Only one played if multiple character level up. voice:Woods]] "Big gun, big man. Big fucking deal.")
			}),
			LootFound = TConcat({
				T(434722514952, --[[ModItemVoiceResponse Woods LootFound VoiceResponse LootFound - A loot container is nearby (e.g. dead body, crate,...) 10s cooldown voice:Woods]] "Gotta be something in here worth stealing."),
				T(405556169723, --[[ModItemVoiceResponse Woods LootFound VoiceResponse LootFound - A loot container is nearby (e.g. dead body, crate,...) 10s cooldown voice:Woods]] "Mark an item."),
				T(696452626789, --[[ModItemVoiceResponse Woods LootFound VoiceResponse LootFound - A loot container is nearby (e.g. dead body, crate,...) 10s cooldown voice:Woods]] "Supplies tagged."),
				T(663025602261, --[[ModItemVoiceResponse Woods LootFound VoiceResponse LootFound - A loot container is nearby (e.g. dead body, crate,...) 10s cooldown voice:Woods]] "Take that item!"),
				T(223974100358, --[[ModItemVoiceResponse Woods LootFound VoiceResponse LootFound - A loot container is nearby (e.g. dead body, crate,...) 10s cooldown voice:Woods]] "We'll need that. Go get it"),
				T(794797046233, --[[ModItemVoiceResponse Woods LootFound VoiceResponse LootFound - A loot container is nearby (e.g. dead body, crate,...) 10s cooldown voice:Woods]] "I don't pass up anything."),
				T(263196638140, --[[ModItemVoiceResponse Woods LootFound VoiceResponse LootFound - A loot container is nearby (e.g. dead body, crate,...) 10s cooldown voice:Woods]] "Can't just leave this shit laying around.")
			}),
			LootOpened = TConcat({
				T(163305938783, --[[ModItemVoiceResponse Woods LootOpened VoiceResponse LootOpened - Loot container opened. Supressed by ValuableItemFound voice:Woods]] "Boring. What else is there?"),
				T(851377199702, --[[ModItemVoiceResponse Woods LootOpened VoiceResponse LootOpened - Loot container opened. Supressed by ValuableItemFound voice:Woods]] "Collecting marked item."),
				T(937651374865, --[[ModItemVoiceResponse Woods LootOpened VoiceResponse LootOpened - Loot container opened. Supressed by ValuableItemFound voice:Woods]] "You got it. Collecting as instructed.")
			}),
			LowChanceShot = TConcat({
				T(895857807262, --[[ModItemVoiceResponse Woods LowChanceShot VoiceResponse LowChanceShot - Successful attack when the CtH is less than 20% voice:Woods]] "See? Piece of cake."),
				T(546970259491, --[[ModItemVoiceResponse Woods LowChanceShot VoiceResponse LowChanceShot - Successful attack when the CtH is less than 20% voice:Woods]] "Oh yeah, that's right."),
				T(437523335291, --[[ModItemVoiceResponse Woods LowChanceShot VoiceResponse LowChanceShot - Successful attack when the CtH is less than 20% voice:Woods]] "Gotcha, you piece of shit!"),
				T(703549819124, --[[ModItemVoiceResponse Woods LowChanceShot VoiceResponse LowChanceShot - Successful attack when the CtH is less than 20% voice:Woods]] "He shoots, he scores."),
				T(980408459490, --[[ModItemVoiceResponse Woods LowChanceShot VoiceResponse LowChanceShot - Successful attack when the CtH is less than 20% voice:Woods]] "That wasn't lucky. That was precise as fuck.")
			}),
			ManyEnemiesSelection = TConcat({
				T(926096810462, --[[ModItemVoiceResponse Woods ManyEnemiesSelection VoiceResponse ManyEnemiesSelection - Selected when the unit sees 5+ units in line of fire voice:Woods]] "Shit! Time to go!"),
				T(166079169617, --[[ModItemVoiceResponse Woods ManyEnemiesSelection VoiceResponse ManyEnemiesSelection - Selected when the unit sees 5+ units in line of fire voice:Woods]] "I ain't asking it twice. Assist on me."),
				T(284965684288, --[[ModItemVoiceResponse Woods ManyEnemiesSelection VoiceResponse ManyEnemiesSelection - Selected when the unit sees 5+ units in line of fire voice:Woods]] "Assist on me!"),
				T(488019215593, --[[ModItemVoiceResponse Woods ManyEnemiesSelection VoiceResponse ManyEnemiesSelection - Selected when the unit sees 5+ units in line of fire voice:Woods]] "I don't care how many of you there are!"),
				T(336782910976, --[[ModItemVoiceResponse Woods ManyEnemiesSelection VoiceResponse ManyEnemiesSelection - Selected when the unit sees 5+ units in line of fire voice:Woods]] "Well ain't this just a fucking walk in the park.")
			}),
			MeleeEnemiesClosing = TConcat({
				T(962523292887, --[[ModItemVoiceResponse Woods MeleeEnemiesClosing VoiceResponse MeleeEnemiesClosing - When enemy in melee range. Needs further clarification!!! voice:Woods]] "Back the fuck off!")
			}),
			MineDisarmed = TConcat({
				T(472671319883, --[[ModItemVoiceResponse Woods MineDisarmed VoiceResponse MineDisarmed - Mine disarmed voice:Woods]] "Prox-mine gone."),
				T(483057502756, --[[ModItemVoiceResponse Woods MineDisarmed VoiceResponse MineDisarmed - Mine disarmed voice:Woods]] "Removed enemy proximity mine."),
				T(103747172605, --[[ModItemVoiceResponse Woods MineDisarmed VoiceResponse MineDisarmed - Mine disarmed voice:Woods]] "Proximity mine threat down."),
				T(389740063227, --[[ModItemVoiceResponse Woods MineDisarmed VoiceResponse MineDisarmed - Mine disarmed voice:Woods]] "Deleted proximity mine.")
			}),
			MineFound = TConcat({
				T(942902164791, --[[ModItemVoiceResponse Woods MineFound VoiceResponse MineFound - A mine (or other explosive trap) was found nearby voice:Woods]] "Eyes on enemy prox-mine."),
				T(906676224750, --[[ModItemVoiceResponse Woods MineFound VoiceResponse MineFound - A mine (or other explosive trap) was found nearby voice:Woods]] "Tagging proximity mine."),
				T(920750742011, --[[ModItemVoiceResponse Woods MineFound VoiceResponse MineFound - A mine (or other explosive trap) was found nearby voice:Woods]] "Have eyes on proximity mine.")
			}),
			MineNearbySelection = TConcat({
				T(142100619995, --[[ModItemVoiceResponse Woods MineNearbySelection VoiceResponse MineNearbySelection - Selected when there is a trap nearby voice:Woods]] "Eyes on enemy prox-mine."),
				T(432987120354, --[[ModItemVoiceResponse Woods MineNearbySelection VoiceResponse MineNearbySelection - Selected when there is a trap nearby voice:Woods]] "Have eyes on proximity mine.")
			}),
			MissHighChance = TConcat({
				T(640951747066, --[[ModItemVoiceResponse Woods MissHighChance VoiceResponse MissHighChance - When a shot with 90%+ CtH was missed voice:Woods]] "Not a fucking word."),
				T(240633623427, --[[ModItemVoiceResponse Woods MissHighChance VoiceResponse MissHighChance - When a shot with 90%+ CtH was missed voice:Woods]] "Never speak of this."),
				T(544717721596, --[[ModItemVoiceResponse Woods MissHighChance VoiceResponse MissHighChance - When a shot with 90%+ CtH was missed voice:Woods]] "Don't gloat. I know I fucked up."),
				T(663249244775, --[[ModItemVoiceResponse Woods MissHighChance VoiceResponse MissHighChance - When a shot with 90%+ CtH was missed voice:Woods]] "Won't happen again. Believe me.")
			}),
			MissedByKillShot = TConcat({
				T(466778038357, --[[ModItemVoiceResponse Woods MissedByKillShot VoiceResponse MissedByKillShot - When character missed a by a shot that would've killed him/her. Shot must have had 50%+ CtH. voice:Woods]] "You suck almost as much as your piece of shit gun!"),
				T(711690051087, --[[ModItemVoiceResponse Woods MissedByKillShot VoiceResponse MissedByKillShot - When character missed a by a shot that would've killed him/her. Shot must have had 50%+ CtH. voice:Woods]] "Not this time, dipshit."),
				T(133009195603, --[[ModItemVoiceResponse Woods MissedByKillShot VoiceResponse MissedByKillShot - When character missed a by a shot that would've killed him/her. Shot must have had 50%+ CtH. voice:Woods]] "Yeah, in your dreams."),
				T(788438808192, --[[ModItemVoiceResponse Woods MissedByKillShot VoiceResponse MissedByKillShot - When character missed a by a shot that would've killed him/her. Shot must have had 50%+ CtH. voice:Woods]] "You can't kill me!")
			}),
			MockGeneral = TConcat({
				T(347706376566, --[[ModItemVoiceResponse Woods MockGeneral VoiceResponse MockGeneral - 20% chance to play when another merc misses a high chance shot voice:Woods]] "You need to book some time on the range when we get back."),
				T(515004282167, --[[ModItemVoiceResponse Woods MockGeneral VoiceResponse MockGeneral - 20% chance to play when another merc misses a high chance shot voice:Woods]] "That hit? I expected more."),
				T(271157625951, --[[ModItemVoiceResponse Woods MockGeneral VoiceResponse MockGeneral - 20% chance to play when another merc misses a high chance shot voice:Woods]] "HAHAHA! That shit was hilarious!"),
				T(625795619102, --[[ModItemVoiceResponse Woods MockGeneral VoiceResponse MockGeneral - 20% chance to play when another merc misses a high chance shot voice:Woods]] "Hahahaha! That was fucking funny!"),
				T(254343714817, --[[ModItemVoiceResponse Woods MockGeneral VoiceResponse MockGeneral - 20% chance to play when another merc misses a high chance shot voice:Woods]] "What the hell?"),
				T(799422467074, --[[ModItemVoiceResponse Woods MockGeneral VoiceResponse MockGeneral - 20% chance to play when another merc misses a high chance shot voice:Woods]] "What the fuck was that?")
			}),
			MockLike1 = TConcat({
				T(396695659287, --[[ModItemVoiceResponse Woods MockLike1 VoiceResponse MockLike1 - Played on a high chance miss by Raven. voice:Woods]] "HAHAHA! That shit was hilarious!")
			}),
			MockLike2 = TConcat({
				T(622413072616, --[[ModItemVoiceResponse Woods MockLike2 VoiceResponse MockLike2 - Played on a high chance miss by Meltdown. voice:Woods]] "Hahahaha! That was fucking funny!")
			}),
			MockLike3 = TConcat({
				T(366648336051, --[[ModItemVoiceResponse Woods MockLike3 VoiceResponse MockLike3 - Played on a high chance miss by Len. voice:Woods]] "What the hell?")
			}),
			MultiOpponentKilled = TConcat({
				T(803549643554, --[[ModItemVoiceResponse Woods MultiOpponentKilled VoiceResponse MultiOpponentKilled - When 2+ enemies are killed with the same attack voice:Woods]] "Bingo, bingo, bongo."),
				T(510651816852, --[[ModItemVoiceResponse Woods MultiOpponentKilled VoiceResponse MultiOpponentKilled - When 2+ enemies are killed with the same attack voice:Woods]] "They're dead."),
				T(452023818338, --[[ModItemVoiceResponse Woods MultiOpponentKilled VoiceResponse MultiOpponentKilled - When 2+ enemies are killed with the same attack voice:Woods]] "You fucking want some more?"),
				T(712395809103, --[[ModItemVoiceResponse Woods MultiOpponentKilled VoiceResponse MultiOpponentKilled - When 2+ enemies are killed with the same attack voice:Woods]] "Can't keep an old dog down!"),
				T(756751064649, --[[ModItemVoiceResponse Woods MultiOpponentKilled VoiceResponse MultiOpponentKilled - When 2+ enemies are killed with the same attack voice:Woods]] "Tell your fucking friends you ain't welcome."),
				T(951788283672, --[[ModItemVoiceResponse Woods MultiOpponentKilled VoiceResponse MultiOpponentKilled - When 2+ enemies are killed with the same attack voice:Woods]] "Dance, you miserable fucking bastards!"),
				T(659851349606, --[[ModItemVoiceResponse Woods MultiOpponentKilled VoiceResponse MultiOpponentKilled - When 2+ enemies are killed with the same attack voice:Woods]] "Shoulda run!"),
				T(827625335119, --[[ModItemVoiceResponse Woods MultiOpponentKilled VoiceResponse MultiOpponentKilled - When 2+ enemies are killed with the same attack voice:Woods]] "I'm fucking their shit up!"),
				T(704452988813, --[[ModItemVoiceResponse Woods MultiOpponentKilled VoiceResponse MultiOpponentKilled - When 2+ enemies are killed with the same attack voice:Woods]] "I love this shit!"),
				T(866596302496, --[[ModItemVoiceResponse Woods MultiOpponentKilled VoiceResponse MultiOpponentKilled - When 2+ enemies are killed with the same attack voice:Woods]] "Bye-bye, bitches.")
			}),
			NoAmmo = TConcat({
				T(851669994349, --[[ModItemVoiceResponse Woods NoAmmo VoiceResponse NoAmmo - No more ammo in the gun and no more bullets. voice:Woods]] "Is it loaded? Better be."),
				T(892556306126, --[[ModItemVoiceResponse Woods NoAmmo VoiceResponse NoAmmo - No more ammo in the gun and no more bullets. voice:Woods]] "Who's got ammo?"),
				T(919573557498, --[[ModItemVoiceResponse Woods NoAmmo VoiceResponse NoAmmo - No more ammo in the gun and no more bullets. voice:Woods]] "I'm black on ammo."),
				T(624180816524, --[[ModItemVoiceResponse Woods NoAmmo VoiceResponse NoAmmo - No more ammo in the gun and no more bullets. voice:Woods]] "I'm out of special ammo.")
			}),
			NotNow = TConcat({
				T(439596777012, --[[ModItemVoiceResponse Woods NotNow VoiceResponse NotNow - When interacting with a NPC while in combat voice:Woods]] "Fuck that."),
				T(352530019763, --[[ModItemVoiceResponse Woods NotNow VoiceResponse NotNow - When interacting with a NPC while in combat voice:Woods]] "Can't comply as ordered."),
				T(589687229521, --[[ModItemVoiceResponse Woods NotNow VoiceResponse NotNow - When interacting with a NPC while in combat voice:Woods]] "Negative on that."),
				T(707814932596, --[[ModItemVoiceResponse Woods NotNow VoiceResponse NotNow - When interacting with a NPC while in combat voice:Woods]] "Hell no!")
			}),
			OpponentFound = TConcat({
				T(348014189522, --[[ModItemVoiceResponse Woods OpponentFound VoiceResponse OpponentFound - Enemy spotted. voice:Woods]] "Got contact."),
				T(883646873749, --[[ModItemVoiceResponse Woods OpponentFound VoiceResponse OpponentFound - Enemy spotted. voice:Woods]] "Eyes on shooter!"),
				T(882093147215, --[[ModItemVoiceResponse Woods OpponentFound VoiceResponse OpponentFound - Enemy spotted. voice:Woods]] "Bad guy front!"),
				T(815768412595, --[[ModItemVoiceResponse Woods OpponentFound VoiceResponse OpponentFound - Enemy spotted. voice:Woods]] "Troops in contact!"),
				T(879090639072, --[[ModItemVoiceResponse Woods OpponentFound VoiceResponse OpponentFound - Enemy spotted. voice:Woods]] "Significant threat marked!"),
				T(612313591035, --[[ModItemVoiceResponse Woods OpponentFound VoiceResponse OpponentFound - Enemy spotted. voice:Woods]] "Guns up! Mean-looking bad guy marked!"),
				T(711114719932, --[[ModItemVoiceResponse Woods OpponentFound VoiceResponse OpponentFound - Enemy spotted. voice:Woods]] "Market priority target.")
			}),
			OpponentKilled = TConcat({
				T(741148463033, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "BDA, one down."),
				T(912601284844, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "They're gone."),
				T(311018212177, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "EKIA."),
				T(361610813689, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "Kill!"),
				T(168533426959, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "Get the fuck out of my way!"),
				T(955743607487, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "How'd that fucking taste?"),
				T(231848733629, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "Cool off, hot shot!"),
				T(550918381675, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "Snuffed him out!"),
				T(480460553481, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "You really thought you had a fucking chance, huh?"),
				T(735251861173, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "You weren't all that special. Believe me."),
				T(658848979740, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "Tell hell that Woods sent ya."),
				T(212343557982, --[[ModItemVoiceResponse Woods OpponentKilled VoiceResponse OpponentKilled - When opponent killed (unless OponentKilledCrit or OponentKilled multi isplayed) voice:Woods]] "There's more where that came from.")
			}),
			OpponentKilledAnimal = TConcat({
				T(367534831052, --[[ModItemVoiceResponse Woods OpponentKilledAnimal VoiceResponse OpponentKilledAnimal - When animal is killed voice:Woods]] "Tango removed."),
				T(884613480533, --[[ModItemVoiceResponse Woods OpponentKilledAnimal VoiceResponse OpponentKilledAnimal - When animal is killed voice:Woods]] "Threat neutralized.")
			}),
			OpponentKilledHeadshot = TConcat({
				T(632373175629, --[[ModItemVoiceResponse Woods OpponentKilledHeadshot VoiceResponse OpponentKilledHeadshot - Opponent killed with a headshot voice:Woods]] "Schwacked!"),
				T(474950624212, --[[ModItemVoiceResponse Woods OpponentKilledHeadshot VoiceResponse OpponentKilledHeadshot - Opponent killed with a headshot voice:Woods]] "Clean shot."),
				T(842887898039, --[[ModItemVoiceResponse Woods OpponentKilledHeadshot VoiceResponse OpponentKilledHeadshot - Opponent killed with a headshot voice:Woods]] "Dropped him!"),
				T(898735101991, --[[ModItemVoiceResponse Woods OpponentKilledHeadshot VoiceResponse OpponentKilledHeadshot - Opponent killed with a headshot voice:Woods]] "Sucks to be you!"),
				T(888687187930, --[[ModItemVoiceResponse Woods OpponentKilledHeadshot VoiceResponse OpponentKilledHeadshot - Opponent killed with a headshot voice:Woods]] "Right in the brain box."),
				T(764060303840, --[[ModItemVoiceResponse Woods OpponentKilledHeadshot VoiceResponse OpponentKilledHeadshot - Opponent killed with a headshot voice:Woods]] "A headshot's like a hole-in-one."),
				T(773915276991, --[[ModItemVoiceResponse Woods OpponentKilledHeadshot VoiceResponse OpponentKilledHeadshot - Opponent killed with a headshot voice:Woods]] "Split your melon."),
				T(632743812108, --[[ModItemVoiceResponse Woods OpponentKilledHeadshot VoiceResponse OpponentKilledHeadshot - Opponent killed with a headshot voice:Woods]] "He shoots, he scores!"),
				T(992871168954, --[[ModItemVoiceResponse Woods OpponentKilledHeadshot VoiceResponse OpponentKilledHeadshot - Opponent killed with a headshot voice:Woods]] "Nailed him right in the ugly."),
				T(923423426715, --[[ModItemVoiceResponse Woods OpponentKilledHeadshot VoiceResponse OpponentKilledHeadshot - Opponent killed with a headshot voice:Woods]] "Face erased.")
			}),
			OpponentKilledMelee = TConcat({
				T(146883262933, --[[ModItemVoiceResponse Woods OpponentKilledMelee VoiceResponse OpponentKilledMelee - Played when killing a unit with melee weapon voice:Woods]] "Sit your ass down, son."),
				T(529771132750, --[[ModItemVoiceResponse Woods OpponentKilledMelee VoiceResponse OpponentKilledMelee - Played when killing a unit with melee weapon voice:Woods]] "Lights out!"),
				T(174215532146, --[[ModItemVoiceResponse Woods OpponentKilledMelee VoiceResponse OpponentKilledMelee - Played when killing a unit with melee weapon voice:Woods]] "Fucking die!"),
				T(954953240251, --[[ModItemVoiceResponse Woods OpponentKilledMelee VoiceResponse OpponentKilledMelee - Played when killing a unit with melee weapon voice:Woods]] "Not so tough now, are ya?"),
				T(324513083199, --[[ModItemVoiceResponse Woods OpponentKilledMelee VoiceResponse OpponentKilledMelee - Played when killing a unit with melee weapon voice:Woods]] "My knife likes blood!"),
				T(858875751283, --[[ModItemVoiceResponse Woods OpponentKilledMelee VoiceResponse OpponentKilledMelee - Played when killing a unit with melee weapon voice:Woods]] "Why'd you have to go and bleed on me?"),
				T(846276840394, --[[ModItemVoiceResponse Woods OpponentKilledMelee VoiceResponse OpponentKilledMelee - Played when killing a unit with melee weapon voice:Woods]] "I'm just getting started."),
				T(481905895075, --[[ModItemVoiceResponse Woods OpponentKilledMelee VoiceResponse OpponentKilledMelee - Played when killing a unit with melee weapon voice:Woods]] "My knife still wants more!")
			}),
			OpponentKilledStealth = TConcat({
				T(171401897550, --[[ModItemVoiceResponse Woods OpponentKilledStealth VoiceResponse OpponentKilledStealth - Played when a Stealth kill happens. Voice should be shushed (except Steroid) voice:Woods]] "Well that was loud as fuck."),
				T(142404445263, --[[ModItemVoiceResponse Woods OpponentKilledStealth VoiceResponse OpponentKilledStealth - Played when a Stealth kill happens. Voice should be shushed (except Steroid) voice:Woods]] "You think anybody heard that?"),
				T(796744423959, --[[ModItemVoiceResponse Woods OpponentKilledStealth VoiceResponse OpponentKilledStealth - Played when a Stealth kill happens. Voice should be shushed (except Steroid) voice:Woods]] "Iced him."),
				T(322667856889, --[[ModItemVoiceResponse Woods OpponentKilledStealth VoiceResponse OpponentKilledStealth - Played when a Stealth kill happens. Voice should be shushed (except Steroid) voice:Woods]] "Surprise, motherfucker!"),
				T(369286943680, --[[ModItemVoiceResponse Woods OpponentKilledStealth VoiceResponse OpponentKilledStealth - Played when a Stealth kill happens. Voice should be shushed (except Steroid) voice:Woods]] "Tagged and bagged."),
				T(282116584502, --[[ModItemVoiceResponse Woods OpponentKilledStealth VoiceResponse OpponentKilledStealth - Played when a Stealth kill happens. Voice should be shushed (except Steroid) voice:Woods]] "Haha, fish in a fucking barrel."),
				T(180431137777, --[[ModItemVoiceResponse Woods OpponentKilledStealth VoiceResponse OpponentKilledStealth - Played when a Stealth kill happens. Voice should be shushed (except Steroid) voice:Woods]] "Who's next?"),
				T(487111064320, --[[ModItemVoiceResponse Woods OpponentKilledStealth VoiceResponse OpponentKilledStealth - Played when a Stealth kill happens. Voice should be shushed (except Steroid) voice:Woods]] "Kinda quiet now, ain't ya?")
			}),
			Order = TConcat({
				T(950864877141, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "No arguments here."),
				T(590865031848, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "God, I could use a drink."),
				T(509943119304, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "Copy that."),
				T(155610625380, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "Got it."),
				T(619562736517, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "Acknowledge that."),
				T(820911660059, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "Can I get a ride?"),
				T(316228481398, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "Copy. Can confirm."),
				T(300374523450, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "As advised."),
				T(697994535641, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "Hard copy."),
				T(375549056034, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "Think I'm gonna say no?"),
				T(101497552334, --[[ModItemVoiceResponse Woods Order VoiceResponse Order - When movement ordered (out of combat) Should be very short (3-5 words) voice:Woods]] "Why the fuck not?")
			}),
			Outnumbered = TConcat({
				T(670499731038, --[[ModItemVoiceResponse Woods Outnumbered VoiceResponse Outnumbered - Unit sees more enemies than allies voice:Woods]] "Does anyone have my back here?"),
				T(382928374635, --[[ModItemVoiceResponse Woods Outnumbered VoiceResponse Outnumbered - Unit sees more enemies than allies voice:Woods]] "I don't care how many of you there are!"),
				T(432401566325, --[[ModItemVoiceResponse Woods Outnumbered VoiceResponse Outnumbered - Unit sees more enemies than allies voice:Woods]] "Heads up, got a situation here.")
			}),
			Overwatch = TConcat({
				T(765319750744, --[[ModItemVoiceResponse Woods Overwatch VoiceResponse Overwatch - When setting overwatch voice:Woods]] "Move up, you're covered."),
				T(874531389769, --[[ModItemVoiceResponse Woods Overwatch VoiceResponse Overwatch - When setting overwatch voice:Woods]] "I'll stay back and cover."),
				T(412102629191, --[[ModItemVoiceResponse Woods Overwatch VoiceResponse Overwatch - When setting overwatch voice:Woods]] "I got your back, soldier.")
			}),
			OverwatchSelection = TConcat({
				T(874641383309, --[[ModItemVoiceResponse Woods OverwatchSelection VoiceResponse OverwatchSelection - Selected when under Overwatch. voice:Woods]] "I'll stay back and provide cover."),
				T(764282000829, --[[ModItemVoiceResponse Woods OverwatchSelection VoiceResponse OverwatchSelection - Selected when under Overwatch. voice:Woods]] "Patrolling on your six!")
			}),
			Pain = TConcat({
				T(594533385371, --[[ModItemVoiceResponse Woods Pain VoiceResponse Pain - Hit by an attack (if surrounded SurroundedPain is played instead). Short. These are emotes - disregard the written text. voice:Woods]] "Gah!"),
				T(807173295999, --[[ModItemVoiceResponse Woods Pain VoiceResponse Pain - Hit by an attack (if surrounded SurroundedPain is played instead). Short. These are emotes - disregard the written text. voice:Woods]] "Ugh!"),
				T(902652527656, --[[ModItemVoiceResponse Woods Pain VoiceResponse Pain - Hit by an attack (if surrounded SurroundedPain is played instead). Short. These are emotes - disregard the written text. voice:Woods]] "Gah!"),
				T(708126717116, --[[ModItemVoiceResponse Woods Pain VoiceResponse Pain - Hit by an attack (if surrounded SurroundedPain is played instead). Short. These are emotes - disregard the written text. voice:Woods]] "Ugh!"),
				T(371200520780, --[[ModItemVoiceResponse Woods Pain VoiceResponse Pain - Hit by an attack (if surrounded SurroundedPain is played instead). Short. These are emotes - disregard the written text. voice:Woods]] "Gah!")
			}),
			PinDown = TConcat({
				T(134641080832, --[[ModItemVoiceResponse Woods PinDown VoiceResponse PinDown - When pinning down (sniper rifles only) voice:Woods]] "Takes patience. Not sure I got that."),
				T(415458896150, --[[ModItemVoiceResponse Woods PinDown VoiceResponse PinDown - When pinning down (sniper rifles only) voice:Woods]] "Looks like I'm going sniping.")
			}),
			PinnedDown = TConcat({
				T(848830114839, --[[ModItemVoiceResponse Woods PinnedDown VoiceResponse PinnedDown - UNUSED voice:Woods]] "Hostile snipers working."),
				T(873966684668, --[[ModItemVoiceResponse Woods PinnedDown VoiceResponse PinnedDown - UNUSED voice:Woods]] "Enemy long rifle, heads down."),
				T(282012058779, --[[ModItemVoiceResponse Woods PinnedDown VoiceResponse PinnedDown - UNUSED voice:Woods]] "We got a sniper!")
			}),
			PraisesBuddy1 = TConcat({
				T(887792076732, --[[ModItemVoiceResponse Woods PraisesBuddy1 VoiceResponse PraisesBuddy1 - Played on a successful kill by Raven. voice:Woods]] "Nice and clean."),
				T(160019739309, --[[ModItemVoiceResponse Woods PraisesBuddy1 VoiceResponse PraisesBuddy1 - Played on a successful kill by Raven. voice:Woods]] "Nice work."),
				T(522758921813, --[[ModItemVoiceResponse Woods PraisesBuddy1 VoiceResponse PraisesBuddy1 - Played on a successful kill by Raven. voice:Woods]] "Hey, soldier, good job.")
			}),
			PraisesBuddy2 = TConcat({
				T(131202083715, --[[ModItemVoiceResponse Woods PraisesBuddy2 VoiceResponse PraisesBuddy2 - Played on a successful kill by Meltdown. voice:Woods]] "Nice and clean."),
				T(851958056827, --[[ModItemVoiceResponse Woods PraisesBuddy2 VoiceResponse PraisesBuddy2 - Played on a successful kill by Meltdown. voice:Woods]] "Hey, soldier, good job."),
				T(287185843970, --[[ModItemVoiceResponse Woods PraisesBuddy2 VoiceResponse PraisesBuddy2 - Played on a successful kill by Meltdown. voice:Woods]] "Nice work.")
			}),
			PraisesBuddy3 = TConcat({
				T(181033870325, --[[ModItemVoiceResponse Woods PraisesBuddy3 VoiceResponse PraisesBuddy3 - Played on a successful kill by Len. voice:Woods]] "Nice and clean."),
				T(546277348338, --[[ModItemVoiceResponse Woods PraisesBuddy3 VoiceResponse PraisesBuddy3 - Played on a successful kill by Len. voice:Woods]] "Hey, soldier, good job."),
				T(826155071625, --[[ModItemVoiceResponse Woods PraisesBuddy3 VoiceResponse PraisesBuddy3 - Played on a successful kill by Len. voice:Woods]] "Nice work.")
			}),
			PraisesFemale = TConcat({
				T(563467840755, --[[ModItemVoiceResponse Woods PraisesFemale VoiceResponse PraisesFemale - Played when a female merc makes a kill (20% chance) voice:Woods]] "Job done. Nice."),
				T(442156677937, --[[ModItemVoiceResponse Woods PraisesFemale VoiceResponse PraisesFemale - Played when a female merc makes a kill (20% chance) voice:Woods]] "Not too shabby, kid."),
				T(411794152461, --[[ModItemVoiceResponse Woods PraisesFemale VoiceResponse PraisesFemale - Played when a female merc makes a kill (20% chance) voice:Woods]] "Good shootin'.")
			}),
			PraisesLearnToLike1 = TConcat({
				T(684257130382, --[[ModItemVoiceResponse Woods PraisesLearnToLike1 VoiceResponse PraisesLearnToLike1 - Played on a successful kill by Raider. voice:Woods]] "Welcome to the big leagues, kid."),
				T(474594813858, --[[ModItemVoiceResponse Woods PraisesLearnToLike1 VoiceResponse PraisesLearnToLike1 - Played on a successful kill by Raider. voice:Woods]] "Well, fucking look at you, all grown up. ")
			}),
			PraisesLearnToLike2 = TConcat({
				T(571257286054, --[[ModItemVoiceResponse Woods PraisesLearnToLike2 VoiceResponse PraisesLearnToLike2 - Played on a successful kill by Nails. voice:Woods]] "Welcome to the big leagues, kid."),
				T(408541531499, --[[ModItemVoiceResponse Woods PraisesLearnToLike2 VoiceResponse PraisesLearnToLike2 - Played on a successful kill by Nails. voice:Woods]] "Well, fucking look at you, all grown up. ")
			}),
			PraisesMale = TConcat({
				T(678555034998, --[[ModItemVoiceResponse Woods PraisesMale VoiceResponse PraisesMale - Played when a male merc makes a kill (20% chance) voice:Woods]] "Nice work, son."),
				T(456207509291, --[[ModItemVoiceResponse Woods PraisesMale VoiceResponse PraisesMale - Played when a male merc makes a kill (20% chance) voice:Woods]] "Not too shabby, kid."),
				T(596588600667, --[[ModItemVoiceResponse Woods PraisesMale VoiceResponse PraisesMale - Played when a male merc makes a kill (20% chance) voice:Woods]] "Hey, soldier, good job.")
			}),
			SectorArrived = TConcat({
				T(596395689977, --[[ModItemVoiceResponse Woods SectorArrived VoiceResponse SectorArrived - SatView - new sector reached. Played by random merc in squad. voice:Woods]] "Damn, look at this place."),
				T(547459015927, --[[ModItemVoiceResponse Woods SectorArrived VoiceResponse SectorArrived - SatView - new sector reached. Played by random merc in squad. voice:Woods]] "I'm on your six."),
				T(442507396225, --[[ModItemVoiceResponse Woods SectorArrived VoiceResponse SectorArrived - SatView - new sector reached. Played by random merc in squad. voice:Woods]] "The hell is this place?"),
				T(743140821633, --[[ModItemVoiceResponse Woods SectorArrived VoiceResponse SectorArrived - SatView - new sector reached. Played by random merc in squad. voice:Woods]] "Friendly behind, Oscar Mike."),
				T(515928995806, --[[ModItemVoiceResponse Woods SectorArrived VoiceResponse SectorArrived - SatView - new sector reached. Played by random merc in squad. voice:Woods]] "Moving on you, formation tight.")
			}),
			Selection = TConcat({
				T(801740982049, --[[ModItemVoiceResponse Woods Selection VoiceResponse Selection - when selected or autoselected voice:Woods]] "Hey."),
				T(117459152897, --[[ModItemVoiceResponse Woods Selection VoiceResponse Selection - when selected or autoselected voice:Woods]] "Hey there."),
				T(937068868763, --[[ModItemVoiceResponse Woods Selection VoiceResponse Selection - when selected or autoselected voice:Woods]] "Hey, what can I do you for?"),
				T(773927627530, --[[ModItemVoiceResponse Woods Selection VoiceResponse Selection - when selected or autoselected voice:Woods]] "Whatcha need?"),
				T(702963911286, --[[ModItemVoiceResponse Woods Selection VoiceResponse Selection - when selected or autoselected voice:Woods]] "Yeah, yeah."),
				T(596918019458, --[[ModItemVoiceResponse Woods Selection VoiceResponse Selection - when selected or autoselected voice:Woods]] "What are you looking at?"),
				T(782370050644, --[[ModItemVoiceResponse Woods Selection VoiceResponse Selection - when selected or autoselected voice:Woods]] "Time to do some damage, brother.")
			}),
			SelectionStealth = TConcat({
				T(312588337801, --[[ModItemVoiceResponse Woods SelectionStealth VoiceResponse SelectionStealth - when selected or autoselected voice:Woods]] "Do it all quiet like."),
				T(223756200030, --[[ModItemVoiceResponse Woods SelectionStealth VoiceResponse SelectionStealth - when selected or autoselected voice:Woods]] "I'm a goddamn onion Mason. You should know that."),
				T(633737643168, --[[ModItemVoiceResponse Woods SelectionStealth VoiceResponse SelectionStealth - when selected or autoselected voice:Woods]] "This is about to get interesting.")
			}),
			SeriouslyWounded = TConcat({
				T(304597477999, --[[ModItemVoiceResponse Woods SeriouslyWounded VoiceResponse SeriouslyWounded - Unit is seriously wounded (3 or more wounds). Add a pain noise at the begining. voice:Woods]] "You can't kill me!"),
				T(759816662466, --[[ModItemVoiceResponse Woods SeriouslyWounded VoiceResponse SeriouslyWounded - Unit is seriously wounded (3 or more wounds). Add a pain noise at the begining. voice:Woods]] "They can't kill me!")
			}),
			SpecialThrowGrenade = TConcat({
				T(800678167128, --[[ModItemVoiceResponse Woods SpecialThrowGrenade VoiceResponse SpecialThrowGrenade - When throwing grenade voice:Woods]] "Lethal out.")
			}),
			Startled = TConcat({
				T(525133725894, --[[ModItemVoiceResponse Woods Startled VoiceResponse Startled - Startled by hearing a sudden noise voice:Woods]] "Ha... Hah... Hah...")
			}),
			SurroundedPain = TConcat({
				T(455126210745, --[[ModItemVoiceResponse Woods SurroundedPain VoiceResponse SurroundedPain - hit by an attack when surrounded. Situation should be very dire voice:Woods]] "Shit!"),
				T(143129958015, --[[ModItemVoiceResponse Woods SurroundedPain VoiceResponse SurroundedPain - hit by an attack when surrounded. Situation should be very dire voice:Woods]] "Agh! Taking Hits!"),
				T(634825371699, --[[ModItemVoiceResponse Woods SurroundedPain VoiceResponse SurroundedPain - hit by an attack when surrounded. Situation should be very dire voice:Woods]] "Dammit!"),
				T(863134602255, --[[ModItemVoiceResponse Woods SurroundedPain VoiceResponse SurroundedPain - hit by an attack when surrounded. Situation should be very dire voice:Woods]] "Ugh! I'm under fire!"),
				T(970525240417, --[[ModItemVoiceResponse Woods SurroundedPain VoiceResponse SurroundedPain - hit by an attack when surrounded. Situation should be very dire voice:Woods]] "Fuck!"),
				T(301734053765, --[[ModItemVoiceResponse Woods SurroundedPain VoiceResponse SurroundedPain - hit by an attack when surrounded. Situation should be very dire voice:Woods]] "Ugh! Fucking hit!")
			}),
			TacticalCareful = TConcat({
				T(755402645455, --[[ModItemVoiceResponse Woods TacticalCareful VoiceResponse TacticalCareful - The other team is making gains during the battle (inflicted 2+ wounds during their turn) voice:Woods]] "They're coming this way"),
				T(588272646575, --[[ModItemVoiceResponse Woods TacticalCareful VoiceResponse TacticalCareful - The other team is making gains during the battle (inflicted 2+ wounds during their turn) voice:Woods]] "Next time around, we'll kick their asses."),
				T(593516083193, --[[ModItemVoiceResponse Woods TacticalCareful VoiceResponse TacticalCareful - The other team is making gains during the battle (inflicted 2+ wounds during their turn) voice:Woods]] "Damn it!"),
				T(349497369573, --[[ModItemVoiceResponse Woods TacticalCareful VoiceResponse TacticalCareful - The other team is making gains during the battle (inflicted 2+ wounds during their turn) voice:Woods]] "Pull yourself together."),
				T(656385517963, --[[ModItemVoiceResponse Woods TacticalCareful VoiceResponse TacticalCareful - The other team is making gains during the battle (inflicted 2+ wounds during their turn) voice:Woods]] "Want revenge? Then take it.")
			}),
			TacticalFocus = TConcat({
				T(335207732125, --[[ModItemVoiceResponse Woods TacticalFocus VoiceResponse TacticalFocus - The team has missed  3+ times voice:Woods]] "Can we focus here?"),
				T(216481716576, --[[ModItemVoiceResponse Woods TacticalFocus VoiceResponse TacticalFocus - The team has missed  3+ times voice:Woods]] "Listen, you fucking amateurs better start pulling your goddamn weight.")
			}),
			TacticalKilling = TConcat({
				T(635883625117, --[[ModItemVoiceResponse Woods TacticalKilling VoiceResponse TacticalKilling - The team is winning the battle  (2+ units have been downed/killed) voice:Woods]] "Fuck yeah! Suck on that!"),
				T(441656575960, --[[ModItemVoiceResponse Woods TacticalKilling VoiceResponse TacticalKilling - The team is winning the battle  (2+ units have been downed/killed) voice:Woods]] "EVERY ONE OF YOU FUCKERS ARE GONNA DIE TODAY!"),
				T(734853431686, --[[ModItemVoiceResponse Woods TacticalKilling VoiceResponse TacticalKilling - The team is winning the battle  (2+ units have been downed/killed) voice:Woods]] "This is my comfort zone!")
			}),
			TacticalLastEnemy = TConcat({
				T(271075527917, --[[ModItemVoiceResponse Woods TacticalLastEnemy VoiceResponse TacticalLastEnemy - A single enemy remains voice:Woods]] "He's done.")
			}),
			TacticalLoss = TConcat({
				T(291441928707, --[[ModItemVoiceResponse Woods TacticalLoss VoiceResponse TacticalLoss - The team is losing the battle (2+ units have been downed/killed) voice:Woods]] "Shit, we got a haul ass."),
				T(338545258119, --[[ModItemVoiceResponse Woods TacticalLoss VoiceResponse TacticalLoss - The team is losing the battle (2+ units have been downed/killed) voice:Woods]] "I'm calling it. We gotta go.")
			}),
			TacticalPressing = TConcat({
				T(697001814747, --[[ModItemVoiceResponse Woods TacticalPressing VoiceResponse TacticalPressing - The team is making gains during the battle (2+ wounds have been inflicted) voice:Woods]] "Take that, you rat bastards"),
				T(171738750025, --[[ModItemVoiceResponse Woods TacticalPressing VoiceResponse TacticalPressing - The team is making gains during the battle (2+ wounds have been inflicted) voice:Woods]] "There's hope for you yet."),
				T(299025737039, --[[ModItemVoiceResponse Woods TacticalPressing VoiceResponse TacticalPressing - The team is making gains during the battle (2+ wounds have been inflicted) voice:Woods]] "Could be a game changer."),
				T(583309484918, --[[ModItemVoiceResponse Woods TacticalPressing VoiceResponse TacticalPressing - The team is making gains during the battle (2+ wounds have been inflicted) voice:Woods]] "This is what I do all day, every day."),
				T(750268949044, --[[ModItemVoiceResponse Woods TacticalPressing VoiceResponse TacticalPressing - The team is making gains during the battle (2+ wounds have been inflicted) voice:Woods]] "Keep on coming. I got time."),
				T(871516702563, --[[ModItemVoiceResponse Woods TacticalPressing VoiceResponse TacticalPressing - The team is making gains during the battle (2+ wounds have been inflicted) voice:Woods]] "They can't kill me!"),
				T(333745831176, --[[ModItemVoiceResponse Woods TacticalPressing VoiceResponse TacticalPressing - The team is making gains during the battle (2+ wounds have been inflicted) voice:Woods]] "Your chances are slim to jack shit.")
			}),
			TacticalReposition = TConcat({
				T(639179429762, --[[ModItemVoiceResponse Woods TacticalReposition VoiceResponse TacticalReposition - The team has not started shooting but is repositioning during the battle voice:Woods]] "I can do tactical.")
			}),
			TacticalRevenge = TConcat({
				T(166383765497, --[[ModItemVoiceResponse Woods TacticalRevenge VoiceResponse TacticalRevenge - A unit from the team has been downed/killed voice:Woods]] "Fuckers. We're gonna make them pay for that."),
				T(324496501882, --[[ModItemVoiceResponse Woods TacticalRevenge VoiceResponse TacticalRevenge - A unit from the team has been downed/killed voice:Woods]] "Tacom, I have a friendly down."),
				T(124719885433, --[[ModItemVoiceResponse Woods TacticalRevenge VoiceResponse TacticalRevenge - A unit from the team has been downed/killed voice:Woods]] "Leave him alone, you piece of shit."),
				T(847669360954, --[[ModItemVoiceResponse Woods TacticalRevenge VoiceResponse TacticalRevenge - A unit from the team has been downed/killed voice:Woods]] "What are you waiting for? Get back in it!"),
				T(663152948156, --[[ModItemVoiceResponse Woods TacticalRevenge VoiceResponse TacticalRevenge - A unit from the team has been downed/killed voice:Woods]] "I'm gonna tear him a new one.")
			}),
			TacticalTaunt = TConcat({
				T(596876068467, --[[ModItemVoiceResponse Woods TacticalTaunt VoiceResponse TacticalTaunt - The team has visible enemies from the other team and is shouting things at them voice:Woods]] "You trying to prove something, kid?"),
				T(545547764665, --[[ModItemVoiceResponse Woods TacticalTaunt VoiceResponse TacticalTaunt - The team has visible enemies from the other team and is shouting things at them voice:Woods]] "Drop it, douchebag, before I drop you."),
				T(244940087131, --[[ModItemVoiceResponse Woods TacticalTaunt VoiceResponse TacticalTaunt - The team has visible enemies from the other team and is shouting things at them voice:Woods]] "I could kill you all without breaking a sweat.")
			}),
			TakeCover = TConcat({
				T(459551865524, --[[ModItemVoiceResponse Woods TakeCover VoiceResponse TakeCover - Played when the Take Cover action is used voice:Woods]] "Barricade set."),
				T(960508221334, --[[ModItemVoiceResponse Woods TakeCover VoiceResponse TakeCover - Played when the Take Cover action is used voice:Woods]] "Cover deployed."),
				T(130275171196, --[[ModItemVoiceResponse Woods TakeCover VoiceResponse TakeCover - Played when the Take Cover action is used voice:Woods]] "Barricade out.")
			}),
			ThreatSelection = TConcat({
				T(218653445148, --[[ModItemVoiceResponse Woods ThreatSelection VoiceResponse ThreatSelection - Selected when under Pinned Down or in the area of an incoming explosion. voice:Woods]] "Nowhere to hide."),
				T(904983995130, --[[ModItemVoiceResponse Woods ThreatSelection VoiceResponse ThreatSelection - Selected when under Pinned Down or in the area of an incoming explosion. voice:Woods]] "I live for this shit."),
				T(485352015191, --[[ModItemVoiceResponse Woods ThreatSelection VoiceResponse ThreatSelection - Selected when under Pinned Down or in the area of an incoming explosion. voice:Woods]] "Shit, cover me!")
			}),
			ThrowGrenade = TConcat({
				T(764335903239, --[[ModItemVoiceResponse Woods ThrowGrenade VoiceResponse ThrowGrenade - When throwing grenade. Voiced line starts before the explosion. voice:Woods]] "Grenade, find cover!"),
				T(870596294249, --[[ModItemVoiceResponse Woods ThrowGrenade VoiceResponse ThrowGrenade - When throwing grenade. Voiced line starts before the explosion. voice:Woods]] "Throwing frag!"),
				T(261615922097, --[[ModItemVoiceResponse Woods ThrowGrenade VoiceResponse ThrowGrenade - When throwing grenade. Voiced line starts before the explosion. voice:Woods]] "Throwing grenade!"),
				T(968058413622, --[[ModItemVoiceResponse Woods ThrowGrenade VoiceResponse ThrowGrenade - When throwing grenade. Voiced line starts before the explosion. voice:Woods]] "Boom!"),
				T(155716328291, --[[ModItemVoiceResponse Woods ThrowGrenade VoiceResponse ThrowGrenade - When throwing grenade. Voiced line starts before the explosion. voice:Woods]] "Get fucking fragged!")
			}),
			Tired = TConcat({
				T(354988405736, --[[ModItemVoiceResponse Woods Tired VoiceResponse Tired - when the merc becomes tired voice:Woods]] "God, I could use a drink.")
			}),
			Travelling = TConcat({
				T(681932822932, --[[ModItemVoiceResponse Woods Travelling VoiceResponse Travelling - When a squad is travelling and enters new sector that is not the final destination of the travel. Played by the squad leader voice:Woods]] "I'm on you. Let's go."),
				T(537792247441, --[[ModItemVoiceResponse Woods Travelling VoiceResponse Travelling - When a squad is travelling and enters new sector that is not the final destination of the travel. Played by the squad leader voice:Woods]] "Following!")
			}),
			ValuableItemFound = TConcat({
				T(495215559408, --[[ModItemVoiceResponse Woods ValuableItemFound VoiceResponse ValuableItemFound - Loot container opened with a valuable item inside voice:Woods]] "This is mine."),
				T(523474158324, --[[ModItemVoiceResponse Woods ValuableItemFound VoiceResponse ValuableItemFound - Loot container opened with a valuable item inside voice:Woods]] "Give me that, I got deep pockets.")
			}),
			WeaponBroken = TConcat({
				T(581738079788, --[[ModItemVoiceResponse Woods WeaponBroken VoiceResponse WeaponBroken - When the player's weapon breaks voice:Woods]] "Anyone want this weapon?")
			}),
			WeaponJammed = TConcat({
				T(776736418284, --[[ModItemVoiceResponse Woods WeaponJammed VoiceResponse WeaponJammed - When weapon has jammed voice:Woods]] "Damn it!")
			}),
			Wounded = TConcat({
				T(450780697234, --[[ModItemVoiceResponse Woods Wounded VoiceResponse Wounded - Unit is Wounded. (When the Wounded VR is played, the Pain VR should be suppressed.) Add a pain noise at the begining voice:Woods]] "Son of a bitch got lucky!"),
				T(329335726723, --[[ModItemVoiceResponse Woods Wounded VoiceResponse Wounded - Unit is Wounded. (When the Wounded VR is played, the Pain VR should be suppressed.) Add a pain noise at the begining voice:Woods]] "Fuck! That actually hurt!"),
				T(735009680041, --[[ModItemVoiceResponse Woods Wounded VoiceResponse Wounded - Unit is Wounded. (When the Wounded VR is played, the Pain VR should be suppressed.) Add a pain noise at the begining voice:Woods]] "You all getting the idea yet?"),
				T(465650011938, --[[ModItemVoiceResponse Woods Wounded VoiceResponse Wounded - Unit is Wounded. (When the Wounded VR is played, the Pain VR should be suppressed.) Add a pain noise at the begining voice:Woods]] "Could use some first aid")
			}),
			comment = "Holds all the text responces",
			group = "MercenariesNew",
			id = "Woods",
		}),
		}),
}