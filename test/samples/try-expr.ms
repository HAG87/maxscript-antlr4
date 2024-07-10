f = openFile "foo.dat"
try
while not eof f do read_some_data f
catch
(
	messageBox "bad data in foo.dat"
	results = undefined
)
close f