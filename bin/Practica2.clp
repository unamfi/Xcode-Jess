(clear)

(deffacts hecho-inicial
    (pregunta-color)
    (pregunta-nota)
)

(defrule preguntacolor
    (pregunta-color)
    =>
    (printout t "Dime un color:" crlf)
    (bind ?c (read))
    (assert (color ?c))
)

(defrule preguntanota
    (pregunta-nota)
    =>
    (printout t "Dime una nota:" crlf)
    (bind ?c (read))
    (assert (_nota ?c))
)

;(deffacts colores
;    (color Rose)
;    (color Magenta)
;    (color Violet)
;    (color Blue)
;    (color Azure)
;    (color Cyan)
;    (color Spring)
;    (color Green)
;    (color Chartreuse)
;    (color Yellow)
;    (color Orange)
;    (color Red)
;)

;(deffacts notas
;    (nota E)
;    (nota D#)
;    (nota D)
;    (nota C#)
;    (nota C)
;    (nota B)
;    (nota A#)
;    (nota A)
;    (nota G#)
;    (nota G)
;    (nota F#)
;    (nota F)
;)

;Color
(defrule regla1
    (color Rose)
    =>
    (bind ?n E)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

;Nota 
(defrule nota1
    (_nota E)
    =>
    (bind ?n Rose)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(defrule regla2
    (color Magenta)
    =>
    (bind ?n D#)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota2
    (_nota D#)
    =>
    (bind ?n Magenta)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(defrule regla3
    (color Violet)
    =>
    (bind ?n D)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota3
    (_nota D)
    =>
    (bind ?n Violet)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)


;Color
(defrule regla4
    (color Blue)
    =>
    (bind ?n C#)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota4
    (_nota C#)
    =>
    (bind ?n Blue)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(defrule regla5
    (color Azure)
    =>
    (bind ?n C)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota5
    (_nota C)
    =>
    (bind ?n Azure)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(defrule regla6
    (color Cyan)
    =>
    (bind ?n B)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota6
    (_nota B)
    =>
    (bind ?n Cyan)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(defrule regla7
    (color Spring)
    =>
    (bind ?n A#)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota7
    (_nota A#)
    =>
    (bind ?n Spring)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(defrule regla8
    (color Green)
    =>
    (bind ?n A)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota8
    (_nota A)
    =>
    (bind ?n Green)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(defrule regla9
    (color Chartreuse)
    =>
    (bind ?n G#)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota9
    (_nota G#)
    =>
    (bind ?n Chartreuse)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(defrule regla10
    (color Yellow)
    =>
    (bind ?n G)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota10
    (_nota G)
    =>
    (bind ?n Yellow)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(defrule regla11
    (color Orange)
    =>
    (bind ?n F#)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota11
    (_nota F#)
    =>
    (bind ?n Orange)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(defrule regla12
    (color Red)
    =>
    (bind ?n F)
    (printout t "La nota correspondiente es  " ?n "" crlf)
    (assert (nota ?n))
)

(defrule nota12
    (_nota F)
    =>
    (bind ?n Red)
    (printout t "El color correspondiente es " ?n "" crlf)
    (assert (_color ?n))
)

(reset)
(facts)
(run)