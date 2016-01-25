(clear)

(deffacts hechos-iniciales
    (ap Mendez Maestra no)
    (np Claudia Actriz si)
    (ap Lopez Secretaria si)
    (na Beatriz Garcia no)
)

(defrule NombreApellido
    (na ?nombre Garcia no)
    =>
    (assert (na ?nombre Lopez puedeser))
    (assert (na ?nombre Mendez puedeser))
)

(defrule ApellidoProfesion
    (ap ?apellido Secretaria si)
    =>
    (assert (ap ?apellido Actriz no))
    (assert (ap ?apellido Maestra no))
)

(defrule NombreProfesion
    (np ?nombre Actriz si)
    =>
    (assert (np ?nombre Maestra no))
    (assert (np ?nombre Secretaria no))
)

(defrule ApellidoProfesion
    (ap ?apellido Maestra no)
    =>
    (assert (ap ?apellido Actriz puedeser))
    (assert (ap ?apellido Secretaria puedeser))
)

(defrule elimina-los-puedeser
    (ap Lopez Secretaria si)
    ?h <- (ap Mendez Actriz puedeser)
    ?i <- (ap Mendez Secretaria puedeser)
    =>
    (retract ?h)
    (retract ?i)
    (assert (ap Mendez Actriz si))
)

(defrule cma
    (ap Mendez Actriz si)
    (np Claudia Actriz si)
    => 
    (printout t "Claudia Mendez es Actriz" crlf)
    (assert (na Claudia Mendez si))
)

(defrule elimina-los-puedeser2
    (na Claudia Mendez si)
    ?h <- (na Beatriz Mendez puedeser)
    ?i <- (na Beatriz Lopez puedeser)
    =>
    (retract ?h)
    (retract ?i)
    (assert (na Beatriz Lopez si))
)


(defrule bla
    (na Beatriz Lopez si)
    (ap Lopez Secretaria si)
    => 
    (printout t "Beatriz Lopez es Secretaria" crlf)
    (assert (np Beatriz Secretaria si))
)



(defrule imprimeultimainferencia
    (na Beatriz Lopez si)
    (ap Lopez Secretaria si)
    (na Claudia Mendez si)
    (ap Mendez Actriz si)
    =>
    (assert (na Alicia Garcia si))
    (assert (ap Garcia Maestra si))
    (printout t "Alicia Garcia es Maestra" crlf )
)


(reset)
;(facts)
(run)
(facts)
;(batch "practica3b.clp")

