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
    dynamorconst:= 1;
    kolsum:= 1500;
    lambdao:= 1;
    zeroing:= 0;
    mode1:= 2;

    inter.Menu(zeroing, dynamORconst, mode1, kolsum, lambdao);





        closegraph;
        writeln('zeroing:', zeroing);
        writeln('mode1:', mode1);
        writeln('kol:' ,kolsum);
        writeln('lambda:', lambdao:5:10);
        writeln('const:', dynamorconst);

  END.
