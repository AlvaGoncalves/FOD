{
   7. Realizar un programa que permita:
	a. Crear un archivo binario a partir de la información almacenada en un archivo de texto.
	El nombre del archivo de texto es: “novelas.txt”
	b. Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar
	una novela y modificar una existente. Las búsquedas se realizan por código de novela.


	NOTA: La información en el archivo de texto consiste en: código de novela,
	nombre,género y precio de diferentes novelas argentinas. De cada novela se almacena la
	información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente
	información: código novela, precio, y género, y la segunda línea almacenará el nombre
	de la novela.
}
program ej7P1;
type
	novela = record
		cod : integer;
		nom : String[10];
		gen : String[10];
		precio : real;
	end;

	archivo = file of novela;

procedure Leer(var n:novela);
begin
	writeln('::::::::::::Comienza la carga:::::::::::::::');
	writeln('ingrese el codigo de la novela');
	readln(n.cod);
	if(n.cod <> -1)then
	begin
		writeln('ingrese el nombre de la novela');
		readln(n.nom);
		writeln('ingrese el genero de la novela');
		readln(n.gen);
		writeln('ingrese el precio de la novela');
		readln(n.precio);
		writeln(':::::::::::::::Termina la carga de este :::::::::::::::');
	end;	
end;

procedure cargarTxt(var t:text);
var
	n:novela;
begin
	leer(n);
	while(n.cod <> -1)do begin
		writeln(t, n.cod,'',n.precio,'',n.gen);
		writeln(t,n.nom);
		leer(n);
	end;
	close(t);
end;


procedure cargarBin(var a:archivo; var t:text);
var
	n:novela;
begin
	rewrite(a);
	reset(t);
	while(not eof(t))do begin
		readln(t,n.cod,n.precio,n.gen);
		readln(t,n.nom);
		write(a,n);
	end;	
	close(a);
	close(t);
end;

procedure menu(var x:integer);
begin
	writeln('Ingresar: ');
	writeln('Numero 1 para agregar una novela al archivo.');
	writeln('Numero 2 para modificar una novela existente.');
	readln(x);
end;

procedure agregar(var a:archivo);
var
	n:novela;
begin
	reset(a);
	
	Leer(n);
	seek(a,filesize(a));
	write(a,n);
	
	close(a);
end;

procedure modificar(var a:archivo);
var
	aux, n: novela;
begin
	reset(a);
	Leer(aux);
	while(not eof(a))do begin
		read(a,n);
		if(aux.nom = n.nom)then
				write(a, aux);
	end;
	close(a);	
end;

VAR
	a:archivo;
	n : String;
	t:text;
	x: integer;
BEGIN
	writeln('Ingrese el nom del archivo a crear:');
	readln(n);
	assign(a,n);
	assign(t,'C:\Users\alva_\OneDrive\Escritorio\facu\FOD\P1\novelas.txt');
	cargarTxt(t);
	cargarBin(a,t);
	
	menu(x);
	if(x = 1)then
		agregar(a)
	else
		modificar(a);	
END.

