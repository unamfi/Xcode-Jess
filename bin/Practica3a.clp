(clear)

(deffacts hechos-iniciales
    (HABLAMASBAJOQUE Angela Rosa si)
    (HABLAMASALTOQUE Celia Rosa si); Por lo tanto A R C en orden ascendente.
)


(defrule ReglaA
    (HABLAMASBAJOQUE ?x ?y si)
    =>
    (assert (HABLAMASALTOQUE ?y ?x no))
    (printout t ?y " no habla mas alto que " ?x crlf)
    (facts)
)

(defrule ReglaB
    (HABLAMASALTOQUE ?x ?y si)
    =>
    (assert (HABLAMASBAJOQUE ?y ?x no))
    (printout t ?y " no habla mas bajo que " ?x crlf)
    (facts)
)

(defrule ReglaC
    (HABLAMASBAJOQUE ?x ?y no)
    (HABLAMASALTOQUE ?x ?z no)
    =>
    (assert (HABLAMASALTOQUE ?z ?x))
    (assert (HABLAMASALTOQUE ?x ?y))
    (printout t ?z " es mas alto que " ?x " , y " ?x " es mas alto que " ?y crlf)
)

(reset)
(facts)
(run)

;(batch "practica3a.clp")


;;;DISEÑO Y PROGRAMA para la proxima clase.   