UndefineClass('Payback')
DefineClass.Payback = {
	__parents = { "CharacterEffect" },
	__generated_by_class = "ModItemCharacterEffectCompositeDef",


	comment = "More accuracy and damage per stack, given by Woods",
	object_class = "CharacterEffect",
	unit_reactions = {
		PlaceObj('UnitReaction', {
			Event = "OnCalcDamageAndEffects",
			Handler = function (self, target, attacker, attack_target, action, weapon, attack_args, hit, data)
				if target == attacker then
					local damageBonus = self:ResolveValue("damageMod") * self.stacks
					data.base_damage = MulDivRound(data.base_damage, 100 + damageBonus, 100)
					data.breakdown[#data.breakdown + 1] = { name = self.DisplayName, value = damageBonus }	
				end
			end,
		}),
		PlaceObj('UnitReaction', {
			Event = "OnCalcChanceToHit",
			Handler = function (self, target, attacker, action, attack_target, weapon1, weapon2, data)
				if target == attacker then
					local chanceBonus = self:ResolveValue("hitChanceMod") * self.stacks
					data.mod_add = data.mod_add + chanceBonus
				end
			end,
		}),
	},
	DisplayName = T(183156117080, --[[ModItemCharacterEffectCompositeDef Payback DisplayName]] "Payback"),
	Description = T(109578663805, --[[ModItemCharacterEffectCompositeDef Payback Description]] "Deal slightly more <em>Damage</em> with a slightly higher <em>Chance to hit</em> until the end of the combat (this effect stacks)."),
	OnAdded = function (self, obj)  end,
	Icon = "UI/Hud/Status effects/bloodthirst",
	max_stacks = 5,
	RemoveOnEndCombat = true,
	Shown = true,
	HasFloatingText = true,
}

