UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO.
;FACULTAD DE INGENIERIA.
;MATERIA: SISTEMAS EXPERTOS.
;PROF.: M.I. JAIME ALFONSO REYES CORTES.
;GRUPO: 01.
;PROGRAMA QUE EJEMPLIFICA EL USO DE HECHOS Y REGLAS
;EJEMPLO DE MODUS PONENS
(clear)
(defrule aterrizaje_forzoso
    ?havion <- (avion ?avion volando)
    (motores ?avion detenido)
    (capitan ?avion ?name)
    =>
    (retract ?havion)
    (assert (aterrizaje_forzoso ?avion))
    (printout t "El capitan " ?name " dio la orden de aterrizar." crlf)
    (printout t "El avion " ?avion " hizo un aterrizaje forzoso." crlf)
    
    )

(defrule detener_motores
    (combustible ?avion vacio)
    (avion ?avion volando)
    ?motor <- (motores ?avion operando)
    =>
    (retract ?motor)
    (assert (motores ?avion detenido))
    (printout t "ADVERTENCIA: Los motores del avion " ?avion " se detuvieron." crlf)
    )

(defrule avion_volando
    (avion ?avion volando)
    ?h1<- (combustible ?avion lleno)
    (motores ?avion operando)
    =>
    (retract ?h1)
    (assert (combustible ?avion vacio))
    (printout t "Avion " ?avion " esta volando." crlf)
    )

(deffacts estado_inicial
    (combustible A lleno)
    (motores A operando)
    (capitan A Juan)
    (avion A volando)
    (combustible B vacio)
    (motores B operando)
    (capitan B Cesar)
    (avion B volando)
    
    )
(reset)
(run)
