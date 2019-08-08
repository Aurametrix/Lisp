(defstruct point
  parent
  (size 1))

(defun uf-find (point)
  (let ((parent (point-parent point)))
    (if parent
        ;; here, we use the fact that the assignment will also return
        ;; the value to perform both path compression and find
        (:= (point-parent point) (uf-find parent))
        point)))

(defun uf-union (point1 point2)
  (with ((major minor (if (> (point-size point1)
                             (point-size point2))
                          (values point1 point2)
                          (values point2 point1)) 
         (root (uf-find major)))
    (:+ (point-size root) (point-size minor))
    (:= (point-parent minor) root)))
    
    (defun uf-disjoint (points)
  "Return true if all of the POINTS belong to different subsets."
  (let (roots)
    (dolist (point points)
      (let ((root (uf-find point)))
        (when (member root roots)
          (return-from uf-disjoint nil))
        (push root roots))))
  t)
