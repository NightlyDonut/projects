{

Inc(zminna [, znachennia])
Tut vykorystovuietsia Inc dlia zbil'shennia znachennia zminnoi. Yaksho parametr inkrementu ne vkazano, za zamovchuvanniam znachennia zbil'shuietsia na 1. 
Tse zruchnyi sposib shvydkoho prysvoiennia novoho znachennia (napryklad, inc(moveCount);).


Randomize
Vyklykaietsia dlia initsializatsii heneratora vypadkovykh chysel, vykorystovuiuchy systemnyi chas yak zerne. Tse zabezpechuie, shcho pry kozhnomu zapusku prohramy poslidovnist vypadkovykh chysel bude riznoi.

Random(verkhniaHranytsia)
Povertaiet vypadkove tsile chyslo vid 0 do (verkhniaHranytsia - 1). Vykorystovuietsia, napryklad, dlia vybory vypadkovoho indeksu u spyskakh dostupnykh pozytsii.

SetLength(masiv, novaDovzhyna)
Dynamichno zmieniaie rozmir masyvu. V prohrami yiei vykorystovuiutsia dlia zbil'shennia rozmir dynamicnykh masiviv (napryklad, pry nakopylennyi dostupnykh pozytsii chy znachen).

High(masiv)
Povertaiet naibil'shyi dopustymyi indeks u masyvi. Napryklad, temp[High(temp)] dozvoliaie otrymaty ostannii element dynamicnoho masyvu.

Length(masiv)
Povertaiet kilkist elementiv u masyvi. Tse dopomahaie vyznachyty, skilky elementiv naraz mistytsia u masyvi, ta vykorystovuietsia pry iteratsiiakh.

IntToStr(tsileChyslo)
Peretvoriie tsile chyslo u riadok, shcho zruchno dlia vyvedennia chyslovykh znachen (napryklad, znachen kliinky chy lichyl'nykiv peremoh/porazok) u hrafichnomu rezhymi.

Delay(milisekundy)
Prysupyniaie vykonannia prohramy na zadanu kilkist milisekund. Tse dozvoliaie, napryklad, zatrimaty pokaz povomlennia pro vyhrash chy prohrash.

KeyPressed ta ReadKey
 KeyPressed pereviriaie, chy bula natysnuta bud-iaka kliatsha.
 ReadKey zchytuie natysnutu kliatshu.
Zahalom tse zabezpechuie vzaiemodiiu z korystuvachom v osnovnomu tsykli hry.

Detect
Vykorystovuietsia dlia avtomatychnoho vyznachennia hrafichnoho draivera. Napryklad, komanda gd := Detect; vstanovliuie rezhym avto-detektsii pered initsializatsiieiu hrafiky.

InitGraph(draiver, rezhym, shliakh)
Initsializuie hrafichnyi rezhym iz zadanymy parametramy (draiver, rezhym ta shliakh do faiov draivera). Tse dozvoliaie uymknuty hrafichnyi rezhym dlia vidobrazhennia hry.

CloseGraph
Zavershuie robotu hrafichnoho rezhymu i povertaie prohramu do tekstovoho rezhymu pislia zavershennia roboty.

OutTextXY(x, y, tekst)
Vyvodiaie tekst na hrafichnomu ekrani za vkazanymy koordynatamy. Vykorystovuietsia dlia vidobrazhennia chyslovykh znachen ta lichyl'nykiv.

Bar(livo, verkh, pravo, nyz)
Maliuie zapovnenyi pryamokutnyk za zadanymy koordynatamy. Tse zastosovuietsia dlia stvorennia fonu kliinok chy inshykh elementiv interfeysui.

Rectangle(livo, verkh, pravo, nyz)
Maliuie pryamokutnyk (kontur) bez zapovnennia, shcho vykorystovuietsia dlia okreslennia mez kliinok chy ihrovoho poly.

SetFillStyle(stil, kolir)
Vstanovliuie stil zalyvky (napryklad, sucilna zalyvka) ta yiyi kolir, shcho vplyvaie na vzhliad zapovnenykh figur.

SetColor(kolir)
Vstanovliuie potochnyi kolir malyuvannia dlia tekstu, linii ta inshykh hrafichnykh obiektiv.

SetTextStyle(shrift, orientatsiia, rozmir)
Nalashtovuie stil tekstu (shrift, napriamok, rozmir), yakyi bude vykorystovuiutsia pry vyvedenni informatsii na ekrani.

}




uses Graph, Crt, SysUtils;
const
  CellSize = 100;
  GridRows = 3;
  GridCols = 6;
  BorderThreshold = 3;
var
  wins, losses, moveCount: Integer;
  gd, gm: Integer;
  i, j: Integer;
type
  TCell = record
    X, Y: Integer;
    Value: Integer;
  end;
var
  Field: array[1..GridRows,1..GridCols] of TCell;
function GetTileColor(val: Integer): Integer;
begin
  case val of
    2: GetTileColor := Yellow;
    4: GetTileColor := LightRed;
    2048: GetTileColor := Cyan;
  else
    GetTileColor := Green;
  end;
end;
procedure DrawCell(row, col: Integer);
var
  left, top: Integer;
  tileColor: Integer;
  txt: string;
begin
  left := (col - 1) * CellSize;
  top := (row - 1) * CellSize;
  if Field[row,col].Value = 0 then
  begin
    SetFillStyle(SolidFill, LightGray);
    Bar(left, top, left + CellSize, top + CellSize);
  end else
  begin
    tileColor := GetTileColor(Field[row,col].Value);
    SetFillStyle(SolidFill, tileColor);
    Bar(left, top, left + CellSize, top + CellSize);
    SetColor(Black);
    SetTextStyle(DefaultFont, HorizDir, 2);
    txt := IntToStr(Field[row,col].Value);
    OutTextXY(left + (CellSize div 2) - (Length(txt)*4), top + (CellSize div 2) - 10, txt);
  end;
  SetColor(Black);
  Rectangle(left, top, left + CellSize, top + CellSize);
end;
procedure DrawGrid;
begin
  for i := 1 to GridRows do
    for j := 1 to GridCols do
    begin
      Field[i,j].X := (j - 1) * CellSize;
      Field[i,j].Y := (i - 1) * CellSize;
      DrawCell(i,j);
    end;
  SetColor(Red);
  SetLineStyle(SolidLn, 0, 3);
  Rectangle(0, 0, GridCols * CellSize, GridRows * CellSize);
end;
procedure RedrawGrid;
begin
  for i := 1 to GridRows do
    for j := 1 to GridCols do
      DrawCell(i,j);
end;
procedure DrawCounter;
begin
  SetColor(White);
  SetFillStyle(SolidFill, Black);
  Bar(GridCols*CellSize + 10, 0, GridCols*CellSize + 200, 100);
  SetColor(White);
  SetTextStyle(DefaultFont, HorizDir, 2);
  OutTextXY(GridCols*CellSize + 20, 20, 'Wins:');
  OutTextXY(GridCols*CellSize + 20, 40, IntToStr(wins));
  OutTextXY(GridCols*CellSize + 20, 60, 'Losses:');
  OutTextXY(GridCols*CellSize + 20, 80, IntToStr(losses));
end;
procedure SpawnTile;
type
  TPos = record
    r, c: Integer;
  end;
var
  availableBorder, availableInterior: array of TPos;
  countBorder, countInterior: Integer;
  r, c, idx: Integer;
begin
  countBorder := 0;
  setlength(availableBorder, 0);
  for r := 1 to GridRows do
    for c := 1 to GridCols do
      if ((r = 1) or (r = GridRows) or (c = 1) or (c = GridCols)) and (Field[r,c].Value = 0) then
      begin
        inc(countBorder);
        setlength(availableBorder, countBorder);
        availableBorder[countBorder-1].r := r;
        availableBorder[countBorder-1].c := c;
      end;
  if countBorder < BorderThreshold then
  begin
    countInterior := 0;
    setlength(availableInterior, 0);
    for r := 2 to GridRows - 1 do
      for c := 2 to GridCols - 1 do
        if Field[r,c].Value = 0 then
        begin
          inc(countInterior);
          setlength(availableInterior, countInterior);
          availableInterior[countInterior-1].r := r;
          availableInterior[countInterior-1].c := c;
        end;
    if countInterior > 0 then
    begin
      idx := Random(countInterior);
      Field[availableInterior[idx].r, availableInterior[idx].c].Value := 2;
      DrawCell(availableInterior[idx].r, availableInterior[idx].c);
      Exit;
    end;
  end;
  if countBorder > 0 then
  begin
    idx := Random(countBorder);
    Field[availableBorder[idx].r, availableBorder[idx].c].Value := 2;
    DrawCell(availableBorder[idx].r, availableBorder[idx].c);
  end;
end;
procedure MoveLeft;
var
  row, col, pos: Integer;
  temp: array of Integer;
begin
  for row := 1 to GridRows do
  begin
    setlength(temp, 0);
    for col := 1 to GridCols do
      if Field[row,col].Value <> 0 then
      begin
        setlength(temp, length(temp)+1);
        temp[High(temp)] := Field[row,col].Value;
      end;
    col := 0;
    while col < Length(temp)-1 do
    begin
      if temp[col] = temp[col+1] then
      begin
        temp[col] := temp[col] * 2;
        for pos := col+1 to Length(temp)-2 do
          temp[pos] := temp[pos+1];
        SetLength(temp, Length(temp)-1);
        inc(col);
      end else inc(col);
    end;
    for col := 1 to GridCols do
      if col <= Length(temp) then
        Field[row,col].Value := temp[col-1]
      else
        Field[row,col].Value := 0;
  end;
end;
procedure MoveRight;
var
  row, col, pos: Integer;
  temp: array of Integer;
begin
  for row := 1 to GridRows do
  begin
    setlength(temp, 0);
    for col := GridCols downto 1 do
      if Field[row,col].Value <> 0 then
      begin
        setlength(temp, length(temp)+1);
        temp[High(temp)] := Field[row,col].Value;
      end;
    col := 0;
    while col < Length(temp)-1 do
    begin
      if temp[col] = temp[col+1] then
      begin
        temp[col] := temp[col] * 2;
        for pos := col+1 to Length(temp)-2 do
          temp[pos] := temp[pos+1];
        SetLength(temp, Length(temp)-1);
        inc(col);
      end else inc(col);
    end;
    for col := GridCols downto 1 do
      if (GridCols - col) < Length(temp) then
        Field[row,col].Value := temp[GridCols - col]
      else
        Field[row,col].Value := 0;
  end;
end;
procedure MoveUp;
var
  col, row, pos: Integer;
  temp: array of Integer;
begin
  for col := 1 to GridCols do
  begin
    setlength(temp, 0);
    for row := 1 to GridRows do
      if Field[row,col].Value <> 0 then
      begin
        setlength(temp, length(temp)+1);
        temp[High(temp)] := Field[row,col].Value;
      end;
    row := 0;
    while row < Length(temp)-1 do
    begin
      if temp[row] = temp[row+1] then
      begin
        temp[row] := temp[row] * 2;
        for pos := row+1 to Length(temp)-2 do
          temp[pos] := temp[pos+1];
        SetLength(temp, Length(temp)-1);
        inc(row);
      end else inc(row);
    end;
    for row := 1 to GridRows do
      if row <= Length(temp) then
        Field[row,col].Value := temp[row-1]
      else
        Field[row,col].Value := 0;
  end;
end;
procedure MoveDown;
var
  col, row, pos: Integer;
  temp: array of Integer;
begin
  for col := 1 to GridCols do
  begin
    setlength(temp, 0);
    for row := GridRows downto 1 do
      if Field[row,col].Value <> 0 then
      begin
        setlength(temp, length(temp)+1);
        temp[High(temp)] := Field[row,col].Value;
      end;
    row := 0;
    while row < Length(temp)-1 do
    begin
      if temp[row] = temp[row+1] then
      begin
        temp[row] := temp[row] * 2;
        for pos := row+1 to Length(temp)-2 do
          temp[pos] := temp[pos+1];
        SetLength(temp, Length(temp)-1);
        inc(row);
      end else inc(row);
    end;
    for row := GridRows downto 1 do
      if (GridRows - row) < Length(temp) then
        Field[row,col].Value := temp[GridRows - row]
      else
        Field[row,col].Value := 0;
  end;
end;
function Has2048: Boolean;
var
  r, c: Integer;
begin
  Has2048 := False;
  for r := 1 to GridRows do
    for c := 1 to GridCols do
      if Field[r,c].Value = 2048 then
      begin
        Has2048 := True;
        Exit;
      end;
end;
function IsBoardFull: Boolean;
var
  r, c: Integer;
begin
  IsBoardFull := True;
  for r := 1 to GridRows do
    for c := 1 to GridCols do
      if Field[r,c].Value = 0 then
      begin
        IsBoardFull := False;
        Exit;
      end;
end;
procedure ResetBoard;
begin
  for i := 1 to GridRows do
    for j := 1 to GridCols do
      Field[i,j].Value := 0;
  moveCount := 0;
  DrawGrid;
  DrawCounter;
end;
var
  ch: char;
begin
  Randomize;
  wins := 0;
  losses := 0;
  gd := Detect;
  InitGraph(gd, gm, '');
  ResetBoard;
  repeat
    if KeyPressed then
    begin
      case ReadKey of
        #0: begin
               case ReadKey of
                 #72: MoveUp;
                 #80: MoveDown;
                 #75: MoveLeft;
                 #77: MoveRight;
               end;
               inc(moveCount);
               if (moveCount mod 2 = 0) then SpawnTile;
               RedrawGrid;
               DrawCounter;
               if Has2048 then
               begin
                 wins := wins + 1;
                 OutTextXY(10, GridRows * CellSize + 10, '+1 won');
                 Delay(1000);
                 ResetBoard;
               end else if IsBoardFull then
               begin
                 losses := losses + 1;
                 OutTextXY(10, GridRows * CellSize + 10, '+1 lose');
                 Delay(1000);
                 ResetBoard;
               end;
             end;
        #27: break;
      end;
    end;
  until False;
  ReadKey;
  CloseGraph;
end.
