(defun org-babel-execute:hy (body params)
  (let* ((temporary-file-directory ".")
         (tempfile (make-temp-file "hy-")))
    (with-temp-file tempfile
      (insert body))
    (unwind-protect
        (shell-command-to-string
         (format "hy %s" tempfile))
      (delete-file tempfile))))
      
(import numpy)
(setv a (numpy.array [1 2 3]))
(setv b (numpy.array [1 2 3]))
(print (numpy.dot a b))
