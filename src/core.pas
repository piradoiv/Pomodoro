unit Core;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math, StrUtils, DateUtils;

const
  SECONDS_PER_POMODORO = 1500;

type
  { TPomodoro }

  TPomodoro = class
  private
    FCurrentPomodoro: integer;
    FStartTime: TDateTime;
    function PrepareDigits(Digits: integer): string;
  public
    constructor Create;
    procedure StartNewPomodoro;
    function GetFormattedTime: string;
    function GetPendingSeconds: integer;
    function GetStatus: string;
    function GetTitle: string;
  end;

implementation

{ TPomodoro }

constructor TPomodoro.Create;
begin
  StartNewPomodoro;
end;

procedure TPomodoro.StartNewPomodoro;
begin
  FStartTime := Now;
  Inc(FCurrentPomodoro);
end;

function TPomodoro.GetFormattedTime: string;
var
  SecondsPending, Minutes, Seconds: integer;
begin
  SecondsPending := GetPendingSeconds;
  DivMod(SecondsPending, 60, Minutes, Seconds);
  Result := Concat(PrepareDigits(Minutes), ':', PrepareDigits(Seconds));
  if SecondsPending < 0 then
    Result := Concat('-', Result);
end;

function TPomodoro.GetPendingSeconds: integer;
begin
  Result := SECONDS_PER_POMODORO - SecondsBetween(Now, FStartTime);
end;

function TPomodoro.PrepareDigits(Digits: integer): string;
begin
  if Digits < 0 then
    Digits := -Digits;
  Result := AddChar('0', IntToStr(Digits), 2);
end;

function TPomodoro.GetStatus: string;
begin
  Result := 'Focus on your task';
  if GetPendingSeconds < 0 then
    Result := 'Take a break, click to continue';
end;

function TPomodoro.GetTitle: string;
begin
  Result := Format('Pomodoro #%d', [FCurrentPomodoro]);
end;

end.
