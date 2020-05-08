{Se cuenta con un archivo que almacena información sobre especies de 
* plantas originarias de Europa, de cada especie se almacena: 
* código especie, 
* nombre vulgar, 
* nombre cientifico, 
* altura promedio, 
* descripción y 
* zona geográfica. 
* El archivo no está ordenado por ningún criterio. Realice un 
* programa que elimine especies de plantas trepadoras. Para ello 
* se recibe por teclado los códigos de especies a eliminar.
Implemente una alternativa para borrar especies, que inicialmente 
* marque los registros a borrar y posteriormente compacte el archivo, 
* quitando los registros marcados. Para quitar los registros se deberá 
* copiar el último registro del archivo en la posición del registro 
* a borrar y luego eliminar del archivo el último registro de forma 
* tal de evitar registros duplicados.
Nota: Las bajas deben finalizar al recibir el código 100000}

program plantas_originarias;
uses
	sysutils;
const
	arch = 'plantasEU.dat';
	valoralto = 9999;
type 
	st4 = string[4];
	st20 = string[20];
	st50 = string[50];
	
	plantas = record 
		cod: integer;
		nom_vulgar: st20;
		nom_latin: st50;
		altura: real;
		desc: st50;
		zona: st20;
	end;
	
fplantas = file of plantas;

procedure leerPlanta(var p: plantas);
begin
	writeln('Agregando una nueva planta');
	writeln('------------------------');
	writeln('Ingrese el codigo de especie: ');
	writeln('Para salir ingrese codigo 0');
	readln(p.cod);
	if (p.cod <> 0) then begin 
		with p do begin 
			writeln('Ingrese el Nombre Vulgar: ');
			readln(nom_vulgar); read();
			writeln('Ingrese el Nombre Cientifico: ');
			readln(nom_latin); read();
			writeln('Ingrese la altura aproximada: ');
			readln(altura); read();
			writeln('Ingrese la descripcion: ');
			readln(desc); read();
			writeln('Ingrese la zona de la planta: ');
			readln(zona); read();
		end;
	end;
end;

procedure leer(var fileP:fplantas; var p:plantas);

begin 
	if (not eof(fileP)) then 
		read(fileP, p)
	else 
		p.cod := valoralto;
end;

procedure Imprimir(var fileP: fplantas);
var 
	p: plantas;
begin
	reset (fileP);
	while (not eof(fileP)) do begin 
		read(fileP, p);
		with p do writeln('Codigo: ', IntToStr(cod), ' Nombre Vulgar: ', nom_vulgar,
						  ' Nombre Cientifico: ', nom_latin, ' Altura Aprox: ',
						   altura:3:2, ' Descripcion: ', desc, ' Zona: ', zona);
	end;
	close(fileP);
	writeln('Presione ENTER para volver al menu');
	readln();
end;

procedure Buscar(var fileP: fplantas);
var planta: plantas; codigo: integer; si: boolean; c: char;
begin
	reset (fileP);
	writeln('Desea buscar una planta? y/n'); read(c);
	if ((c = 'y') or (c='Y')) then  si:= true else si:= false; 
		if si then begin 
		repeat
			writeln('Ingrese el Codigo de planta a buscar: ');
			readln(codigo);
			reset(fileP);
			leer (fileP, planta);

			 
				// si el codigo se encuentra, se marca logicamente el registro
				while (planta.cod <>  codigo) do leer(fileP, planta); 
				if (planta.cod = codigo) then
				begin
					writeln();
					writeln('Se encontro la planta que buscaba en el archivo! ');
					writeln();
					writeln('Su planta buscada se imprimira a continuacion.');
					writeln('---------------------------------------------');
					writeln('Su planta buscada es: ');
					with planta do writeln('Codigo: ', IntToStr(cod), ', Nombre Vulgar: ', nom_vulgar,
											' Nombre Cientifico: ', nom_latin, ', Altura Aprox: ',
											altura:3:2, ', Descripcion: ', desc, ', Zona: ', zona);
				end;

				// sale del while sin encontrar, la planta no esta en el archivo
				if (planta.cod = valoralto) then begin
					writeln('La planta con el codigo ingresado no se encontro en el archivo.');
				end;
			
		writeln('Desea buscar otra planta? y/n'); read(c);
		if ((c = 'y') or (c='Y')) then  si:= true else si:= false; 
				   
	until (si = false) or (planta.cod = valoralto);
	end;	
    writeln('presione ENTER para volver al menu principal');
	readln(); readln();
	close (fileP);
