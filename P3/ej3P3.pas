{
   3. Realizar un programa que genere un archivo de novelas filmadas durante el presente
	año. De cada novela se registra: código, género, nombre, duración, director y precio.
	El programa debe presentar un menú con las siguientes opciones:
	
	a. Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se
	utiliza la técnica de lista invertida para recuperar espacio libre en el
	archivo. Para ello, durante la creación del archivo, en el primer registro del
	mismo se debe almacenar la cabecera de la lista. Es decir un registro
	ficticio, inicializando con el valor cero (0) el campo correspondiente al
	código de novela, el cual indica que no hay espacio libre dentro del
	archivo.
	
	b. Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el
	inciso a., se utiliza lista invertida para recuperación de espacio. En
	particular, para el campo de ´enlace´ de la lista, se debe especificar los
	números de registro referenciados con signo negativo, (utilice el código de
	novela como enlace).Una vez abierto el archivo, brindar operaciones para:
		
		i. Dar de alta una novela leyendo la información desde teclado. Para
		esta operación, en caso de ser posible, deberá recuperarse el
		espacio libre. Es decir, si en el campo correspondiente al código de
		novela del registro cabecera hay un valor negativo, por ejemplo -5,
		se debe leer el registro en la posición 5, copiarlo en la posición 0
		(actualizar la lista de espacio libre) y grabar el nuevo registro en la
		posición 5. Con el valor 0 (cero) en el registro cabecera se indica
		que no hay espacio libre.
		
		ii. Modificar los datos de una novela leyendo la información desde
		teclado. El código de novela no puede ser modificado.
		
		iii. Eliminar una novela cuyo código es ingresado por teclado. Por
		ejemplo, si se da de baja un registro en la posición 8, en el campo
		código de novela del registro cabecera deberá figurar -8, y en el
		registro en la posición 8 debe copiarse el antiguo registro cabecera.
	
	c. Listar en un archivo de texto todas las novelas, incluyendo las borradas, que
	representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
	
	NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
	proporcionado por el usuario.

}


program ej3P3;
const
	tope = 9999;
type
	
	novela = record
		cod : integer;
		gen : cadena;
		nom : cadena;
		dur : real;
		dir : cadena;
		precio : real;
	end;	
		
	arch = file of novela;	
		
procedure leer(var n:novela);
begin
	writeln('::::::::::::Comienza la carga:::::::::::::::');
	writeln('ingrese el codigo de la novela: ');
	readln(n.cod);
	if( n.cod <> tope)then
	begin
		writeln('ingrese el genero de la novela: ');
		readln(n.gen);
		writeln('ingrese el nombre de la novela: ');
		readln(n.nom);
		writeln('ingrese la duración de la novela: ');
		readln(n.nom);
		writeln('ingrese el precio de la novela: ');
		readln(n.precio);
		writeln('ingrese el director de la novela: ');
		readln(n.dir);
		writeln(':::::::::::::::Termina la carga de este :::::::::::::::');
	end;	
end;

procedure crearA(var a:arch);
var
	n : novela;
begin
	//Cabecera
	n.cod := 0; //me importan los demas campos? Supongo que no!	
	write(a, n);
	//Carga normal 
	leer(n);
	while(n.cod <> tope )do begin
		if(n.cod <> 0)then begin
			write(a, n);
			leer(n)
		else
			P :=  filepos(a); //guardo la posición como negativo (como se hacia lo de negativo?)
			seek(a, 0);	//siempre salto a 0
	end;	
	close(a);
end;

VAR
	a:arch;

BEGIN
	repeat 
		writeln('-> Ingrese 1 si quiere crear y cargar un archivo: ');
		writeln('-> Ingrese 2 si quiere : ');
		writeln('-> Ingrese 3 si quiere : ');
		writeln('-> Ingrese 4 si quiere : ');
		writeln('-> Ingrese 5 si quiere : ');
		writeln('-> Ingrese 6 si quiere : ');
		writeln('-> Ingrese 7 si quiere : ');
		writeln('Ingrese 0 si desea salir del programa: ');
		readln(y);
		
		case y of
			 1: begin
					writeln('Ingrese : ');
					readln();
					writeln('Ingrese : ');
					readln();
				end;	
				
			 2: ;
			 
			 3: ;
			 
			 4: ;
			 
			 5: ;
			 
			 6: ;
			 
			 7: ;			  	
		else 
			writeln('Ha ingresado el un valor equivocado');
		end;
			
	until (y = 0);	
END.

