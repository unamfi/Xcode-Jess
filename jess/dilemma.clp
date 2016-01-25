

;;;======================================================
;;;   Farmer's Dilemma Problem
;;;
;;;     Another classic AI problem (cannibals and the 
;;;     missionary) in agricultural terms. The point is
;;;     to get the farmer, the fox the cabbage and the
;;;     goat across a stream.
;;;        But the boat only holds 2 items. If left 
;;;     alone with the goat, the fox will eat it. If
;;;     left alone with the cabbage, the goat will eat
;;;     it.
;;;
;;;     CLIPS Version 6.0 Example, modified for Jess
;;;
;;;     To execute, merely load, reset and run.
;;;======================================================

;;;*************
;;;* TEMPLATES *
;;;*************

;;; The status facts hold the state  
;;; information of the search tree.

(deftemplate MAIN::status 
   (slot search-depth)
   (slot parent)
   (slot farmer-location)
   (slot fox-location)
   (slot goat-location)
   (slot cabbage-location)
   (slot last-move))
   
;;;*****************
;;;* INITIAL STATE *
;;;*****************

(deffacts MAIN::initial-positions
  (status (search-depth 1) 
          (parent no-parent)
          (farmer-location shore-1)
          (fox-location shore-1)
          (goat-location shore-1)
          (cabbage-location shore-1)
          (last-move no-move)))

(deffacts MAIN::opposites
  (opposite-of shore-1 shore-2)
  (opposite-of shore-2 shore-1))

;;;***********************
;;;* GENERATE PATH RULES *
;;;***********************

(defrule MAIN::move-alone 
  ?node <- (status (search-depth ?num) 
                   (farmer-location ?fs))
  (opposite-of ?fs ?ns)
  =>
  (duplicate ?node (search-depth (+ 1 ?num))
                   (parent ?node)
                   (farmer-location ?ns)
                   (last-move alone)))

(defrule MAIN::move-with-fox
  ?node <- (status (search-depth ?num) 
                   (farmer-location ?fs)
                   (fox-location ?fs))
  (opposite-of ?fs ?ns)
  =>
  (duplicate ?node (search-depth (+ 1 ?num)) 
                   (parent ?node)
                   (farmer-location ?ns)
                   (fox-location ?ns)
                   (last-move fox)))

(defrule MAIN::move-with-goat 
  ?node <- (status (search-depth ?num) 
                   (farmer-location ?fs)
                   (goat-location ?fs))
  (opposite-of ?fs ?ns)
  =>
  (duplicate ?node (search-depth (+ 1 ?num)) 
                   (parent ?node)
                   (farmer-location ?ns)
                   (goat-location ?ns)
                   (last-move goat)))

(defrule MAIN::move-with-cabbage
  ?node <- (status (search-depth ?num)
                   (farmer-location ?fs)
                   (cabbage-location ?fs))
  (opposite-of ?fs ?ns)
  =>
  (duplicate ?node (search-depth (+ 1 ?num)) 
                   (parent ?node)
                   (farmer-location ?ns)
                   (cabbage-location ?ns)
                   (last-move cabbage)))

;;;******************************
;;;* CONSTRAINT VIOLATION RULES *
;;;******************************

(defmodule CONSTRAINTS)

(defrule CONSTRAINTS::fox-eats-goat 
  (declare (auto-focus TRUE))
  ?node <- (status (farmer-location ?s1)
                   (fox-location ?s2&~?s1)
                   (goat-location ?s2))
  =>
  (retract ?node))

(defrule CONSTRAINTS::goat-eats-cabbage 
  (declare (auto-focus TRUE))
  ?node <- (status (farmer-location ?s1)
                   (goat-location ?s2&~?s1)
                   (cabbage-location ?s2))
  =>
  (retract ?node))

(defrule CONSTRAINTS::circular-path 
  (declare (auto-focus TRUE))
  (status (search-depth ?sd1)
          (farmer-location ?fs)
          (fox-location ?xs)
          (goat-location ?gs)
          (cabbage-location ?cs))
  ?node <- (status (search-depth ?sd2&:(< ?sd1 ?sd2))
                   (farmer-location ?fs)
                   (fox-location ?xs)
                   (goat-location ?gs)
                   (cabbage-location ?cs))
  =>
  (retract ?node))

;;;*********************************
;;;* FIND AND PRINT SOLUTION RULES *
;;;*********************************

(defmodule SOLUTION)
       
(deftemplate SOLUTION::moves 
   (slot id)
   (multislot moves-list))


(defrule SOLUTION::recognize-solution 
  (declare (auto-focus TRUE))
  ?node <- (status (parent ?parent)
                   (farmer-location shore-2)
                   (fox-location shore-2)
                   (goat-location shore-2)
                   (cabbage-location shore-2)
                   (last-move ?move))
  =>
  (retract ?node)
  (assert (moves (id ?parent) (moves-list ?move))))

(defrule SOLUTION::further-solution 
  ?node <- (status (parent ?parent)
                   (last-move ?move))
  ?mv <- (moves (id ?node) (moves-list $?rest))
  =>
  (modify ?mv (id ?parent) (moves-list ?move ?rest)))

(defrule SOLUTION::print-solution 
  ?mv <- (moves (id no-parent) (moves-list no-move $?m))
  =>
  (retract ?mv)
  (printout t crlf "Solution found: " crlf crlf)
  (bind ?length (length$ ?m))
  (bind ?i 1)
  (bind ?shore shore-2)
  (while (<= ?i ?length)
     (bind ?thing (nth$ ?i ?m))
     (if (eq ?thing alone)
        then (printout t "Farmer moves alone to " ?shore "." crlf)
        else (printout t "Farmer moves with " ?thing " to " ?shore "." crlf))
     (if (eq ?shore shore-1)
        then (bind ?shore shore-2)
        else (bind ?shore shore-1))
     (bind ?i (+ 1 ?i))))

(reset)
(run)