;UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO.
;FACULTAD DE INGENIERIA.
;MATERIA: SISTEMAS EXPERTOS.
;PROF.: ING. JAIME ALFONSO REYES CORTES.
;GRUPO: 01.
;PROGRAMA QUE CREA LA RED SEMANTICA DEL ARBOL FAMILIAR.
(clear)

(defrule inicio
	;(declare (salience 1))
	(pregunta-relacion)
=>
	(printout t "ÀQue relacion quieres saber?" crlf)
	(printout t "Dame el primer nombre: ")
	(bind ?name1 (read))
	(printout t "Dame el segundo nombre: ")
	(bind ?name2 (read))
	
	(if (eq ?name1 ?name2) then
		(printout t "No es posible relacionar a personas con el mismo nombre" crlf)
		(halt)
	else
		(assert (relacion_entre ?name1 ?name2))
	)	
	
)

(defrule padre
	(relacion hijo_de ?hijo ?papa)
=>
    (printout t ?hijo " es hijo de " ?papa "." crlf)
	(assert (relacion padre_de ?papa ?hijo))
)

(defrule hijo
	(relacion padre_de ?papa ?hijo)
=>
	(printout t ?papa " es padre de " ?hijo "." crlf)
	(assert (relacion hijo_de ?hijo ?papa))
)

(defrule esposo
	(relacion padre_de ?papa ?hijo)
	(relacion padre_de ?mama ?hijo)
	
=>
	(if (neq ?papa ?mama) then
		(printout t ?mama " y " ?papa " son esposos." crlf)
		(assert (relacion esposo_de ?papa ?mama))
	)
)

(defrule encuentra_esposo
	(relacion padre_de ?papa ?hijo)
	(relacion esposo_de ?papa ?mama)
=>
	(printout t ?mama " es padre de " ?hijo "." crlf)
	(assert (relacion padre_de ?mama ?hijo))
)
 
(defrule encuentra_hijo
	(relacion hijo_de ?hijo ?papa)
	(relacion esposo_de ?papa ?mama)
=>
	(printout t ?hijo " es hijo de " ?mama "." crlf)
	(assert (relacion hijo_de ?hijo ?mama))
)

(defrule hermano
	(relacion hijo_de ?name1 ?papa)
	(relacion hijo_de ?name2 ?papa)
=>
	(if (neq ?name1 ?name2)  then
       		(printout t ?name1 " y " ?name2 " son hermanos. " crlf)
		(assert (relacion hermano_de ?name1 ?name2))
	)
)

(defrule abuelo
	(relacion padre_de ?name1 ?papa)
	(relacion padre_de ?papa ?name2)
=>
	(printout t ?name1 " es abuelo de " ?name2 "." crlf)
	(assert (relacion abuelo_de ?name1 ?name2))
)

(defrule nieto
	(relacion hijo_de ?name1 ?papa)
	(relacion hijo_de ?papa ?name2)
=>
	(printout t ?name1 " es nieto de " ?name2 "." crlf)
	(assert (relacion nieto_de ?name1 ?name2))
)
(defrule tio
	(relacion padre_de ?papa ?hijo)
	(relacion hermano_de ?papa ?tio)
=>
	(printout t ?tio " es tio de " ?hijo "." crlf)
	(assert (relacion tio_de ?tio ?hijo))
)

(defrule sobrino 
	(relacion hijo_de ?hijo ?papa)
	(relacion hermano_de ?papa ?tio)
=>
	(printout t ?hijo " es sobrino de " ?tio "." crlf)
	(assert (relacion sobrino_de ?hijo ?tio))

)
	
(defrule primo
	(relacion hijo_de ?primo1 ?papa)
	(relacion hijo_de ?primo2 ?tio)
	(relacion hermano_de ?papa ?tio)
=>
	(printout t ?primo1 " y " ?primo2 " son primos." crlf)
	(assert (relacion primo_de ?primo1 ?primo2))
)

(defrule bisabuelo
	(relacion padre_de ?bisabuelo ?abuelo)
	(relacion padre_de ?abuelo ?papa)
	(relacion padre_de ?papa ?hijo)
=>
	(printout t ?bisabuelo " es bisabuelo de " ?hijo "." crlf)
	(assert (relacion bisabuelo_de ?bisabuelo ?hijo))
)

(defrule bisnieto
	(relacion hijo_de ?hijo ?papa)
	(relacion hijo_de ?papa ?abuelo)
	(relacion hijo_de ?abuelo ?bisabuelo)
=>
	(printout t ?hijo " es bisnieto de " ?bisabuelo "." crlf)
	(assert (relacion bisnieto_de ?hijo ?bisabuelo))
)



(defrule relacion_directa
	(declare (salience -1))
	?relacion <- (relacion_entre ?name1 ?name2)
	(relacion ?parentesco ?name1 ?name2)
=>
	(retract ?relacion)
	(if (eq ?parentesco hijo_de) then
		(printout t ?name1 " es hijo de " ?name2 "." crlf)
     elif (eq ?parentesco padre_de) then
			(printout t ?name1 " es padre de " ?name2 "." crlf)
     elif (eq ?parentesco esposo_de) then
			(printout t ?name1 " y " ?name2 " son esposos." crlf)
     elif (eq ?parentesco hermano_de) then
			(printout t ?name1 " y " ?name2 " son hermanos." crlf)
     elif (eq ?parentesco abuelo_de) then
			(printout t ?name1 " es abuelo de " ?name2 "." crlf)
	 elif (eq ?parentesco nieto_de) then
			(printout t ?name1 " es nieto de " ?name2 "." crlf)
	 elif (eq ?parentesco bisabuelo_de) then
			(printout t ?name1 " es bisabuelo de " ?name2 "." crlf)
	 elif (eq ?parentesco bisnieto_de) then
			(printout t ?name1 " es bisnieto de " ?name2 "." crlf)
	 elif (eq ?parentesco tio_de) then
			(printout t ?name1 " es tio de " ?name2 "." crlf)
	 elif (eq ?parentesco sobrino_de) then
			(printout t ?name1 " es sobrino de " ?name2 "." crlf)
	 else 
			(printout t ?name1 " y " ?name2 " son primos." crlf)
 	)
)	

(defrule sin-parentesco
	(declare (salience -2))
	?relacion<-(relacion_entre ?name1 ?name2)
	(not (or (relacion ?rel ?name1 ?name2) (relacion ?rel ?name2 ?name1) ))
=>
	(printout t "No existe relación entre " ?name1 " y " ?name2 crlf)
)
;
;opcional tatarabuelo, tataranieto
(deffacts parentesco
	(relacion padre_de Pedro Pablo)
	(relacion padre_de Pedro Juan)
	(relacion padre_de Alma Juan)
	(relacion padre_de Alma Pablo)
	(relacion padre_de Juan Vito)
	(relacion padre_de Irma Vito)
	(relacion hijo_de Raquel Vito)
	(relacion esposo_de Vito Nancy)
	(relacion hijo_de Hugo Nancy)
	(relacion hijo_de Irma Rosa)
	(relacion esposo_de Rosa Jorge)
	(relacion hermano_de Irma Karla)
	(relacion esposo_de Karla Alberto)
    (relacion hijo_de Joaquin Hugo)
    (pregunta-relacion)
)

(reset)
(run)
