program Pomodoro;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces,
  Forms, main, Core;

{$R *.res}

begin
  Application.Title:='Pomodoro';
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TFormPomodoro, FormPomodoro);
  Application.Run;
end.

