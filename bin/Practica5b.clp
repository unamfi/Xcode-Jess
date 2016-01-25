(clear)

(deftemplate bacteria

    (slot Tipo
        (type SYMBOL)
        (allowed-values Cocoid Actinomycete Coryneform Endospore-forming Enteric Filamentous Gliding Microbacterium Mycoplasma PseudoMonad Rickettsia Sheathed Spirillum Spirochete Vibrio)
        (default Actinomycete)
    )
    
    (slot Forma
        (type SYMBOL)
        (allowed-values Rod Spherical Filamentous)
        (default Rod)
    )

    (slot Tincion-Gramm
        (type SYMBOL)
        (allowed-values + - ninguno)
        (default ninguno)
    )

    (multislot Req-oxigeno)
)

(deffacts instancias
    (bacteria (Tipo Cocoid)(Forma Rod)(Tincion-Gramm +)(Req-oxigeno aerobica anaerobica))
    (solicitatipodebacteria)
)

(defrule REGLA1
    (declare (salience 6))

    ?h <- (bacteria (Tipo ?)(Tincion-Gramm ?)(Forma ?)(Req-oxigeno $?lista))
    (test (>= (length$ ?lista) 2))
    =>
    (foreach ?v ?lista
        (bind ?hecho (duplicate ?h (Req-oxigeno ?v)))
        (assert ?hecho)
    )
    (retract ?h)
)

(defrule Regla2
    (declare (salience 5))
    ?h <- (bacteria (Tipo ?)(Tincion-Gramm ?)(Forma ?)(Req-oxigeno $?lista))
    (test (>= (length$ ?lista) 2))
    =>
    (bind ?h1 (duplicate ?h (Req-oxigeno (nth$ 1 $lista))))
    (modify ?h (Req-oxigeno (nth$ 2 ?lista)))
    (assert ?h1)
)

(defrule Regla3
    (declare (salience 5))
    ?h <- (bacteria (Tipo ?)(Tincion-Gramm ?)(Forma ?)(Req-oxigeno $?lista))
    (test (>= (length$ ?lista) 2))
    =>
    (bind ?h1 (duplicate ?h (Req-oxigeno (first$ ?lista))))
    (modify ?h (Req-oxigeno (rest$ ?lista)))
    (assert ?h1)
)

(defrule SolicitaTipoDeBacteria
    (solicitatipodebacteria)
    =>
    (printout t "¿Qué tipo de bacteria te interesa?" crlf)
    (bind ?tipo-de-bacteria (read))
    (assert (tipo-de-bacteria ?tipo-de-bacteria))
)

(defrule ImprimeTipoDeBacteria
    (tipo-de-bacteria ?tipo-de-bacteria)
    ?h <- (bacteria (Tipo ?tipo-de-bacteria)(Tincion-Gramm ?tincion)(Forma ?forma)(Req-oxigeno $?lista))
    =>
    (printout t "Tipo de bacteria " ?tipo-de-bacteria crlf)
    (printout t "Tincion Gramm " ?tincion crlf)
    (printout t "Forma: " ?forma crlf)
    (printout t "Requerimientos de oxigeno: " crlf)
    (foreach ?v ?lista
         (printout t ?v crlf)
    )
)

(reset)
(run)
(facts)
;(batch "practica5b.clp")
