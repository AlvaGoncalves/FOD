{
	 4. Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma
		fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las
		máquinas se conectan con un servidor central. Semanalmente cada máquina genera un
		archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por
		cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos:
		cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos
		detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha,
		tiempo_total_de_sesiones_abiertas.
		
		Notas:
		- Cada archivo detalle está ordenado por cod_usuario y fecha.
		- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes
		máquinas.
		- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.
}

program ej4P2;
const
	tope = 9999;
type
	
{
	date = record
		dia : 1..31;
		mes : 1..12;
		anio : 1950..2040;
	end;	
}

	RegA = record  //registro general que utilizo para los 2 archivos
		cod : integer;
		fecha : string;
		tiempo : real;
	end;
	
	detalle = file of RegA;
	maestro = file of RegA;
	
	maquinas = Array[1..5] of detalle;
	archivos = Array[1..5] of RegA; //por que este es de 1 a 5 si yo no se cuantos registros tengo en cada archivo?


procedure LeerD(var d:detalle; var r:RegA);
begin
		if(not eof(d))then
			read(d, r)
		else
			r.cod := tope;				
end;

procedure abrirD(var vd:maquinas);
var
	i : integer;
	r : RegA;
begin
	for i := 1 to 5 do begin
		assign(vd[i], 'Ej4P2_detalle'+Chr(i+48));
		reset(vd[i]);
		LeerD(vd[i], r);
	end;	
end;

procedure minimo(var vd:maquinas; var min:RegA; var vr:archivos);
var
	i, minCod, indiceMin: integer;
begin
	minCod := 9999;
	for i := 1 to 5 do begin
		if(vr[i].cod < minCod)then begin
			minCod := vr[i].cod;
			indiceMin := i;
		end;
	end;
	min := vr[indiceMin];	
	leerD(vd[indiceMin], vr[indiceMin]);
end;


procedure cargarM(var m:maestro; var vd:maquinas);
var
	min, aux : RegA;
	i : integer;
	vr:archivos;
begin
	minimo(vd, min, vr);
	//for i := 1 to 5 do begin	no utilizo el for pq el min ya lo calculo dentro de minino
		while(min.cod <> tope)do begin	
			aux.cod := min.cod;
			aux.tiempo := 0;
			while(aux.cod = min.cod)do begin
				aux.fecha := min.fecha;
				while(aux.cod = min.cod) and (aux.fecha = min.fecha)do begin	
					aux.tiempo := aux.tiempo + min.tiempo;
					minimo(vd, min, vr);
				end;
			end;
			write(m,aux);		
		end;
		for i := 1 to 5 do
			close(vd[i]);
		close(m);			
end;

VAR
	m : maestro;
	vd:maquinas;
BEGIN
	assign(m,'/var/log');
	rewrite(m);
	cargarM(m, vd);
END.

