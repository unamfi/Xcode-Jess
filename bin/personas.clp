(clear)
(defrule inicializa-personas 
	?h<-(declara-personas)
	=>
	(bind ?cpersonas 20)
	(while ( >= ?cpersonas 1)
		(assert (persona ?cpersonas)); ASSERT INSERTA UN HECHO EN LA MEMORIA
		(if (eq (mod ?cpersonas 2) 0)  then
			(assert (sexo ?cpersonas mujer))
		else
			(assert (sexo ?cpersonas hombre)))
		(bind ?cpersonas (- ?cpersonas 1))
	)
	(retract ?h)
	(facts)
)

(defrule senala-hombres
	(persona ?x)
	(sexo ?x hombre)
	(indica-hombres)
	=>
	(printout t "Persona " ?x " es hombre" crlf)
)


(defrule senala-mujeres
	(persona ?x)
	(sexo ?x mujer)
	(indica-mujeres)
	=>
	(printout t "Persona " ?x " es mujer" crlf)
)

(deffacts personas
	(declara-personas)
	(indica-hombres)
	;(indica-mujeres)
)

(deffacts caracteristicas
	(sexo 1 hombre)
	(sexo 2 mujer)
)

(facts)
(reset)
(facts)
(run)