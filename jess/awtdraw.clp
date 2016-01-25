;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; AwtDraw.clp
;; Simple example of using the jess.awt.Canvas class to draw in a
;; Jess GUI without writing any Java code!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(import java.awt.event.WindowEvent)
(import java.awt.event.WindowListener)
(import java.awt.Frame)
(import java.awt.Color)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; painter(java.awt.Component, java.awt.Graphics)
;; Draw a red X on a blue background. The X goes between the 
;; component's corners.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffunction painter (?canvas ?graph)
  (bind ?x (get-member (?canvas getSize) width))
  (bind ?y (get-member (?canvas getSize) height))
  (?graph setColor (Color.blue))
  (?graph fillRect 0 0 ?x ?y)
  (?graph setColor (Color.red))
  (?graph drawLine 0 0 ?x ?y)
  (?graph drawLine ?x 0 0 ?y))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Create some components. Note how we use the special Canvas subclass
;; and tell it which function to call to paint itself. We also install
;; a handler so the window responds to close events.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(deffunction create-components ()  
  (bind ?f (new Frame "Drawing Demo"))
  (?f addWindowListener
    (implement WindowListener using (lambda (?name ?event)
      (if (eq ?name windowClosing) then 
       (System.exit 0)))))
  (bind ?c (new jess.awt.Canvas painter (engine)))
  (?f add "Center" ?c)
  (?f setSize 200 200)
  (?f setVisible TRUE))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Put things together and display
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(create-components)

