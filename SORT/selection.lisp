(defun selection-sort (l)
  "Finds the smallest element in l and adds it to the result  This function must
   continually remove items from l which makes it very slow"
  (labels ((min-list (l)
                     (let ((best (first l)))
                       (dolist (el l best)
                         (if (< el best) (setf best el))))))
    (do* ((so-far nil (push (min-list lis) so-far))
          (lis l (remove (min-list lis) lis)))
        ((null lis) (reverse so-far)))))
