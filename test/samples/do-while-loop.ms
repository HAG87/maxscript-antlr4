-- <do_loop>
-- <while_loop>
while x > 0 do 
( print x 
	x -= 1 
) 
while not eof f do print (read_value f) 

do 
( 
	exchanged=false 
	for i=1 to imax do 
	( 
		j=i+gap 
		if (compare array[j] array[i]) do 
		(swap array[j] array[i]; exchanged=true) 
	) 
) 
while exchanged

while not eof f do -- read until reach end of file 
(  
	local line=readline f -- read in a line  
	if line[1] == "-" do continue -- if comment, skip to next line  
	line1=parser1 line -- call function parser1  
	processobjs line1 -- call function processobjs 
) 