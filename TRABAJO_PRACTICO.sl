/*

Integrantes:

	1)	Cáseres Gonzáles, Iván Demetrio
	
	2)	Franco Vera, Enrique Martin
	
	3)	Peralta González, Juan Fernando
	
	4) Samaniego Muñoz, Mijhael Andrés

*/
var

	ALFABETO : matriz [ *, * ] cadena
	
	M, N : numerico
	
	Eme, Ene, Pasos, Res_M, Res_N: numerico
	
	Porcentaje_P, Porcentaje_Vocales, Porcentaje_Consonantes : numerico
	
	Vocales : vector [ 5 ] cadena

	Consonantes : vector [ 21 ] cadena
	
	Abecedario : vector [ 27 ] cadena

inicio

	cls()
	
	Vocales = { "A", "E", "I", "O", "U" }
	
	Consonantes = { "B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "Ñ", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z" }

	Abecedario = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "Ñ", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }

	imprimir( "\nESTE PROGRAMA SE COME PARALABRAS DE UNA MATRIZ\n" )

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

	cargar_matriz( ALFABETO )
	
	imprimir_matriz( )

	imprimir( "\n\nAhora probemos buscar la P más cercana a una ubicacíon ingresada\n(Tenga en cuenta la dimensión de la matriz que generó)")

	imprimir("\n\nIngrese la fila: ")

	leer( Eme )
	
	imprimir("\nIngrese la columna: ")

	leer( Ene )

	buscar_P_cercana( Eme, Ene )

	imprimir( "\n\nLa P más cercana esta en: fila = ", Res_M, " columna = ", Res_N )

	imprimir("\nA ", Pasos, " pasos de distancia de la letra ", ALFABETO[ Eme ][ Ene ] )

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

subrutina buscar_P_cercana( Ubi_M : numerico; Ubi_N : numerico)
	var
		
		i, j : numerico
		
	inicio
		
		Pasos = 999
		
		desde i = 1 hasta M {
			
			desde j = 1 hasta N {
				
				//La línea de abajo es super interesante, acá averiguo a cuantos pasos está una letra respecto a una ubicación... la suma "abs( Eme - i ) + abs( Ene - j )" indica la distacia en pasos desde la ubicación dada
				
				si( ALFABETO[ i ][ j ] == "P" and ( abs( Eme - i ) + abs( Ene - j ) ) < Pasos ){ 
					
					Pasos = abs( Eme - i ) + abs( Ene - j )
					
					Res_M = i
					
					Res_N = j
					
				}
				
			}
			
		}
		
	fin



