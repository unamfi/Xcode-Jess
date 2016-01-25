;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; SwingDraw.clp
;; Simple example of using the jess.swing.JPanel class to draw in a
;; Jess GUI without writing any Java code!
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; painter(java.awt.Component, java.awt.Graphics)
;; Draw a red X on a blue background. The X goes between the 
;; component's corners.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(import javax.swing.JFrame)
(import java.awt.Color)
(import java.awt.BorderLayout)

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
  (bind ?f (new JFrame "Drawing Demo"))
  (?f setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE))
  (bind ?c (new jess.swing.JPanel painter (engine)))
  ((?f getContentPane) add ?c (BorderLayout.CENTER))
  (?f setSize 200 200)
  (?f setVisible TRUE))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Put things together and display
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(create-components)

