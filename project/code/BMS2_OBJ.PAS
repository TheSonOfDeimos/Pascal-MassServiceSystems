unit bms2_obj;
interface
uses types;

type
  bms2 = object
     constructor init;
  	 procedure buff_record_call(var indbuf:buff; elem:call);
     procedure  gen_next_call(var elem:call;  var lambdaofsourse:lambdaofS);
  	 procedure main(var indbuf:buff; var elem:call; var counts, counts1, counts2:count; var lambdaofsourse:lambdaofS);
  end;


implementation

	procedure bms2.buff_record_call(var indbuf:buff; elem:call);
          begin
              indbuf:= indbuf^.prev;
              indbuf^.bufn:= elem.nmin;
              indbuf^.buft:= elem.tpost;
          end;

  procedure bms2.gen_next_call(var elem:call; var lambdaofsourse:lambdaofS);
         var  r:real;
              tay:real;

         begin

           if elem.nmin = 1 then begin
             r:= random;
             tay:= -1 / lambdaofsourse.lambda1 * ln(r);
             elem.tpost:= elem.tpost + tay;
           end;
           if elem.nmin = 2  then begin
             r:= random;
             tay:= -1 / lambdaofsourse.lambda2 * ln(r);
             elem.tpost:= elem.tpost + tay;
           end;

         end;

  procedure bms2.main(var indbuf:buff; var elem:call; var counts, counts1, counts2:count; var lambdaofsourse:lambdaofS);
  	begin
  		buff_record_call(indbuf, elem);
  		gen_next_call(elem, lambdaofsourse);
  		counts.kol:= counts.kol + 1;

      if elem.nmin = 1 then begin
        counts1.kol:= counts1.kol + 1;
      end
      else begin
        counts2.kol:= counts2.kol + 1;
      end;
     end;

  constructor bms2.init;
            begin
            end;


end.
