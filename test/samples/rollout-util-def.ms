-- utility
utility Infinity "Game Utilities"
( 
	group "Lighting" 
	( 
		label  
		label1d  
		"Number of Day lights:"  
		across:2  
		offset:  [10,0] 
		label label2d "0" offset:  [10,0] 
		label label1n "Number of Night lights:" across:2 offset:  [13,0] 
		label label2n "0" offset:  [10,0] 
		label label3 
		Radiobuttons WhichOn "Active Lights:" labels:   
		# ( "Day","Night") 
	) 
	group "Scene Data Dump" 
	( 
		Button scenedump "Dump Scene Data" 
	) 
	group "Exclusions/Inclusions" 
	( 
		Button DispExcl "Unhide Exclusions&Inclusions" 
	) 
	group "Camera Mattes" 
	( 
		radiobuttons CamMatte labels:#("None","1","2","3","4") columns:3 
	) 
	Button resetb "Reset"
)

rollout a "Rollout A" 
( 
	button a1 "a1" 
	on a resized val do (format "A: %\n" val) 
) 
-- 
rollout b "Rollout B" 
( 
	button b1 "b1" 
	on b resized val do (format "B: %\n" val) 
)