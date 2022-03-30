program ej3Yej4P1;
type
	empleado = record
		numero : integer;
		apellido : string[10];
		nombre : string[10];
		edad : integer;
		dni : string[10];
	end;
	arch = file of empleado;
	
procedure Leer(var e:empleado);
begin
	writeln('::::::::::::Comienza la carga:::::::::::::::');
	writeln('ingrese el apellido del empleado: ');
	readln(e.apellido);
	if(e.apellido <> 'fin')then
	begin
		writeln('ingrese el numero del empleado: ');
		readln(e.numero);
		writeln('ingrese el nombre del empleado: ');
		readln(e.nombre);
		writeln('ingrese la edad del empleado: ');
		readln(e.edad);
		writeln('ingrese el dni del empleado: ');
		readln(e.dni);
		writeln(':::::::::::::::Termina la carga de este empleado:::::::::::::::');
	end;	
end;

procedure ImpEmple(var e:empleado);
begin
	writeln('Nombre del empleado: ');
	writeln(e.nombre);
	writeln('Apellido del empleado: ');
	writeln(e.apellido);
	writeln('Numero del empleado: ');
	writeln(e.numero);
	writeln('dni del empleado: ');
	writeln(e.dni);
	writeln('Edad del empleado: ');
	writeln(e.edad);
end;
	
procedure cargarA(var a:arch);
var
	e : empleado;
begin
	rewrite(a);
	Leer(e);
	while(e.apellido <> 'fin')do
	begin
		write(a,e);
		leer(e);
	end;
	close(a);
end;

procedure ListarApellidos(var a:arch; ape: string; nom: string);
var
	aux : empleado;
begin
	reset(a);
	while(not EOF(a))do
	 begin
		read(a,aux);
		if(aux.nombre = nom) or (aux.apellido = ape)then
			ImpEmple(aux);
	end;
	close(a);
end;

procedure ListarEmpleados(var a: arch); //TIPOS ARCHIVO SIEMPRE TIENEN QUE SER VAR
var
	aux : empleado;
begin
	reset(a);
	while(not Eof(a))do
	begin
		read(a,aux);
		ImpEmple(aux);
	end;
	close(a);
end;

procedure ListarXJubilarse(var a: arch);
var 
	aux : empleado;
begin
	reset(a);
	while(not EOF(a))do
	 begin
		read(a,aux);
		if(aux.edad > 70)then
			ImpEmple(aux);
	end;
	close(a);
end;		

procedure empleado(var a:arch); //4
var
	e:empleado;
begin
	reset(a);
	seek(a, FileSize(a)); //me posiciono en el largo del archivo (final)
	Leer(e); //leo el dato a ingresar
	while(e.nombre <> ' ')do //entro al loop donde escribo los datos en el final
	begin
		write(a,e);
		leer(e);
	end;	
	close(a);
end;
	
var
	a : arch;
	n, nom, ape : string;
	x, y : integer;
BEGIN
	writeln('Ingrese el nombre del archivo con el que desea trabajar: ');
	readln(n);
	assign(a, 'n');
	
	Writeln('Ingrese 1 si quiere crear un archivo o 2 si desea abrir uno: ' );
	readln(x);
	if(x = 1)then
	begin	
		cargarA(a);	
	end	
	else if(x = 2)then 
		begin
			writeln('Ingrese el nombre del archivo que desea abrir: ');
			readln(n);
		end;
	repeat 
		writeln('Ingrese 1 si quiere ver los datos de los empleados segun un n y a: ');
		writeln('Ingrese 2 si quiere ver los datos de todos los empleados en el archivo: ');
		writeln('Ingrese 3 si quiere ver los empleados proximos a jubilarse: ');
		//--------------- ej4----------------------
		writeln('Ingrese 4 si quiere añadir 1 o mas empleados: ');
		writeln('Ingrese 5 si quiere modificar la edad de uno o mas empleados: ');
		writeln('Ingrese 6 si quiere exportar el contenido de archivo a "todos_empleados.txt": ');
		writeln('Ingrese 7 si quiere exportar a "faltaDNIEmpleado.txt" a los empleados que no tengan el dni cargado (DNI en 00): ');
		writeln('Ingrese 0 si desea salir del programa: ');
		readln(y);
		
		case y of
			 (y = 1): writeln('Ingrese nombre del empleado: ');
					   readln(nom);
					   writeln('Ingrese apellido del empleado: ');
					   readln(ape);
					   ListarApellidos(a, ape, nom);
			 (y = 2): ListarEmpleados(a);
			 (y = 3): ListarXJubilarse(a);
			 (y = 4): agregar(e);
			 (y = 5): modificar();
			 (y = 6): recorrer();
					  	
		else 
			(y = 0) : writeln('A ingresado el 0, el programa se cerrará');
		end;
			
	until (y = 0);	
END.

