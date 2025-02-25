uses
  Graph, Crt, SysUtils;

const
  CellSize  = 10;
  GridRows  = 40;
  GridCols  = 40;
  DelayTime = 100;
  ScoreX = (GridCols + 2) * CellSize;
  ScoreY = 20;

var
  Field: array[1..GridRows, 1..GridCols] of Integer;
  tailRows, tailCols: array[1..1000] of Integer;
  tailCount, i, j, gd, gm: Integer;
  currentRow, currentCol: Integer;
  foodSpawnRate: Integer;
  dRow, dCol: Integer;
  score: Integer;
  ch: char;
  gameOver: Boolean;

procedure DrawCell(row, col, color: Integer);
begin
  SetFillStyle(SolidFill, color);
  Bar((col - 1) * CellSize, (row - 1) * CellSize, col * CellSize, row * CellSize);
  SetColor(Black);
  Rectangle((col - 1) * CellSize, (row - 1) * CellSize, col * CellSize, row * CellSize);
end;

procedure DrawGrid;
begin
  for i := 1 to GridRows do
    for j := 1 to GridCols do
    begin
      Field[i, j] := 0;
      DrawCell(i, j, LightGray);
    end;
end;

procedure SpawnFood;
var
  f, row, col: Integer;
begin
  for f := 1 to foodSpawnRate do
  begin
    repeat
      row := Random(GridRows) + 1;
      col := Random(GridCols) + 1;
    until Field[row, col] = 0;
    Field[row, col] := 9;
    DrawCell(row, col, Red);
  end;
end;

procedure ShowScore;
var
  scoreText: string;
begin
  SetFillStyle(SolidFill, Black);
  Bar(ScoreX - 10, 0, ScoreX + 150, ScoreY + 30);
  
  scoreText := 'Score: ' + IntToStr(score);
  SetColor(White);
  SetTextStyle(DefaultFont, HorizDir, 2);
  OutTextXY(ScoreX, ScoreY, scoreText);
end;

procedure InitGame;
begin
  DrawGrid;
  score := 0;
  tailCount := 0;
  foodSpawnRate := 1;
  gameOver := False;
  
  ShowScore;

  currentRow := GridRows div 2;
  currentCol := GridCols div 2;
  dRow := 0;
  dCol := 1;
  Field[currentRow, currentCol] := 2;
  DrawCell(currentRow, currentCol, Yellow);
  
  SpawnFood;
end;

procedure ShowGameOver;
begin
  SetColor(Red);
  SetTextStyle(DefaultFont, HorizDir, 3);
  OutTextXY(GridCols * CellSize div 2 - 100, GridRows * CellSize div 2, 'Game Over!');
  Delay(1000);
  // Затираємо напис Game Over
  SetFillStyle(SolidFill, Black);
  Bar(GridCols * CellSize div 2 - 100, GridRows * CellSize div 2 - 20, 
      GridCols * CellSize div 2 + 100, GridRows * CellSize div 2 + 20);
end;

begin
  Randomize;
  gd := Detect;
  InitGraph(gd, gm, '');
  
  repeat
    InitGame;
    
    while not gameOver do
    begin
      if KeyPressed then
      begin
        ch := ReadKey;
        if ch = #27 then
        begin
          CloseGraph;
          Exit;
        end;
        if ch = #0 then
        begin
          ch := ReadKey;
          case ch of
            #72: begin dRow := -1; dCol := 0; end;
            #80: begin dRow := 1; dCol := 0; end;
            #75: begin dRow := 0; dCol := -1; end;
            #77: begin dRow := 0; dCol := 1; end;
          end;
        end;
      end;
      
      tailCount := tailCount + 1;
      tailRows[tailCount] := currentRow;
      tailCols[tailCount] := currentCol;
      DrawCell(currentRow, currentCol, LightGreen);
      
      currentRow := currentRow + dRow;
      currentCol := currentCol + dCol;
      if currentRow < 1 then currentRow := GridRows;
      if currentRow > GridRows then currentRow := 1;
      if currentCol < 1 then currentCol := GridCols;
      if currentCol > GridCols then currentCol := 1;
      
      if Field[currentRow, currentCol] = 9 then
      begin
        score := score + 1;
        ShowScore;
        if (score mod 10 = 0) then
        begin
          foodSpawnRate := foodSpawnRate + 1;
        end;
        SpawnFood;
      end;
      
      if Field[currentRow, currentCol] = 2 then
      begin
        gameOver := True;
        ShowGameOver;
        Break;
      end;
      
      Field[currentRow, currentCol] := 2;
      DrawCell(currentRow, currentCol, Yellow);
      
      if tailCount > score + 1 then
      begin
        DrawCell(tailRows[1], tailCols[1], LightGray);
        Field[tailRows[1], tailCols[1]] := 0;
        for i := 1 to tailCount - 1 do
        begin
          tailRows[i] := tailRows[i + 1];
          tailCols[i] := tailCols[i + 1];
        end;
        Dec(tailCount);
      end;
      
      Delay(DelayTime);
    end;
    
  until False; // Безкінечний цикл, який переривається тільки по Escape
  
  CloseGraph;
end.