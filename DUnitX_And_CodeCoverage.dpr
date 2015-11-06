program DUnitX_And_CodeCoverage;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}

{$R *.res}

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Windows.Console,
  DUnitX.Loggers.XML.NUnit,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  System.SysUtils,
  Core.Card in 'Core\Core.Card.pas',
  Core.CardTests in 'Tests\Core.CardTests.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  try
    TestInsight.DUnitX.RunRegisteredTests;
  except
    on e : Exception do
    begin
      Writeln(e.Message);
      ReadLn;
    end;
  end;

  exit;
{$ENDIF}
  try
    try
      //Create the runner
      TDUnitX.CheckCommandLine;
      runner := TDUnitX.CreateRunner;
      runner.UseRTTI := True;
      runner.FailsOnNoAsserts := true;

      //tell the runner how we will log things
      logger := TDUnitXConsoleLogger.Create(false);
      runner.AddLogger(logger);
      nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
      runner.AddLogger(nunitLogger);

      //Run tests
      results := runner.Execute;

      //Let the CI Server know that something failed.
      if results.AllPassed then
        System.ExitCode := 0
      else
        System.ExitCode := EXIT_ERRORS;

      System.Writeln;
    except
      on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
    end;

  finally
    {$IFNDEF CI}
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  end;
end.
