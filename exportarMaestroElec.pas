program exportarmaestroELEC;
uses
	sysutils;
const
    elec='maestroELEC.txt';
    valor_alto=9999;
type
    	cadena50=string[50];
	e=record
	cod:integer;
        stock_m:integer;
	stock_a:integer;
        precio:integer;
        desc:cadena50;
	end;
 arch_m=file of e;

procedure leerMaestro(var arch_m:arch_m; var dato:e);
begin
	if(not eof(arch_m))then
		read(arch_m, dato)
		else
			dato.cod:= valor_alto;
	end;
procedure exportarMaestro(var a:arch_m);
var
electro:e;
listaELEC: text;
begin
  assign(listaELEC, elec);
  rewrite(listaELEC);
  reset(a);
  leerMaestro(a,electro);
  while(electro.cod<valor_alto) do begin
        with electro do
            writeln(listaELEC, cod, ' ', stock_m,' ', stock_a,' ',precio,' ',desc);
		leerMaestro(a,electro);
        end;
	close(a);
	close(listaELEC);
end;

var
arc_m:arch_m;
begin
assign(arc_m, 'arch_m');
exportarMaestro(arc_m);

end.
