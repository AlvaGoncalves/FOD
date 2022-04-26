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
		espacio libre. Es decir, si en el campo coro -5,
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
	cadena = string[20];
	
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
	n.cod := 0; //no me importan los demas campos	
	write(a, n);
	//Carga normal 
	leer(n);
	while(n.cod <> tope)do begin
		//if(n.cod <> 0)then begin
		write(a, n);
		leer(n)
		{else
			P :=  filepos(a)*-1; //guardo la posición como negativo
			seek(a, 0);	//siempre salto a 0
		}
	end;	
	close(a);
end;

procedure agregar(var a:arch; n:novela);
var
	aux:novela;
	P:integer;
begin
	reset(a);
	read(a, n);
	if(n.cod <> 0)then begin
		P := n.cod*(-1);//tomo la pos sin el negativo
		seek(a, P);//me paro en la pos del archivo que no va
		read(a, aux);//copio la cabecera de esa pos
		write(a,n);//escribo el dato a agregar
		seek(a, 0);//me posiciono al inicio del archivo
		write(a,aux);//Reescribo la cabecera(actualizo)
	end
	else
		writeln('!!!!!!!El archivo no cuenta con lugar para agregar registros!!!!!!!!');
	close(a);	
end;

procedure modificar(var a:arch);
var
	aux, n:novela;
begin
	reset(a);
	leer(n);
	while(n.cod <> tope)do begin 
		read(a,aux);
		if(n.cod = aux.cod)then
			write(a,n);	
	end;
	close(a);
end;

procedure eliminar(var a:arch; deleted:integer);
var
	aux, n:novela;
	P: integer;
begin
	reset(a);
	while(not eof(a))do begin
		read(a,n);
		if(n.cod = deleted)then begin
			P := filepos(a)*-1;//guardo la pos del que tengo que eliminar
			aux.cod := 0;
			aux.nom := '*******';//le pongo la marca de eliminado (no me acuerdo que otro comando era)
			write(a, aux);
			seek(a,0);//voy a la cabecera para modificar el campo
			aux.cod := P;
			write(a, aux);
		end;
	end;
	close(a);	
end;

procedure Calcular(var a:arch);
var
	x:integer;
	n:novela;
	d:integer;
begin
	writeln('Ingrese 1 si desea agregar una nueva novela: ');
	writeln('Ingrese 2 si desea modificar una novela: ');
	writeln('Ingrese 3 si desea eliminar una novela: ');
	readln(x);
	if(x = 1)then begin
		leer(n);
		agregar(a, n);
	end
	else
		if(x = 2)then begin
			modificar(a);
		end
		else
			if(x = 3)then begin
				writeln('Ingrese el codigo de la novela a eliminar: ');
				readln(d);
				eliminar(a, d);
			end
			else
				writeln('Que ganas de joder wacho');
				
	close(a);
end;

procedure Exportar(var a:arch; var t:text);
var
	n:novela;
begin
	reset(a);
	reset(t);
	while(not eof(a))do begin
		read(a,n);
		write(t, n.cod,'',n.gen,'',n.nom,'',n.dur,'',n.dir,'',n.precio);
	end;
	close(a);
	close(t);		
end;

VAR
	a:arch;
	s:cadena;
	t:text;
	y:integer;
BEGIN

	repeat 
		writeln('-> Ingrese 1 si quiere crear y cargar un archivo: ');
		writeln('-> Ingrese 2 si quiere abir archivo para trabajar con el: ');
		writeln('-> Ingrese 3 si quiere exportar el archivo a uno .txt con todo y novelas borradas: ');
		writeln('Ingrese 0 si desea salir del programa: ');
		readln(y);
		
		case y of
			 1: begin
					writeln('Ingrese el nombre del archivo que desea crear: ');
					readln(s);
					assign(a, s);
					rewrite(a);
					crearA(a);
				end;	
				
			 2: begin
					Calcular(a);
				end;
			
			 3: begin
					assign(t, 'novelas.txt');
					Exportar(a,t);
				end	
		else 
			writeln('Ha ingresado el un valor equivocado');
		end;
			
	until (y = 0);	
END.
