program p2e02;
uses
	sysutils;
const
	alumnos_binario='alumnosMaestro';
	detalle_binario='alumnosDetalle';
	alumnos_txt='alumnos.txt';
	detalle_txt='detalle.txt';
	listado_txt= 'reporteAlumnos.txt';
	reporte_d_txt= 'reporteDetalle.txt';
	debefinales_txt='debefinales.txt';
	valor_alto=9999999;
type
	str30=string[30];
	alumno=record
		cod:integer;
		apellido:str30;
		nombre:str30;
		cant_prom:integer;
		cant_final:integer;
		end;
	det_alumno=record
		cod:integer;
		final:byte;
	end;

	arch_mae= file of alumno;
	arch_det=file of det_alumno;
//---------------------------------------------------------------------//
procedure crearMaestro(var arch_mae:arch_mae);
var
alum_txt: text;
reg_alumno:alumno;
begin
	assign(alum_txt, alumnos_txt);
	reset(alum_txt);
	rewrite(arch_mae);
	leerMaestro(alum_txt, reg_alumno);
	while(reg_alumno.cod < valor_alto) do begin
		write(arch_mae, reg_alumno);
		leerMaestro(alum_txt,reg_alumno);
		end;
	close(arch_mae);
	close(alum_txt);
	end;

procedure leerMaestrotxt (var alum_txt: text; var reg: alumno);
begin
	if (not eof(alum_txt)) then
		with reg do begin
			readln (alum_txt, cod, cant_prom, cant_final, nombre);
			readln (alum_txt, apellido);
			end
	else
		reg.cod=valor_alto;
	end;

procedure crearDetalle (var arch_det: arch_det);
var
det_txt: text;
reg: det_alumno;
begin
	assign(det_txt, detalle_txt);
	reset(det_txt);
	rewrite(arch_det);
	leerDetalletxt(det_txt,reg);
	while (reg.cod < valor_alto) do begin
		write(arch_det, reg);
		leerDetalletxt(det_txt,reg);
		end;
	close(arch_det);
	close(det_txt);
	end;

procedure leerDetalletxt(var det_txt: text, var reg: det_alumno);
begin
	if(not eof(det_txt)) then
		with reg do begin
			readln(det_txt, cod, final);
			end
		else
		 	reg.cod:= valor_alto;
		 	end;
procedure leerMaestro(var arch_mae, var a:alumno);
	begin
	if (not eof(arch_mae)) then begin
	read(arch_mae, a)
	else
	a.cod:=valor_alto;
end;

procedure exportarMaestro (var arch_mae: arch_mae);
var
alu:alumno;
lista_txt: text;
begin
	assign(lista_txt, listado_txt);
	rewrite(listado_txt);
	reset(arch_mae);
	leerMaestro(arch_mae,alu);
	while (alu.cod < valor_alto) do begin
		with alu do begin
			writeln(lista_txt, cod, ' ', cant_prom,' ', cant_final,' ',nombre);
			writeln(lista_txt, apellido);
			end;
			leerMaestro(arch_mae,alu);
			end;
	close(arch_mae);
	close(lista_txt);
end;

procedure leerDetalle(var arch_det: arch_det; var dato: det_alumno);
begin
	if (not eof(arch_det)) then
		read(arch_det, dato)
		else
		dato.cod:=valor_alto;
		end;

procedure exportarDetalle (var arch_det: arch_det);
var
reg_det: det_alumno;
detalle: text;
begin
	assign(detalle, reporte_d_txt);
	rewrite(detalle);
	reset(arch_det);
	leerDetalle(arch_det, reg_det);
	while (reg_det<valor_alto) do begin
		with reg_det do
			writeln(detalle, cod, ' ', final);
		leerDetalle(arch_det,reg_det);
		end;
	close(arch_det);
	close(detalle);
	end;

procedure actualizarMaestro(var arch_mae:arch_mae; var arch_det:arch_det);
	var
	reg_mae:alumno;
	reg_det:det_alumno;
	cod_aux:integer;
	cant_final:integer;
	cant_prom:integer;
	begin
		reset(arch_det);
		reset(arch_mae);
		leerDetalle(arch_det, reg_det);
		leerMaestro(arch_mae, reg_mae);
		while(reg_det.cod<valor_alto) do begin
			cod_aux:=reg_det.cod;
			cant_prom:=0;
			cant_final:=0;
			while (cod_aux = reg_det.cod) do begin
				if(reg_det.final =0) then
					cant_prom:=cant_prom+1
					else
						cant_final:=cant_final+1;
				leerDetalle(arch_det, reg_det);
			while(reg_mae.cod<>cod_aux) do
				read(arch_mae, reg_mae);

			reg_mae.cant_final:= reg_mae.cant_final + cant_final;
			reg_mae.cant_prom:= reg_mae.cant_prom + cant_prom;
			seek(arch_mae, filepos(arch_mae-1));
			write(arch_mae, reg_mae);
			if (not eof(arch_mae)) then 
			 read(arch_mae, reg_mae);
		end;
	close(arch_mae);
	close(arch_det);
	end;

procedure exportarCursadasNoFinal( var arch_mae: arch_mae);
	var
debefinales:text;
reg_mae:alumno;
begin
	assign(debefinales, debefinales_txt);
	rewrite(debefinales);
	reset(arch_mae);
	leerMaestro(arch_mae,reg_mae);
	while(reg_mae.cod < valor_alto) do begin
		if((reg_mae.cant_prom - reg_mae.cant_final) > 4) then
			with(reg_mae) do begin
				writeln(debefinales, cod,' ', cant_final,' ', cant_prom,' ', nombre);
				writeln(debefinales, apellido);
				end;
		leerMaestro(arch_mae, reg_mae);
		end;
		close(arch_mae);
		close(debefinales);
		end;

var
arch_maestro: arch_mae;
arch_detalle: arch_det;
opcion: byte;
salir:boolean;
begin
	assign(arch_maestro, alumnos_binario);
	assign(arch_det, detalle_binario);
	writeln('seleccione: ');
	writeln('1)crear maestro ');
	writeln('2)crearDetalle ');
	writeln('3) exportarMaestro ');
	writeln('4) exportarDetalle ');
	writeln('5- actualizarMaestro');
	writeln('6-exportar los que deben finales');
	writeln('0- salir');
	readln(opcion);
	while (opcion >0) and (opcion<7) and (not salir do begin
		case opcion of
		1: crearMaestro(arch_maestro);
		2:crearDetalle(arch_detalle);
		3:exportarMaestro(arch_maestro);
		4:exportarDetalle(arch_detalle);
		5:actualizarMaestro(arch_maestro, arch_detalle);
		6:exportarCursadasNoFinal(arch_maestro);
		0:salir:=true
		else begin
		writeln('vuelva a elegir opcion valida');
		readln(opcion);
		end;
		writeln('seleccione: ');
	writeln('1)crear maestro ');
	writeln('2)crearDetalle ');
	writeln('3) exportarMaestro ');
	writeln('4) exportarDetalle ');
	writeln('5- actualizarMaestro');
	writeln('6-exportar los que deben finales');
	writeln('0- salir');
	readln(opcion);
		end;
		end.



