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

