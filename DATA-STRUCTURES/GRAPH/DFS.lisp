;;;; DEPTH-FIRST SEARCH

;;; iterative version for a tree 
;;; Uses only the open list 
;;; Assumes the existence of a function successors to expand a node 
;;; and a predicate goalp to check for a goal state.
;;; Returns the goal state (not the path to reach it)
(defun df (start)
  (do ((open (list start)                     ; initial value
	     (nconc (successors (car open))   ; value after each iteration
		    (cdr open))))
      ((null open))                           ; exit condition
      (cond ((goalp (car open)) 
	     (return (car open))))))

;;; recursive version for a tree 
;;; same assumptions as before
;;; the open list is passed as an argument in the recursive call
(defun df (nodelist)
  (cond ((null nodelist) nil)
	((goalp (car nodelist)) (car nodelist))
	(t (df (nconc (successors (car nodelist)) 
		      (cdr nodelist))))))

;;; iterative version for a graph
;;; both open and closed are used 
(defun df-graph (start)
  (do ((open (list start)
             ;; avoids re-expanding nodes already in closed
	     (nconc (remove-seen (successors (car open)) 
				 closed)
		    (cdr open)))
       (closed () (cons (car open) closed)))
      ((null open))
      (cond ((goalp (car open)) 
	     (return (car open))))))

;;; utility function
;;; removes from sublst elements that are in lst 
(defun remove-seen (sublst lst)
  (remove-if #'(lambda (x) (member x lst)) sublst))

