;;;;The function y-or-n-p can be answered with a single character
;;;; It returns t if the user types y, nil if the user types n, <SPC> means yes, <DEL> is no, C-] means quit”
;;;; yes-or-no-p starts by displaying prompt in the echo area, it's ppropriate for more crucial decisions
 
(yes-or-no-p "Do you really want to remove everything? ")
          
          ;; After evaluation of the preceding expression,
          ;;   the following prompt appears,
          ;;   with an empty minibuffer:
          
          ---------- Buffer: minibuffer ----------
          Do you really want to remove everything? (yes or no)
          ---------- Buffer: minibuffer ----------

