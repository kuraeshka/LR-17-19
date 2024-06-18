unit calculatorunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  TCalculatorOperation = (None, Equal, Add, Subtract, Multiplication, Division,
                       Percentage, Stepen, KOPEN,Znamen);

  TCalculator = class
  private
    DisplayText: string;
    CurrentInput: string;
    LastResult: string;
    ResultShown:Boolean;
    LastOperator:TCalculatorOperation;
  public
    constructor Create;
    procedure SendInput(Input:string);
    procedure InputNumber(Number:string);
    procedure AddOperator(Operation: TCalculatorOperation);
    function GetDisplay:string;
    procedure Clear;
    procedure AllClear;
    procedure Backspace;
  end;


implementation

constructor TCalculator.Create;
begin
  AllClear;
end;

procedure TCalculator.SendInput(Input: string);
begin
  case Input of
    '0' .. '9': InputNumber(Input);
    '.': InputNumber(Input);
    '+': AddOperator(TCalculatorOperation.Add);
    '-': AddOperator(TCalculatorOperation.Subtract);
    '*', '×': AddOperator(TCalculatorOperation.Multiplication);
    '/', '÷': AddOperator(TCalculatorOperation.Division);
    '=': AddOperator(TCalculatorOperation.Equal);
    'C': Clear;
    'CE': AllClear;
    '←': Backspace;
    'I/x': AddOperator(TCalculatorOperation.Znamen);
    'x^2': AddOperator(TCalculatorOperation.Stepen);
    'KOP': AddOperator(TCalculatorOperation.Kopen);
  else
      //
  end;
end;

procedure TCalculator.InputNumber(Number: string);
begin
  if LastResult='Ноуп' then LastResult:=Number;
  if (Pos('.', CurrentInput)<>0) and (Number = '.') then Exit;
  if StrToFloat(LastResult)=0 then if (Number='.') then Number:='0';

  end else begin
  if Number='.' then Number:=',';
  if ResultShown then
      CurrentInput:=Number
    else
      CurrentInput:=CurrentInput+Number;
  end;

  DisplayText:=CurrentInput;
  ResultShown:=False;
end;

procedure TCalculator.AddOperator(Operation: TCalculatorOperation);
begin
  if Operation = TCalculatorOperation.Equal then begin
    if LastOperator = TCalculatorOperation.Add then
      if LastResult='Ноуп' then LastResult:='Ноуп' else
      LastResult:= floattostr( StrToFloat(LastResult) + StrToFloat(CurrentInput) )
    else if LastOperator = TCalculatorOperation.Subtract then
      if LastResult='Ноуп' then LastResult:='Ноуп' else
      LastResult:= floattostr( StrToFloat(LastResult) - StrToFloat(CurrentInput) )
    else if LastOperator = TCalculatorOperation.Multiplication then
      if LastResult='Ноуп' then LastResult:='Ноуп' else
      LastResult:= floattostr( StrToFloat(LastResult) * StrToFloat(CurrentInput) )
    else if LastOperator = TCalculatorOperation.Division then
      if StrToFloat(CurrentInput)=0 then LastResult:='Ноуп' else
      if LastResult='Ноуп' then LastResult:='Ноуп' else
      LastResult:= floattostr( StrToFloat(LastResult) / StrToFloat(CurrentInput) )
    else if LastOperator = TCalculatorOperation.Stepen then
    if LastResult='Ноуп' then LastResult:='Ноуп' else
    if StrToFloat(LastResult)>999999999999999999999999999999999999 then LastResult:='Ноуп' else
      LastResult:= floattostr(StrToFloat(LastResult) * StrToFloat(LastResult) )
    else if LastOperator = TCalculatorOperation.Kopen then
    if LastResult='Ноуп' then LastResult:='Ноуп' else
      LastResult:= floattostr(sqrt(StrToFloat(LastResult)))
    else if LastOperator = TCalculatorOperation.Znamen then
    if StrToFloat(LastResult)=0 then LastResult:='Ноуп' else
    if LastResult='Ноуп' then LastResult:='Ноуп' else
      LastResult:= floattostr(1 / StrToFloat(LastResult))
    ;
    CurrentInput:=LastResult;
    LastOperator:=TCalculatorOperation.None;
    ResultShown:=True;
  end else if Operation = TCalculatorOperation.Percentage then begin
    LastResult := floattostr( StrToFloat(LastResult) * ( StrToFloat(CurrentInput) / 100 ) );
    CurrentInput := LastResult;
    DisplayText := LastResult;
    ResultShown := true;
  end else if LastOperator <> TCalculatorOperation.None then begin
    AddOperator(TCalculatorOperation.Equal);
    AddOperator(Operation);
  end else begin
    // Двойное нажатие
    LastOperator := Operation;
    LastResult := CurrentInput;
    DisplayText := CurrentInput;
    CurrentInput := '0';
  end;
end;

function TCalculator.GetDisplay: string;
begin
  if ResultShown then
    Result := LastResult
  else
    Result := DisplayText;
end;

procedure TCalculator.Clear;
begin
  CurrentInput:='0';
  DisplayText:='0';
end;

procedure TCalculator.AllClear;
begin
  Clear;
  LastResult:='0';
  ResultShown:=false;
  LastOperator:=TCalculatorOperation.None;
end;

procedure TCalculator.Backspace;
begin
  // удалить последний элемент
  if ResultShown then Exit;

  if Length(CurrentInput) > 1 then
    CurrentInput:=Copy(CurrentInput,0,Length(CurrentInput)-1)
  else
    CurrentInput:='0';
  DisplayText:=CurrentInput;
end;

end.

