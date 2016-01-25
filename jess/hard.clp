(deffacts information
  (find-match a c e g)
  (item a)
  (item b)
  (item c)
  (item d)
  (item e)
  (item f)
  (item g)
)

;; This is a deliberately bad rule. Putting the find-match pattern at
;; the top speeds up pattern matching by a huge factor.

(defrule match-2
  (item ?x)
  (item ?y)
  (item ?z)
  (item ?w)
  (find-match ?x ?y ?z ?w)
  =>
  )

(defglobal ?*time* = (time))
(set-reset-globals FALSE)
(deffunction run-n-times (?n)
  (while (> ?n 0) do
         (reset)
         (bind ?n (- ?n 1))))

(run-n-times 1)

(printout t "Elapsed time: " (integer (- (time) ?*time*)) crlf)
;; (exit)


