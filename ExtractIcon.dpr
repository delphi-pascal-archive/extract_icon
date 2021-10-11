program ExtractIcon;

uses
  Forms,
  UExtractIcon in 'UExtractIcon.pas' {FormExtractIcon};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Извлечение иконок';
  Application.CreateForm(TFormExtractIcon, FormExtractIcon);
  Application.Run;
end.
