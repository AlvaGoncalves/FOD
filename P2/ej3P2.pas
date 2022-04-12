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

//donde va el merge --> pp o modulo, dentro del actualizarM?

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
	
	rDetalle : record
		cod : integer;
		cantV : integer;
	end;

	maestro : file of producto; 
	
	vdetalles = Array[1..30]of file of rDetalle; //detalles
	vregdetalles = Array[1..30] of rDetalle //registos	

procedure LeerD(var d:detalle; var r:rDetalle);
begin
	if(not eof(d))then
		read(d, r);
	else
			d.cod := tope;		
end;

procedure abrirDetalles(var vdetalles);
var
	i : integer;
begin
	for i := 1 to 30 do begin
		assign(d[i], 'det'+i);
		reset(d[i]);
		leerD(d[i], r);
	end;	
end;

procedure actualizarM();
var
begin

end;


VAR
	m : maestro;
	d : detalle;
	t : text;
	vd : vdetalles;
BEGIN
	rewrite(m);
	
	abrirDetalles(vd);
	actualizarM(m, d);
	Exportar(m, t);
	
	
	
END.

