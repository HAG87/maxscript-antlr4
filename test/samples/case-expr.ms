-- <case_expr>
b = Box()
copy_type = 2 --copy
new_obj = case copy_type of
(
2: copy b
3: instance b
default: reference b
)

case of
(
    (a > b): print "a is big"
    (b < c): print "b is little"
    (c <= d*3): (
        print "c is less than 3 times d" 
        print "also this code has 2 lines"
    )
    default: print "none of the above"
)