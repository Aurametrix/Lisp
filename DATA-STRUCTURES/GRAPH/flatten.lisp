(defun flatten (structure)
  (cond ((null structure) nil)
        ((atom structure) (list structure))
        (t (mapcan #'flatten structure))))

(defun flatten (obj)
  (let (result)
    (labels ((grep (obj)
               (cond ((null obj) nil)
                     ((atom obj) (push obj result))
                     (t (grep (rest obj))
                        (grep (first obj))))))
      (grep obj)
      result)))