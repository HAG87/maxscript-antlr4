plugin helper lightMaster 
name:"Light Master" 
classID:#(12345,54321) 
extends:Dummy 
invisible:true 
replaceUI:true 
version:  3 -- set current version to 3 
(  
	parameters main rollout:params 
	--    ...  
	on update do  
	(  
		if version == 1 then something  -- do something special for v1 instances  
	) 
	--    ... 
)

plugin shape Extended_Rect 
name:"Rectangle2" 
classID:#(0x133067, 0x54375) 
extends:rectangle version:1 
category:"Splines" 
(  
	tool create  
	(  
		local startPoint  
		on mousePoint click do  
		case click of  
		(  
			1:  startPoint = nodeTM.translation = gridPoint  
			3:  #stop  
		)  
		on mouseMove click do  
		case click of  
		(  
			2:  (delegate.width= abs gridDist.x  
				delegate.length= abs gridDist.y  
				nodeTM.translation = startpoint + gridDist/2.   
			)  
			3:  delegate.corner_radius = amax 0 -gridDist.x  
		)  
	) 
)

plugin simpleMod saddle
name:"SaddleDeform"
classID:#(685325,452281)
version:1
( 
	parameters main rollout:params 
	( 
		amount type:#integer ui:amtSpin default:20 
	) 
	rollout params "Saddle Parameters" 
	( 
		spinner amtSpin "Amount: " type:#integer range: [0,1000,20] 
	) 
	on map i p do 
	( 
		p.z += amount * sin((p.x * 22.5/extent.x) * (p.y * 22.5/extent.y)) 
		p 
	)
)