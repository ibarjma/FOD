program p2e01;
const
    valor_alto = 99999;
type
	str30=string[30];
	empleado=record
		cod:integer;
		nombre:str30;
		comision:real;
		end;
	arch_empleado= file of empleado;

procedure leerEmpleado (var e: empleado);
begin
    write('Ingrese el codigo del empleado, o cero para terminar: ');
    readln(e.cod);
    if (e.cod <> 0) then begin
        write('Ingrese el nombre: ');
        readln(e.nombre);
        write('Ingrese la comision generada: ');
        readln(e.comision);
    end;
end;

procedure crearDetalle (var arch_det: arch_empleado);
var emp:empleado;
begin
	rewrite(arch_det);
	leerEmpleado(emp);
	while (emp.cod <> 0) do begin
		write(arch_det, emp);
		leerEmpleado(emp);
		end;
	close(arch_det);
end;

procedure listarTodos(var arch_mae: arch_empleado);
var
    emp_leido: empleado;
begin
    reset(arch_mae);
    while(not eof(arch_mae)) do begin
        read(arch_mae,emp_leido);
        writeln('Codigo: ', emp_leido.cod, '. Nombre: ', emp_leido.nombre,
                '. Comision: ', emp_leido.comision:2:2);
    end;
    close(arch_mae);
end;
//----------------------------------------------------------------------//


//-------------------------------------------------------------------//
procedure leerArchivo (var arch: arch_empleado; var dato: empleado);
begin
     if (not eof(arch)) then
         read(arch, dato)
     else
         dato.cod := valor_alto;
end;

procedure compactar(var arch_m:arch_empleado; var arch_d:arch_empleado);
var
reg_m:empleado;
reg_d:empleado;
begin
	reset(arch_d);
	rewrite(arch_m);
	leerArchivo(arch_d, reg_d);
	while(reg_d.cod < valor_alto) do begin
		reg_m.cod:= reg_d.cod;
		reg_m.nombre:=reg_d.nombre;
		reg_m.comision:=0;
		while( reg_d.cod = reg_m.cod) do begin
			reg_m.comision:=reg_m.comision + reg_d.comision;
			leerArchivo(arch_d, reg_d);
			end;
		write(arch_m, reg_m);
	end;
	close(arch_m);
	close(arch_d);
	end;

//_-----------------------------------------------------------------//

var
arch_detalle: arch_empleado;
arch_maestro:arch_empleado;
opcion:integer;
begin
	assign(arch_detalle, 'detalleEmp');
	assign(arch_maestro, 'maestroEmp');
	writeln( 'ingrese 1 para crear detalle, 2 para comprimirlo, 3 para leer detalle: ');
	readln(opcion);
	while((opcion <> 2) or (opcion <>1)) do begin
	case opcion of
	1: begin crearDetalle(arch_detalle);
	end;
	2: begin
	compactar(arch_detalle, arch_maestro);
	writeln(' presiona una tecla para imprimir archivo maestro: ');
	readln;
	listarTodos(arch_maestro);
	readln;
	end;
	3: begin
	listarTodos(arch_detalle);
	readln;
	end
	else begin
	writeln('ingrese un numero valido');
        readln(opcion);
	end;
	end;
	end;
        end.

