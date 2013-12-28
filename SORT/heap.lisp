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

