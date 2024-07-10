for i = 1 to 10 do print i -- sequence numbers 

for item in table1 do x = x + item.height -- sequence an array 

for t in 0f to 100f by 5f do sliderTime=t -- sequence time (given as frames, here) 

bigones = for obj in $box* -- you can sequence pathnames! 

where obj.height > 100 collect obj -- collect the big boxes into an array 

for i,j,k = 12 to 24 where (mod i 3 == 0) do ( -- filter numbers divisible by 3  
	format "val:% index:% filtered index:%\n" i j k 
) 

for i=1 to 8 do (if i == 5 do continue; print i) -- prints 1..4, 6..8 

for i=1 to 8 collect (if i == 5 do continue; i) -- returns #(1, 2, 3, 4, 6, 7, 8)