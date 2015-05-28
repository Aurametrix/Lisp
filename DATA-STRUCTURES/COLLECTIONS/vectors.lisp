(vector)     ==> #()
(vector 1)   ==> #(1)
(vector 1 2) ==> #(1 2)

;;;;  To make a vector with a fill pointer, pass MAKE-ARRAY a :fill-pointer argument. 
;;;;  example: vector with room for five elements looks empty because the fill pointer is zero
(make-array 5 :fill-pointer 0) ==> #()

;;;;  resizing
(defparameter *x* (make-array 5 :fill-pointer 0))

(vector-push 'a *x*) ==> 0
*x*                  ==> #(A)
(vector-push 'b *x*) ==> 1
*x*                  ==> #(A B)
(vector-push 'c *x*) ==> 2
*x*                  ==> #(A B C)
(vector-pop *x*)     ==> C
*x*                  ==> #(A B)
(vector-pop *x*)     ==> B
*x*                  ==> #(A)
(vector-pop *x*)     ==> A
*x*                  ==> #()

;;;; adjusting
(make-array 5 :fill-pointer 0 :adjustable t) ==> #()

;;;;  initially empty but resizable string
(make-array 5 :fill-pointer 0 :adjustable t :element-type 'character)  ""

;;;;  vectors as sequences
defparameter *x* (vector 1 2 3))

(length *x*) ==> 3
(elt *x* 0)  ==> 1
(elt *x* 1)  ==> 2
(elt *x* 2)  ==> 3
(elt *x* 3)  ==> error
