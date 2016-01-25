(clear)
(import java.lang.*)	; bibliotecas de Java. Para todos aquellas clases de Java que se deseen usar 
						; se debe importar su correspondiente biblioteca

;Se crea un template que define un shadow fact con el nombre de la clase
;shadow facts are just unordered facts that serve as "bridges" to Java objects.
;By using shadow facts, you can put any Java object into Jess's working memory.
;Los slots se crean a partir de la clase

(deftemplate MiClase "define un template con el objeto de Java"
    (declare (from-class MiClase)	;se le indica que cree los slots a partir de la clase original que está en Java
        (include-variables TRUE)	;para hacer uso de sus métodos y variables públicas. Es forzosa esta declaración
        )) 

(defrule crea-clase-java	"Creo una clase "
    (crea-objeto ?name)	;se pide un hecho que coincida con los parámetros que están en el constructor.
    =>
    
    (printout t "Indica el número de elementos del arreglo a procesar: ")
 	(bind ?tamanio (read))
  
    (bind ?instancia (new MiClase ?name ?tamanio)) ;Se crea una instancia de ese objeto.

    (add ?instancia)	;se añade la instancia a la memoria de trabajo
    
    (facts)	; muestra los hechos de la memoria de trabajo
    
    (printout t "Cantidad de elementos: " (call ?instancia getTamanio) crlf)		;se invoca a un método de la clase
    ; Si se quiere acceder a una variable de instancia de la clase la variable debe ser declarada como pública 
    ; en la clase original si no marca un error.
    ; Para mantener la seguridad es necesario solamente declarar los mètodos como públicos y las variables de instancia
    ; como privadas .
    (bind ?elementos  (?instancia getTamanio) )	;se invoca a un mètodo de la clase es equivalente a
    											;(call ?instancia getTamanio)
    (if (= ?elementos ?tamanio) then
        ((System.out) println "Coincide el tamaño con la cantidad de objetos definidos." )
        ; Se invoca a un mètodo de una clase ya existente en Java
        
        (bind ?pos 0)
        (while (< ?pos ?elementos)
            (printout t "Dame el valor para la posición " ?pos ": " crlf)
            (bind ?valor (read))
            (?instancia setPos ?pos ?valor)	;se invoca a otro método de esa instancia
            (update ?instancia)	;se hace que se actualice el valor en la memoria de trabajo
            (bind ?pos (+ ?pos 1))
            )
        		 ;se añade el marco de instancia a la memoria de trabajo
        	(facts)
    		(assert (lee-valores ?tamanio))
        else 
       		 ((System.out) println "No coincide el tamaño por lo que no es posible hacer la asignación")
        )
    
    
   
    )

(defrule usa-metodos-y-el-objeto-clase-java
    (lee-valores ?tam)
    ?h <- (MiClase (string ?nombre) (tamanio ?tam) (array $?lista)) ;Pide un objeto de la clase
    =>
    (modify ?h (string "Otro nombre"))
    ;(call ?h setString "Otro nombre")
    ;(update ?h)	; se podría usar modify siempre y cuando la variable de instancia sea pública
    (facts)
    ;usar variables globales y luego aplicar métodos
    ;(printout t "El objeto se llama: " (?h getString))
    (bind ?pos ?tam)
    (printout t "Tamaño " ?tam " Elementos son: " ?lista crlf) ;Se accede a los los atributos de la clase como
  					;slots
    				;El arreglo se puede manejar como una lista siempre y cuando sea declarado público en la clase
    				;de Java
;    (while (>= ?pos 0)
;        (printout t "El elemento en la posición " ?pos " es: " (?h getPos) crlf)
;        (bind ?pos (- ?pos 1))
;        )
    
    )

(deffacts hechos-iniciales
    (crea-objeto "Nuevo objeto")
    
    )

(reset)
(run)