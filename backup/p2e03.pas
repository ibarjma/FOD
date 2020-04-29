program p2e03;
uses
    sysutils;
const
	valor_alto=999999;
	n_detalles=4;
type
	cadena50=string[50];
	e=record
	cod:integer;
        stock_m:integer;
	stock_a:integer;
        precio:integer;
        desc:cadena50;
	end;
	ped=record
	cod:integer;
	cant:integer;
	end;

	arch_m= file of e;
	arch_d= file of ped;

	v_detalles= array[1..4] of arch_d;
	v_reg= array[1..4] of ped;


procedure leerMaestro(var arch_m:arch_m; var dato:e);
begin
	if(not eof(arch_m))then
		read(arch_m, dato)
		else
			dato.cod:= valor_alto;
	end;

procedure leerDetalle(var arch_d:arch_d; var dato:ped);
begin
	if(not eof(arch_d)) then
		read(arch_d, dato)
		else
		dato.cod:=valor_alto;
		end;

procedure leerMaestrotxt(var m_txt: text; var reg: e);
begin
	if (not eof(m_txt)) then
		readln(m_txt, reg.cod, reg.stock_m, reg.stock_a, reg.precio, reg.desc)
	else
		reg.cod:=valor_alto;
		end;

procedure crearMaestro(var arch_m: arch_m; var maestro_d:text);
var
reg_e:e;
begin
 leerMaestrotxt(maestro_d,reg_e);
 while (reg_e.cod < valor_alto) do begin
	write(arch_m, reg_e);
	leerMaestrotxt(maestro_d,reg_e);
	end;
close(arch_m);
close(maestro_d);
end;

procedure leerDetalletxt(var d_txt: text; var reg: ped);
begin
	if (not eof(d_txt)) then
		with reg do begin
		readln(d_txt, cod, cant);
		end
	else
		reg.cod:=valor_alto;
		end;

procedure crearDetalle(var d_txt: text; var arch_d:arch_d);
var
reg_d:ped;
begin
 leerDetalletxt(d_txt,reg_d);
 while (reg_d.cod < valor_alto) do begin
	write(arch_d, reg_d);
	leerDetalletxt(d_txt,reg_d);
	end;
close(d_txt);
close(arch_d);
end;

procedure minimoyactualizo(var arch_m:arch_m; v:v_reg;var min:integer; var n:integer);
var 	aux:ped;
	aux2:e;
	diferencia:integer;
	i:integer     ;
begin
min:=999;
reset(arch_m);
for i:=1 to n_detalles do
	if (v[i].cod<min) then begin
	min:=v[i].cod;
	n:=i;
	aux:=v[i];
 end;
if (min<>valor_alto) then begin
	leerMaestro(arch_m, aux2);
        while (aux2.cod<>min) or (aux2.cod<>valor_alto) do
             leerMaestro(arch_m, aux2);
        if(aux2.cod<>valor_alto) then begin
	diferencia:=aux2.stock_a-aux.cant;
	if(diferencia<0) then begin
	writeln(' faltan ',(diferencia*(-1)),' de cant del prod', aux2.cod, ' de la sucursal ',n);
	diferencia:=0;
	end
	else
		if(diferencia < aux2.stock_m) then
			writeln(' le cant del prod', aux2.cod, ' de la sucursal ',n, ' quedo por debajo del stock min');
	seek(arch_m,filepos(arch_m)-1);
        aux2.stock_a:=diferencia;
	write(arch_m, aux2);
	end;
end;
close(arch_m);
end;

procedure actualizarMaestro(var arch_m:arch_m; vec_d:v_detalles);
var
v_re:v_reg;
i:integer;
num:integer;
n:integer;
begin
	for i:=1 to n_detalles do
				leerDetalle(vec_d[i], v_re[i]);
        
        minimoyactualizo(arch_m, v_re, num, n);
	while(num<>valor_alto) do begin
		leerDetalle(vec_d[n], v_re[n]);
		minimoyactualizo(arch_m,v_re, num, n);
		end;
close(vec_d[1]);
close(vec_d[2]);
close(vec_d[3]);
close(vec_d[4]);

end;
//--------------------------------------------------------------------------//
var
arc_m:arch_m;
detalle4:text;
detalle1:text;
detalle2:text;
detalle3:text;
vec_d:v_detalles;
arc_txt:text;
begin
        assign(arc_txt,'maestrocarga.txt');
        assign(arc_m, 'arch_m');
	assign(detalle1, 'detalle1.txt');
	assign(detalle2, 'detalle2.txt');
	assign(detalle3, 'detalle3.txt');
	assign(detalle4, 'detalle4.txt');
	assign(vec_d[1], 'det1');
	assign(vec_d[2], 'det2');
	assign(vec_d[3], 'det3');
	assign(vec_d[4], 'det4');
        reset(detalle1);
        reset(detalle2);
        reset(detalle3);
        reset(detalle4);
        rewrite(vec_d[1]);
        rewrite(vec_d[2]);
        rewrite(vec_d[3]);
        rewrite(vec_d[4]);
	crearDetalle(detalle1,vec_d[1]);
	crearDetalle(detalle2,vec_d[2]);
	crearDetalle(detalle3,vec_d[3]);
	crearDetalle(detalle4,vec_d[4]);
        readln();
        rewrite(arc_m);
        reset(arc_txt);
	crearMaestro(arc_m,arc_txt);
        readln();
    reset(vec_d[1]);
    reset(vec_d[2]);
    reset(vec_d[3]);
    reset(vec_d[4]);
	actualizarMaestro(arc_m,vec_d);
        readln();
end.

