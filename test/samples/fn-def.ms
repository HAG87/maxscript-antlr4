fn uppercase instring = 
(  
	local upper, lower, outstring  
	upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"  
	lower="abcdefghijklmnopqrstuvwxyz"  
	outstring=copy instring -- operate on copy of instring      
	for i=1 to outstring.count do  
	(  
		j=findString lower outstring[i]  
		if j != undefined do outstring[i]=upper[j]  
	)  
	return outstring 
)

fn test1 &p3 = return &p3.x

function foo x y &z = 
(  
	-- ...     
	z = x * y  
	-- ...     
	return true 
) 

function my_add a b = a + b 
fn factorial n = if n <= 0 then 1 else n * factorial (n - 1) 
mapped function rand_color x = 
x.wireColor = random (color 0 0 0) (color 255 255 255) 
fn starfield count extent:  [200,200,200] pos:  [0,0,0] = 
(  
	local f = pos - extent / 2,  
	t = pos + extent / 2  
	for i = 1 to count do  
	sphere name:  "star"\  
	radius:(random 0.1 2.0) \  
	position:(random f t) \  
	segs:4 smooth:false 
)

fn foo a b:  c:"default c" = 
(  
	if b == unsupplied then format "Where's the b: argument??"  
	else format "a:% b:% c:%" a b c 
)

fn getXYZset val =
(  
	val.x=random -100 100  
	val.y=random 100 100  
	val.z=random val.x val.y
)
(  
	v1=[0,0,0]  
	v4=v1  
	getXYZSet v1  
	format "v1= %; v4= %\n" v1 v4  
	getXYZSet v4  
	format "v1= %; v4= %\n"v1 v4
)

fn readDataFile filename = 
(  
	f=openfile filename  
	data=#()  
	avg=0  
	nVals=0  
	while not eof f do  
	(  
		val = readvalue f  
		append data val  
		avg += val  
		nVals += 1  
	)  
	close f  
	#(data,(avg/nVals)) 
)

fn find_root twod_fn = 
( 
	local root, last_root 
	while true do 
	( 
		--... 
		if abs(root - last_root) < epsilon then return root 
		--... 
	) 
)