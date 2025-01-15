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














{massiv iz sliv ryadka}
Var
S:string;
a_s:array[1..100] of string;
k,i,j:byte;
begin
writeln('S?');
readln(s); s:=s+'';
i:=1;
k:=0;
for j:=1 to length(s) do
    if s[j]=' ' then k:=k+1
    else
    begin
        a_s[i]:=copy(s,j-k,k);
        i:=i+1;
        k:=0
    end;
for j:=1 to i do write(a_s[j],';')
end.

{naidovshe slovo u reccheniy}
var s:string;
Function MaxW(r:string):string;
var i,k,m:integer;
begin
    k:=0; m:=0;
    for i:=1 to length(r) do
        if r[i]=' ' then k:=k+1 else begin if k>m then begin m:=k; MaxW:=Copy(r,i-k,k);end;
            k:=0;
        end
end
begin repeat writeln('rechenya?'); readln(s); s:=s+' '; writeln(MaxW(s)) until s=' '
end.

{perevirka pravilnosti rozstanovki ()  }
var s:string;
function Pr(string):boolean;
var i,k:integer;
begin
    P:=true; k:=0; i:=0;
    repeat
        i:=i+1;
        if R[i]='(' then k:=k+1 else k:=k-1;
        until (i=length(r))or(k<0);
    if k<>0 then P:=false
end;
begin readln(s); writeln(Pr)end.

{Dovjina kojnogo slova u recchenyi}
var s:string;
Procedure LW(r:string);
var i,k:integer;
begin
    k:=0;
    for i:=1 to length(r) do
        if r[i]=' ' then k:=k+1
        else begin write(k,k,' ');k:=0end
end
begin
    repeat
        writeln('rechenya?'); readln(s); s:=s+' '; LW(s)
    until s=' '
end.

{viluchenya zaivih progalyn}
var
s:string;
procedure Del_P(var R:string);
var
    p:byte;
begin
    p:=Pos(' ',R);
    while p>0 do
    begin
        delete(R,p,1); p:=Pos(' ',R);
    end;
end;
begin
    repeat
        writeln('????');readln(s);Del_P(s);
        writeln(s)
    until s=''
end.

{vivesty z rechenya slova v yakih povtor ostanya litera}
var
    s:string;
function PS(s1:string):boolean;
var
    i,L:longint;
begin
    L:=length(s1);
    PS:=false;
    for i:=1 to L -1 do
        if s1[i]=s1[L] then PS:=true;
end;
procedure slovo(str:string);
var
    i,k:longint;
    s1:string;
begin
    k:=0;
    for i:=1 to length(str) do
        if str[i]=' ' then k:=k+1
        else
        begin
            s1:=copy(str,i-k,k);
            if PS(s1) then write(s1,';');
            k:=0;
        end;
end;
begin
    repeat
        writeln('rechenya?');
        readln(s); s:=s+' ';
        slovo(s);
    until s=' ';
end.

{zamina po kontekstu}
Var 
S,S1,S2:string;
procedure Zam(var R,R1,R2:string);
var p:byte;
begin
    p:=Pos(R1,R);
    while p>0 do
    begin
        delete(R,p,length(R1));
        insert(R2,R,p); p:=Pos(R1,R);
    end;
end;
begin
    repeat
        writeln('ryadok: ');readln(s);
        writeln('scho zaminity: ');readln(s1);
        writeln('na scho same zaminity: ');readln(s2);
        Zam(s,s1,s2); writeln(s)
    until s=' '
end.

{slova palindorm}
var
    s:string;
function PS(s1:string):boolean;
var
    i,L:longint;
begin
    L:=length(s1);
    PS:=true;
    for i:=1 to L div 2 do
        if s1[i]<>s1[L-i+1] then PS:=false;
end;
procedure slovo(str:string);
var
    i,k:longint;
    s1:string;
begin
    k:=0;
    for i:=1 to length(str) do
        if str[i]=' ' then k:=k+1
        else
        begin
            s1:=copy(str,i-k,k);
            if PS(s1) then write(s1,';');
            k:=0;
        end;
end;
begin
    repeat
        writeln('string?');
        readln(s); s:=s+' ';
        slovo(s);
    until s=' ';
end.
