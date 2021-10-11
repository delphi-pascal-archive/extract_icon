unit UExtractIcon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ShellApi, ExtCtrls, ComCtrls, Buttons;

type
  TFormExtractIcon = class(TForm)
    BitBtnOpen: TBitBtn;
    BitBtnSave: TBitBtn;
    ButtonReLoad: TButton;
    UpDownIconIndex: TUpDown;
    OpenDialogIcon: TOpenDialog;
    SaveDialogIcon: TSaveDialog;
    ImageIcon: TImage;
    EditIconIndex: TEdit;
    LabelIconIndex: TLabel;
    LabelIcon: TLabel;
    LabelFileName: TLabel;
    BevelIcon: TBevel;
    procedure OpenIconClick(Sender: TObject);
    procedure SaveIconClick(Sender: TObject);
    procedure LoadIconFromFile;
    procedure ButtonReLoadClick(Sender: TObject);
    procedure EditIconIndexKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormExtractIcon: TFormExtractIcon;

implementation

{$R *.DFM}

{ExtractIconResInfo}

var
  Bitmap   : TBitmap;
  IconSave : TIcon;
  FullDir  : String;
  IconIndex: Word;

procedure TFormExtractIcon.LoadIconFromFile;
var
  Pch: array[0..256] of Char;
  IconExtr: HIcon;
begin
  IconIndex := StrToInt(EditIconIndex.Text);
  FullDir := OpenDialogIcon.FileName;
  StrPCopy(Pch,FullDir);
  IconExtr := ExtractAssociatedIcon(hInstance,Pch,IconINdex);
  IconSave.Handle := IconExtr;
  Bitmap.Width := IconSave.Width;
  Bitmap.Height := IconSave.Height;
  Bitmap.Canvas.Draw(0, 0, IconSave);
  ImageIcon.Picture.Icon := IconSave;
  BitBtnSave.Enabled := True;
  ButtonReLoad.Enabled := True;
  LabelFileName.Caption := 'Τΰιλ: '+ExtractFileName(FullDir);
  SaveDialogIcon.InitialDir := ExtractFilePath(FullDir);
  SaveDialogIcon.FileName := '';
end;

procedure TFormExtractIcon.OpenIconClick(Sender: TObject);
begin
  if OpenDialogIcon.Execute then
    LoadIconFromFile;
end;

procedure TFormExtractIcon.SaveIconClick(Sender: TObject);
const
  SaveBoolean:Boolean = False;
begin
{SaveDialogIcon.FileName := ChangeFileExt(ExtractFileName(FullDir),'');}
  if SaveDialogIcon.Execute then begin
    case SaveDialogIcon.FilterIndex of
      1: IconSave.SaveToFile(ChangeFileExt(SaveDialogIcon.FileName,'.ico'));
      2: Bitmap.SaveToFile(ChangeFileExt(SaveDialogIcon.FileName,'.bmp'));
    end;
    SaveDialogIcon.InitialDir := ExtractFilePath(SaveDialogIcon.FileName);
  end;
end;

procedure TFormExtractIcon.ButtonReLoadClick(Sender: TObject);
begin
  LoadIconFromFile;
end;

procedure TFormExtractIcon.EditIconIndexKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9',#8]) then
    key := #0;
end;

procedure TFormExtractIcon.FormActivate(Sender: TObject);
begin
//  IconSave.Free;
  IconSave := TIcon.Create;
//  Bitmap.Free;
  Bitmap := TBitmap.Create;
end;

end.
