unit boss_obj;
interface
uses types, bms1_obj, bms2_obj, bms3_obj, bms4_obj;

type
  boss = object
  	constructor init;
	  procedure bas12(var elem:call; var counts, counts1, counts2:count; var indbuf:buff);
	  procedure bas3(var elem:call; var tosv, lambdaO:real; var counts, counts1, counts2:count; var nombuf, indbuf, ob:buff);
    procedure main(var elem1, elem2:call; var  kolprev, req_in_buf:integer; var tosv:real; lambdaO:real;
              var indbuf, tail, ob:buff; var counts, counts1, counts2:count);

  end;


implementation

  procedure boss.bas12(var elem:call; var counts, counts1, counts2:count; var indbuf:buff);
    var
      bm1	: bms1;
  	  bm2	: bms2;
  	begin
  		if indbuf^.prev = nil then
          		bm1.main(elem, counts, counts1, counts2)
      else
  			      bm2.main(indbuf, elem, counts, counts1, counts2);

  	end;

  procedure boss.bas3(var elem:call; var tosv, lambdaO:real; var counts, counts1, counts2:count; var nombuf, indbuf, ob:buff);
          var
             bm4	: bms4;
  	         bm3	: bms3;
            begin
            	if indbuf^.bufn = 0 then
            		bm4.main(elem, tosv, lambdaO, counts, counts1, counts2)
            	else
  			        bm3.main(nombuf, tosv, lambdaO, counts, counts1, counts2, ob, indbuf);
            end;

  procedure boss.main(var elem1, elem2:call; var  kolprev, req_in_buf:integer; var tosv:real; lambdaO:real;
            var indbuf, tail, ob:buff; var counts, counts1, counts2:count);
  	var
  		elem:call;
  		nombuf:buff;

  	begin


  		if elem1.tpost < elem2.tpost then begin
  			 elem.tpost:= elem1.tpost;
  			 elem.nmin:= elem1.nmin;
  		end
  		else begin
  			elem.tpost:= elem2.tpost;
  			elem.nmin:= elem2.nmin;
  		end;

  		nombuf:= tail^.prev;
  		if tosv <= elem.tpost then
  			bas3(elem, tosv, lambdaO, counts, counts1, counts2, nombuf, indbuf, ob)
  		else
  			bas12(elem, counts, counts1, counts2, indbuf);

      if (indbuf^.bufn <> 0) and (counts.kol <> kolprev) and (counts.kol mod 100 = 0) then begin
        req_in_buf:= req_in_buf + indbuf^.bufp;
        kolprev:= counts.kol;
      end;

      if elem.nmin = 1 then begin
        elem1.tpost:= elem.tpost;
        elem1.nmin:= elem.nmin;
      end
      else begin
        elem2.tpost:= elem.tpost;
        elem2.nmin:= elem.nmin;
      end;

    {
      {ALL
      counts.kol:= counts.kol + kol;
      counts.kolobr:= counts.kolobr + kolobr;
      counts.kotk:= counts.kotk + kotk;
      counts.tog:= counts.tog + tog;

      {1 CALL
      counts1.kol:= counts1.kol + kol1;
      counts1.kolobr:= counts1.kolobr + kolobr1;
      counts1.kotk:= counts1.kotk + kotk1;
      counts1.tog:= counts1.tog + tog1;

      {2 CALL
      counts2.kol:= counts2.kol + kol2;
      counts2.kolobr:= counts2.kolobr + kolobr2;
      counts2.kotk:= counts2.kotk + kotk2;
      counts2.tog:= counts2.tog + tog2;
     }
  	end;

  constructor boss.init;
              begin
              end;

end.