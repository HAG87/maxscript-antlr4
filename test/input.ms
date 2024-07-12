undo on 
(  
	-- delete $box*  
	-- delete $sphere*  
	-- clearUndoBuffer()  
)
-- undo "add background" on 
(  
	--    ... 
)
-- my_context_name = "An Undo Context" 
-- undo my_context_name on 
(  
	--... 
)
-- cascading
-- animate on, at time (t+1), with undo off,coordsys local 
-- ( 
-- 	-- ...  
-- )

-- oc = set coordsys parent -- remember old coordsys