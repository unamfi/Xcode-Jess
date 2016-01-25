(clear)

(deffacts hechos-iniciales
    (puede-donar-a A+ A+)
    (puede-recibir-de A+ A+)
    (pregunta-a-que-tipos-puede-donar A+)
)

(defrule Regla1
    (pregunta-a-que-tipos-puede-donar ?x)
    =>
    (printout t "Indica a que tipos puede donar " ?x crlf )
    (bind ?cadena (readline))
    (printout t "Cadena: " ?cadena crlf)
    (bind ?lista (explode$ ?cadena))
    ;(assert (puede-donar-a ?x ?lista)
    ;        (puede-donar-a ?x ?cadena))
    ;(foreach ?v ?lista
    ;    (assert (puede-donar-a ?x ?v))
    ;    (printout t ?x " puede donar a " ?v crlf)
    ;)
    ;(bind ?c 1)
    ;(while (<= ?c (length$ ?lista))
    ;    (bind ?v2 (nth$ ?c ?lista))
    ;    (assert (puede-donar-a ?x ?v2))
    ;    (printout t "Elemento:" ?c " " ?x " puede donar a " ?v2 crlf)
    ;    (bind ?c (+ ?c 1))
    ;)

    (puede-donar-a ?x ?lista)

)

(defrule Regla2
    (puede-donar-a ?x $?lista)
    =>
    (foreach ?v ?lista
        (assert (puede-donar-a ?x ?v))
        (printout t ?x " puede donar a " ?v crlf)
    )
)

(defrule puede-donar-a
    (puede-donar-a ?tipoA ?tipoB)
    =>
    (assert (puede-recibir-de ?tipoB ?tipoA))
)

(defrule puede-recibir-de
    (puede-recibir-de ?tipoA ?tipoB)
    =>
    (assert (puede-donar-a ?tipoA ?tipoB))
)

(reset)
(facts)
(run)
(facts)
;(batch "practica4a.clp")