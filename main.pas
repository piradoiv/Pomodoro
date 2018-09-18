unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Core;

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
  public

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
  LabelPendingTime.Caption := Pomodoro.GetFormatted;
  if Pomodoro.GetPendingSeconds >= 0 then
    Exit;

  BgColor := clDefault;
  FgColor := clDefault;
  if Pomodoro.GetPendingSeconds mod 2 <> 0 then
  begin
    BgColor := clRed;
    FgColor := clWhite;
  end;

  FormPomodoro.Color := BgColor;
  LabelPendingTime.Font.Color := FgColor;
end;

procedure TFormPomodoro.ResetClick(Sender: TObject);
begin
  Caption := Format('Pomodoro #%d', [Pomodoro.CurrentPomodoro]);
  if Pomodoro.GetPendingSeconds > 0 then
    Exit;
  Pomodoro.StartNewPomodoro;
  FormPomodoro.Color := clDefault;
  LabelPendingTime.Font.Color := clDefault;
end;

end.
