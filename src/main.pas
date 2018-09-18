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
    LabelInfo: TLabel;
    LabelPendingTime: TLabel;
    PanelPomodoro: TPanel;
    PomodoroTimer: TTimer;
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
  PendingSeconds: integer;
begin
  if LabelPendingTime.Caption = Pomodoro.GetFormattedTime then
    Exit;

  LabelPendingTime.Caption := Pomodoro.GetFormattedTime;
  LabelInfo.Caption := Pomodoro.GetStatus;
  Caption := Pomodoro.GetTitle;

  PendingSeconds := Pomodoro.GetPendingSeconds;
  if PendingSeconds >= 0 then
    Exit;

  BgColor := DEFAULT_BG;
  FgColor := DEFAULT_FG;
  if PendingSeconds mod 2 <> 0 then
  begin
    BgColor := ALERT_BG;
    FgColor := ALERT_FG;
  end;

  FormPomodoro.Color := BgColor;
  LabelPendingTime.Font.Color := FgColor;
  LabelInfo.Font.Color := FgColor;
end;

procedure TFormPomodoro.ResetClick(Sender: TObject);
begin
  if Pomodoro.GetPendingSeconds > 0 then
    Exit;
  Pomodoro.StartNewPomodoro;
  FormPomodoro.Color := DEFAULT_BG;
  LabelPendingTime.Font.Color := DEFAULT_FG;
  LabelInfo.Font.Color := DEFAULT_FG;
end;

end.