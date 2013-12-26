(defun quick-sort (l)
  "Quicksort divides all elements into smaller or larger than the first element.
   These are then sorted recursivly with the first element in the middle"
  (if (null l) nil                      ; Recursive case
    (labels ((bigger-el (x) (> x (first l)))) ; t if x > first
      (let ((smaller (remove-if #'bigger-el (rest l))) ; all < first
            (bigger  (remove-if-not #'bigger-el (rest l)))) ; all > first
        (append (quicksort smaller) (list (first l)) (quicksort bigger))))))

