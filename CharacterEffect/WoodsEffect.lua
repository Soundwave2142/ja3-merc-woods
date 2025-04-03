UndefineClass('WoodsEffect')
DefineClass.WoodsEffect = {
	__parents = { "Perk" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "Get Payback on turn start, give to random ally on kill",
	object_class = "Perk",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnBeginTurn",
			Handler = function (self, target)
				target:AddStatusEffect("Payback")
			end,
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
		}),
	},
	DisplayName = T(268564161033, --[[ModItemCharacterEffectCompositeDef WoodsEffect DisplayName]] "WMD"),
	Description = T(561136195130, --[[ModItemCharacterEffectCompositeDef WoodsEffect Description]] "Receive <color EmStyle>Payback</color> at the start of <color EmStyle>each turn</color>. Upon killing an enemy, move one stack from self to a random ally; that ally has a chance to become <color EmStyle>Inspired</color>.\n\nEach stack of <color EmStyle>Payback</color> increases <color EmStyle>Damage</color> with a higher <color EmStyle>Chance to hit</color> until the end of the combat."),
	OnAdded = function (self, obj)  end,
	Icon = "UI/Icons/Perks/HawksEye",
	Tier = "Personal",
}

