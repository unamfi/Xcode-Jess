;UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO.
;FACULTAD DE INGENIERIA.
;MATERIA: SISTEMAS EXPERTOS.
;PROF.: ING. JAIME ALFONSO REYES CORTES.
;GRUPO: 01.
;PROGRAMA QUE EJEMPLIFICA EL USO DE FUNCIONES Y LISTAS


;funciones que aceptan como parametros variables de tipo símbolo, número o cadena

;función que eleva un número al cuadrado

(deffunction pow2 (?valor)
	(bind ?pow2 (* ?valor ?valor))
)

;función que calcula la distancia entre dos puntos P1(x1, y1) y P2(x2, y2)  

(deffunction distancia (?x1 ?y1 ?x2 ?y2)
	(bind ?distancia (sqrt (+ (pow2 (- ?x1 ?x2)) (pow2 (- ?y1 ?y2)))))
)

(deffunction crealista (?x1 ?y1 ?x2 ?y2)
	(bind ?crealista (create$ ?x1 ?y1 ?x2 ?y2))
)



;función que acepta como parametros multivariables o listas

;función que muestra en pantalla los elementos de una lista y devuelve el número de elementos de la lista

(deffunction num_com$($?lista)

	(bind ?l (length$ $?lista)) ;length$ devuelve el número de elementos de la lista
	(bind ?i 1) ;¡Ojo! El primer elemento de la lista tiene índice 1
   
 	
	(while (<= ?i ?l)

		(printout t "valor " ?i ":" (nth$ ?i $?lista) crlf)

		(bind ?i (+ ?i 1))

	)

	(bind ?cadena (implode$ ?lista))
	(printout t "La lista: " ?lista crlf)
	(assert (calcula_d ?lista))
	(printout t "La cadena: " ?cadena crlf)
	(assert (calcula_d ?cadena))
	;(assert ?lista)

;	(bind ?v1 (nth$ 1 $?lista))
;	(bind ?v2 (nth$ 2 $?lista))
;	(bind ?v3 (nth$ 3 $?lista))
;	(bind ?v4 (nth$ 4 $?lista))
;;	(assert (calcula_d ?v1 ?v2 ?v3 ?v4))
	(bind ?num_com$ ?i)
)

(defrule obtendistancia
 "permite calcular la distancia con base en un hecho que exista en la memoria activa"
	(calcula_d ?x1 ?y1 ?x2 ?y2)

=>
	
	;invoco a la función que acepta variables símbolo, número o cadena como parámetros

	(bind ?d (distancia ?x1 ?y1 ?x2 ?y2)) 
						
	(printout t "La distancia es " ?d crlf)

)

(defrule obtendistancia-conlistas
 "permite calcular la distancia con base en un hecho que exista en la memoria activa"
	(calcula_d $?coordenadas)
	(test (eq (length$ $?coordenadas) 4))

=>
	
	;invoco a la función que acepta variables símbolo, número o cadena como parámetros

	(bind ?d (distancia (nth$ 1 ?coordenadas) (nth$ 2 ?coordenadas) (nth$ 3 ?coordenadas) (nth$ 4 ?coordenadas))) ;OJo
						
	(printout t "La distancia con listas es " ?d crlf)

)



;¡Ojo! Esta regla no funciona bien por lo que está entre comentarios
;(defrule obten-coordenadas "obtiene coordenadas del teclado"
;	(obten_de teclado)

;=>
	
;(printout t "Dame x1 x2 y1 y2")

;	(bind $?coords (readline))

;	(bind ?c (num_com$ $?coords))

;	(printout t "Cantidad " ?c crlf)

;	;(printout t "Datos " $?coords crlf)

;	(assert (calcula_d (explode$ $?coords)))
;)



(defrule obten-coordenadas "obtiene coordenadas del teclado"
	?h <- (obten_de teclado)

=>
	
	(retract ?h)
	(printout t "Dame las coordenadas x1 y1 x2 y2 " crlf)

	;¡Ojo! Lee una línea del teclado como una cadena
	(bind ?coords (readline)) 
	;¡Ojo! explode$ se encarga de convertir una cadena en una lista
	(bind ?listacoords (explode$ ?coords))
	;Invoco a la función que necesita una lista como parámetros
	(bind ?c (num_com$ ?listacoords)) 

	(printout t "Cantidad " ?c crlf)


	(assert (calcula_d (explode$ ?coords)))
)
	
	;NOTA: si se hiciera (assert (calcula_d ?coords)) se guardaría la entrada como una
	;cadena y no se podrían manipular sus elementos individualmente por ello usando
	;(assert (calcula_d (explode$ ?coords))) es posible guardarlos de esa forma)



(defrule obten-coordenadas-individuales "obtiene coordenadas del teclado y crea una lista"
	?h <- (obten_de coordenadas-individuales)
=>
	(retract ?h)
	(printout t "Coordenadas en forma individual" crlf)
	(printout t "Dame x1 " crlf)
	(bind ?x1 (read))
	(printout t "Dame y1 " crlf)
	(bind ?y1 (read))
	(printout t "Dame x2 " crlf)
	(bind ?x2 (read))
	(printout t "Dame y2 " crlf)
	(bind ?y2 (read))

	(printout t "Lista creada " crlf)
	(assert (calcula_d  (crealista ?x1 ?y1 ?x2 ?y2)))
	(printout t "Variables " crlf)
	(assert (calcula_d ?x1 ?y1 ?x2 ?y2))
	;(assert (calcula_d  (create$ ?x1 ?y1 ?x2 ?y2)))
)


(deffacts hechos-iniciales "definimos las coordenadas de dos puntos"
	(calcula_d 1.0 1.0 2.0 2.0)
 	;punto definido inicialmente
	(obten_de teclado)
	;punto a obtenerse por vía teclado
	(obten_de coordenadas-individuales)
)