-- randomly jiggle each object in the selection around + or - 20 units
in coordsys local selection.pos = random [-20,20,20] [20,20,20]
-- rotate all the boxes 30 degrees about the y_axis of $foo
about $box001 rotate $box002* 30 y_axis
-- generate a keyframed animation of $foo randomly chasing $baz
-- animate on 
for t in 0 to 100 by 5 do 
at time t 
$box001.pos = $box002.pos + random [-10,-10,-10] [10,10,10] 

with animate on 
(  
	at time tStart obj.pos.z=loadheight+liftHeight  
	at time tEnd obj.pos.z=loadheight 
) 

in $mannequin01...LClav...hand --set context to hand 
$mannequin01.spine.LClav.arm.hand 
(  
	rotate $thumb1 15 y_axis --rotate hand's child thumb      
	rotate $finger11 10 y_axis --rotate hand's child first finger      
	PalmCenter=$finger21.parent.pos --get hand's position      
	PalmCenter+=(LHandPos-$finger21.pos)/2.--calculate center of palm      
	--create a dummy there, dummy is a child of the hand:      
	dummy name:"palmLink" pos:PalmCenter 
)

in $dummy 
(  
	-- create automatically as children of $dummy:      
	sphere name:"ear1" pos:  [10,10,10]  
	sphere name:"ear2" pos:  [-10,10,10]  
	scale $foo/* [1,1,2] --look for 'foo' as a child of $dummy 
)

-- randomly jiggle each object in the selection around +/- 20 units
in coordsys local selection.pos = random [-20,20,20] [20,20,20]
-- rotate objects in parent’s coordinate system
in coordsys parent rotate selection (EulerAngles 0 0 90)

-- rotate all the boxes 30 degrees about the y_axis of $foo
about $foo rotate $box* 30 y_axis
-- rotate each planet 45 degrees around its parent
in coordsys parent about coordsys rotate $planets* 45 z_axis

-- -- undo ["undo_item_label" | label:<string_operand> | variable_name ] <bool_expr> <expr> 
undo on 
(  
	delete $box*  
	delete $sphere*  
	clearUndoBuffer()  
) 
-- undo "add background" on 
(  
	--    ... 
)

my_context_name = "An Undo Context" 
-- undo my_context_name on 
(  
	--... 
)

with redraw off
for t=0 to 10 do
(  
	sliderTime=t  
	exportFile ("outfile_"+(t as string)+".dxf") #noPrompt selectedOnly:true
)

a = for i = 1 to 30 collect i 
--> #(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...) 

with printAllElements off (print a #nomap;ok) 
--> #(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...) 
--> OK 

with printAllElements on (print a #nomap;ok) 
--> #(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30) 
--> OK 

with printAllElements off a as string 
--> "#(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...)" 

with printAllElements on a as string 
--> "#(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30)" 

(  
	-- note that the following is not exception safe!   
	local oldPrintAllElements = options.printAllElements  
	options.PrintAllElements = true  
	print a #nomap  
	options.printAllElements = oldPrintAllElements  
	ok 
)

try with MXSCallstackCaptureEnabled off (setproperty obj #prop val) 
catch()  -- just eat any errors

with MXSCallstackCaptureEnabled off try (setproperty obj #prop val) 
catch()  -- just eat any errors

with MXSCallstackCaptureEnabled off 
(  
	try (setproperty obj #prop val)  
	catch()  -- just eat any errors
)

with dontrepeatmessages on with animate on for t = 1 to 100 do at time t $.radius = t/2

s = sphere isSelected:true
(t1=timestamp();with dontrepeatmessages off with animate on for t = 1 to 10000 do at time t s.radius = t/2;timestamp()-t1)
(t1=timestamp();with dontrepeatmessages on with animate on for t = 1 to 10000 do at time t s.radius = t/2;timestamp()-t1)

-- cascading
-- animate on, at time (t+1), with undo off,coordsys local 
-- ( 
-- 	-- ...  
-- )

-- oc = set coordsys parent -- remember old coordsys