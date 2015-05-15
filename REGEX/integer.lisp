(loop for x in '(1 2 3 b 4)
      if (not (integerp x)) return nil
      else collect (1+ x))

;;; typep determines object type - integer,hashtable (but not var type) 
;;; (defvar *x* 1)
;;; *x*
;;; (typep *x* 'integer)
;;; T
;;; type-of object => typespec
;;; (type-of 1) same as (type-of *x*)
;;; FIXNUM
;;; 
;;; 

(defun add-1-all (L) 
  (add-1-all-helper L nil))

(defun add-1-all-helper (L answer)
  (if (null L)
    answer
    (if (integerp (car L))
      (add-1-all-helper
        (cdr L)
        (cons (+ (car L) 1) answer)))))
