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
    (bacteria (Tipo Actinomycete)(Forma Rod)(Tincion-Gramm +)(Req-oxigeno aerobica))
    (bacteria (Tipo Actinomycete)(Forma Filamenious)(Tincion-Gramm +)(Req-oxigeno aerobica))
    (bacteria (Tipo Coccoid)(Forma Spherical)(Tincion-Gramm +)(Req-oxigeno aerobica anaerobica))
    (bacteria (Tipo Coryneform)(Forma Rod)(Tincion-Gramm +)(Req-oxigeno aerobica anaerobica))
    (bacteria (Tipo Endosphere-forming)(Forma Rod)(Tincion-Gramm +)(Req-oxigeno aerobica anaerobica))
    (bacteria (Tipo Endosphere-forming)(Forma Rod)(Tincion-Gramm -)(Req-oxigeno aerobica anaerobica))
    (bacteria (Tipo Enteric)(Forma Rod)(Tincion-Gramm -)(Req-oxigeno aerobica))
    (bacteria (Tipo Gliding)(Forma Rod)(Tincion-Gramm -)(Req-oxigeno aerobica))
    (bacteria (Tipo Mycobacterium)(Forma Spherical)(Tincion-Gramm ninguno)(Req-oxigeno aerobica))
    (bacteria (Tipo Mycoplasma)(Forma Spherical)(Tincion-Gramm ninguno)(Req-oxigeno aerobica))
    (bacteria (Tipo PseudoMonad)(Forma Rod)(Tincion-Gramm -)(Req-oxigeno aerobica))
    (bacteria (Tipo Rickettsia)(Forma Spherical)(Tincion-Gramm -)(Req-oxigeno aerobica))
    (bacteria (Tipo Rickettsia)(Forma Rod)(Tincion-Gramm -)(Req-oxigeno aerobica))
    (bacteria (Tipo Sheathed)(Forma Filamentous)(Tincion-Gramm -)(Req-oxigeno aerobica))
    (bacteria (Tipo Spirillum)(Forma Spiral)(Tincion-Gramm -)(Req-oxigeno aerobica))
    (bacteria (Tipo Spirochete)(Forma Spiral)(Tincion-Gramm -)(Req-oxigeno anaerobica))
    (bacteria (Tipo Vibrio)(Forma Rod)(Tincion-Gramm -)(Req-oxigeno aerobica))
    (solicitadatosdebacteria)
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

(defrule SolicitaDatosDeBacteria
    (solicitadatosdebacteria)
    =>
    (printout t "Porfavor contesta las siguientes preguntas." crlf)

    (printout t "¿Qué tipo de bacteria te interesa?" crlf)
    (bind ?tipo-de-bacteria (read))

    (printout t "¿Qué tinción gramm tiene?" crlf)
    (bind ?tincion-gramm (read))

    (printout t "¿Qué forma tiene?" crlf)
    (bind ?forma (read))

    (printout t "¿Qué requerimiento de oxigeno tiene?" crlf)
    (bind ?req-oxigeno (read))

    (bind ?result (run-query* search-by-type ?tipo-de-bacteria ?forma ?tincion-gramm ?req-oxigeno))
    (while (?result next)
    (printout t "Tipo: " (?result getString ty) crlf  
                "Forma:" (?result getString fo) crlf
                "Tincion Gramm:" (?result getString ti) crlf
                "Requerimientos de Oxigeno:" (?result getString re) crlf))
)

(defquery search-by-type
  "Finds bacterias with a given type"
  (declare (variables ?ty ?fo ?ti ?re))
  (bacteria (Tipo ?ty)(Forma ?fo)(Tincion-Gramm ?ti)(Req-oxigeno ?re))
)

(reset)
(run)
(facts)
;(batch "practica5c.clp")
