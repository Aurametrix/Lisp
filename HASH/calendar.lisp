;;;; applying predicates to each timestamps to retrieve its calendar information

;;; month, day, weekday, hour, minute

(defn get-date-fields [ts]
  (let [millis (* 1000 ts)
        day (.format cet-date-format millis)
        t (.format cet-time-format millis)
        day-tokens (clojure.string/split day #"[\s|,]")
        year (java.lang.Integer/parseInt (last day-tokens ))
        weekday (first day-tokens )
        day (java.lang.Integer/ parseInt (nth day-tokens 2))
        month (nth day-tokens 3)
        time-tokens (clojure.string/split t #":")
        hour (java.lang.Integer/parseInt (first time-tokens ))
        minute (java.lang.Integer/ parseInt (second time-tokens ))]
   {: weekday weekday
    :month month
    :day day
    :hour hour
    :minute minute
    :year year }))


;; each of these predicates can be applied to a time-window, 
;; retrieving the information corresponding to its initial timestamp.

(defn abstract-interval [ts]
  (let [jt (timec/ from-long (* 1000 ts))
    hour (time/hour jt)
    minute (time/minute jt)
    weekday (["" "Monday" "Tuesday" " Wednesday "
    "Thursday" "Friday" "Saturday" "Sunday"]
    (time/ day-of-week jt ))]
{: hour hour :minute minute :weekday weekday :interval ts }))
