(defun insertion-sort (l)
  "Inserts every element of l into a sorted sublist.  InsertOrd inserts the
   element in order using recursion, so-far maintains the sorted sublist"
  (labels ((insertOrd (theNumber lesser theRest)
                      (if (null theRest)
                          (append lesser (list theNumber))
                        (let ((lo (first theRest)))
                          (if (< lo theNumber)
                              (insertOrd theNumber
                                         (append lesser (list lo))
                                         (rest theRest))
                            (append lesser (list theNumber) theRest))))))
    (let ((so-far nil))
      (dolist (el l so-far)
        (setf so-far (insertord el nil so-far))
        (1+ (aref table item))))
    (mm (x) (- x min)))                 ; Returns x minus min (for aref
  (mapcar #'insert (mapcar #'mm l))
  (dotimes (x (1+ (- max min)) (reverse result-list))
    (dotimes (count (aref table x))
      (push (+ min x) result-list))))
 

