unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Core;

const
  DEFAULT_BG = clDefault;
  DEFAULT_FG = clDefault;
  ALERT_BG = clRed;
  ALERT_FG = clWhite;

type

  { TFormPomodoro }

  TFormPomodoro = class(TForm)
    LabelPendingTime: TLabel;
    PomoTimer: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure OnTickHandler(Sender: TObject);
    procedure ResetClick(Sender: TObject);
  private
    Pomodoro: TPomodoro;
  end;

var
  FormPomodoro: TFormPomodoro;

implementation

{$R *.lfm}

{ TFormPomodoro }

procedure TFormPomodoro.FormCreate(Sender: TObject);
begin
  Pomodoro := TPomodoro.Create;
  ResetClick(Self);
end;

procedure TFormPomodoro.OnTickHandler(Sender: TObject);
var
  BgColor, FgColor: TColor;
begin
  LabelPendingTime.Caption := Pomodoro.GetFormattedTime;
  if Pomodoro.GetPendingSeconds >= 0 then
    Exit;

  BgColor := DEFAULT_BG;
  FgColor := DEFAULT_FG;
  if Pomodoro.GetPendingSeconds mod 2 <> 0 then
  begin
    BgColor := ALERT_BG;
    FgColor := ALERT_FG;
  end;

  FormPomodoro.Color := BgColor;
  LabelPendingTime.Font.Color := FgColor;
end;

procedure TFormPomodoro.ResetClick(Sender: TObject);
begin
  Caption := Pomodoro.GetTitle;
  if Pomodoro.GetPendingSeconds > 0 then
    Exit;
  Pomodoro.StartNewPomodoro;
  FormPomodoro.Color := DEFAULT_BG;
  LabelPendingTime.Font.Color := DEFAULT_FG;
end;

end.
