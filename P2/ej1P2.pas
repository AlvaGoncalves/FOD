{
 1- Una empresa posee un archivo con información de los ingresos percibidos por diferentes
	empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado,
	nombre y monto de la comisión. La información del archivo se encuentra ordenada por
	código de empleado y cada empleado puede aparecer más de una vez en el archivo de
	comisiones.
	Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En
	consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una
	única vez con el valor total de sus comisiones.

	NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser
	recorrido una única vez.
   
}


program ej1P2;
const 
	valoralto = 9999;
type
	empleado = record
		cod : integer;
		monto : real;
	end;
	
	detalle = file of empleado;
	maestro = file of empleado;

procedure LeerD(var d:detalle; var e:empleado);
begin
	if(not eof(d))then
		read(d,e)
	else
		e.cod := valoralto;
end;

procedure cargarMaestro(var m:maestro; var d:detalle);
var
	ed, regM : empleado;
	aux : integer;
	tot : real;
begin
	reset(d);
	LeerD(d,ed);
	while(ed.cod <> valoralto)do begin
		aux := ed.cod;
		tot := 0;
		while(aux = ed.cod)do begin
			tot := tot + ed.monto;
			LeerD(d,ed);
		end;	
	end;
	regM.cod := aux;
	regM.monto := tot;	
	write(m, regM);
end;

	
VAR
	d : detalle;
	m : maestro;
BEGIN
	assign(d,'detalle');
	assign(m,'maestro');
	rewrite(m);
	cargarMaestro(m, d);
END.

