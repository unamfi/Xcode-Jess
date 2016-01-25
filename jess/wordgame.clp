;;;======================================================
;;;   Number Puzzle Problem
;;;     
;;;     Solves the number puzzle problem in which
;;;
;;;          GERALD 
;;;        + DONALD
;;;          ------
;;;        = ROBERT
;;;
;;;     Jess version 4.1 example
;;;
;;;     To execute, merely load, reset and run.
;;;     This example takes alot of memory to execute.
;;;======================================================


(defrule startup
  =>
  (printout t "The problem is" crlf)
  (printout t "   GERALD" crlf)
  (printout t " + DONALD" crlf)
  (printout t "   ------" crlf)
  (printout t " = ROBERT" crlf)
  (assert (number 0)
          (number 1)
          (number 2)
          (number 3)
          (number 4)
          (number 5)
          (number 6)
          (number 7)
          (number 8)
          (number 9)
          (letter G)
          (letter E)
          (letter R)
          (letter A)
          (letter L)
          (letter D)
          (letter O)
          (letter N)
          (letter B)
          (letter T)))

(deftemplate combination (slot letter (type SYMBOL)) (slot number (type INTEGER)))
(defrule generate-combinations
  (number ?x)
  (letter ?a)
  =>
  (assert (combination (letter ?a) (number ?x))))

(defrule find-solution
  (combination (letter D) (number ?d))
  (combination (letter T) (number ?t&~?d&:(= (mod (+ ?d ?d) 10) ?t)))

  (combination (letter L) (number ?l&~?d&~?t))
  (combination (letter R) (number ?r&~?d&~?t&~?l&:(= (mod (+ ?d ?d
                                                    (* 10 ?l) (* 10 ?l))
                                                 100)
                                            (+ (* 10 ?r) ?t))))

  (combination (letter A) (number ?a&~?d&~?t&~?l&~?r))
  (combination (letter E) (number ?e&~?d&~?t&~?l&~?r&~?a&:(= (mod (+ ?d ?d
                                                    (* 10 ?l) (* 10 ?l)
                                                    (* 100 ?a) (* 100 ?a))
                                                 1000)
                                            (+ (* 100 ?e) (* 10 ?r) ?t))))

  (combination (letter N) (number ?n&~?d&~?t&~?l&~?r&~?a&~?e))
  (combination (letter B) (number ?b&~?d&~?t&~?l&~?r&~?a&~?e&~?n&:(= (mod (+ ?d ?d
                                                                                     (* 10 ?l) (* 10 ?l)
                                                                                     (* 100 ?a) (* 100 ?a)
                                                                                     (* 1000 ?r) (* 1000 ?n))
                                                                                  10000)
                                                                             (+ (* 1000 ?b) (* 100 ?e) (* 10 ?r) ?t))))

  (combination (letter O) (number ?o&~?d&~?t&~?l&~?r&~?a&~?e&~?n&~?b))
  (combination (letter G) (number ?g&~?d&~?t&~?l&~?r&~?a&~?e&~?n&~?b&~?o&:(= (+ ?d ?d
                                                            (* 10 ?l) (* 10 ?l)
                                                            (* 100 ?a) (* 100 ?a)
                                                            (* 1000 ?r) (* 1000 ?n)
                                                            (* 10000 ?e) (* 10000 ?o)
                                                            (* 100000 ?g) (* 100000 ?d))
                                                                                     (+ (* 100000 ?r) (* 10000 ?o) (* 1000 ?b) (* 100 ?e) (* 10 ?r) ?t))))

  =>
  (printout t "A Solution is:" crlf)
  (printout t "  G = " ?g crlf)
  (printout t "  E = " ?e crlf)
  (printout t "  R = " ?r crlf)
  (printout t "  A = " ?a crlf)
  (printout t "  L = " ?l crlf)
  (printout t "  D = " ?d crlf)
  (printout t "  O = " ?o crlf)
  (printout t "  N = " ?n crlf)
  (printout t "  B = " ?b crlf)
  (printout t "  T = " ?t crlf)
  (printout t crlf)
  (printout t "   " ?g ?e ?r ?a ?l ?d crlf)
  (printout t " + " ?d ?o ?n ?a ?l ?d crlf) 
  (printout t "   " "------" crlf)
  (printout t " = " ?r ?o ?b ?e ?r ?t crlf))  
  
(defglobal ?*time* = (time))
(set-reset-globals FALSE)
(deffunction run-n-times (?n)
  (while (> ?n 0) do
         (reset)
         (run)
         (bind ?n (- ?n 1))))

(bind ?*time* (time))

(run-n-times 1)
(printout t "Elapsed time: " (- (time) ?*time*) crlf)

;; (exit)
