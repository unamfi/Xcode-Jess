(clear)
(import java.lang.*)	; bibliotecas de Java. Para todos aquellas clases de Java que se deseen usar 
						; se debe importar su correspondiente biblioteca

;Se crea un template que define un shadow fact con el nombre de la clase
;shadow facts are just unordered facts that serve as "bridges" to Java objects.
;By using shadow facts, you can put any Java object into Jess's working memory.
;Los slots se crean a partir de la clase

(deftemplate MiClase "define un template con el objeto de Java"
    (declare (from-class MiClase)	;se le indica que cree los slots a partir de la clase original que est� en Java
        (include-variables TRUE)	;para hacer uso de sus m�todos y variables p�blicas. Es forzosa esta declaraci�n
        )) 

(defrule crea-clase-java	"Creo una clase "
    (crea-objeto ?name)	;se pide un hecho que coincida con los par�metros que est�n en el constructor.
    =>
    
    (printout t "Indica el n�mero de elementos del arreglo a procesar: ")
 	(bind ?tamanio (read))
  
    (bind ?instancia (new MiClase ?name ?tamanio)) ;Se crea una instancia de ese objeto.

    (add ?instancia)	;se a�ade la instancia a la memoria de trabajo
    
    (facts)	; muestra los hechos de la memoria de trabajo
    
    (printout t "Cantidad de elementos: " (call ?instancia getTamanio) crlf)		;se invoca a un m�todo de la clase
    ; Si se quiere acceder a una variable de instancia de la clase la variable debe ser declarada como p�blica 
    ; en la clase original si no marca un error.
    ; Para mantener la seguridad es necesario solamente declarar los m�todos como p�blicos y las variables de instancia
    ; como privadas .
    (bind ?elementos  (?instancia getTamanio) )	;se invoca a un m�todo de la clase es equivalente a
    											;(call ?instancia getTamanio)
    (if (= ?elementos ?tamanio) then
        ((System.out) println "Coincide el tama�o con la cantidad de objetos definidos." )
        ; Se invoca a un m�todo de una clase ya existente en Java
        
        (bind ?pos 0)
        (while (< ?pos ?elementos)
            (printout t "Dame el valor para la posici�n " ?pos ": " crlf)
            (bind ?valor (read))
            (?instancia setPos ?pos ?valor)	;se invoca a otro m�todo de esa instancia
            (update ?instancia)	;se hace que se actualice el valor en la memoria de trabajo
            (bind ?pos (+ ?pos 1))
            )
        		 ;se a�ade el marco de instancia a la memoria de trabajo
        	(facts)
    		(assert (lee-valores ?tamanio))
        else 
       		 ((System.out) println "No coincide el tama�o por lo que no es posible hacer la asignaci�n")
        )
    
    
   
    )

(defrule usa-metodos-y-el-objeto-clase-java
    (lee-valores ?tam)
    ?h <- (MiClase (string ?nombre) (tamanio ?tam) (array $?lista)) ;Pide un objeto de la clase
    =>
    (modify ?h (string "Otro nombre"))
    ;(call ?h setString "Otro nombre")
    ;(update ?h)	; se podr�a usar modify siempre y cuando la variable de instancia sea p�blica
    (facts)
    ;usar variables globales y luego aplicar m�todos
    ;(printout t "El objeto se llama: " (?h getString))
    (bind ?pos ?tam)
    (printout t "Tama�o " ?tam " Elementos son: " ?lista crlf) ;Se accede a los los atributos de la clase como
  					;slots
    				;El arreglo se puede manejar como una lista siempre y cuando sea declarado p�blico en la clase
    				;de Java
;    (while (>= ?pos 0)
;        (printout t "El elemento en la posici�n " ?pos " es: " (?h getPos) crlf)
;        (bind ?pos (- ?pos 1))
;        )
    
    )

(deffacts hechos-iniciales
    (crea-objeto "Nuevo objeto")
    
    )

(reset)
(run)