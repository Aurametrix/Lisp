;;;; to interrupt the control flow of an application and pass error information up the call stack

;;; compare to exception handling in c++
;;; // C++ exceptions
;;;try {
;;;   LogData d = parseLog(log);
;;;   doSomethingWithData(d);
;;;}
;;;catch (const LogParseError& e) {
;;;   fprintf(stderr, "Failed to parse data out of log");
;;;}

;; conditions in common Lisp
(handler-case
    (let ((d (parse-log log)))
      (do-something-with-data d))
  (log-parse-error (e) 
    (format *error-output* "Failed to parse data out of log")))
