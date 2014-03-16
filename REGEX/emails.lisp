(in-package :test.email-newsletter)

(load-config)
(log:config :info)
(log:config :daily (conf 'email-newsletter-log-path))

(defparameter *db* nil)

(defun within-nutrient-range (previous-food current-food begin end)
  (and (< (nutrient-allowed-in-unit previous-food) begin)
       (between (nutrient-allowed-in-units current-food) begin end)))

(defmacro unsubscribe-link (user-id)
  `(htm (:p "You are receiving this email because you subscribed for our newsletter at "
            (:a :href "http://test.com" "test.com")
            ". To unsubscribe from these newsletter "
            (:a :href (format nil "https://a.test.com~A?id=~A"
                              (url 'disable-email-newsletter-by-id) ,user-id)
                "click here") ".")))

(defun food-newsletter-table (user-id)
  (with-html-output-to-string (s)
    (let ((foods (w/c (select-dao 'food (:= 'user-id user-id) 'allowed))))
      (unsubscribe-link user-id)
      (do-tuples/o (prev current) (cons (make-food -1 "" -10000) foods) ; dummy first food
        (cond ((within-nutrient-allowed-range prev current 0 7)
               (htm (:h1 "days")))
              ((within-nutrient-allowed-range prev current 7 30)
               (htm (:h1 "weeks")))
              ((within-nutrient-allowed-range prev current 30 365)
               (htm (:h1 "months")))
              ((within-nutrient-allowed-range prev current 365 10000)
               (htm (:h1 "years"))))
        (when (>= (food-allowed-in-range current) 0)
          (htm (:p (fmt "~A - ~A" (food-name current) (food-nutrients-natural current))))))
      (unsubscribe-link user-id))))

(defun send-email-newsletters ()
  (let ((user-ids (w/c
                    (query
                     (:select 'user-id :from 'user-accounts :where (:= 'email-newsletter "true"))
                     :column))))
    (loop for id in user-ids
          for email = (w/c
                        (query (:select 'email :from 'user-accounts :where (:= 'user-id '$1))
                               id :single)) do
         (log:info "sending email to: ~A" email)
         (handler-case
             (cl-sendgrid:send-email
              :api-user "test@aurametrix.com" :api-key (conf 'send-grid-password)
              :subject "Daily newsletter - test"
              :to email
              :from "email-newsletter@test.com"
              :from-name "test.com"
              :reply-to "test@test.com"
              :html (food-newsletter-table id))
           (cl-sendgrid:sendgrid-error (c)
             (log:error "sendgrid error for ~A, ~A" email
                        (cl-sendgrid:sendgrid-error-message c)))))))

(defun run ()
  (send-email-newsletters)
  (ccl:quit))

(run)
