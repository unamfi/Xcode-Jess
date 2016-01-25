;UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO.
;FACULTAD DE INGENIERIA.
;MATERIA: SISTEMAS EXPERTOS.
;PROF.: M. I. JAIME ALFONSO REYES CORTES.
;GRUPO: 01.
;PROGRAMA QUE MUESTRA EL USO DE MÓDULOS MEDIANTE UN GUION 
; QUE SE USA EN CASO DE INCENDIO.
(deftemplate incendio
    (slot tipo
        (type SYMBOL)
        (allowed-values A B C D))
    (slot combustibles
        (type LEXEME)
        (allowed-values papel madera ropa aceite "equipo eléctrico"))
    (slot Estatus
        (type SYMBOL)
        (allowed-values activo inactivo))
    )

(deftemplate extintor
    (slot tipo-incendio
        (type SYMBOL)
        (allowed-values A B C D))
    (slot material-extintor
        (type LEXEME)
        (allowed-values agua "químicos secos" CO2 espuma bromotrifluorometano))
    (slot cortar-corriente
        (type SYMBOL)
        (allowed-values Sí No))
    (slot estatus
        (type SYMBOL)
        (allowed-values sin-usar en-uso)
        (default sin-usar))
    )

(deftemplate persona
    (slot ID
        (type NUMBER))
    (slot tipo
        (type SYMBOL)
        (allowed-values bombero incendiario testigo otro))
    (slot herido
        (type SYMBOL)
        (allowed-values Sí No)
        (default No))
    (slot vivo
        (type SYMBOL)
        (allowed-values Sí No)
        (default Sí))
    (slot incendio-iniciado
        (type SYMBOL)
        (allowed-values A B C D ninguno)
        (default ninguno))     
    )
(defmodule Inicio-incendio)
(defmodule Identificar-tipo-de-incendio)
(defmodule Apagar-incendio)

(deffacts incendios
    (incendio (tipo A) (combustibles papel) (Estatus inactivo))
    (extintor (tipo-incendio A) (material-extintor "químicos secos") (estatus sin-usar) (cortar-corriente No))
    (persona (ID 1) (tipo bombero))
    (persona (ID 2) (tipo incendiario) (herido No) (incendio-iniciado A))
    (persona (ID 3) (tipo testigo) (herido Sí))
    (persona (ID 4) (tipo otro))
    )

(defrule Inicio-incendio::iniciar-incendio
    ?h<-(MAIN::persona (ID ?x) (tipo incendiario) (herido ?) (vivo ?))
    ?h1 <- (MAIN::incendio (tipo ?y) (Estatus inactivo))
    =>
    (modify ?h (incendio-iniciado ?y) )
    (modify ?h1 (Estatus activo))
    (printout t ?x " inició un incendio de tipo " ?y crlf )
    )

(defrule Inicio-incendio::dar-alarma
    (MAIN::persona (ID ?x) (tipo testigo) (herido ?) (vivo Sí) (incendio-iniciado ?))
    (MAIN::incendio (tipo ?t) (combustibles ?) (Estatus activo))
     =>
    	(assert (emite-alarma ?x))
    	(printout t ?x "Dió la alarma" crlf)
    )
(defrule Inicio-incendio::llamada-a-bomberos
    ?h<-(emite-alarma ?x)
    ?h1 <- (MAIN::persona (ID ?i) (tipo bombero) (vivo Sí) (herido No))
    =>
    (assert (Identificar-tipo-de-incendio::Identifica-tipo-incendio ?i))
    (retract ?h)
    )
(defrule Identificar-tipo-de-incendio::que-tipo-es
    ?h<-(Identifica-tipo-incendio ?i)
    ?h1<-(MAIN::persona (ID ?i) (tipo bombero) (vivo Sí) (herido No))
    ?h2<-(incendio (tipo ?x) (combustibles ?c) (Estatus activo))
    =>
    	(if (or (eq ?c ropa) (eq ?c madera)
             (eq ?c papel)) then
        	(assert (extintor-necesario A))
        	(printout t "Extintor necesario " ?x)
        elif (or (eq ?c aceite) (eq ?c gas)
            (eq ?c grasas)) then
        		(assert (extintor-necesario B))
        		(printout t "Extintor necesario " ?x)
        else
        	(printout t "Tipo no identificado")
        )
    )
(defrule Apagar-incendio::apaga-incendio
    ?h<-(Identificar-tipo-de-incendio::extintor-necesario ?e)
    ?h1<-(MAIN::persona (ID ?i) (tipo bombero) (vivo Sí) (herido ?))
    ?h2<-(MAIN::incendio (tipo ?e) (Estatus activo))
    ?h3<-(extintor (tipo-incendio ?e) (material-extintor ?me) (estatus sin-usar) )
    =>
    (retract ?h)
    (modify ?h2 (Estatus inactivo))
    (modify ?h1 (herido Sí))
    (modify ?h3 (estatus en-uso))
    (printout t "El bombero " ?i " ha apagado el incendio " ?e crlf)
    (printout t " con el extintor " ?e " que consiste de " ?me crlf)
    )
(watch all)
(reset)
(focus MAIN
     Inicio-incendio
     Identificar-tipo-de-incendio
     Apagar-incendio)
(while TRUE 
    (run))