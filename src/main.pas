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
    procedure SetLabelsAndTitle;
    procedure SetColors;
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
  SetLabelsAndTitle;
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

procedure TFormPomodoro.OnTickHandler(Sender: TObject);
begin
  if LabelPendingTime.Caption = Pomodoro.GetFormattedTime then
    Exit;

  SetLabelsAndTitle;
  SetColors;
end;

procedure TFormPomodoro.SetLabelsAndTitle;
begin
  LabelPendingTime.Caption := Pomodoro.GetFormattedTime;
  LabelInfo.Caption := Pomodoro.GetStatus;
  Caption := Pomodoro.GetTitle;
end;

procedure TFormPomodoro.SetColors;
var
  BgColor, FgColor: TColor;
  PendingSeconds: integer;
begin
  PendingSeconds := Pomodoro.GetPendingSeconds;
  if PendingSeconds > 0 then
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

end.
