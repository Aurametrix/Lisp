(defun drill (n f)
      "Repeat n times the drill phrase.  Call f to obtain i-th drill
       phrase."
      (dotimes (i n)
        (format t "~%Phrase ~d begins. " i)
        (sleep 1)
        (format t "~s" (funcall f i))
        (sleep 1)
        (format t " Phrase ~d ends." i)))
        
(defun drill-phrase-generator (i)
       "Return i-th drill phrase."
       (format nil "I love Java! BTW, ~d*~d=~d." i i (* i i)))
       
 (drill 10 'drill-phrase-generator)
 

(defun drill (n f)
      "Repeat n times the drill phrase.  Call f to obtain i-th drill
       phrase."
      (dotimes (i n)
        (format t "~%Phrase ~d begins. " i)
        (sleep 1)
        (format t "~s" (funcall f i))
        (sleep 1)
        (format t " Phrase ~d ends." i)))

(defun drill-phrase-generator (i)
       "Return i-th drill phrase."
       (format nil "I love Java! BTW, ~d*~d=~d." i i (* i i)))
DRILL-PHRASE-GENERATOR

 (drill 3 'drill-phrase-generator))


Continue execution

(defun drill-phrase-generator (i)
                  (format nil "I love Common Lisp! BTW, ~d+~d=~d." i i (+ i i)))
DRILL-PHRASE-GENERATOR

(defun drill (n f)
           "Repeat n times the drill phrase.  Call f to obtain i-th drill
            phrase."
           (dotimes (i n)
             (format t "~%Drill ~d begins. " i)
             (sleep 1)
             (format t "~s" (funcall f i))
             (sleep 1)
             (format t " Drill ~d ends." i)))
DRILL

continue

"I love Common Lisp! BTW, 1+1=2." Phrase 1 ends.
Phrase 2 begins. "I love Common Lisp! BTW, 2+2=4." Phrase 2 ends.
Drill 0 begins. "I love Common Lisp! BTW, 0+0=0." Drill 0 ends.
Drill 1 begins. "I love Common Lisp! BTW, 1+1=2." Drill 1 ends.
Drill 2 begins. "I love Common Lisp! BTW, 2+2=4." Drill 2 ends.
