;UNIVERSIDAD NACIONAL AUTONOMA DE MEXICO.
;FACULTAD DE INGENIERIA.
;MATERIA: SISTEMAS EXPERTOS.
;PROF.: ING. JAIME ALFONSO REYES CORTES.
;GRUPO: 01.
;PROGRAMA QUE EJEMPLIFICA EL USO DE ARCHIVOS

;NOTA: LOS ARCHIVO QUE SE PUEDEN OPERAR SîLO SON ARCHIVOS DE TEXTO

(defrule lee-archivo "Lee un archivo de texto"
    (abre-archivo)
    =>
    (printout t "Nombre del archivo: ")
    (bind ?name (read))	;se pide el nombre del archivo
    (try	;se usa para cachar errores, en este caso, de apertura del archivo
    	(open ?name fid r)	;Se abre el archivo para lectura. TambiŽn se puede poner (open ?name fid)
        					;Los par‡metros de open son r | w | a
        				    ;El archivo debe estar en el mismo directorio que el programa
   		(printout t "Archivo abierto." crlf)
        (bind ?lee (read fid))	;Se lee del archivo con read y se le asigna a una variable
        						;Se podr’a usar readline y se leer’a una cadena
        						;Se tendr’a que usar explode$ para convertirlo a una lista
        (bind ?pos 1)	;primer elemento de la lista
        
        
    	(while (neq ?lee EOF)	;se compara con el fin de archivo
            (if (= ?pos 1) then
                (bind ?list (create$ ?lee))	;Con el primer elemento se crea la lista
                else
                (bind ?list (insert$ ?list ?pos ?lee))	;se le a–aden m‡s elementos en la posici—n correspondiente
                )
        	(bind ?pos (+ ?pos 1))    ;incrementa la posici—n
            
           	(assert (valor ?lee))	;crea un hecho
           	(bind ?lee (read fid))	;se sigue leyendo el archivo
           	)
        (bind ?lista (insert$ ?list ?pos ?lee))	;a–ade el œltimo elemento a la lista
        
        (printout t "Lista creada: " ?list crlf)	;se muestra la lista
        (close fid)	;se cierra el archivo
        (assert (muestra-coords))	;se crea un hecho para mostrar los elementos del archivo
        (assert (escribe-archivo))	;se a–ade este hecho para invocar a la regla de escritura del archivo
        (assert (lista ?list))	;se coloca la lista en la memoria de trabajo
    catch
		(printout t (call ?ERROR toString) crlf)	;se muestra el error
        (halt))    ;se forza a detener la ejecuci—n
   
 )

(defrule show-coords
    (muestra-coords)
    (valor ?v)
    =>
    (printout t "valor = " ?v crlf)
    )

(defrule write-file	"escribe en un archivo de texto"
    (declare (salience -1))
    (escribe-archivo)
    (lista $?list)
    =>
    (printout t "Nombre del archivo a guardar: ")
    (bind ?name (read)) ;se lee el nombre del archivo
    (try	;se usa para cachar errores, en este caso, de apertura del archivo
    	(open ?name fid w)	;se abre el archivo para escritura. Si no existe el archivo, lo crea.
        					;Si ya existe el archivo, lo sobreescribe
        					; a en lugar de w a–ade al archivo nuevo contenido sin perder el anterior
   		(printout t "Archivo abierto." crlf)
        
        (foreach ?x ?list 	;foreach ?variable ?lista acci—n que involucre al elemento actual
           ;se puede usar para moverse elemento a elemento de la lista
        							;sin necesidad de conocer la cantidad de elementos de la lista
             (printout fid "elemento : " ?x crlf) ;se escribe en el archivo en el formato que el programador decida
            )	
        
        (close fid)	;se cierra el archivo
        (printout t "Archivo cerrado." crlf)
    catch
		(printout t (call ?ERROR toString) crlf)	;muestra el error
        (halt)) ;detiene la ejecuci—n del programa
    )

(deffacts hechos-iniciales
    (abre-archivo)
    )
;(watch all)
(reset)

(run)