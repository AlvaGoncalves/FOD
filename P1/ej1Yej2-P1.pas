{
1. Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del
archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando
se ingrese el número 30000, que no debe incorporarse al archivo.
2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados
creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y
el promedio de los números ingresados. El nombre del archivo a procesar debe ser
proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el
contenido del archivo en pantalla.
}



program ej1Yej2P1;
type
	archivo_int = file of integer;
var
	arch : archivo_int;
	nom : string;
	n, tot : integer;
	pro : real;
BEGIN
	tot := 0;
	writeln('Ingrese el nombre del archivo que desea usar: '); //'que desea crear: '
	readln(nom);
	assign(arch, 'nom'); //nombre de la variable de tipo archivo
	reset(arch);//rewrite(arch); (ej 1)
	//writeln('Ingrese el numero que desea agregar al archivo: ');
	read(arch,n);	//readln(n);
	while(not Eof(arch))do//while(n <> 30000)do
	begin
		tot := tot + n;
		writeln('El numero: ',n,' se encuentra cargado en el archivo');	//write(arch,n);
		//writeln('Ingrese el numero que desea agregar al archivo: ');
		//readln(n);
		if(n < 1500)then
			writeln('El numero: ',n,' es menor a 1500');
		read(arch,n);
	end;
	pro := tot / filesize(arch);
	writeln('El promedio de los numeros cargados es de: ',pro);
	close(arch);	
END.

