(define day "Sunday")

"It's a lovely ~day morning" ;=> "It's a lovely Sunday morning"
"(+ 1 1) is ~(+ 1 1)" ;=> "(+ 1 1) is 2"


primitives :: [(String, [LispVal] -> LispVal)]
primitives = [ -- ...
              ("string-append", stringAppend)]

stringAppend =
  String . concatMap unpackString

unpackString (String s) = s
unpackString v = show v

