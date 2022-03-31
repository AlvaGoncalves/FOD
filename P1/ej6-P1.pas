{
	6. Agregar al menú del programa del ejercicio 5, opciones para:
	a. Añadir uno o más celulares al final del archivo con sus datos ingresados por
	teclado.
	b. Modificar el stock de un celular dado.
	c. Exportar el contenido del archivo binario a un archivo de texto denominado:
	”SinStock.txt”, con aquellos celulares que tengan stock 0.

	NOTA: Las búsquedas deben realizarse por nombre de celular.   
}
program ej6P1;
type
	Celular = record
		cod : integer;
		nom : String[10];
		desc : String[40];
		marca : String[10];
		precio : real;
		stMin : integer;
		stDisp : integer;
	end;
	
	archivos = file of Celular;
	
procedure Leer(var c:Celular);
begin
	writeln('::::::::::::Comienza la carga:::::::::::::::');
	writeln('ingrese el codigo de celular: ');
	readln(c.cod);
	if(c.cod <> -1)then
	begin
		writeln('ingrese el nombre del celular: ');
		readln(c.nom);
		writeln('ingrese la descripcion del celular: ');
		readln(c.desc);
		writeln('ingrese la marca del celular: ');
		readln(c.marca);
		writeln('ingrese el precio del celular: ');
		readln(c.precio);
		writeln('ingrese el stock minimo del celular: ');
		readln(c.stMin);
		writeln('ingrese el stock disponible del celular: ');
		readln(c.stDisp);
		writeln(':::::::::::::::Termina la carga de este :::::::::::::::');
	end;	
end;	

procedure Imprimir(var c:Celular);
begin
	writeln(' Codigo del celular: ');
	writeln(c.cod);
	writeln(' Nombre del celular: ');
	writeln(c.nom);
	writeln(' Descripcion del celular: ');
	writeln(c.desc);
	writeln(' Marca del celular: ');
	writeln(c.marca);
	writeln(' Precio del celular: ');
	writeln(c.precio);
	writeln(' Stock minimo del celular: ');
	writeln(c.stMin);
	writeln(' Stock disponible del celular: ');
	writeln(c.stDisp);
end;

procedure cargar(var arch:archivos; var t:text);
var
	c:Celular;
begin
	reset(t);
	//leer(c);
	while(not eof(t))do begin
		readln(t, c.cod, c.nom, c.desc, c.marca, c.precio, c.stMin, c.stDisp); //asi se pasa de txt a binario
		write(arch, c);
		//leer(c);
	end;
	close(t);
	close(arch);	
end;

procedure ListarXstock(var arch:archivos);
var
	c:Celular;
begin
	reset(arch);
	while(not eof(arch))do begin
		read(arch, c);
		if(c.stDisp < c.stMin)then	
			Imprimir(c);
	end;		
	close(arch);
end;

procedure ListarXdesc(var arch:archivos; n:String);
var
	r:Celular;
begin
	reset(arch);
	while(not eof(arch))do begin
		read(arch,r);
		if(r.desc = n)then
			Imprimir(r);
	end;
	close(arch);
end;

procedure exportar(var arch:archivos);
var
	r:Celular;
	s:string;
	t : text;
begin
	reset(arch);
	writeln('Ingrese el nombre del archivo .txt que desea crear');
	readln(s);
	assign(t,s);
	rewrite(t);
	
	while(not eof(arch))do begin
		read(arch,r);
		writeln(t,r.cod,' ',r.precio,' ',r.marca);
		writeln(t,r.stDisp,' ',r.stMin,'',r.desc);
		writeln(t,r.nom);
	end;
	close(arch);
	close(t);
end;

procedure aniadir(var arch:archivos);
var
	c:Celular;
begin
	reset(arch);
	seek(arch, filesize(arch));
	Leer(c);
	while(c.cod<>0)do begin
		write(arch,c);
		Leer(c);
	end;
	close(arch);	
end;

procedure modificar(var arch:archivos);
var
	c:Celular;
	n : string;
	st:integer;
begin
	reset(arch);
	writeln('Ingrese el nombre del celular que desea modificar: ');
	readln(n);
	writeln('Ingrese el nuevo stock del celular: ');
	readln(st);
	while(not eof(arch))do begin	
		read(arch,c);
		if(c.nom = n)then
			c.stDisp := st;
			write(arch, c);	
	end;
	close(arch);
end;

procedure expoCero(var arch:archivos);
var
	tx:text;
	aux:Celular;
begin
	reset(arch);
	assign(tx,'SinStock.txt');
	rewrite(tx);
	
	while(not eof(arch))do begin
		read(arch,aux);
		if(aux.stDisp = 0)then
			writeln(tx,aux.cod,' ',aux.precio,' ',aux.marca);
			writeln(tx,aux.stDisp,' ',aux.stMin,'',aux.desc);
			writeln(tx,aux.nom);
	end;		
	close(arch);
	close(tx);
end;

VAR
	arch : archivos;
	n : String[10];
	x : integer;
	texto : text;
BEGIN
	
	writeln('Ingrese el nombre del archivo con el que desea trabajar: ');
	readln(n);

	assign(arch, n);
	
	assign(texto,'C:\Users\alva_\OneDrive\Escritorio\facu\FOD\P1\Celulares.txt');
	{
	writeln('-> Ingrese s si quiere crear un archivo o n si quiere abrir uno')
	readln(n);
	
	if(n = 's')then	
		cargar(arch);
	else (n = 'n')
	*} 
		repeat
			writeln('-> Ingrese 1 para crear archivo a partir de un .text');
			writeln('-> Ingrese 2 para listar en pantalla los celulares que tengan un stock menor al minimo');
			writeln('-> Ingrese 3 para listar en pantalla los celulares que tengan una descripcion ingresada');
			writeln('-> Ingrese 4 para exportar los datos del archivo a  "celulares.txt" ');
			writeln('-> Ingrese 5 para añadir uno o mas celulares al final del archivo ingresando sus datos');
			writeln('-> Ingrese 6 para modificar el stock de un celular dado');
			writeln('-> Ingrese 7 para exportar los celulares con stock 0');
			writeln('-> Ingrese 0 si quiere salir del programa');
		
			readln(x);
		
			case x of
				1: begin
					rewrite(arch);
					cargar(arch,texto);
				   end;	
				2: ListarXstock(arch);
				3: begin
					writeln('Ingrese la cadena de caracteres que desea comparar: ');
					readln(n);
					ListarXdesc(arch, n);
				   end;
				4: exportar(arch);
				5: aniadir(arch);
				6: modificar(arch);
				7: expoCero(arch);	
			else
				writeln('Esta saliendo del programa...');
			end;
		
		until (x = 0)	
	
END.


