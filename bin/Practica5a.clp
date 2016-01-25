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

    (slot Req-oxigeno
        (type SYMBOL)
        (allowed-values aerobica anaerobica ambos)
    )
)

(deffacts instancias
    (bacteria (Tipo Cocoid)(Forma Rod)(Tincion-Gramm +)(Req-oxigeno ambos))
)

(defrule ReglaA
    ?h <- (bacteria (Tipo ?x)(Tincion-Gramm ?y)(Forma ?z)(Req-oxigeno ambos))
    =>
    (retract ?h)
    (assert (bacteria (Tipo ?x)(Tincion-Gramm ?y)(Forma ?z)(Req-oxigeno aerobica))
            (bacteria (Tipo ?x)(Tincion-Gramm ?y)(Forma ?z)(Req-oxigeno anaerobica)))
)

(defrule ReglaA
    ?h <- (bacteria (Tipo ?)(Tincion-Gramm ?)(Forma ?)(Req-oxigeno ambos))
    =>
    (bind ?hecho (duplicate ?h (Req-oxigeno anaerobica)))
    (assert ?hecho)
    (modify ?h (Req-oxigeno aerobica))
)

(reset)
(run)
(facts)
;(batch "practica5a.clp")
