uses Graph, SysUtils, crt;
const
  xs = 800; ys = 600; sz = 50;
  sxs = 400; sys = 300;
var GD, GM: Integer; a, b: real;
procedure viv;
var i: Integer;
begin
  SetColor(White);
  for i := 0 to xs div sz do Line(i * sz, 0, i * sz, ys);
  for i := 0 to ys div sz do  Line(0, i * sz, xs, i * sz);
  SetColor(Green);Line(sxs, 0, sxs, ys); 
  Line(0, sys, xs, sys);
end;
procedure lng;
var
  i, xy, yx: Integer;
  x2, y2: real;
begin
  Write('a, b: '); ReadLn(a, b);
  viv;
  SetColor(Yellow);
  for i := -160 to 160 do 
  begin 
    x2 := i * 0.1; 
    y2 := a * x2 + b;
    xy := sxs + Round(x2 * sz); 
    yx := sys - Round(y2 * sz);
    if i = -160 then MoveTo(xy, yx)
    else LineTo(xy, yx);
end;end;

procedure xoy;
var
  i, xy, yx, x1, y1: Integer;
  x2, y2: real;
begin
  Write('a, b: ');ReadLn(a, b);
  viv;
  SetColor(White);
  for i := -xs div (2 * sz) to xs div (2 * sz) do 
  begin 
    x1 := sxs + i * sz;
    if i <> 0 then OutTextXY(x1 - 5, sys + 5, IntToStr(i)); 
  end;
  for i := -ys div (2 * sz) to ys div (2 * sz) do 
  begin 
    y1 := sys - i * sz;
    if i <> 0 then OutTextXY(sxs + 5, y1 - 5, IntToStr(i)); 
  end;
  SetColor(Yellow);
  for i := 0 to 160 do begin
    x2 := -8.0 + i * 0.1; 
    y2 := a * x2 * x2 + b;
    xy := sxs + Round(x2 * sz);
    yx := sys - Round(y2 * sz);
    if i = 0 then MoveTo(xy, yx)
    else LineTo(xy, yx);
end;end;


procedure gip;
var
  i, xy, yx: Integer;
  x2, y2: real;
begin
  viv;
  SetColor(Yellow);
  for i := -160 to 160 do begin
    if i <> 0 then begin x2 := i * 0.1;  y2 := 1 / x2;
                           xy := sxs + Round(x2 * sz); 
                           yx := sys - Round(y2 * sz);
    if i = -160 then MoveTo(xy, yx)
                else LineTo(xy, yx);
end;end;end;


begin
  GD := Detect;
  InitGraph(GD, GM, '');
  repeat
    ClearDevice;
    Writeln('1-liniyni, 2-x*y, 3-gyperbla'); WriteLn('0 = exit');
    case ReadKey of
      '1': begin ClearDevice; lng; end;
      '2': begin ClearDevice; xoy; end;
      '3': begin ClearDevice; gip; end;
      '0': Break;
    end;
    if GraphResult <> grOk then WriteLn();ReadKey;until False; CloseGraph;
end.