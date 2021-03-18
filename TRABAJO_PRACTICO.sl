/*

Integrantes:

	1)	Cáseres Gonzáles, Iván Demetrio
	
	2)	Franco Vera, Enrique Martin
	
	3)	Peralta González, Juan Fernando
	
	4) Samaniego Muñoz, Mijhael Andrés

*/
tipos
punto: registro 
			{
				x:numerico
				y:numerico
			}
var

	fila: registro {
							frente,trasero:numerico
							array:vector [50] punto
						}

	ALFABETO : matriz [ *, * ] cadena

	ALFABETO_Visitado : matriz [ *, * ] logico
	
	M, N : numerico
	
	Prueba,Resultado:punto
	
	Porcentaje_P, Porcentaje_Vocales, Porcentaje_Consonantes : numerico
	
	Vocales : vector [ 5 ] cadena

	Consonantes : vector [ 21 ] cadena
	
	Abecedario : vector [ 27 ] cadena

	posicionesx : vector [4] numerico

	posicionesy : vector [4] numerico
inicio

	cls()
	
	Vocales = { "A", "E", "I", "O", "U" }
	
	Consonantes = { "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "Ñ", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z" }

	Abecedario = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "Ñ", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

	posicionesx = { -1, 0, 1, 0 }
	
	posicionesy = { 0, 1, 0, -1 }

	imprimir( "\nESTE PROGRAMA SE COME PALABRAS DE UNA MATRIZ\n" )

	repetir
		
		imprimir("\nIngrese el número de filas: ")
		
		leer( M )
		
		si( M < 8 or M > 12 ){
			
			imprimir("\n(!) Debe ser un número del 8 al 12.\n")
			
		}
		
	hasta( M >= 8 and M <= 12 )

	repetir
		
		imprimir( "\nIngrese el número de columnas: " )
		
		leer( N )
		
		si( N < 8 or N > 12 ){
			
			imprimir("\n(!) Debe ser un número del 8 al 12.\n")
			
		}
		
	hasta( N >= 8 and N <= 12 )

	Porcentaje_P = int( M * N * ( 25/100 ) )

	Porcentaje_Vocales = int( M * N * ( 50/100 ) )

	Porcentaje_Consonantes = M * N - Porcentaje_P - Porcentaje_Vocales
	
	dim ( ALFABETO, M, N )

	dim ( ALFABETO_Visitado, M, N )

	cargar_matriz( ALFABETO )
	
	imprimir_matriz( )

	imprimir( "\n\nAhora probemos buscar la P más cercana a una ubicacíon ingresada\n(Tenga en cuenta la dimensión de la matriz que generó)")

	imprimir("\n\nIngrese la fila: ")

	leer( Prueba.x )
	
	imprimir("\nIngrese la columna: ")

	leer( Prueba.y )
	
	Resultado=buscar_P_cercana( Prueba )

	imprimir( "\n\nLa P más cercana esta en: fila = ", Resultado.x, " columna = ", Resultado.y)


fin

subrutina cargar_matriz( ref ALFABETO : matriz [ *, * ] cadena )
	
	var
		
		i, j : numerico
		
		Contador_Vocales, Contador_Consonantes : numerico
		
	inicio
		
		/* ACÁ SE CARGAN LOS ELEMENTOS EN EL ORDEN EN QUE SE RECORRE LA MATRIZ
			
			PRIMERA PARTE : 50 % VOCALES ALEATORIAS
			
			SEGUNDA PARTE : 25 % CONSONANTES ALEATORIAS
			
			TERCERA PARTE : 25 % LETRAS "P"
			
		*/
		
		desde i = 1 hasta M {
			
			desde j = 1 hasta N {
				
				// PRIMERA PARTE 
				
				si( Contador_Vocales < Porcentaje_Vocales ){
					
					ALFABETO[ i ][ j ] = Vocales[ random( 5 ) + 1 ]
					
					Contador_Vocales = Contador_Vocales + 1
					
					// SEGUNDA PARTE 
					
				sino si ( Contador_Consonantes < Porcentaje_Consonantes )
					
					ALFABETO[ i ][ j ] = Consonantes[ random( 21 ) + 1 ]
					
					Contador_Consonantes = Contador_Consonantes + 1
					
					// TERCERA PARTE
					
				sino
					
					ALFABETO[ i ][ j ] = "P"
					
				}
				
			}
			
		}
		
		/* ACÁ SE BARAJAN TODOS LOS ELEMENTOS DE LA MATRIZ PARA TENER LA ALEATORIEDAD */
		
		desde i = 1 hasta M {
			
			desde j = 1 hasta N {
				
				intercambiar( ALFABETO[ i ][ j ], ALFABETO[ random( M ) + 1 ][ random( N ) + 1 ])
				
			}
			
		}
		
		
	fin

subrutina imprimir_matriz(  )
	
	var
		
		i, j : numerico

	inicio
		
		cls( )
		
		imprimir( "La matriz es:\n" )
		
		desde i = 1 hasta M {
			
			imprimir( "\n" )
			
			desde j = 1 hasta N {
				
				imprimir( "  ", ALFABETO[ i ][ j ] )
				
			}
			
		}
		
	fin

subrutina buscar_P_cercana( ubi:punto)  retorna punto
var
i:numerico
celda,aux:punto
	inicio
		ALFABETO_Visitado[ ubi.x,ubi.y ] = SI
		insertar(ubi)
		mientras (!vacio()) {
			celda=fila.array[fila.frente]
			si (ALFABETO[celda.x,celda.y]=="P"){
				salir
			}
			pop()
			desde i=1 hasta 4 {
				si (es_Seguro (celda.x+posicionesx[i],celda.y+posicionesy[i])) {
					
					aux.x=celda.x+posicionesx[i]
					aux.y=celda.y+posicionesy[i]
					insertar (aux)
					ALFABETO_Visitado[ aux.x,aux.y ] = SI
				}
			}
		}
		retorna celda
	fin

subrutina es_Seguro (fil,col:numerico) retorna logico
var
res: logico
inicio
		si ((fil >= 1) && (fil <= M) && (col >= 1) && (col <= N) && (!ALFABETO_Visitado[fil,col])) {
			res=SI
		sino 
			res=NO
		}
		retorna res
fin

subrutina insertar (valor:punto)
inicio
		si (fila.frente==0) {
			fila.frente=1
		}
		inc (fila.trasero)
		fila.array[fila.trasero]=valor
fin
subrutina pop ()
inicio
		inc (fila.frente)
		si (fila.frente>fila.trasero) {
			fila.frente=0
			fila.trasero=0
		}
fin	
subrutina vacio() retorna logico
var
res:logico
inicio
		si (fila.frente==0 && fila.trasero==0) {
			res=SI
		sino
			res=NO
		}
		retorna res
fin

