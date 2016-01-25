;UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO.
;FACULTAD DE INGENIERIA.
;MATERIA: SISTEMAS EXPERTOS.
;PROF.: M.I. JAIME ALFONSO REYES CORTES.
;GRUPO: 01.
;PROGRAMA QUE EJEMPLIFICA LA DEFINICIÓN DE REGLAS
(clear)
(defrule dont-walk
	(light ~green)
=>
	(printout t "Don't walk" crlf))
(defrule cautious
	(light yellow | blinking-yellow)
=>
	(printout t "Be cautious" crlf))
(defrule walk
	(light ~red)
=>
	(printout t "Walk" crlf))

(deffacts hechos-iniciales
    (light green)
    )
(reset)
(run)