uses crt;
var a: array[1..100] of integer; n, i: byte;
procedure res; var i: byte; begin for i:=1 to n do write(a[i]:3); writeln; end;
procedure qs(lw, hi: integer); var i, j, b, t: integer;
begin if lw < hi then begin b := a[(lw + hi) div 2]; i := lw; j := hi;
repeat while a[i] < b do i := i + 1; while a[j] > b do j := j - 1;
if i <= j then begin t := a[i]; a[i] := a[j]; a[j] := t; res; i := i + 1; j := j - 1; end;
until i > j; qs(lw, j); qs(i, hi); end; end;
begin randomize; readln(n); for i:=1 to n do a[i] := random(100); res; qs(1, n); res; readln; end.








































{uses Graph, Crt;
var gd, gm, n, i, sp, bws, temp, j: Integer; nu: array of Integer;
procedure viv(idx, val: Integer);
var x, bhs: Integer;
begin
  x := sp + idx * (bws + sp);
  SetFillStyle(SolidFill, black);
  Bar(x, 0, x + bws, GetMaxY);
  bhs := val * 20;
  SetFillStyle(SolidFill, white);
  Bar(x, GetMaxY - bhs, x + bws, GetMaxY);
  SetColor(red);
  Rectangle(x, GetMaxY - bhs, x + bws, GetMaxY);
end;
procedure QuickSort(var arr: array of Integer; l, r: Integer);
var i, j, pivot, temp: Integer;
begin
  if l >= r then Exit;
  pivot := arr[(l + r) div 2];
  i := l; j := r;
  while i <= j do
  begin
    while arr[i] < pivot do inc(i);
    while arr[j] > pivot do dec(j);
    if i <= j then
    begin
      temp := arr[i]; arr[i] := arr[j]; arr[j] := temp;
      viv(i, arr[i]); viv(j, arr[j]);
      inc(i); dec(j);
    end;
  end;
  QuickSort(arr, l, j);
  QuickSort(arr, i, r);
end;
begin
  ClrScr; n := 78;
  SetLength(nu, n); Randomize;
  for i := 0 to n - 1 do nu[i] := i + 1;
  for i := 0 to n - 1 do begin j := Random(n); temp := nu[i]; nu[i] := nu[j]; nu[j] := temp; end;
  gd := Detect; InitGraph(gd, gm, ''); if GraphResult <> grOk then Halt(1);
  sp := 3; bws := (GetMaxX - (n + 1) * sp) div n; if bws < 1 then bws := 1;
  for i := 0 to n - 1 do viv(i, nu[i]);
  QuickSort(nu, 0, n - 1);
  Readln; CloseGraph;
end.
}
