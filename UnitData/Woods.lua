UndefineClass('Woods')
DefineClass.Woods = {
	__parents = { "UnitData" },
	__generated_by_class = "ModItemUnitDataCompositeDef",


	comment = "Holds overall information about merc, from stats to references of other components",
	object_class = "UnitData",
	Health = 86,
	Agility = 80,
	Dexterity = 83,
	Strength = 71,
	Wisdom = 66,
	Leadership = 42,
	Marksmanship = 86,
	Mechanical = 32,
	Explosives = 51,
	Medical = 18,
	Portrait = "Mod/iXq5UQs/Images/woods_portrait_small.png",
	BigPortrait = "Mod/iXq5UQs/Images/woods_portrait_full.png",
	IsMercenary = true,
	Name = T(117779094280, --[[ModItemUnitDataCompositeDef Woods Name]] "Frank Woods"),
	Nick = T(186885432568, --[[ModItemUnitDataCompositeDef Woods Nick]] "Woods"),
	AllCapsNick = T(653767947505, --[[ModItemUnitDataCompositeDef Woods AllCapsNick]] "WOODS"),
	Bio = T(443033985929, --[[ModItemUnitDataCompositeDef Woods Bio]] "He ran away from his home as a young child, forced to rely on street smarts and follow his instincts. Woods quickly learned to be fully independent.\n\nHe served in the United States Marine Corps, during which he had much combat experience fighting in the Korean War. This gained him a reputation that led the CIA to recruit him for their Special Activities Division.\n\nAfter lengthy career and a betrayal he refuses to talk about, Woods found himself on the free market."),
	Nationality = "USA",
	Title = T(934935202072, --[[ModItemUnitDataCompositeDef Woods Title]] "YOU CAN'T KILL ME!"),
	Email = T(634887339728, --[[ModItemUnitDataCompositeDef Woods Email]] "FrankWoods@aim.com"),
	snype_nick = T(158396975608, --[[ModItemUnitDataCompositeDef Woods snype_nick]] "WOODS"),
	ExtraPartingWords = {},
	Offline = {
		PlaceObj('ChatMessage', {
			'Text', T(139388634169, --[[ModItemUnitDataCompositeDef Woods Text Offline ChatMessage voice:Woods]] "Keep going, soldier!"),
		}),
	},
	GreetingAndOffer = {
		PlaceObj('ChatMessage', {
			'Text', T(445300168799, --[[ModItemUnitDataCompositeDef Woods Text GreetingAndOffer ChatMessage voice:Woods]] "Whatcha need?"),
		}),
	},
	ConversationRestart = {
		PlaceObj('ChatMessage', {
			'Text', T(304588569694, --[[ModItemUnitDataCompositeDef Woods Text ConversationRestart ChatMessage voice:Woods]] "Yeah, yeah."),
		}),
	},
	IdleLine = {
		PlaceObj('ChatMessage', {
			'Text', T(709339022582, --[[ModItemUnitDataCompositeDef Woods Text IdleLine ChatMessage voice:Woods]] "What are you looking at?"),
		}),
	},
	PartingWords = {
		PlaceObj('ChatMessage', {
			'Text', T(412177064544, --[[ModItemUnitDataCompositeDef Woods Text PartingWords ChatMessage voice:Woods]] "Let's get this fucking thing done!"),
		}),
	},
	RehireIntro = {
		PlaceObj('ChatMessage', {
			'Text', T(554693637023, --[[ModItemUnitDataCompositeDef Woods Text RehireIntro ChatMessage voice:Woods]] "You all need me in this!"),
		}),
	},
	RehireOutro = {
		PlaceObj('ChatMessage', {
			'Text', T(850529824249, --[[ModItemUnitDataCompositeDef Woods Text RehireOutro ChatMessage voice:Woods]] "Time to do some damage, brother."),
		}),
	},
	StartingSalary = 2950,
	SalaryIncrease = 200,
	SalaryMaxLv = 6000,
	StartingLevel = 4,
	Likes = {
		"Raven",
		"Meltdown",
		"Len",
	},
	LearnToLike = {
		"Raider",
		"Nails",
	},
	Dislikes = {
		"Ivan",
		"Omryn",
	},
	LearnToDislike = {
		"Igor",
		"MD",
	},
	StartingPerks = {
		"WoodsEffect",
		"AutoWeapons",
		"NightOps",
		"Spiritual",
		"OldDog",
		"TakeAim",
		"OpportunisticKiller",
		"Hotblood",
	},
	AppearancesList = {
		PlaceObj('AppearanceWeight', {
			'Preset', "Woods",
		}),
	},
	Equipment = {
		"Woods",
	},
	Tier = "Elite",
	Specialization = "AllRounder",
	pollyvoice = "Nicole",
	gender = "Male",
	blocked_spots = set(),
	VoiceResponseId = "Woods",
	FallbackMissingVR = "Steroid",
	DaysUntilOnline = 1,
}

