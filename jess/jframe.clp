; -*- clips -*-

;; **********************************************************************
;;                           Frame.clp
;;
;; A nifty example of building a a Swing GUI using jess reflection.
;; Using this package, we can create java objects, call their methods,
;; access their fields, and respond to GUI events.
;; You can therefore build an entire GUI application without actually
;; writing any Java code!
;;
;; **********************************************************************

;; ******************************
;; Declarations

(import javax.swing.*)
;; Explicit import so we get JFrame.EXIT_ON_CLOSE
(import javax.swing.JFrame) 
(import java.awt.event.ActionListener)
(import java.awt.BorderLayout)
(import java.awt.Color)

;; ******************************
;; DEFGLOBALS

(defglobal ?*f* = 0)
(defglobal ?*c* = 0)
(defglobal ?*m* = 0)

;; ******************************
;; DEFFUNCTIONS

(deffunction create-frame ()
  (bind ?*f* (new JFrame "Jess Reflection Demo"))
  (bind ?*c* (?*f* getContentPane))
  (set ?*c* background (Color.magenta)))


(deffunction add-widgets ()
  (?*c* add (new JLabel "This is: ") (BorderLayout.CENTER))
  (bind ?*m* (new JComboBox))
  (?*m* addItem "Cool")
  (?*m* addItem "Really Cool")
  (?*m* addItem "Awesome")
  (?*c* add ?*m* (BorderLayout.SOUTH)))


(deffunction add-behaviours ()
  (?*f* setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE))
                            
  (?*m* addActionListener (implement ActionListener using
    (lambda (?name ?event)
      (printout t "You chose: " (get ?*m* selectedItem) crlf)))))

(deffunction show-frame ()
  (?*f* pack)
  (?*f* setVisible TRUE))


;; ******************************
;; Run the program

(create-frame)
(add-widgets)
(add-behaviours)
(show-frame)

