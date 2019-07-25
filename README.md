Lisp
====

Second-oldest high-level programming language after Fortran

+ [Tutorial on Good Lisp Programming Style](https://www.cs.umd.edu/~nau/cmsc421/norvig-lisp-style.pdf)


implementing functional sorts is much easier than procedural sorts
-------
from here
http://hipster.home.xs4all.nl/lib/scheme/librep/sorts.jl
This means
that algorithmic sorts such as quicksort will be simple while sorts
which modify the array like bubble sort will be worst.

Quicksort is by far the simplest, requiring only five lines of code.
Selection sort also did surprisingly well, especially if min-list is
replaced by apply #'min.  Insertion sort is surprisingly complex,
mostly because inserting an item into a sorted list is difficuilt.
Bucket sort is very simple but not very resource efficient (as per
usual).  Bubble sort is quite small but very hard to read.  Heap sort
is the big winner.  Heap sort is generally taught as 'you can also
sort using a heap but it is too complex to do in practise'.  This
shows that in a functional language, heap-sort isn't too complex
(especially if you already have tree manipulation routines.


(defun heap-sort (l)
  "Inserts every element into a sorted binary tree.
   The tree is then scanned 'inorder'"
  (labels ((tree-insert (el tree)
                        (cond ((null tree)
                        (list nil el nil))
                              ((< el (second tree))
                              (list (tree-insert el (first tree))
                                    (second tree)
                                    (third tree)))
                              ((>= el (third tree))
                              (list (first tree)
                                    (second tree)
                                    (tree-insert el (third tree))))))
           (tree-leaves (tree)
                        (if (null tree) nil
                          (remove nil (append (tree-leaves (first tree))
                                              (list (second tree))
                                              (tree-leaves (third tree)))))))
    (let ((tree-so-far nil))
      (dolist (el l (tree-leaves tree-so-far))
        (setf tree-so-far (tree-insert el tree-so-far))))))


====
+ [Works](http://www.lispworks.com/documentation/lcl50/ug/ug-21.html)
+ [Land of Lisp](http://landoflisp.com/source.html)

### Web frameworks
+ [Clack](https://github.com/fukamachi/clack)
+ [Ningle](https://github.com/fukamachi/ningle)
+ [Clojure toolbox](https://www.clojure-toolbox.com)

+ [SQL APIs and ORMs](https://github.com/marijnh/Postmodern)


vs C++
http://www.dawnofthedata.com/2014/05/abusing-langauge-features-common-lisp.html

learning with Python
http://un.portemanteau.ca/learn-a-lisp-with-python.html

Hylang - a dialect designed to interact with Python by translating expressions into Python's abstract syntax tree (AST)

+ [Hy docs](https://hy.readthedocs.io/en/stable/)

+ [Hy demo](https://try-hy.appspot.com/)

+ [SHCL: Shell Meets Common Lisp](https://github.com/bradleyjensen/shcl)

+ [Make a Lisp](https://github.com/kanaka/mal#mal---make-a-lisp), in 68 languages


### 
+ [Make a language in 1 hr](https://beautifulracket.com/stacker/)

+ [Numpy clone](https://github.com/numcl/numcl)


#### PAPERS
+ [Common Lisp, Typing and Math](https://www-fourier.ujf-grenoble.fr/~sergerar/Papers/Ezcaray.pdf)

