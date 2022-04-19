{
   3. Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados.
	De cada producto se almacena: código del producto, nombre, descripción, stock disponible,
	stock mínimo y precio del producto.
	Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se
	debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo
	maestro. La información que se recibe en los detalles es: código de producto y cantidad
	vendida. Además, se deberá informar en un archivo de texto: nombre de producto,
	descripción, stock disponible y precio de aquellos productos que tengan stock disponible por
	debajo del stock mínimo.

	Nota: todos los archivos se encuentran ordenados por código de productos. En cada detalle
	puede venir 0 o N registros de un determinado producto.
}

program ej3P2;
const
	tope = 9999;
type
	cadena = string[15];
	
	producto = record
		cod : integer;
		nom : cadena;
		desc : cadena;
		stDisp : integer;
		stMin : integer;
		precio : real;
	end;
	
	rDetalle = record
		cod : integer;
		cantV : integer;
	end;

	maestro = file of producto; 
	detalle = file of rDetalle;
	
	vdetalles = Array[1..30]of detalle; //detalles
	vregdetalles = Array[1..30] of rDetalle; //registos	

procedure LeerD(var d:detalle; var r:rDetalle);
begin
		if(not eof(d))then
			read(d, r)
		else
			r.cod := tope;				
end;

procedure abrirDetalles(var vd:vdetalles);
var
	i : integer;
	r : rDetalle;
begin
	for i := 1 to 30 do begin
		assign(vd[i], 'ej3P2_detalle'+Chr(i+48));
		reset(vd[i]);
		LeerD(vd[i], r);
	end;	
end;

{
procedure actualizarM(var m:maestro; var vd:vdetalles); es correcta esta forma? (si utilizara un min)
var
	codActual, i : integer;
	aux : producto;
	r : rDetalle;
begin
	reset(m);
	abrirDetalles(vd);
	for i := 1 to 30 do begin
		while(not eof(vd[i]))do begin
			read(vd[i], r);
			codActual := r.cod;
			while(codActual = r.cod)do begin
				read(m, aux);
				aux.stDisp := aux.stDisp - r.cantV;
			end;
		end;
		close(vd[i]);
	end;
	close(m);
end;
}
procedure minimo(var vd:vdetalles; var min:rDetalle; var vr:vregdetalles);
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

procedure cargarM(var m:maestro; var vd:vdetalles);
var
	min: rDetalle;
	aux : producto;
	i : integer;
	vr: vregdetalles;
begin
	minimo(vd, min, vr);
	//for i := 1 to 5 do begin	no utilizo el for pq el min ya lo calculo dentro de minino
		while(min.cod <> tope)do begin	
			aux.cod := min.cod;
			aux.stDisp := 0;
			while(aux.cod = min.cod)do begin
				aux.stDisp := aux.stDisp + min.cantV;
				minimo(vd, min, vr);
			end;
			write(m,aux);		
		end;
		for i := 1 to 5 do
			close(vd[i]);
		close(m);			
end;

procedure Exportar(var m:maestro; var t:text);
var
	p:producto;
begin
	reset(m);
	reset(t);
	while(not eof(m))do begin
		read(m,p);
		if(p.stMin > p.stDisp)then
			write(t, p.nom,'',p.desc,'',p.stDisp,'',p.precio);
	end;
	close(m);
	close(t);		
end;

VAR
	m : maestro;
	t : text;
	vd : vdetalles;
BEGIN
	rewrite(m);
	rewrite(t);
	assign(t, 'textoP2E3');
	abrirDetalles(vd);
	cargarM(m, vd);
	Exportar(m, t);
END.

