//intarpritattor
uses crt;
var
k, cod, rez, a, b, i: integer;
s, temp, left, right: string;
begin
readln(s);
while pos('*', s) > 0 do
begin
k := pos('*', s);
i := k - 1;
while (i > 0) and ((s[i] >= '0') and (s[i] <= '9') or (s[i] = '-')) do
dec(i);
left := copy(s, i + 1, k - i - 1);
i := k + 1;
while (i <= length(s)) and (s[i] >= '0') and (s[i] <= '9') do
inc(i);
right := copy(s, k + 1, i - k - 1);
val(left, a, cod);
val(right, b, cod);
delete(s, pos(left, s), length(left) + 1 + length(right));
str(a * b, temp);
insert(temp, s, k - length(left));
writeln(s);
end;
writeln('zirochka: ', s); rez := 0;
while length(s) > 0 do begin k := 1;
while (k <= length(s)) and ((s[k] >= '0') and (s[k] <= '9') or ((k = 1) and (s[k] = '-'))) do inc(k);
temp := copy(s, 1, k - 1); delete(s, 1, k - 1); val(temp, a, cod); rez := rez + a;
if (length(s) > 0) and (s[1] in ['+', '-']) then delete(s, 1, 1);
end;
writeln('plus minus: ', rez); readln;
end.


//plusminus



var k,a,cod,rez:integer; s,s1:string; 
begin 
  readln(s); 
  n:=length(s); 
  while n>1 do 
  begin 
    k:=1; 
    while ((s[k]<>'+') and (s[k]<>'-')) do inc(k); 
    s1:=copy(s,1,k-1); 
    delete(s,1,k); 
    val(s1,a,cod); 
    if s[k-1]='+' then rez:=rez+a else rez:=rez-a; 
  end; 
  writeln(rez); 
end.



//zirka

var kl,kp,a,b,c,cod,rez,p:integer; s,s1,s2:string; 
begin 
  readln(s); 
  p:=pos('*',s); 
  while p>0 do 
  begin 
    kl:=p-1; 
    while (kl>0) and (s[kl] in ['0'..'9']) do dec(kl); 
    s1:=copy(s,kl+1,p-kl-1); 
    kp:=p+1; 
    while (kp<=length(s)) and (s[kp] in ['0'..'9']) do inc(kp); 
    s2:=copy(s,p+1,kp-p-1); 
    val(s1,a,c); val(s2,b,c); 
    delete(s,kl+1,kp-kl-1); 
    insert(inttostr(a*b),s,kl+1); 
    p:=pos('*',s); 
  end; 
  writeln(s); 
end.
