unit boss_obj;
interface
uses types, bms1_obj, bms2_obj, bms3_obj, bms4_obj;

type
  boss = object
  	constructor init;
	  procedure bas12(var elem:call; var counts, counts1, counts2:count; var indbuf:buff; var lambdaofsourse:lambdaofS);
	  procedure bas3(var elem:call; var tosv, lambdaO:real; var counts, counts1, counts2:count; var nombuf, indbuf, ob:buff;
              var lambdaofsourse:lambdaofS);
    procedure main(var elem1, elem2:call; var  kolprev:INTEGER; var tosv:real; lambdaO:real;
              var indbuf, tail, ob:buff; var counts, counts1, counts2:count; var lambdaofsourse:lambdaofS);

  end;


implementation

  procedure boss.bas12(var elem:call; var counts, counts1, counts2:count; var indbuf:buff; var lambdaofsourse:lambdaofS);
    var
      bm1	: bms1;
  	  bm2	: bms2;
  	begin
  		if indbuf^.prev = nil then
          		bm1.main(elem, counts, counts1, counts2, lambdaofsourse)
      else
  			      bm2.main(indbuf, elem, counts, counts1, counts2, lambdaofsourse);

  	end;

  procedure boss.bas3(var elem:call; var tosv, lambdaO:real; var counts, counts1, counts2:count; var nombuf, indbuf, ob:buff;
            var lambdaofsourse:lambdaofS);
          var
             bm4	: bms4;
  	         bm3	: bms3;
          begin
            	if indbuf^.bufn = 0 then
            		bm4.main(elem, tosv, lambdaO, counts, counts1, counts2, lambdaofsourse)
            	else
  			        bm3.main(nombuf, tosv, lambdaO, counts, counts1, counts2, ob, indbuf);
            end;

  procedure boss.main(var elem1, elem2:call; var  kolprev:INTEGER; var tosv:real; lambdaO:real;
            var indbuf, tail, ob:buff; var counts, counts1, counts2:count; var lambdaofsourse:lambdaofS);
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
  			bas3(elem, tosv, lambdaO, counts, counts1, counts2, nombuf, indbuf, ob, lambdaofsourse)
  		else
  			bas12(elem, counts, counts1, counts2, indbuf, lambdaofsourse);

      if counts.kolobr <> kolprev then begin
        {counts.request:= counts.request + indbuf^.bufp;}

        {1}
        if ob^.bufn = 1 then begin
          counts1.request:= counts1.request + 1;
          counts.request:= counts.request + 1;
        end;
        if tail^.prev^.bufn = 1 then begin
          counts1.request:= counts1.request + 1;
          counts.request:= counts.request + 1;
        end;

        if tail^.prev^.prev^.bufn = 1 then begin
          counts1.request:= counts1.request + 1;
          counts.request:= counts.request + 1;
        end;
        {2}
        if ob^.bufn = 2 then begin
          counts2.request:= counts2.request + 1;
          counts.request:= counts.request + 1;
        end;
        if tail^.prev^.bufn = 2 then begin
          counts2.request:= counts2.request + 1;
          counts.request:= counts.request + 1;
        end;
        if tail^.prev^.prev^.bufn = 2 then begin
          counts2.request:= counts2.request + 1;
          counts.request:= counts.request + 1;
        end;


        kolprev:= counts.kolobr;
      end;


      if elem.nmin = 1 then begin
        elem1.tpost:= elem.tpost;
        elem1.nmin:= elem.nmin;
      end
      else begin
        elem2.tpost:= elem.tpost;
        elem2.nmin:= elem.nmin;
      end;



  	end;

  constructor boss.init;
              begin
              end;

end.
