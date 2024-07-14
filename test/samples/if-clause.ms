-- <if_expr>
-- if <expr> then <expr> [else <expr> ]
-- if <expr> do <expr>
if a > b do (print d; print e)
a = (if d == 0 then 0 else a / d)

if match x y then print x

if a > b then print a
   else if b > c then print b
   else if c > d then print c
   else print d

if a > b then print c else print d
   x = if a > b then c else d

x = if (if a > b then c else d) < e then f else (g = 23)