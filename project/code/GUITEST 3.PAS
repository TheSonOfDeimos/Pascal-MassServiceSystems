USES
  crt, graph, tpko_obj, GUI_obj, wind_obj;

  VAR
    x,i, y, g, h:INTEGER;
    j, c, s:string;
    gr:graphik;
    wind:windows;
    inter:GUI;

    zeroing, dynamORconst,mode1, kolsum:INTEGER;
    lambdao:REAL;
  BEGIN
    g:= detect;
    initgraph(g, h, '');
    x:= 10;
    y:= 475;

    kolsum:= 1001;
    lambdao:= 1;
    inter.Menu(zeroing, dynamORconst, mode1, kolsum, lambdao);
   {

    wind.values(i,j);
    }




        closegraph;
        writeln('zeroing:', zeroing);
        writeln('mode1:', mode1);
        writeln('kol:' ,kolsum);
        writeln('lambda:', lambdao:5:10);

  END.
