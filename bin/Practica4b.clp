(clear)

(deffacts hechos-iniciales
    (pregunta-clase-de-veneno)
    (pregunta-si-tiene-convulsiones)
    (pregunta-si-esta-consciente)
)


(defrule ReglaA
    (pregunta-clase-de-veneno)
    =>
    (printout t "¿Qué tipo de veneno te inyectaste?" crlf)
    (bind ?tipo-de-veneno (read))
    (assert (tipo-de-veneno ?tipo-de-veneno))
)

(defrule ReglaB
    (pregunta-si-tiene-convulsiones)
    =>
    (printout t "¿La victima tiene convulsiones?" crlf)
    (bind ?si (read))
    (assert (tiene convulsiones ?si))
)

(defrule ReglaC
    (pregunta-si-esta-consciente)
    =>
    (printout t "¿La victima esta consiente?" crlf)
    (bind ?si (read))
    (assert (esta consciente ?si))
)


(defrule Clasificacion-del-veneno
    (tipo-de-veneno ?tipo-de-veneno)
    =>
    (
    if (or  (eq ?tipo-de-veneno removedor-de-pintura)
            (eq ?tipo-de-veneno tintura-de-iodo) ) then
        (assert (es_de_la_clase ?tipo-de-veneno acidos))

    elif (or  (eq ?tipo-de-veneno amoniaco)
              (eq ?tipo-de-veneno lejia) ) then
        (assert (es_de_la_clase ?tipo-de-veneno alcalinos))

    elif (or  (eq ?tipo-de-veneno gasolina)
              (eq ?tipo-de-veneno trementina) ) then
        (assert (es_de_la_clase ?tipo-de-veneno derivados-del-petroleo))
    else
        (assert (es_de_la_clase ?tipo-de-veneno otros))
    )
)

(defrule tomar-agua-o-leche
    (es_de_la_clase ?tipo-de-veneno ?clase)
    (tiene convulsiones no)
    (esta consciente si)
    =>
    (
    if (or (eq ?clase acidos)
           (eq ?clase alcalinos)
           (eq ?clase otros)) then
        (printout t "Toma algún líquido como agua o leche." crlf)
    )
)

(defrule induce-vomito
    (es_de_la_clase ?tipo-de-veneno otros)
    =>
    (printout t "¡Induce vomito ahora!" crlf)
)

(reset)
(run)
(facts)
;(batch "practica4b.clp")
