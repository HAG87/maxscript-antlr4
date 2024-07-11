struct RandVals 
( --ooops
    A = 1,
    B = 3,
	RndVals=#(), ptr, eedVal, 
	fn generateRV num fromVal toVal = 
	( 
		if seedVal != undefined do seed seedVal 
		RndVals=for i=1 to num collect random fromVal toVal 
		ptr=1 
		RndVals 
	)/* , 
    private
	fn deleteRv = 
	( 
		RndVals=#() 
		ptr=undefined 
		undefined 
	), 
	fn getNextRV = 
	( 
		if Nvals == 0 do return undefined 
		val = RndVals[ptr]
		ptr += 1 
		if ptr > RndVals.count do ptr=1 
		val 
	), 
    public
	fn sortRV =(sort RndVals), 
	fn setSeed val = (SeedVal = val), 
	fn setPointer val = 
	(   
		if val > 0 and val <= RndVals.count then 
		(ptr=val;true) 
		else 
		false 
	),
    on create do format "Struct Created: %\n" this,
    on clone do format "Struct Cloned: %\n" this */
)