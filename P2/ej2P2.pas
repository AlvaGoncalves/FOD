{
   2. Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por
	cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias
	(cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene
	un archivo detalle con el código de alumno e información correspondiente a una materia
	(esta información indica si aprobó la cursada o aprobó el final).
	
	Todos los archivos están ordenados por código de alumno y en el archivo detalle puede
	haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un
	programa con opciones para:

	a. Actualizar el archivo maestro de la siguiente manera:
		i.Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
		
		ii.Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin
		final.

	b. Listar en un archivo de texto los alumnos que tengan más de cuatro materias
	con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.

	NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.
   
}

program ej2P2;
const
	tope = 9999;
type
	cadena = string[10];
	
	alumno = record
		cod : integer;
		ape : cadena;
		nom : cadena;
		sinF : integer;
		conF : integer;
	end;
	
	materia = record
		cod : integer;
		conF : boolean;
		sinF : boolean;
	end;
	
	detalle = file of materia; //el detalle siempre es del registro que actualiza al maestro
	maestro = file of alumno; 	
 
 
procedure LeerD(var d:detalle; var mat:materia);
begin
	if(not eof(d))then
		read(d,mat)
	else	
		mat.cod := tope;
end; 
 
 procedure actualizarM(var m:maestro; var d:detalle);
 var
	regD : materia;
	regM : alumno;
 begin
		rewrite(m);
		reset(d);
		leerD(d, regD);
		while(regD.cod <> tope)do begin //mientras no llegue al valor alto (no utilizo eof pq puede haber varios detalles que modifiquen este maestro)
			read(m, regM); //leo del maestro
			while(regM.cod <> regD.cod)do //si el cod es dif, leo cambio de maestro
				read(m, regM);
			while(regM.cod = regD.cod)do begin//corte de control donde actualizo el maestro
					if(regD.conF = true)then
						regM.conF := regM.conF + 1;	//acutalizo el maestro
					if(regD.sinF = true)then
						regM.sinF := regM.sinF + 1;
								
					leerD(d, regD);	//vuelvo a leer del detalle
			end;
			seek(m, filepos(m)-1);//busco la ultima pos en el maestro
			write(m, regM);//escribo el registro en esa pos
		end;
		close(m);
		close(d);
end;

procedure Exportar(var m:maestro; var t:text);
var
	aux : alumno;
begin
	reset(m);
	rewrite(t);
	while(not eof(m))do begin 
		read(m, aux);
		write(t, aux.cod,'',aux.ape,'',aux.nom,'',aux.sinF,'',aux.conF);
	end;
	close(m);
	close(t);
end;					
 
VAR
	m:maestro;
	d:detalle;
	t: Text;
	mae, det : cadena;
BEGIN
	writeln('Ingrese el nombre para el arch maestro: ');
	readln(mae);
	writeln('Ingrese el nombre para el arch detalle: ');
	readln(det);
	
	assign(m, mae);
	assign(d, det);
	assign(t, 'A_TEXT');
	actualizarM(m, d);
	Exportar(m, t);
END.
