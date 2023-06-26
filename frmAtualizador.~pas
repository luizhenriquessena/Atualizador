unit frmAtualizador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, IniFiles, ShellAPI;

type
  TfrmPrincipal = class(TForm)
    pnl1: TPanel;
    lbl4: TLabel;
    lbl1: TLabel;
    img1: TImage;
    lbl5: TLabel;
    procedure CopiarNovaVersao(Local, Servidor: string);
    function  ValidaArquivos(Local, Servidor:String): Boolean;
    function  GetCaminhoIniFile:String;
    function  CopyData(const fromDir, toDir: string): Boolean;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;
  execFechar, Local, Servidor, Servidor2 : String;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmPrincipal.CopiarNovaVersao(Local, Servidor: string);
var
  data : String;
begin
 DeleteFile(Local+'_OLD');
 data := FormatDateTime('dd',Now) + '_' + FormatDateTime('mm',Now) + '_' + FormatDateTime('yyyy',Now) + '_' + FormatDateTime('hh',Now) + '_' + FormatDateTime('nn',Now) + '_' + FormatDateTime('ss',Now);
 if RenameFile(Local,(Local+'_OLD')) then
 begin
   if not CopyData(Servidor, Local) then
   begin
    ShowMessage('Não foi possivel Copiar o arquivo.');
    Application.Terminate;
   end else
   begin
   ShellExecute(Handle,'open',pchar(Local),nil,nil,sw_show);
   end;
 end;
 Application.Terminate;
end;

function TfrmPrincipal.CopyData(const fromDir, toDir: string): Boolean;
var
  fos: TSHFileOpStruct;
begin
  ZeroMemory(@fos, SizeOf(fos));
  with fos do
  begin
    wFunc  := FO_COPY;
    fFlags := {FOF_SILENT or} FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR;
    pFrom  := PChar(fromDir + #0);
    pTo    := PChar(toDir);
  end;
  Result := (0 = ShFileOperation(fos));
end;

function TfrmPrincipal.GetCaminhoIniFile: String;
begin
  result:= ExtractFileDir(Application.ExeName)+'\ConfigArquivos.ini';
end;

function TfrmPrincipal.ValidaArquivos(Local, Servidor: String): Boolean;
begin
  result:=True;
   //verifica se se o arquivo local existe
   if not FileExists(Local) then
   begin
       Application.MessageBox(Pchar('O arquivo local não foi encontrado.'+#13+Local), 'Atenção', MB_OK+MB_ICONEXCLAMATION);
       result :=False;
   end else
   //verifica se o arquivo remoto existe
   if not FileExists(Servidor) then
   begin
       Application.MessageBox(Pchar('O arquivo Remoto não foi encontrado.'+#13+Servidor), 'Atenção', MB_OK+MB_ICONEXCLAMATION);
       result :=False;
   end;
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
var
ini : TIniFile;
begin
  ini      := TIniFile.Create(GetCaminhoIniFile);
  Local    := ini.ReadString('ARQUIVOS', 'dirLocal', '') + ini.ReadString('ARQUIVOS', 'exec', '');
  Servidor := ini.ReadString('ARQUIVOS', 'dirRemoto', '') + ini.ReadString('ARQUIVOS', 'exec', '');
  Servidor2 := ini.ReadString('ARQUIVOS', 'dirRemoto2', '') + ini.ReadString('ARQUIVOS', 'exec', '');


  if FileExists(Servidor) then
  begin
    CopiarNovaVersao(Local, Servidor);
  end else
  begin
    CopiarNovaVersao(Local, Servidor2);
  end;
end;

end.
