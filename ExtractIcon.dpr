program ExtractIcon;

uses
  Forms,
  UExtractIcon in 'UExtractIcon.pas' {FormExtractIcon};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '���������� ������';
  Application.CreateForm(TFormExtractIcon, FormExtractIcon);
  Application.Run;
end.
