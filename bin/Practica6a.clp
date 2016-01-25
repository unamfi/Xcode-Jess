(clear)

(deftemplate incendio

    (slot tipo
        (type SYMBOL)
        (allowed-values A B C D)
    )
    (slot combustibles
        (type LEXEME)
        (allowed-values papel madera ropa aceite gasas "equipo electrico" magnesio sodio potasio)
    )
    (slot actividad
        (type SYMBOL)
        (allowed-values activo inactivo)
    )

)

(deftemplate extintor

    (slot tipo-incendio
        (type SYMBOL)
        (allowed-values A B C D)
    )
    (slot material-extintor
        (type LEXEME)
        (allowed-values agua "quimicos secos" espuma  )
    )
    (slot cortar-corirente
        (type SYMBOL)
        (allowed-values Si No)
    )
    (slot estatus
        (type SYMBOL)
        (allowed-values sin-usar en-uso)
        (default sin-usar)
    )

)

(deftemplate persona
    (slot ID
        (type NUMBER)
    )
    (slot tipo
        (type SYMBOL)
        (allowed-values bombero incendiario testigo otro)
    )
    (slot herido
        (type SYMBOL)
        (allowed-values Si No)
        (default No)
    )
    (slot vivo
        (type SYMBOL)
        (allowed-values Si No)
        (default Si)
    )
    (slot incendio-iniciado
        (type SYMBOL)
        (allowed-values A B C D ninguno)
        (default ninguno)
    )

)

roles - incendiario, bomberos, personas
utilerias - agua, fuego, mangueras, extintor, electricidad
condiciones - debe existir un incendio
resultados - incendio apagado, personas afectadas, mobiliario afectado
posibles ecenas, idenfitica el incendio, apagar incendio.

(defmodule Inicio-incendio)
(defmodule Identificar-tipo-de-incendio)
(defmodule Apagar-incendio)

(defrule Inicio-incendio::iniciar-incendio
    ?h  <- (MAIN::persona (ID ?x)(tipo incendiario)(herido ?)(vivo ?Si))
    ?h1 <- (MAIN::incendio )
    =>
    (modify ?h (incendio-iniciado ?y))
    (modify ?h1 (estatus-activo))
)

;;;;
(deffacts instancias

)

(defrule REGLA1

)

(reset)
(run)
(facts)
;(batch "practica6a.clp")
