{
	2. 	Definir un programa que genere un archivo con registros de longitud fija conteniendo
		información de asistentes a un congreso a partir de la información obtenida por
		teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y
		nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del
		archivo de datos generado, elimine de forma lógica todos los asistentes con nro de
		asistente inferior a 1000.
		Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo
		String a su elección. Ejemplo: ‘@Saldaño’.
}

program ej2P3;
const 
	MARCA = '--------';
type
	cadena = string[20];
	
	asistente = record
		nro : integer;
		ape : cadena;
		nom : cadena;
		email : cadena;
		tel : integer;
		dni : integer;
	end;	
	
	arch = file of asistente;

procedure Leer(var a:asistente);
begin
	writeln('::::::::::::Comienza la carga:::::::::::::::');
	writeln('ingrese el apellido del asistente: ');
	readln(a.ape);
	if(a.ape <> 'zzz')then
	begin
		writeln('ingrese el numero del asistente: ');
		readln(a.nro);
		writeln('ingrese el email del asistente: ');
		readln(a.nom);
		writeln('ingrese la edad del asistente: ');
		readln(a.email);
		writeln('ingrese el dni del asistente: ');
		readln(a.dni);
		writeln('ingrese el telefono del asistente: ');
		readln(a.tel);
		writeln(':::::::::::::::Termina la carga de este asistente:::::::::::::::');
	end;	
end;
	
procedure cargarA(var a:arch);
var
	e : asistente;
begin
	rewrite(a);
	Leer(e);
	while(e.ape <> 'zzz')do
	begin
		write(a,e);
		leer(e);
	end;
	close(a);
end;

procedure bajaLogica(var a:arch);
var
	aux : asistente;
begin
	reset(a);
	while(not eof(a))do begin
		read(a,aux);
		if(aux.nro < 1000)then begin 
			aux.nom := MARCA;
			write(a, aux);
		end;	
	end;
	close(a);
end;

VAR
	a:arch;
BEGIN
	assign(a, 'SAOKO PAPI SAOKO');
	cargarA(a);
	bajaLogica(a);
END.

