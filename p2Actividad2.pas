program actualizarEstudiantes;
uses
    sysutils;
const
    alumnos_binary = 'alumnosMaestro';
    detalle_binary = 'alumnosDetalle';
    alumnos_txtfilename = 'alumnos.txt';
    detalle_txtfilename = 'detalle.txt';
    listado_txtfilename = 'reporteAlumnos.txt';
    reporte_d_txtfilename = 'reporteDetalle.txt';
    debe_finales_txtfilename = 'alum_debe_finales.txt';
    valor_alto = 99999;
type
    str20 = string[20];
    alumno = record
        cod: integer;
        apellido: str20;
        nombre: str20;
        cant_cursadas: integer;
        cant_finales: integer;
    end;

    det_alumno = record
        cod: integer;
        aprobo_final: integer;
    end;

    arch_mae = file of alumno;
    arch_det = file of det_alumno;
//------------------PROCESOS LEER------------------//
procedure leerDetalle (var arch_detalle: arch_det; var dato: det_alumno);
begin
    if (not eof(arch_detalle)) then
        read(arch_detalle, dato)
    else
        dato.cod := valor_alto;
end;

procedure leerMaestro (var arch_mae: arch_mae; var dato: alumno);
begin
    if (not eof(arch_mae)) then
        read(arch_mae, dato)
    else
        dato.cod := valor_alto;
end;

procedure leerMaestroTxt (var alum_text: text; var reg_alumno: alumno);
begin
    if (not eof(alum_text)) then
        with reg_alumno do begin
            readln(alum_text, cod, cant_cursadas, cant_finales, nombre);        //Este es el formato que debe respetar
            readln(alum_text, apellido);                                        //el archivo de texto de alumnos.
            nombre := Trim(nombre); //RECORDAR HACER LA ASIGNACIÓN
        end
    else
        reg_alumno.cod := valor_alto;
end;

procedure leerDetalleTxt (var det_txt: text; var reg_det: det_alumno);
begin
    if (not eof(det_txt)) then
        with reg_det do begin
            readln(det_txt, cod, aprobo_final);                               //Este es el formato del ".txt" del detalle.
        end
    else
        reg_det.cod := valor_alto;
end;

//------------------------------------------------//
procedure crearMaestro (var arch_mae: arch_mae);
var
    alum_text: text;
    reg_alumno: alumno;
begin
    assign(alum_text, alumnos_txtfilename);
    reset(alum_text);
    rewrite(arch_mae);
    leerMaestroTxt(alum_text, reg_alumno);
    while (reg_alumno.cod < valor_alto) do begin
        write(arch_mae, reg_alumno);
        leerMaestroTxt(alum_text, reg_alumno);
    end;
    close(arch_mae);
    close(alum_text);
end;

procedure crearDetalle (var arch_det: arch_det);
var
    det_txt: text;
    reg_det: det_alumno;
begin
    assign(det_txt, detalle_txtfilename);
    reset(det_txt);
    rewrite(arch_det);
    leerDetalleTxt(det_txt, reg_det);
    while (reg_det.cod < valor_alto) do begin
        write(arch_det, reg_det);
        leerDetalleTxt(det_txt, reg_det);
    end;
    close(arch_det);
    close(det_txt);
end;

procedure exportarMaestro (var arch_mae: arch_mae);
var
    alumno: alumno;
    listado_txt: text;
begin
    assign(listado_txt, listado_txtfilename);
    rewrite(listado_txt);
    reset(arch_mae);
    leerMaestro(arch_mae, alumno);
    while (alumno.cod < valor_alto) do begin
        with alumno do begin
            writeln(listado_txt, cod, ' ', cant_cursadas, ' ', cant_finales, ' ', nombre);
            writeln(listado_txt, apellido);
        end;
        leerMaestro(arch_mae, alumno);
    end;
    close(arch_mae);
    close(listado_txt);
end;

procedure exportarDetalle (var arch_det: arch_det);
var
    reg_det: det_alumno;
    det_exportar: text;