end;

procedure Agregar(var fileP: fplantas);
var p: plantas; si: boolean; c: char;
begin
	reset(fileP);
	repeat 
		writeln('Desea agregar una nueva planta? y/n');
		readln(c);
		
		if (c = 'y') or (c = 'Y') then 
			begin
				seek(fileP, filesize(fileP)); 
				leerPlanta(p);
				write(fileP, p);
				si:= true;
			end
		else begin
			si:= false;
			writeln('saliendo del proceso "Agregar Planta"');
		end;
	until (not si);
	close(fileP);
end;

procedure Eliminar(var fileP: fplantas);
var 
	planta: plantas; c: char; si, es : boolean; codigo: integer;
begin
	reset (fileP);
	writeln('Desea eliminar una planta? y/n'); read(c);
	if ((c = 'y') or (c='Y')) then si:= true else si:= false; 
	
		if si then begin 
		repeat
			writeln('Ingrese el Codigo de planta a Eliminar distinto a 1000: ');
			readln(codigo);

			leer (fileP, planta);

			 
				// si el codigo se encuentra, se marca logicamente el registro
				while (planta.cod <>  codigo) do leer(fileP, planta); 
				
				if (planta.cod = codigo) then
				begin
					writeln();
					writeln('Se encontro la planta que desea ELIMINAR ');
					writeln();
					writeln('Su planta buscada se imprimira a continuacion.');
					writeln('---------------------------------------------');
					writeln('Su planta buscada es? ');
					with planta do writeln('Codigo: ', IntToStr(cod), ', Nombre Vulgar: ', nom_vulgar,
											' Nombre Cientifico: ', nom_latin, '? y/n');
					read(c);
					if ((c = 'y') or (c='Y')) then  es:= true else es:= false; 
						if es then 
						   begin
									planta.cod:= -1*planta.cod;
									seek(fileP, filepos(fileP) - 1);
									write(fileP, planta);
									writeln('se ha elimnado logicamente la planta con codigo: ', -1*planta.cod); 
						   end;
				end;

				// sale del while sin encontrar, la planta no esta en el archivo
				if (planta.cod = valoralto) then begin
					writeln('La planta con el codigo ingresado no se encontro en el archivo.');
				end;
			
			writeln('Desea eliminar otra planta? y/n'); read(c);
			if ((c = 'y') or (c='Y')) then  si:= true else si:= false; 
			   
	until (si = false) or (planta.cod = valoralto) or (codigo = 1000);
	end;	
    writeln('presione ENTER para volver al menu principal');
	readln();	readln();
	close (fileP);
end;

procedure Compactar(var fileP: fplantas);
var p: plantas; aux: plantas; pos: Int64; c: char; si: boolean; distancia: integer;
begin
	writeln('Desea compactar el archivo? y/n');
	read(c);
	if ((c = 'y') or (c='Y')) then  si:= true else si:= false; 
	if si then begin 
	 	reset (fileP);
		leer(fileP, p);
		distancia:=0;
			while (p.cod > 0) and (p.cod <> valoralto) do leer(fileP, p);
				if (p.cod < 0) and (fileSize(fileP)>distancia)then begin 
					writeln('empezando a truncar');
					distancia:=distancia+1;
					pos:= filePos(fileP)-1;
					seek(fileP, fileSize(fileP) - 1);
					read(fileP, p);
					aux:= p;
					seek(fileP, pos);
					write(fileP, aux);
				end;
	seek(fileP, fileSize(fileP)-distancia);
	truncate(fileP);
	writeln('se ha compactado el archivo usando Truncate Method');
	end;
	close (fileP);
end;

var 
	fileP: fplantas;
	op: char;
begin 
	assign (fileP, arch);
	op:= '0';
	repeat 
		writeln('Bienvenido/a a Plantas Originarias Europeas');
		writeln('-------------------------------------------');
		writeln('Ingrese una opcion para continuar');
		writeln('[A]: Imprimir el archivo en pantalla');
		writeln('[B]: Agregar una planta al archivo');
		writeln('[C]: Buscar una Planta en el archivo');
		writeln('[D]: Eliminar una planta del archivo');
		writeln('[E]: Compactar eliminadas');
		writeln('[F]: SALIR');
		readln(op);
		
		case (op) of
			'A': Imprimir(fileP);
			'B': Agregar(fileP);
			'C': Buscar(fileP);
			'D': Eliminar(fileP);
			'E': Compactar(fileP);
		end;
	until (op = 'F');

end.
