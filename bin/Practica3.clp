(clear)

(deffacts hechos-iniciales
    (HABLAMASBAJOQUE Angela Rosa)
    (HABLAMASALTOQUE Celia Rosa)
)

;Reglas
(defrule Regla1
    (HABLAMASBAJOQUE ?x ?y)
    =>
    (assert (HABLAMASALTOQUE ?y ?x))
    (printout t ?y " habla mas alto que " ?x crlf)
)

(defrule Regla2
    (HABLAMASALTOQUE ?x ?y)
    =>
    (assert (HABLAMASBAJOOQUE ?y ?x))
    (printout t ?y " habla mas bajo que " ?x crlf)
)

(defrule Regla3
    (HABLAMASBAJOQUE ?x ?y) 
    (HABLAMASBAJOQUE ?y ?z)
    =>
    (assert (HABLAMASBAJOQUE ?x ?z))
    (printout t ?x " habla mas bajo que " ?z crlf) 
)

(defrule Regla4
    (HABLAMASALTOQUE ?x ?y)
    (HABLAMASALTOQUE ?y ?z)
    =>
    (assert (HABLAMASALTOQUE ?x ?z))
    (printout t ?x " habla mas alto que " ?z crlf)
)

(reset)
(facts)
(run)