begin
    assign(det_exportar, reporte_d_txtfilename);
    rewrite(det_exportar);
    reset(arch_det);
    leerDetalle(arch_det, reg_det);
    while (reg_det.cod < valor_alto) do begin
        with reg_det do
            writeln(det_exportar, cod, ' ', aprobo_final);
        leerDetalle(arch_det, reg_det);
    end;
    close(arch_det);
    close(det_exportar);
end;

procedure actualizarMaestro (var arch_mae: arch_mae; var arch_det: arch_det);
var
    reg_mae: alumno;
    reg_det: det_alumno;
    cod_actual: integer;
    cant_cursadas: integer;
    cant_finales: integer;
begin
    reset(arch_mae);
    reset(arch_det);
    leerDetalle(arch_det, reg_det);
    read(arch_mae, reg_mae);                  //Precondicion: Si existe un archivo detalle, entonces el archivo maestro necesariamente contiene elementos.
    while (reg_det.cod < valor_alto) do begin //Si el enunciado mencionara que el maestro podría estar vacío, habría que hacer la comprobación.
        cod_actual := reg_det.cod;           //Preparo los datos a guardar.
        cant_cursadas := 0;
        cant_finales := 0;
        while (cod_actual = reg_det.cod) do begin    //Cuando termine el recorrido, reg_det quedará posicionado en el siguiente registro detalle a procesar
            if (reg_det.aprobo_final = 0) then      //Contabilizo.
                cant_cursadas := cant_cursadas + 1
            else
                cant_finales := cant_finales + 1;
            leerDetalle(arch_det, reg_det);
        end;
        while (reg_mae.cod <> cod_actual) do    //No lo puedo comparar con reg_det.cod porque estaría omitiendo un alumno entero del detalle
            read(arch_mae, reg_mae);
        reg_mae.cant_cursadas := reg_mae.cant_cursadas + cant_cursadas;
        reg_mae.cant_finales := reg_mae.cant_finales + cant_finales;
        seek(arch_mae, filepos(arch_mae)-1);                                  //No necesito hacer reg_mae.cod := aux porque cuando busque en el while de arriba
        write(arch_mae, reg_mae);                                             //el registro quedó asignado con el código correcto.
        if (not eof(arch_mae)) then
            read(arch_mae, reg_mae);
    end;
    close(arch_mae);
    close(arch_det);
end;

procedure exportarIncisoF (var arch_mae: arch_mae);
var
    debe_finales: text;
    reg_mae: alumno;
begin
    assign(debe_finales, debe_finales_txtfilename);
    rewrite(debe_finales);
    reset(arch_mae);
    leerMaestro(arch_mae, reg_mae);
    while(reg_mae.cod < valor_alto) do begin
        if ((reg_mae.cant_cursadas - reg_mae.cant_finales) > 4) then
            with reg_mae do begin
                writeln(debe_finales, cod, ' ', cant_cursadas, ' ', cant_finales, ' ', nombre);
                writeln(debe_finales, apellido);
            end;
        leerMaestro(arch_mae, reg_mae);
    end;
    close(arch_mae);
    close(debe_finales);
end;
//------------------------------------------------//
var
    arch_maestro: arch_mae;
    arch_detalle: arch_det;
    opcion: byte;
    salir: boolean;
begin
    assign(arch_maestro, alumnos_binary);
    assign(arch_detalle, detalle_binary);
    writeln('Seleccione una opcion: ');
    writeln('1) Crear maestro');
    writeln('2) Crear detalle');
    writeln('3) Exportar maestro');
    writeln('4) Exportar detalle');
    writeln('5) Actualizar maestro');
    writeln('6) Exportar según inciso F');
    writeln('0) Salir');
    salir := false;
    readln(opcion);
    while ((opcion > 0) and (opcion < 7)) and (not salir) do begin
        case opcion of
            1: crearMaestro(arch_maestro);
            2: crearDetalle(arch_detalle);
            3: exportarMaestro(arch_maestro);
            4: exportarDetalle(arch_detalle);
            5: actualizarMaestro(arch_maestro, arch_detalle);
            6: exportarIncisoF(arch_maestro);
            0: salir := true;
        end;
        writeln('Tarea completada. Seleccione otra opcion: ');
        readln(opcion);
    end;
end.
