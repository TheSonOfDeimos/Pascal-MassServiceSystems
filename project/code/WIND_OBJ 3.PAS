unit wind_obj;

interface

  uses
     crt, graph, tpko_obj, boss_obj, alg_obj, types;
  TYPE
    windows = object
      procedure PointingDot(ButN:integer; var flag:INTEGER; j:STRING);
      procedure drawbottom(alig,  elip, swich:INTEGER; nameBott:STRING);
      procedure mode(var tick:INTEGER);
      procedure values(var tick, tick2, kolsum:INTEGER; var lambdao:real);
      procedure meta(var tick:INTEGER);
      procedure table(align:INTEGER);
      procedure plot(tick:INTEGER);
      procedure main(flag, flag2:INTEGER;  var mode1, kolsum, zeroing, dynamORconst:INTEGER; var lambdao:REAL);
      constructor init(var tick:INTEGER);
    end;
implementation

  procedure windows.PointingDot(ButN:integer; var flag:INTEGER; j:STRING);
    begin

      if j = #80 then begin
         drawbottom(flag + 1, 1, 2, '');
         flag:= flag + 1;
      end;

      if (j = #72) and (flag <> -1) then begin
        drawbottom(flag + 1, 1, 2, '');
        flag:= flag - 1;
      end;

      if flag > ButN - 1 then
        flag:= flag - ButN;
      if flag < 0 then
        flag:= flag + ButN;

      if flag >= 0 then begin
         drawbottom(flag + 1, 1, 1, '');

      end;
    end;

  procedure windows.drawbottom(alig, elip, swich:INTEGER; nameBott:STRING);
    var x:INTEGER;
    begin

      if elip  = 1 then begin
        x:= 30;
        if swich = 0 then begin

          setcolor(7);
          Rectangle	(GetMaxX div 4, 100  + 60 * ALIG , GetMaxX div 4 * 3, 155 + 60 * alig);{don't change}
          SetFillStyle(SolidFill, 7);
          FloodFill(GetMaxX div 4 + 1, 101 + 60 * alig, 7);

          SetColor(8);
          settextstyle(0, horizDir, 3);
          outtextxy(GetMaxX div 3  - 20 + x, (118 + 60 * alig), nameBott);


          setFillStyle(SolidFill, 8);
          SetColor(8);
          fillEllipse(GetMaxX div 4 + x, (128  + 60 * ALIG), 12, 12);

          setFillStyle(SolidFill, 7);
          SetColor(7);
          fillEllipse(GetMaxX div 4 + x, (128  + 60 * ALIG), 10, 10);

          setFillStyle(SolidFill, 8);
          SetColor(8);
          fillEllipse(GetMaxX div 4 + x, (128  + 60 * ALIG), 8, 8);
        end;
        if swich = 1 then begin
          setFillStyle(SolidFill, 7);
          SetColor(7);
          fillEllipse(GetMaxX div 4 + x, (128  + 60 * ALIG), 6, 6);
        end;
        if swich = 2 then begin
          setFillStyle(SolidFill, 8);
          SetColor(8);
          fillEllipse(GetMaxX div 4 + x, (128  + 60 * ALIG), 6, 6);
        end;
      end
      else begin
        setcolor(8);
        Rectangle	(GetMaxX div 4, 100  + 60 * ALIG , GetMaxX div 4 * 3, 155 + 60 * alig);{don't change}
        SetFillStyle(SolidFill, 8);
        FloodFill(GetMaxX div 4 + 1, 101 + 60 * alig, 8);

        SetColor(7);
        settextstyle(0, horizDir, 3);
        outtextxy(GetMaxX div 3  + 20, (118 + 60 * alig)  , nameBott);
      end;
    end;

  procedure windows.mode(var tick:INTEGER);
    var j:STRING;
        flag:INTEGER;
    begin
      flag:= -1;
      drawbottom(0, 0, 0, ' MODE');
      drawbottom(1, 1, 0, 'STEPPING');
      drawbottom(2, 1, 0, 'OFFLINE');
      drawbottom(3, 1, 0, 'ALL');

      repeat
        j:= readkey;
        if j <> #8 then begin
          PointingDot(3, flag, j);
          if j = #13 then begin
            tick:= flag;{MIGHT BE A MISTAKE... 123 is unic idetiyty cide fof each setting}
          end;
        end;
      until (j = #8);
    end;

  procedure windows.values(var tick, tick2, kolsum:INTEGER; var lambdao:real);
    label start;
    var j, bt, lam, ko:STRING;
        flag, i, n:INTEGER;
    begin
      flag:= -1;
      start:
      lam:= '';
      ko:= '';
      PointingDot(4, flag, j);
      drawbottom(0, 0, 0, ' VALUES');
      drawbottom(1, 1, 0, 'L CONST:');
      drawbottom(2, 1, 0, 'L DYNAM:');
      drawbottom(3, 1, 0, 'R VAL:');
      drawbottom(4, 1, 0, 'ZEROING');

      repeat
        j:= readkey;

        if j <> #8 then begin
          PointingDot(4, flag, j);
          i:= 0;

          if j = #13 then begin
            if (flag = 0) or (flag = 1) or (flag = 2) then begin

              repeat
                bt:= readkey;
                if bt <> #13 then begin
                  inc(i);
                  outtextXY((GetMaxX div 4  *  3) + (i * 25), (118 + 60 * (flag + 1)),bt);
                  if flag = 0  then begin
                    lam:= lam + bt;
                    val(lam, lambdao, n);
                    tick2:= 0;
                  end;
                  if  flag = 1 then begin
                    lam:= lam + bt;
                    val(lam, lambdao, n);
                    tick2:= 1;
                  end;
                  if flag  = 2 then begin
                    ko:= ko + bt;
                    val(ko, kolsum, n);
                  end;
                end;

              until (bt = #13);




              ClearViewPort;
              goto start;
            end;
            tick:= flag;{MIGHT BE A MISTAKE... 123 is unic idetiyty cide fof each setting}

          end;

        end;
      until (j = #8);
    end;

  procedure windows.meta(var tick:INTEGER);
    begin

    end;

  procedure windows.table(align:INTEGER);
    var j, bt, line, save:STRING;
        n:INTEGER;
        tpinput: file of count;
        counts:count;


    begin

      SetColor(15);
      settextstyle(2, horizDir, 5);
      assign(tpinput, 'typedoutp.txt');
      reset(tpinput);
      align:= 10;

      Seek(tpinput, 0) ;
      while not eof(tpinput)  do begin

        read(tpinput, counts);
        str((100 * (counts.kotk/(counts.kol + 1))):3:3, save);
        line:= 'P(all): ' + save + '%';
        read(tpinput, counts);
        str((100 * (counts.kotk/(counts.kol + 1))):3:3, save);
        line:= line + '   P(1): ' + save + '%';

        read(tpinput, counts);
        str((100 * (counts.kotk/(counts.kol + 1))):3:3, save);
        line:= line +  '   P(2): ' + save + '%';

        outtextxy(100, align, line);
        align:= align + 12;
      end;
      bt:= readkey;
      close(tpinput);

    end;

  procedure windows.plot(tick:INTEGER);
    var
       axe:graphik;
       bt:STRING;
       i, res:INTEGER;
       counts:count;
       input: file of count;
    begin

      assign(input, 'typedoutp.txt');
      reset(input);
      res:= 0;
      repeat
        bt:= readkey;
        if bt = #77 then begin
          res:= res + 1;
        end;

        if bt = #75 then begin
          res:= res - 1;
        end;

        if res > 2 then begin
          res:= 0;
        end;
        if res < 0 then begin
          res:= 2;
        end;

        ClearViewPort;
        axe.coordinates(45, 440, 'numUP');
        case res of
            0: begin
                  {P all}
                  SetColor(15);
                  setfillstyle(solidfill, 15);
                  seek(input, 0);

                  read(input, counts);
                  Moveto(45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                  read(input, counts);
                  read(input, counts);
                  for i:= 1 to 20 do begin
                    read(input, counts);
                    lineto(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                    fillEllipse(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200), 2, 2);
                    read(input, counts);
                    read(input, counts);
                  end;
                end;
             1: begin
                  {p1}
                  SetColor(2);
                  setfillstyle(solidfill, 2);
                  seek(input, 0);
                  read(input, counts);
                  read(input, counts);
                  Moveto(45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                  read(input, counts);
                  for i:= 1 to 20 do begin
                    read(input, counts);
                    read(input, counts);
                    lineto(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                    fillEllipse(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200), 2, 2);
                    read(input, counts);
                  end;
                end;
                  {p2}
             2: begin
                    SetColor(4);
                    setfillstyle(solidfill, 4);
                    seek(input, 0);
                    read(input, counts);
                    read(input, counts);
                    read(input, counts);
                    Moveto(45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                    for i:= 1 to 20 do begin
                      read(input, counts);
                      read(input, counts);
                      read(input, counts);
                      lineto(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200));
                      fillEllipse(i * 28 + 45, 440 - round(counts.kotk/(counts.kol + 1) * 200), 2, 2);
                    end;
                  end;
          end;
        until (bt = #8);
        close(input);

    end;

  procedure windows.main(flag, flag2:INTEGER; var mode1, kolsum, zeroing, dynamORconst:INTEGER; var lambdao:REAL);

    var simulating:alg;
        alig:integer;

    begin
      case flag of
        0: begin
            simulating.main(lambdao, kolsum, flag2, zeroing, dynamORconst)
           end;

        1: begin
            case flag2 of
              0: table(10);
              1: plot(0);

            end;
           end;

        2: begin
            case flag2 of
              0: mode(mode1);
              1: values(zeroing, dynamORconst, kolsum, lambdao);
              2: meta(kolsum);
            end;
           end;

      end;
    end;

  constructor windows.init;
    begin
    end;
end.
