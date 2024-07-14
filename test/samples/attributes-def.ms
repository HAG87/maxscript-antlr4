-- weaponDataCA=
attributes weaponData 
(  
	parameters main rollout:params  
	(  
		hitPoints type:#float ui:hits default:10  
		cost type:#float ui:cost default:100  
		sound type:#string  
	)  

	rollout params "Weapon Parameters"  
	(  
		spinner hits "Hit Points" type:  #float  
		spinner cost "Cost" type:  #float  
		dropdownlist sound_dd "Sound" items:  #("boom","sparkle","zap","fizzle")  

		on sound_dd selected i do sound = sound_dd.items [i]  
	) 
)  

CAT_DEF = attributes Custom_Attributes 
Redefine:CAT_CurrentDef 
remap:  # (# ("Param1"),# ("Param9")) 
(  
	Parameters main rollout:params  
	(  
		'Param9' Type:#float UI:'Param9' Default:0.0 
		'Param2' Type:#float UI:'Param2' Default:0.0 
	) 
	Rollout Params "Custom Attributes" 
	( 
		spinner 'Param9' "Param9" Width:160 Height:16 Align:  #Center Type:  #float Range: [0,100,0] 
		spinner 'Param2' "Param2" Width:160 Height:16 Align:  #Center Type:  #float Range: [0,100,0] 
	) 
) 
CustAttributes.add CAT_TargetObject CAT_DEF #Unique BaseObject:  false 
