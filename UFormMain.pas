unit UFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Mask, JvExMask, JvToolEdit, FolderDialog, AdvSmoothTabPager,
  Vcl.Grids, JclStrings, System.IOUtils, AdvEdit, AdvEdBtn, AdvFileNameEdit,
  System.ImageList, Vcl.ImgList, Vcl.WinXCtrls, AdvObj, BaseGrid,
  System.Generics.Collections, System.UITypes, AdvSmoothMessageDialog,
  JvBaseDlg, JvBrowseFolder, JvSelectDirectory, JvGridFilter, AdvGrid;

type

  TFileRec = record
    SourcPath: String;
    TargetDir: String;
    Configurations: String;
    RemoteName: String;
  end;

  TFormMain = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    OpenDialog1: TOpenDialog;
    BAddFile: TButton;
    BAddFolder: TButton;
    ASPConf: TAdvSmoothTabPager;
    ASPPAndroid32: TAdvSmoothTabPage;
    ASPPAndroid64: TAdvSmoothTabPage;
    CBInclude: TCheckBox;
    CBConf: TComboBox;
    Label2: TLabel;
    BDelSel: TButton;
    BSave: TButton;
    BTransfer: TButton;
    FEProjFile: TAdvFileNameEdit;
    LERemName: TLabeledEdit;
    Button1: TButton;
    BSaveTargetDir: TButton;
    ImageList1: TImageList;
    BSaveRemName: TButton;
    SBSearch: TSearchBox;
    BNext: TButton;
    BPrevious: TButton;
    AdvSmoothMessageDialog1: TAdvSmoothMessageDialog;
    BRefresh: TButton;
    LETargetDir: TComboBox;
    Label1: TLabel;
    OpenDialog2: TOpenDialog;
    JvSelectDirectory1: TJvSelectDirectory;
    LEFilter: TLabeledEdit;
    CBFilterCol: TComboBox;
    Label3: TLabel;
    BClearFilter: TButton;
    SGAndroid32: TAdvStringGrid;
    SGAndroid64: TAdvStringGrid;
    BCompare: TButton;
    procedure BAddFileClick(Sender: TObject);
    procedure BAddFolderClick(Sender: TObject);
    procedure FEProjFileKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FEProjFileChange(Sender: TObject);
    procedure CBConfChange(Sender: TObject);
    procedure BDelSelClick(Sender: TObject);
    procedure CBIncludeClick(Sender: TObject);
    procedure BSaveClick(Sender: TObject);
    procedure BTransferClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BSaveTargetDirClick(Sender: TObject);
    procedure BSaveRemNameClick(Sender: TObject);
    procedure SBSearchInvokeSearch(Sender: TObject);
    procedure BPreviousClick(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure SGAndroid32SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SGAndroid64SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BRefreshClick(Sender: TObject);
    procedure ASPConfChange(Sender: TObject);
    procedure SBSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LEFilterChange(Sender: TObject);
    procedure BClearFilterClick(Sender: TObject);
    procedure CBFilterColChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BCompareClick(Sender: TObject);
  private
    procedure LoadFiles;
    procedure ShowASMDMessage(Mess: String);
    procedure AddMessButton(Capt: String; ButtRes: integer);
    procedure ApplyFilter;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;
  Andr32Items: TList<TFileRec>;
  Andr64Items: TList<TFileRec>;

implementation

{$R *.dfm}

uses UFCompare;

function IsFileInUse(FileName: TFileName): Boolean;
var
  HFileRes: HFILE;
begin
  Result := False;
  if not FileExists(FileName) then Exit;
  HFileRes := CreateFile(PChar(FileName),
                         GENERIC_READ or GENERIC_WRITE,
                         0,
                         nil,
                         OPEN_EXISTING,
                         FILE_ATTRIBUTE_NORMAL,
                         0);
  Result := (HFileRes = INVALID_HANDLE_VALUE);
  if not Result then
    CloseHandle(HFileRes);
end;

procedure TFormMain.ASPConfChange(Sender: TObject);
begin

   LETargetDir.Items.Clear;
   LETargetDir.Items.Add('.\');
   LETargetDir.Items.Add('.\res\xml');
   LETargetDir.Items.Add('.\assets');
   LETargetDir.Items.Add('.\res\raw');

   if ASPConf.ActivePage = ASPPAndroid32
   then
      begin
         LETargetDir.Items.Add('library\lib\armeabi-v7a');
      end
   else
      begin
         LETargetDir.Items.Add('library\lib\arm64-v8a');
      end;

   ApplyFilter;

end;

procedure TFormMain.BAddFileClick(Sender: TObject);

var
   Path: String;
   i: Integer;

begin

   if OpenDialog1.Execute
   then
      begin

         if Pos(ExtractFilePath(FEProjFile.Text), OpenDialog1.FileName) > 0
         then
            Path := StrAfter(ExtractFilePath(FEProjFile.Text), OpenDialog1.FileName)
         else
            Path := OpenDialog1.FileName;

         if ASPConf.ActivePage = ASPPAndroid32
         then
            begin

                for i := 0 to SGAndroid32.RowCount - 1 do
                  if SGAndroid32.Cells[0, i] = Path
                  then
                     begin
                        ShowASMDMessage('File already added');
                        Exit;
                     end;

               if SGAndroid32.Cells[0, SGAndroid32.RowCount - 1] <> ''
               then
                  SGAndroid32.RowCount := SGAndroid32.RowCount + 1;

               SGAndroid32.ScrollBy(0, 9999);
               SGAndroid32.Row := SGAndroid32.RowCount - 1;
               SGAndroid32.Cells[0, SGAndroid32.RowCount - 1] := Path;
               SGAndroid32.Cells[1, SGAndroid32.RowCount - 1] := '.\';
               SGAndroid32.Cells[2, SGAndroid32.RowCount - 1] := 'False';
               SGAndroid32.Cells[3, SGAndroid32.RowCount - 1] := 'All';
               SGAndroid32.Cells[4, SGAndroid32.RowCount - 1] := ExtractFileName(OpenDialog1.FileName);

            end
         else
            begin

                for i := 0 to SGAndroid64.RowCount - 1 do
                  if SGAndroid64.Cells[0, i] = Path
                  then
                     begin
                        ShowASMDMessage('File already added');
                        Exit;
                     end;

               if SGAndroid64.Cells[0, SGAndroid64.RowCount - 1] <> ''
               then
                  SGAndroid64.RowCount := SGAndroid64.RowCount + 1;

               SGAndroid64.ScrollBy(0, 9999);
               SGAndroid64.Row := SGAndroid64.RowCount - 1;
               SGAndroid64.Cells[0, SGAndroid64.RowCount - 1] := Path;
               SGAndroid64.Cells[1, SGAndroid64.RowCount - 1] := '.\';
               SGAndroid64.Cells[2, SGAndroid64.RowCount - 1] := 'False';
               SGAndroid64.Cells[3, SGAndroid64.RowCount - 1] := 'All';
               SGAndroid64.Cells[4, SGAndroid64.RowCount - 1] := ExtractFileName(OpenDialog1.FileName);

            end;

         CBInclude.Enabled := False;
         CBInclude.Checked := False;
         LERemName.Enabled := True;

         CBConf.ItemIndex := CBConf.Items.IndexOf('All');
         LETargetDir.Text := '.\';

      end;

   LEFilter.Text := '';
   ApplyFilter;

end;

procedure TFormMain.BAddFolderClick(Sender: TObject);

var
   Path: String;
   i: Integer;

begin

   JvSelectDirectory1.InitialDir := ExtractFilePath(FEProjFile.Text);

   if JvSelectDirectory1.Execute
   then
      begin

         if Pos(ExtractFilePath(FEProjFile.Text), JvSelectDirectory1.Directory) > 0
         then
            Path := StrAfter(ExtractFilePath(FEProjFile.Text), JvSelectDirectory1.Directory)
         else
            Path := JvSelectDirectory1.Directory;

         if ASPConf.ActivePage = ASPPAndroid32
         then
            begin

               for i := 0 to SGAndroid32.RowCount - 1 do
                  if SGAndroid32.Cells[0, i] = Path
                  then
                     begin
                        ShowASMDMessage('Folder already added');
                        Exit;
                     end;

               if SGAndroid32.Cells[0, SGAndroid32.RowCount - 1] <> ''
               then
                  SGAndroid32.RowCount := SGAndroid32.RowCount + 1;

               SGAndroid32.ScrollBy(0, 9999);
               SGAndroid32.Row := SGAndroid32.RowCount - 1;
               SGAndroid32.Cells[0, SGAndroid32.RowCount - 1] := Path;
               SGAndroid32.Cells[1, SGAndroid32.RowCount - 1] := '.\';
               SGAndroid32.Cells[2, SGAndroid32.RowCount - 1] := 'True';
               SGAndroid32.Cells[3, SGAndroid32.RowCount - 1] := 'All';

            end
         else
            begin

                for i := 0 to SGAndroid64.RowCount - 1 do
                  if SGAndroid64.Cells[0, i] = Path
                  then
                     begin
                        ShowASMDMessage('Folder already added');
                        Exit;
                     end;

               if SGAndroid64.Cells[0, SGAndroid64.RowCount - 1] <> ''
               then
                  SGAndroid64.RowCount := SGAndroid64.RowCount + 1;

               SGAndroid64.ScrollBy(0, 9999);
               SGAndroid64.Row := SGAndroid64.RowCount - 1;
               SGAndroid64.Cells[0, SGAndroid64.RowCount - 1] := Path;
               SGAndroid64.Cells[1, SGAndroid64.RowCount - 1] := '.\';
               SGAndroid64.Cells[2, SGAndroid64.RowCount - 1] := 'True';
               SGAndroid64.Cells[3, SGAndroid64.RowCount - 1] := 'All';

            end;

         CBInclude.Enabled := True;
         CBInclude.Checked := True;

         CBConf.ItemIndex := CBConf.Items.IndexOf('All');
         LETargetDir.Text := '.\';

      end;

   LEFilter.Text := '';
   ApplyFilter;

end;

procedure TFormMain.BClearFilterClick(Sender: TObject);
begin
   LEFilter.Text := '';
   ApplyFilter;
end;

procedure TFormMain.BDelSelClick(Sender: TObject);
begin

   if ASPConf.ActivePage = ASPPAndroid32
   then
      SGAndroid32.RemoveSelectedRows;

   if ASPConf.ActivePage = ASPPAndroid64
   then
      SGAndroid64.RemoveSelectedRows;

   LEFilter.Text := '';
//   ApplyFilter;

end;

procedure TFormMain.ShowASMDMessage(Mess: String);
begin

   AdvSmoothMessageDialog1.HTMLText.Text := Mess;
   AdvSmoothMessageDialog1.Buttons.Clear;
   AddMessButton('OK', 100);
   AdvSmoothMessageDialog1.ExecuteDialog;

end;

procedure TFormMain.CBConfChange(Sender: TObject);

var
   i, x: integer;
   DebFound, RelFound: Boolean;

begin

   if ASPConf.ActivePage = ASPPAndroid32
   then
      for i := SGAndroid32.Selection.Top to SGAndroid32.Selection.Bottom do
         if i > 0
         then
            begin

               if CBConf.Items[CBConf.ItemIndex] = 'All'
               then
                  begin

                     DebFound := False;
                     RelFound := False;

                     for x := 1 to SGAndroid32.RowCount - 1 do
                        begin

                           if (SGAndroid32.Cells[0, x] = SGAndroid32.Cells[0, i]) and
                              (SGAndroid32.Cells[3, x] = 'Debug')
                           then
                              DebFound := True;

                           if (SGAndroid32.Cells[0, x] = SGAndroid32.Cells[0, i]) and
                              (SGAndroid32.Cells[3, x] = 'Release')
                           then
                              RelFound := True;

                        end;

                     if (DebFound) and
                        (RelFound)
                     then
                        begin
                           ShowASMDMessage('File already defined for both Debug and Release');
                           Continue;
                        end;

                  end;

               SGAndroid32.Cells[3, i] := CBConf.Items[CBConf.ItemIndex];

            end;

   if ASPConf.ActivePage = ASPPAndroid64
   then
      for i := SGAndroid64.Selection.Top to SGAndroid64.Selection.Bottom do
         if i > 0
         then
            begin

               if CBConf.Items[CBConf.ItemIndex] = 'All'
               then
                  begin

                     DebFound := False;
                     RelFound := False;

                     for x := 1 to SGAndroid64.RowCount - 1 do
                        begin

                           if (SGAndroid64.Cells[0, x] = SGAndroid64.Cells[0, i]) and
                              (SGAndroid64.Cells[3, x] = 'Debug')
                           then
                              DebFound := True;

                           if (SGAndroid64.Cells[0, x] = SGAndroid64.Cells[0, i]) and
                              (SGAndroid64.Cells[3, x] = 'Release')
                           then
                              RelFound := True;

                        end;

                     if (DebFound) and
                        (RelFound)
                     then
                        begin
                           ShowASMDMessage('File already defined for both Debug and Release');
                           Continue;
                        end;

                  end;

               SGAndroid64.Cells[3, i] := CBConf.Items[CBConf.ItemIndex];

            end;

end;

procedure TFormMain.ApplyFilter;
begin

   SGAndroid32.FilterActive := False;
   SGAndroid64.FilterActive := False;
   SGAndroid32.Filter.Clear;
   SGAndroid64.Filter.Clear;

   if LEFilter.Text <> ''
   then
      if ASPConf.ActivePage = ASPPAndroid32
      then
         begin

            with SGAndroid32.Filter.Add do
            begin
               CaseSensitive := False;
               Condition := '*' + LEFilter.Text + '*';
               Column := CBFilterCol.ItemIndex;
            end;

            SGAndroid32.FilterActive := True;

         end
      else
         begin

            with SGAndroid64.Filter.Add do
            begin
               CaseSensitive := False;
               Condition := '*' + LEFilter.Text + '*';
               Column := CBFilterCol.ItemIndex;
            end;

            SGAndroid64.FilterActive := True;

         end;

end;

procedure TFormMain.CBFilterColChange(Sender: TObject);
begin
   ApplyFilter;
end;

procedure TFormMain.CBIncludeClick(Sender: TObject);

var
   i: integer;
   FullName: String;

begin

   if ASPConf.ActivePage = ASPPAndroid32
   then
      for  i := SGAndroid64.Selection.Top to SGAndroid64.Selection.Bottom do
         if i > 0
         then
            begin

               if Pos(':\', SGAndroid32.Cells[0, i]) = 0
               then
                  FullName := ExtractFilePath(FEProjFile.Text) + SGAndroid32.Cells[0, i]
               else
                  FullName := SGAndroid32.Cells[0, i];

               if DirectoryExists(FullName)
               then
                  if CBInclude.Checked
                  then
                     SGAndroid64.Cells[2, i] := 'True'
                  else
                     SGAndroid64.Cells[2, i] := 'False';

            end;

   if ASPConf.ActivePage = ASPPAndroid64
   then
      for  i := SGAndroid64.Selection.Top to SGAndroid64.Selection.Bottom do
         if i > 0
         then
            begin

               if Pos(':\', SGAndroid64.Cells[0, i]) = 0
               then
                  FullName := ExtractFilePath(FEProjFile.Text) + SGAndroid64.Cells[0, i]
               else
                  FullName := SGAndroid64.Cells[0, i];

               if DirectoryExists(FullName)
               then
                  if CBInclude.Checked
                  then
                     SGAndroid64.Cells[2, i] := 'True'
                  else
                     SGAndroid64.Cells[2, i] := 'False';

            end;

end;

procedure TFormMain.LEFilterChange(Sender: TObject);
begin
   ApplyFilter;
end;

procedure TFormMain.LoadFiles;

var
   Line: String;
   FileName, Config: String;
   SLLinesIn: TStringList;
   i: integer;

begin

   FEProjFile.OnChange := nil;
   FEProjFile.Text := StringReplace(FEProjFile.Text, '"', '', [rfReplaceAll]);
   FEProjFile.OnChange := FEProjFileChange;

   SGAndroid32.BeginUpdate;
   SGAndroid64.BeginUpdate;

   if FileExists(FEProjFile.Text)
   then
      if StringReplace(ExtractFileExt(FEProjFile.Text), '"', '', [rfReplaceAll]) = '.dproj'
      then
         begin

            SGAndroid32.RowCount := 2;
            SGAndroid32.ClearRows(1, 1);
            SGAndroid64.RowCount := 2;
            SGAndroid64.ClearRows(1, 1);

            SLLinesIn := TStringList.Create;
            SLLinesIn.LoadFromFile(FEProjFile.Text);

            i := 0;

            while i < SLLinesIn.Count do
               begin

                  Line := SLLinesIn[i];

                  if (Pos('<DeployFile', Line) > 0) and
                     (Pos('Class="File"', Line) > 0)
                  then
                     begin

                        FileName := StrBefore('" Configuration=', StrAfter('LocalName="', Line));
                        Config :=   StrBefore('" Class=', StrAfter('Configuration="', Line));
                        Inc(i);
                        Line := SLLinesIn[i];

                        if Pos('Platform Name="All Platforms"', Line) > 0
                        then
                           begin

                              if SGAndroid32.Cells[0, SGAndroid32.RowCount - 1] <> ''
                              then
                                 SGAndroid32.RowCount := SGAndroid32.RowCount + 1;

                              SGAndroid32.Cells[0, SGAndroid32.RowCount - 1] := FileName;
                              SGAndroid32.Cells[3, SGAndroid32.RowCount - 1] := Config;

                              if SGAndroid64.Cells[0, SGAndroid64.RowCount - 1] <> ''
                              then
                                 SGAndroid64.RowCount := SGAndroid64.RowCount + 1;

                              SGAndroid64.Cells[0, SGAndroid64.RowCount - 1] := FileName;
                              SGAndroid64.Cells[3, SGAndroid64.RowCount - 1] := Config;

                              Inc(i);
                              Line := SLLinesIn[i];

                              SGAndroid32.Cells[1, SGAndroid32.RowCount - 1] := StrBefore('</RemoteDir>', StrAfter('<RemoteDir>', Line));
                              SGAndroid64.Cells[1, SGAndroid64.RowCount - 1] := StrBefore('</RemoteDir>', StrAfter('<RemoteDir>', Line));

                              Inc(i);
                              Line := SLLinesIn[i];

                              SGAndroid32.Cells[4, SGAndroid32.RowCount - 1] := StrBefore('</RemoteName>', StrAfter('<RemoteName>', Line));
                              SGAndroid64.Cells[4, SGAndroid64.RowCount - 1] := StrBefore('</RemoteName>', StrAfter('<RemoteName>', Line));

                              SGAndroid32.Cells[2, SGAndroid32.RowCount - 1] := 'False';
                              SGAndroid64.Cells[2, SGAndroid64.RowCount - 1] := 'False';

                           end
                        else
                           if Pos('Platform Name="Android64"', Line) > 0
                           then
                              begin

                                 if SGAndroid64.Cells[0, SGAndroid64.RowCount - 1] <> ''
                                 then
                                    SGAndroid64.RowCount := SGAndroid64.RowCount + 1;

                                 SGAndroid64.Cells[0, SGAndroid64.RowCount - 1] := FileName;
                                 SGAndroid64.Cells[3, SGAndroid64.RowCount - 1] := Config;

                                 Inc(i);
                                 Line := SLLinesIn[i];

                                 SGAndroid64.Cells[1, SGAndroid64.RowCount - 1] := StrBefore('</RemoteDir>', StrAfter('<RemoteDir>', Line));

                                 Inc(i);
                                 Line := SLLinesIn[i];

                                 SGAndroid64.Cells[4, SGAndroid64.RowCount - 1] := StrBefore('</RemoteName>', StrAfter('<RemoteName>', Line));

                                 SGAndroid64.Cells[2, SGAndroid64.RowCount - 1] := 'False';

                              end
                           else
                              if Pos('Platform Name="Android"', Line) > 0
                              then
                                 begin

                                    if SGAndroid32.Cells[0, SGAndroid32.RowCount - 1] <> ''
                                    then
                                       SGAndroid32.RowCount := SGAndroid32.RowCount + 1;

                                    SGAndroid32.Cells[0, SGAndroid32.RowCount - 1] := FileName;
                                    SGAndroid32.Cells[3, SGAndroid32.RowCount - 1] := Config;

                                    Inc(i);
                                    Line := SLLinesIn[i];

                                    SGAndroid32.Cells[1, SGAndroid32.RowCount - 1] := StrBefore('</RemoteDir>', StrAfter('<RemoteDir>', Line));

                                    Inc(i);
                                    Line := SLLinesIn[i];

                                    SGAndroid32.Cells[4, SGAndroid32.RowCount - 1] := StrBefore('</RemoteName>', StrAfter('<RemoteName>', Line));

                                    SGAndroid32.Cells[2, SGAndroid32.RowCount - 1] := 'False';

                                 end;

                     end;

                  Inc(i);

               end;

         end;

   SGAndroid32.Sort(0,TSortDirection.sdAscending);
   SGAndroid64.Sort(0,TSortDirection.sdAscending);
   SGAndroid32.EndUpdate;
   SGAndroid64.EndUpdate;

end;

procedure TFormMain.SBSearchInvokeSearch(Sender: TObject);

var
   i: Integer;

begin

   if ASPConf.ActivePage = ASPPAndroid32
   then
      begin

         for i := 1 to SGAndroid32.RowCount - 1 do
            if (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[0, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[1, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[2, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[3, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[4, i])) > 0)
            then
               begin
                  SGAndroid32.Row := i;
                  SGAndroid32.TopRow := i;
                  Break;
               end;

      end;

   if ASPConf.ActivePage = ASPPAndroid64
   then
      begin

         for i := 1 to SGAndroid64.RowCount - 1 do
            if (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[0, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[1, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[2, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[3, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[4, i])) > 0)
            then
               begin
                  SGAndroid64.Row := i;
                  SGAndroid64.TopRow := i;
                  Break;
               end;

      end;

end;

procedure TFormMain.SBSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   if Key = VK_RETURN
   then
      SBSearchInvokeSearch(Sender);

   if Key = VK_F3
   then
      BNextClick(BNext);

end;

procedure TFormMain.SGAndroid32SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);

var
   FullName: String;

begin

   if ARow <> 0
   then
      begin

         if Pos(':\', SGAndroid32.Cells[0, ARow]) = 0
         then
            FullName := ExtractFilePath(FEProjFile.Text) + SGAndroid32.Cells[0, ARow]
         else
            FullName := SGAndroid32.Cells[0, ARow];

         if DirectoryExists(FullName)
         then
            begin
               CBInclude.Enabled := True;
               LERemName.Enabled := False;
               BSaveRemName.Enabled := False;
            end
         else
            begin
               CBInclude.Enabled := False;
               LERemName.Enabled := True;
               BSaveRemName.Enabled := True;
            end;

         LERemName.Text := SGAndroid32.Cells[4, ARow];
         LETargetDir.Text := SGAndroid32.Cells[1, ARow];

         CBConf.OnChange := nil;
         CBConf.ItemIndex := CBConf.Items.IndexOf(SGAndroid32.Cells[3, ARow]);
         CBConf.OnChange := CBConfChange;

         if SGAndroid32.Cells[2, ARow] = 'False'
         then
            CBInclude.Checked := False
         else
            CBInclude.Checked := True;

      end;

end;

procedure TFormMain.SGAndroid64SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);

var
   FullName: String;

begin

   if ARow <> 0
   then
      begin

         if Pos(':\', SGAndroid64.Cells[0, ARow]) = 0
         then
            FullName := ExtractFilePath(FEProjFile.Text) + SGAndroid64.Cells[0, ARow]
         else
            FullName := SGAndroid64.Cells[0, ARow];

         if DirectoryExists(FullName)
         then
            begin
               CBInclude.Enabled := True;
               LERemName.Enabled := False;
               BSaveRemName.Enabled := False;
            end
         else
            begin
               CBInclude.Enabled := False;
               LERemName.Enabled := True;
               BSaveRemName.Enabled := True;
            end;

         LERemName.Text := SGAndroid64.Cells[4, ARow];
         LETargetDir.Text := SGAndroid64.Cells[1, ARow];

         CBConf.OnChange := nil;
         CBConf.ItemIndex := CBConf.Items.IndexOf(SGAndroid64.Cells[3, ARow]);
         CBConf.OnChange := CBConfChange;

         if Pos(':\', SGAndroid64.Cells[0, ARow]) = 0
         then
            FullName := ExtractFilePath(FEProjFile.Text) + SGAndroid64.Cells[0, ARow]
         else
            FullName := SGAndroid64.Cells[0, ARow];

         if DirectoryExists(FullName)
         then
            CBInclude.Enabled := True
         else
            CBInclude.Enabled := False;

         if SGAndroid64.Cells[2, ARow] = 'False'
         then
            CBInclude.Checked := False
         else
            CBInclude.Checked := True;

      end;

end;

procedure TFormMain.FEProjFileChange(Sender: TObject);
begin

   LoadFiles;

end;

procedure TFormMain.FEProjFileKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   if Key = VK_RETURN
   then
      LoadFiles;

end;

procedure TFormMain.FormActivate(Sender: TObject);
begin

   if ParamCount > 0
   then
      FEProjFile.Text := ParamStr(1);

end;

procedure TFormMain.FormCreate(Sender: TObject);
begin

   SGAndroid32.ColWidths[0] := 300;
   SGAndroid32.ColWidths[1] := 300;
   SGAndroid32.ColWidths[2] := 50;
   SGAndroid32.ColWidths[3] := 100;
   SGAndroid32.ColWidths[4] := 300;
   SGAndroid32.Cells[0, 0] := 'Source Path';
   SGAndroid32.Cells[1, 0] := 'Target Directory';
   SGAndroid32.Cells[2, 0] := 'SubDirs';
   SGAndroid32.Cells[3, 0] := 'Configurations';
   SGAndroid32.Cells[4, 0] := 'Remote Name';

   SGAndroid64.ColWidths[0] := 300;
   SGAndroid64.ColWidths[1] := 300;
   SGAndroid64.ColWidths[2] := 50;
   SGAndroid64.ColWidths[3] := 100;
   SGAndroid64.ColWidths[4] := 300;
   SGAndroid64.Cells[0, 0] := 'Source Path';
   SGAndroid64.Cells[1, 0] := 'Target Directory';
   SGAndroid64.Cells[2, 0] := 'SubDirs';
   SGAndroid64.Cells[3, 0] := 'Configurations';
   SGAndroid64.Cells[4, 0] := 'Remote Name';

   LETargetDir.Items.Clear;
   LETargetDir.Items.Add('.\');
   LETargetDir.Items.Add('.\res\xml');
   LETargetDir.Items.Add('.\assets');
   LETargetDir.Items.Add('.\res\raw');
   LETargetDir.Items.Add('library\lib\armeabi-v7a');

   CBFilterCol.Items.Add('Source Path');
   CBFilterCol.Items.Add('Target Directory');
   CBFilterCol.Items.Add('SubDirs');
   CBFilterCol.Items.Add('Configurations');
   CBFilterCol.Items.Add('Remote Name');
   CBFilterCol.ItemIndex := 0;

  Andr32Items := TList<TFileRec>.Create;
  Andr64Items := TList<TFileRec>.Create;

end;

procedure TFormMain.BSaveClick(Sender: TObject);

var
   LineOut: String;
   i, x, y: Integer;
   FullName, ShortName, TmpStr: String;
   FileList: TArray<String>;
   SaveFile: String;
   SLLinesIn, SLLINETmp: TStringList;

begin

   if not DirectoryExists(ExtractFilePath(FEProjFile.Text) + 'Archive')
   then
      if not CreateDir(ExtractFilePath(FEProjFile.Text) + 'Archive')
      then
        begin
           ShowMessage('There was an error creating Archive Folder');
           Exit;
        end;

   SaveFile := ExtractFilePath(FEProjFile.Text) + 'Archive\' + StrBefore('.dproj', ExtractFileName(FEProjFile.Text)) + 'DM' + FormatDateTime('yyyymmddhhnnss', Now) + '.dproj';
   if not CopyFile(PChar(FEProjFile.Text), PChar(SaveFile), False)
   then
     begin
        ShowMessage('There was an error making a backup of the projectfile');
        Exit;
     end;

   SLLinesIn := TStringList.Create;
   SLLINETmp := TStringList.Create;

   SLLinesIn.LoadFromFile(FEProjFile.Text);

   y := 0;

   while Pos('</Deployment>', SLLinesIn[y]) = 0 do
      begin

         if Pos('<DeployFile', SLLinesIn[y]) > 0
         then
            if Pos('Class="File"', SLLinesIn[y]) > 0
            then
               begin

                  while Pos('</DeployFile>', SLLinesIn[y]) = 0 do
                     Inc(y);

               end
            else
               begin

                  while Pos('</DeployFile>', SLLinesIn[y]) = 0 do
                     begin

                        SLLINETmp.Add(SLLinesIn[y]);

                        Inc(y);

                     end;

                  SLLINETmp.Add(SLLinesIn[y]);

               end
         else
            SLLINETmp.Add(SLLinesIn[y]);

         Inc(y);

      end;

   for i := 1 to SGAndroid32.RowCount - 1 do
      begin

         if Pos(':\', SGAndroid32.Cells[0, i]) = 0
         then
            FullName := ExtractFilePath(FEProjFile.Text) + SGAndroid32.Cells[0, i]
         else
            FullName := SGAndroid32.Cells[0, i];

         if DirectoryExists(FullName)
         then
            begin

               if SGAndroid32.Cells[2, i] = 'True'
               then
                  FileList := TDirectory.GetFiles(FullName, '*.*', TSearchOption.soAllDirectories)
               else
                  FileList := TDirectory.GetFiles(FullName, '*.*', TSearchOption.soTopDirectoryOnly);

               for x := 0 to High(FileList) do
                  begin

                     if Pos(ExtractFilePath(FEProjFile.Text), FileList[x]) > 0
                     then
                        begin

                           TmpStr := ExtractFilePath(FEProjFile.Text) + SGAndroid32.Cells[0, i] + '\';
                           TmpStr := StrAfter(TmpStr, FileList[x]);
                           TmpStr := Copy(ExtractFilePath(TmpStr), 1, Length(ExtractFilePath(TmpStr)) - 1);

                           if TmpStr <> ''
                           then
                              TmpStr := SGAndroid32.Cells[1, i] + '\' + TmpStr
                           else
                              TmpStr := SGAndroid32.Cells[1, i];

                           ShortName := StrAfter(ExtractFilePath(FEProjFile.Text), FileList[x]);

                        end
                     else
                        begin

                           TmpStr := StrAfter(SGAndroid32.Cells[0, i] + '\', FileList[x]);
                           TmpStr := Copy(ExtractFilePath(TmpStr), 1, Length(ExtractFilePath(TmpStr)) - 1);

                           if TmpStr <> ''
                           then
                              TmpStr := SGAndroid32.Cells[1, i] + '\' + TmpStr
                           else
                              TmpStr := SGAndroid32.Cells[1, i];

                           ShortName := FileList[x];

                        end;

                     if (SGAndroid32.Cells[3, i] = 'All') or
                        (SGAndroid32.Cells[3, i] = 'Debug')
                     then
                        begin

                           LineOut := '                <DeployFile LocalName="' + ShortName + '" Configuration="Debug" Class="File">';
                           SLLINETmp.Add(LineOut);
                           LineOut := '                    <Platform Name="Android">';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <RemoteDir>' + TmpStr + '</RemoteDir>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <RemoteName>' + ExtractFileName(ShortName) + '</RemoteName>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <Overwrite>true</Overwrite>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                    </Platform>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                </DeployFile>';
                           SLLINETmp.Add(LineOut);;
                        end;

                     if (SGAndroid32.Cells[3, i] = 'All') or
                        (SGAndroid32.Cells[3, i] = 'Release')
                     then
                        begin
                           LineOut := '                <DeployFile LocalName="' + ShortName + '" Configuration="Release" Class="File">';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                    <Platform Name="Android">';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <RemoteDir>' + TmpStr + '</RemoteDir>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <RemoteName>' + ExtractFileName(ShortName) + '</RemoteName>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <Overwrite>true</Overwrite>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                    </Platform>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                </DeployFile>';
                           SLLINETmp.Add(LineOut);;
                        end;

                  end;

            end
         else
            begin

               if (SGAndroid32.Cells[3, i] = 'All') or
                  (SGAndroid32.Cells[3, i] = 'Debug')
               then
                  begin
                     LineOut := '                <DeployFile LocalName="' + SGAndroid32.Cells[0, i] + '" Configuration="Debug" Class="File">';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                    <Platform Name="Android">';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <RemoteDir>' + SGAndroid32.Cells[1, i] + '</RemoteDir>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <RemoteName>' + SGAndroid32.Cells[4, i] + '</RemoteName>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <Overwrite>true</Overwrite>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                    </Platform>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                </DeployFile>';
                     SLLINETmp.Add(LineOut);;
                  end;

               if (SGAndroid32.Cells[3, i] = 'All') or
                  (SGAndroid32.Cells[3, i] = 'Release')
               then
                  begin
                     LineOut := '                <DeployFile LocalName="' + SGAndroid32.Cells[0, i] + '" Configuration="Release" Class="File">';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                    <Platform Name="Android">';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <RemoteDir>' + SGAndroid32.Cells[1, i] + '</RemoteDir>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <RemoteName>' + SGAndroid32.Cells[4, i] + '</RemoteName>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <Overwrite>true</Overwrite>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                    </Platform>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                </DeployFile>';
                     SLLINETmp.Add(LineOut);;
                  end;

            end;

      end;

   for i := 1 to SGAndroid64.RowCount - 1 do
      begin

         if Pos(':\', SGAndroid64.Cells[0, i]) = 0
         then
            FullName := ExtractFilePath(FEProjFile.Text) + SGAndroid64.Cells[0, i]
         else
            FullName := SGAndroid64.Cells[0, i];

         if DirectoryExists(FullName)
         then
            begin

               if SGAndroid64.Cells[2, i] = 'True'
               then
                  FileList := TDirectory.GetFiles(FullName, '*.*', TSearchOption.soAllDirectories)
               else
                  FileList := TDirectory.GetFiles(FullName, '*.*', TSearchOption.soTopDirectoryOnly);

               for x := 0 to High(FileList) do
                  begin

                     if Pos(ExtractFilePath(FEProjFile.Text), FileList[x]) > 0
                     then
                        begin

                           TmpStr := ExtractFilePath(FEProjFile.Text) + SGAndroid64.Cells[0, i] + '\';
                           TmpStr := StrAfter(TmpStr, FileList[x]);
                           TmpStr := Copy(ExtractFilePath(TmpStr), 1, Length(ExtractFilePath(TmpStr)) - 1);

                           if TmpStr <> ''
                           then
                              TmpStr := SGAndroid64.Cells[1, i] + '\' + TmpStr
                           else
                              TmpStr := SGAndroid64.Cells[1, i];

                           ShortName := StrAfter(ExtractFilePath(FEProjFile.Text), FileList[x]);

                        end
                     else
                        begin

                           TmpStr := StrAfter(SGAndroid64.Cells[0, i] + '\', FileList[x]);
                           TmpStr := Copy(ExtractFilePath(TmpStr), 1, Length(ExtractFilePath(TmpStr)) - 1);

                           if TmpStr <> ''
                           then
                              TmpStr := SGAndroid64.Cells[1, i] + '\' + TmpStr
                           else
                              TmpStr := SGAndroid64.Cells[1, i];

                           ShortName := FileList[x];

                        end;

                     if (SGAndroid64.Cells[3, i] = 'All') or
                        (SGAndroid64.Cells[3, i] = 'Debug')
                     then
                        begin
                           LineOut := '                <DeployFile LocalName="' + ShortName + '" Configuration="Debug" Class="File">';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                    <Platform Name="Android64">';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <RemoteDir>' + TmpStr + '</RemoteDir>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <RemoteName>' + ExtractFileName(ShortName) + '</RemoteName>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <Overwrite>true</Overwrite>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                    </Platform>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                </DeployFile>';
                           SLLINETmp.Add(LineOut);;
                        end;

                     if (SGAndroid64.Cells[3, i] = 'All') or
                        (SGAndroid64.Cells[3, i] = 'Release')
                     then
                        begin
                           LineOut := '                <DeployFile LocalName="' + ShortName + '" Configuration="Release" Class="File">';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                    <Platform Name="Android64">';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <RemoteDir>' + TmpStr + '</RemoteDir>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <RemoteName>' + ExtractFileName(ShortName) + '</RemoteName>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                        <Overwrite>true</Overwrite>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                    </Platform>';
                           SLLINETmp.Add(LineOut);;
                           LineOut := '                </DeployFile>';
                           SLLINETmp.Add(LineOut);;
                        end;

                  end;

            end
         else
            begin

               if (SGAndroid64.Cells[3, i] = 'All') or
                  (SGAndroid64.Cells[3, i] = 'Debug')
               then
                  begin
                     LineOut := '                <DeployFile LocalName="' + SGAndroid64.Cells[0, i] + '" Configuration="Debug" Class="File">';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                    <Platform Name="Android64">';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <RemoteDir>' + SGAndroid64.Cells[1, i] + '</RemoteDir>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <RemoteName>' + SGAndroid64.Cells[4, i] + '</RemoteName>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <Overwrite>true</Overwrite>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                    </Platform>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                </DeployFile>';
                     SLLINETmp.Add(LineOut);;
                  end;

               if (SGAndroid64.Cells[3, i] = 'All') or
                  (SGAndroid64.Cells[3, i] = 'Release')
               then
                  begin
                     LineOut := '                <DeployFile LocalName="' + SGAndroid64.Cells[0, i] + '" Configuration="Release" Class="File">';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                    <Platform Name="Android64">';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <RemoteDir>' + SGAndroid64.Cells[1, i] + '</RemoteDir>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <RemoteName>' + SGAndroid64.Cells[4, i] + '</RemoteName>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                        <Overwrite>true</Overwrite>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                    </Platform>';
                     SLLINETmp.Add(LineOut);;
                     LineOut := '                </DeployFile>';
                     SLLINETmp.Add(LineOut);;
                  end;

            end;

      end;

   while y < SLLInesin.Count do
      begin

         SLLINETmp.Add(SLLinesIn[y]);
         Inc(y);

      end;

   SLLINETmp.SaveToFile(FEProjFile.Text);
   ShowASMDMessage('Done. Backup of project file located in ' + SaveFile);

end;

procedure TFormMain.BSaveRemNameClick(Sender: TObject);

var
   x: integer;

begin

   AdvSmoothMessageDialog1.Buttons.Clear;

   AddMessButton('Yes', 100);
   AddMessButton('No', 101);
   AddMessButton('Cancel', 102);

   if (ASPConf.ActivePage = ASPPAndroid32) and
      (SGAndroid32.Row <> 0)
   then
      begin

         for x := 1 to SGAndroid32.RowCount - 1 do
            begin

               if (SGAndroid32.Cells[0, SGAndroid32.Row] = SGAndroid32.Cells[0, x]) and
                  (SGAndroid32.Cells[3, SGAndroid32.Row] = 'Debug') and
                  (SGAndroid32.Cells[3, x] = 'Release')
               then
                  begin

                     AdvSmoothMessageDialog1.HTMLText.Text := 'This file is also defined for Release configuration. Change Remote Name for Release also?';

                     case AdvSmoothMessageDialog1.ExecuteDialog of

                        100:
                           begin
                              SGAndroid32.Cells[4, x] := LERemName.Text;
                              Break;
                           end;

                        102: Exit;

                     end;

                  end;

               if (SGAndroid32.Cells[0, SGAndroid32.Row] = SGAndroid32.Cells[0, x]) and
                  (SGAndroid32.Cells[3, SGAndroid32.Row] = 'Release') and
                  (SGAndroid32.Cells[3, x] = 'Debug')
               then
                  begin

                     AdvSmoothMessageDialog1.HTMLText.Text := 'This file is also defined for Debug configuration. Change Remote Name for Debug also?';

                     case AdvSmoothMessageDialog1.ExecuteDialog of

                        100:
                           begin
                              SGAndroid32.Cells[4, x] := LERemName.Text;
                              Break;
                           end;

                        102: Exit;

                     end;

                  end;

            end;

         SGAndroid32.Cells[4, SGAndroid32.Row] := LERemName.Text;

      end;

   if (ASPConf.ActivePage = ASPPAndroid64) and
      (SGAndroid64.Row <> 0)
   then
      begin

         for x := 1 to SGAndroid64.RowCount - 1 do
            begin

               if (SGAndroid64.Cells[0, SGAndroid64.Row] = SGAndroid64.Cells[0, x]) and
                  (SGAndroid64.Cells[3, SGAndroid64.Row] = 'Debug') and
                  (SGAndroid64.Cells[3, x] = 'Release')
               then
                  begin

                     AdvSmoothMessageDialog1.HTMLText.Text := 'This file is also defined for Release configuration. Change Remote Name for Release also?';

                     case AdvSmoothMessageDialog1.ExecuteDialog of

                        100:
                           begin
                              SGAndroid64.Cells[4, x] := LERemName.Text;
                              Break;
                           end;

                        102: Exit;

                     end;

                  end;

               if (SGAndroid64.Cells[0, SGAndroid64.Row] = SGAndroid64.Cells[0, x]) and
                  (SGAndroid64.Cells[3, SGAndroid64.Row] = 'Release') and
                  (SGAndroid64.Cells[3, x] = 'Debug')
               then
                  begin

                     AdvSmoothMessageDialog1.HTMLText.Text := 'This file is also defined for Debug configuration. Change Remote Name for Debug also?';

                     case AdvSmoothMessageDialog1.ExecuteDialog of

                        100:
                           begin
                              SGAndroid64.Cells[4, x] := LERemName.Text;
                              Break;
                           end;

                        102: Exit;

                     end;

                  end;

            end;

         SGAndroid64.Cells[4, SGAndroid64.Row] := LERemName.Text;

      end;

end;

procedure TFormMain.AddMessButton(Capt: String; ButtRes: integer);
begin

   with AdvSmoothMessageDialog1.Buttons.Add do
      begin
         Caption := Capt;
         ButtonResult := ButtRes;
         BorderColor := clWhite;
         Color := clBlack;
         ColorDown := clBlack;
         ColorFocused := clBlack;
         HoverColor := clBlack;
      end;

end;

procedure TFormMain.BTransferClick(Sender: TObject);
var
   i, x, z: Integer;
   OverRideAll, SkipAll, OverRideFile, Skip: Boolean;

begin

   OverRideAll := False;
   SkipAll := False;

   AdvSmoothMessageDialog1.Buttons.Clear;

   AddMessButton('Override', 100);
   AddMessButton('Override All', 101);
   AddMessButton('Skip', 102);
   AddMessButton('Skip All', 103);
   AddMessButton('Cancel', 104);

   if ASPConf.ActivePage = ASPPAndroid32
   then
      begin

         SGAndroid64.BeginUpdate;

         for i := 0 to SGAndroid32.SelectedRowCount - 1  do
               begin

                  Skip := False;
                  OverRideFile := False;

                  for x := 1 to SGAndroid64.RowCount - 1 do
                     if SGAndroid64.Cells[0, x] = SGAndroid32.Cells[0, SGAndroid32.SelectedRow[i]]
                     then
                        if ((SGAndroid32.Cells[3, SGAndroid32.SelectedRow[i]] = 'All') and
                            ((SGAndroid64.Cells[3, x] = 'All') or
                             (SGAndroid64.Cells[3, x] = 'Release') or
                             (SGAndroid64.Cells[3, x] = 'Debug'))) or
                           (SGAndroid64.Cells[3, x] = SGAndroid32.Cells[3, SGAndroid32.SelectedRow[i]])
                        then
                           begin

                              if SkipAll
                              then
                                 Skip := True
                              else
                                 if OverRideAll
                                 then
                                    OverRideFile := True
                                 else
                                    begin

                                       AdvSmoothMessageDialog1.HTMLText.Text := 'Source Path "' + SGAndroid64.Cells[0, x] + '" for ' + SGAndroid64.Cells[3, x] + ' configuration allready exist';

                                       case AdvSmoothMessageDialog1.ExecuteDialog of

                                          104:
                                             Exit;

                                          100: OverRideFile := True;

                                          101:
                                             begin
                                                OverRideAll := True;
                                                OverRideFile := True;
                                             end;

                                          102: Skip := True;

                                          103:
                                             begin
                                                SkipAll := True;
                                                Skip := True;
                                             end;

                                       end;

                                    end;

                              Break;

                           end;

                  if Skip
                  then
                     Continue;

                  if OverRideFile
                  then
                     begin

                        for x := SGAndroid64.RowCount - 1 downto 1 do
                           if SGAndroid64.Cells[0, x] = SGAndroid32.Cells[0, SGAndroid32.SelectedRow[i]]
                           then
                              if ((SGAndroid32.Cells[3, SGAndroid32.SelectedRow[i]] = 'All') and
                                  ((SGAndroid64.Cells[3, x] = 'All') or
                                   (SGAndroid64.Cells[3, x] = 'Release') or
                                   (SGAndroid64.Cells[3, x] = 'Debug'))) or
                                 (SGAndroid64.Cells[3, x] = SGAndroid32.Cells[3, SGAndroid32.SelectedRow[i]])
                              then
                                 SGAndroid64.RemoveRows(x, 1);

                     end;

                  if SGAndroid64.Cells[0, SGAndroid64.RowCount - 1] <> ''
                  then
                     SGAndroid64.AddRow;

                  SGAndroid64.Cells[0, SGAndroid64.RowCount - 1] := SGAndroid32.Cells[0, SGAndroid32.SelectedRow[i]];

                  if SGAndroid32.Cells[1, SGAndroid32.SelectedRow[i]] = 'library\lib\armeabi-v7a'
                  then
                     SGAndroid64.Cells[1, SGAndroid64.RowCount - 1] := 'library\lib\arm64-v8a'
                  else
                     SGAndroid64.Cells[1, SGAndroid64.RowCount - 1] := SGAndroid32.Cells[1, SGAndroid32.SelectedRow[i]];

                  SGAndroid64.Cells[2, SGAndroid64.RowCount - 1] := SGAndroid32.Cells[2, SGAndroid32.SelectedRow[i]];
                  SGAndroid64.Cells[3, SGAndroid64.RowCount - 1] := SGAndroid32.Cells[3, SGAndroid32.SelectedRow[i]];
                  SGAndroid64.Cells[4, SGAndroid64.RowCount - 1] := SGAndroid32.Cells[4, SGAndroid32.SelectedRow[i]];

               end;

         SGAndroid64.Sort(0, TSortDirection.sdAscending);
         SGAndroid64.EndUpdate;

      end;

   if ASPConf.ActivePage = ASPPAndroid64
   then
      begin

         SGAndroid32.BeginUpdate;

         for i := 0 to SGAndroid64.SelectedRowCount - 1  do
               begin

                  Skip := False;
                  OverRideFile := False;

                  for x := 1 to SGAndroid32.RowCount - 1 do
                     if SGAndroid32.Cells[0, x] = SGAndroid64.Cells[0, SGAndroid64.SelectedRow[i]]
                     then
                        if ((SGAndroid64.Cells[3, SGAndroid64.SelectedRow[i]] = 'All') and
                            ((SGAndroid32.Cells[3, x] = 'All') or
                             (SGAndroid32.Cells[3, x] = 'Release') or
                             (SGAndroid32.Cells[3, x] = 'Debug'))) or
                           (SGAndroid32.Cells[3, x] = SGAndroid64.Cells[3, SGAndroid64.SelectedRow[i]])
                        then
                           begin

                              if SkipAll
                              then
                                 Skip := True
                              else
                                 if OverRideAll
                                 then
                                    OverRideFile := True
                                 else
                                    begin

                                       AdvSmoothMessageDialog1.HTMLText.Text := 'Source Path "' + SGAndroid32.Cells[0, x] + '" for ' + SGAndroid32.Cells[3, x] + ' configuration allready exist';

                                       case AdvSmoothMessageDialog1.ExecuteDialog of

                                          104:
                                             Exit;

                                          100: OverRideFile := True;

                                          101:
                                             begin
                                                OverRideAll := True;
                                                OverRideFile := True;
                                             end;

                                          102: Skip := True;

                                          103:
                                             begin
                                                SkipAll := True;
                                                Skip := True;
                                             end;

                                       end;

                                    end;

                              Break;

                           end;

                  if Skip
                  then
                     Continue;

                  if OverRideFile
                  then
                     begin

                        for x := SGAndroid32.RowCount - 1 downto 1 do
                           if SGAndroid32.Cells[0, x] = SGAndroid64.Cells[0, SGAndroid64.SelectedRow[i]]
                           then
                              if ((SGAndroid64.Cells[3, SGAndroid64.SelectedRow[i]] = 'All') and
                                  ((SGAndroid32.Cells[3, x] = 'All') or
                                   (SGAndroid32.Cells[3, x] = 'Release') or
                                   (SGAndroid32.Cells[3, x] = 'Debug'))) or
                                 (SGAndroid32.Cells[3, x] = SGAndroid64.Cells[3, SGAndroid64.SelectedRow[i]])
                              then
                                 SGAndroid32.RemoveRows(x, 1);

                     end;

                  if SGAndroid32.Cells[0, SGAndroid32.RowCount - 1] <> ''
                  then
                     SGAndroid32.AddRow;

                  SGAndroid32.Cells[0, SGAndroid64.RowCount - 1] := SGAndroid64.Cells[0, SGAndroid64.SelectedRow[i]];

                  if SGAndroid64.Cells[1, i] = 'library\lib\arm64-v8a'
                  then
                     SGAndroid32.Cells[1, SGAndroid64.RowCount - 1] := 'library\lib\armeabi-v7a'
                  else
                     SGAndroid32.Cells[1, SGAndroid64.RowCount - 1] := SGAndroid64.Cells[1, SGAndroid64.SelectedRow[i]];

                  SGAndroid32.Cells[2, SGAndroid64.RowCount - 1] := SGAndroid64.Cells[2, SGAndroid64.SelectedRow[i]];
                  SGAndroid32.Cells[3, SGAndroid64.RowCount - 1] := SGAndroid64.Cells[3, SGAndroid64.SelectedRow[i]];
                  SGAndroid32.Cells[4, SGAndroid64.RowCount - 1] := SGAndroid64.Cells[4, SGAndroid64.SelectedRow[i]];

               end;

         SGAndroid32.Sort(0,TSortDirection.sdAscending);
         SGAndroid32.EndUpdate;

      end;

end;

procedure TFormMain.Button1Click(Sender: TObject);

var
   i: Integer;
   FileList: TArray<String>;
   InFile, OutFile: TextFile;
   LineIn, LineOut: string;

begin

//   AssignFile(OutFile, 'D:\Deplhi\Explorer\Resources\res foren\TranslationTo.txt');
//   Rewrite(OutFile);
//   FileList := TDirectory.GetFiles('D:\Deplhi\Explorer\Resources\res foren', 'Strings.xml', TSearchOption.soAllDirectories);
//
//   for i := 0 to High(FileList) do
//      begin
//
//         LineOut := StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren\Values-', FileList[i]));
//         WriteLn(OutFile, LineOut);

//         AssignFile(InFile, FileList[i]);
//         Reset(InFile);
//
//         while not Eof(InFile) do
//            begin
//
//               ReadLn(InFile, LineIn);
//
//               if Pos('<plurals name=', LineIn) > 0
//               then
//                  begin
//
//                     ReadLn(InFile, LineIn);
//                     ReadLn(InFile, LineIn);
//                     ReadLn(InFile, LineIn);
//
//                     if Pos('</plurals>', LineIn) = 0
//                     then
//                        begin
//                           LineOut := FileList[i];
//                           WriteLn(OutFile, LineOut);
//                           Break;
//                        end;
//
//                  end;
//
//            end;
//
//         CloseFile(InFile);

//      end;
//
//   CloseFile(OutFile);

//   FileList := TDirectory.GetFiles('D:\Deplhi\Explorer\Resources\res foren - Kopi', 'Plurals.xml', TSearchOption.soAllDirectories);
//
//   for i := 0 to High(FileList) do
//      begin
//
//         AssignFile(InFile, FileList[i]);
//         Reset(InFile);
//         AssignFile(OutFile, ExtractFilePath(FileList[i]) + StrBefore('.xml', ExtractFileName(FileList[i])) + 'tmp.xml');
//         Rewrite(OutFile);
//
//         while not Eof(InFile) do
//            begin
//
//               ReadLn(InFile, LineIn);
//               WriteLn(OutFile, LineIn);
//
//               if Pos('<plurals name=', LineIn) > 0
//               then
//                  begin
//
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'ar'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="zero">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="two">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="few">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="many">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'cs'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="few">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="many">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'hr'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="few">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'id'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'in'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'iw'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="two">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="many">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'ja'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'ko'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'lt-rLT'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="few">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="many">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'ml'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'pl'
//                     then
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'ro'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="few">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'ru'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="few">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="many">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'sk'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="few">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="many">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'sr'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="few">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                     if StrBefore('\', StrAfter('D:\Deplhi\Explorer\Resources\res foren - Kopi\Values-', FileList[i])) = 'th'
//                     then
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end
//                     else
//                        begin
//
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="other">', []);
//                           WriteLn(OutFile, LineOut);
//                           ReadLn(InFile, LineIn);
//                           LineOut := StringReplace(LineIn, '<item>', '<item quantity="one">', []);
//                           WriteLn(OutFile, LineOut);
//
//                        end;
//
//                  end;
//
//            end;
//
//         CloseFile(InFile);
//         CloseFile(OutFile);
//
//         DeleteFile(FileList[i]);
//         RenameFile(ExtractFilePath(FileList[i]) + StrBefore('.xml', ExtractFileName(FileList[i])) + 'tmp.xml', FileList[i]);
//
//      end;

   ShowASMDMessage('Done');

end;

procedure TFormMain.BCompareClick(Sender: TObject);

var
   i, x: integer;
   FileRec: TFileRec;
   Swapped: Boolean;

begin

   Andr32Items.Clear;
   Andr64Items.Clear;

   for i := 1 to SGAndroid32.RowCount - 1 do
      begin

         FileRec.SourcPath := SGAndroid32.Cells[0, i];
         FileRec.TargetDir := SGAndroid32.Cells[1, i];
         FileRec.Configurations := SGAndroid32.Cells[3, i];
         FileRec.RemoteName := SGAndroid32.Cells[4, i];

         Andr32Items.Add(FileRec);

      end;

   Swapped := True;

   while Swapped do
      begin

         Swapped := False;

         for i := 0 to Andr32Items.Count - 2 do
            if Andr32Items[i].SourcPath > Andr32Items[i + 1].SourcPath
            then
               begin
                  Andr32Items.Exchange(i, i + 1);
                  Swapped := True;
               end;

      end;

   for i := 1 to SGAndroid64.RowCount - 1 do
      begin

         FileRec.SourcPath := SGAndroid64.Cells[0, i];
         FileRec.TargetDir := SGAndroid64.Cells[1, i];
         FileRec.Configurations := SGAndroid64.Cells[3, i];
         FileRec.RemoteName := SGAndroid64.Cells[4, i];

         Andr64Items.Add(FileRec);

      end;

   Swapped := True;

   while Swapped do
      begin

         Swapped := False;

         for i := 0 to Andr64Items.Count - 2 do
            if Andr64Items[i].SourcPath > Andr64Items[i + 1].SourcPath
            then
               begin
                  Andr64Items.Exchange(i, i + 1);
                  Swapped := True;
               end;


      end;

   i := 0;
   x := 0;

   FCompare.SGCompAndr32.RowCount := 2;
   FCompare.SGCompAndr32.ClearRows(1, 1);
   FCompare.SGCompAndr64.RowCount := 2;
   FCompare.SGCompAndr64.ClearRows(1, 1);

   while True do
      begin

         if Andr32Items[i].SourcPath <> Andr64Items[x].SourcPath
         then
            begin

            end;

         if FCompare.SGCompAndr32.Cells[0, FCompare.SGCompAndr32.RowCount - 1] <> ''
         then
            FCompare.SGCompAndr32.RowCount := FCompare.SGCompAndr32.RowCount + 1;


         if (i < Andr32Items.Count)
         then
            Inc(i);

      end;

   SGAndroid32.Cells[0, 0] := 'Source Path';
   SGAndroid32.Cells[1, 0] := 'Target Directory';
   SGAndroid32.Cells[2, 0] := 'SubDirs';
   SGAndroid32.Cells[3, 0] := 'Configurations';
   SGAndroid32.Cells[4, 0] := 'Remote Name';

end;

procedure TFormMain.BSaveTargetDirClick(Sender: TObject);

var
   x: integer;

begin

   AdvSmoothMessageDialog1.Buttons.Clear;

   AddMessButton('Yes', 100);
   AddMessButton('No', 101);
   AddMessButton('Cancel', 102);

   if (ASPConf.ActivePage = ASPPAndroid32) and
      (SGAndroid32.Row <> 0)
   then
      begin

         for x := 1 to SGAndroid32.RowCount - 1 do
            begin

               if (SGAndroid32.Cells[0, SGAndroid32.Row] = SGAndroid32.Cells[0, x]) and
                  (SGAndroid32.Cells[3, SGAndroid32.Row] = 'Debug') and
                  (SGAndroid32.Cells[3, x] = 'Release')
               then
                  begin

                     AdvSmoothMessageDialog1.HTMLText.Text := 'This file is also defined for Release configuration. Change Target Directory for Release also?';

                     case AdvSmoothMessageDialog1.ExecuteDialog of

                        100:
                           begin
                              SGAndroid32.Cells[1, x] := LETargetDir.Text;
                              Break;
                           end;

                        102: Exit;

                     end;

                  end;

               if (SGAndroid32.Cells[0, SGAndroid32.Row] = SGAndroid32.Cells[0, x]) and
                  (SGAndroid32.Cells[3, SGAndroid32.Row] = 'Release') and
                  (SGAndroid32.Cells[3, x] = 'Debug')
               then
                  begin

                     AdvSmoothMessageDialog1.HTMLText.Text := 'This file is also defined for Debug configuration. Change Target Directory for Debug also?';

                     case AdvSmoothMessageDialog1.ExecuteDialog of

                        100:
                           begin
                              SGAndroid32.Cells[1, x] := LETargetDir.Text;
                              Break;
                           end;

                        102: Exit;

                     end;

                  end;

            end;

         SGAndroid32.Cells[1, SGAndroid32.Row] := LETargetDir.Text;

      end;

   if (ASPConf.ActivePage = ASPPAndroid64) and
      (SGAndroid64.Row <> 0)
   then
      begin

         for x := 1 to SGAndroid64.RowCount - 1 do
            begin

               if (SGAndroid64.Cells[0, SGAndroid64.Row] = SGAndroid64.Cells[0, x]) and
                  (SGAndroid64.Cells[3, SGAndroid64.Row] = 'Debug') and
                  (SGAndroid64.Cells[3, x] = 'Release')
               then
                  begin

                     AdvSmoothMessageDialog1.HTMLText.Text := 'This file is also defined for Release configuration. Change Target Directory for Release also?';

                     case AdvSmoothMessageDialog1.ExecuteDialog of

                        100:
                           begin
                              SGAndroid64.Cells[1, x] := LETargetDir.Text;
                              Break;
                           end;

                        102: Exit;

                     end;

                  end;

               if (SGAndroid64.Cells[0, SGAndroid64.Row] = SGAndroid64.Cells[0, x]) and
                  (SGAndroid64.Cells[3, SGAndroid64.Row] = 'Release') and
                  (SGAndroid64.Cells[3, x] = 'Debug')
               then
                  begin

                     AdvSmoothMessageDialog1.HTMLText.Text := 'This file is also defined for Debug configuration. Target Directory Name for Debug also?';

                     case AdvSmoothMessageDialog1.ExecuteDialog of

                        100:
                           begin
                              SGAndroid64.Cells[1, x] := LETargetDir.Text;
                              Break;
                           end;

                        102: Exit;

                     end;

                  end;

            end;

         SGAndroid64.Cells[1, SGAndroid64.Row] := LETargetDir.Text;

      end;

end;

procedure TFormMain.BPreviousClick(Sender: TObject);

var
   i: Integer;

begin

   if ASPConf.ActivePage = ASPPAndroid32
   then
      begin

         if SGAndroid32.Row = 1
         then
            Exit;

         for i := SGAndroid32.Row - 1 downto 1 do
            if (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[0, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[1, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[2, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[3, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[4, i])) > 0)
            then
               begin
                  SGAndroid32.Row := i;
                  SGAndroid32.TopRow := i;
                  Break;
               end;

      end;

   if ASPConf.ActivePage = ASPPAndroid64
   then
      begin

         if SGAndroid64.Row = 1
         then
            Exit;

         for i := SGAndroid64.Row - 1 downto 1 do
            if (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[0, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[1, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[2, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[3, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[4, i])) > 0)
            then
               begin
                  SGAndroid64.Row := i;
                  SGAndroid64.TopRow := i;
                  Break;
               end;

      end;

end;

procedure TFormMain.BRefreshClick(Sender: TObject);
begin
   LoadFiles;
end;

procedure TFormMain.BNextClick(Sender: TObject);

var
   i: Integer;

begin

   if ASPConf.ActivePage = ASPPAndroid32
   then
      begin

         if SGAndroid32.Row = SGAndroid32.RowCount - 1
         then
            Exit;

         for i := SGAndroid32.Row + 1 to SGAndroid32.RowCount - 1 do
            if (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[0, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[1, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[2, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[3, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid32.Cells[4, i])) > 0)
            then
               begin
                  SGAndroid32.Row := i;
                  SGAndroid32.TopRow := i;
                  Break;
               end;

      end;

   if ASPConf.ActivePage = ASPPAndroid64
   then
      begin

         if SGAndroid64.Row = SGAndroid64.RowCount - 1
         then
            Exit;

         for i := SGAndroid64.Row + 1 to SGAndroid64.RowCount - 1 do
            if (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[0, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[1, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[2, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[3, i])) > 0) or
               (Pos(AnsiLowerCase(SBSearch.Text), AnsiLowerCase(SGAndroid64.Cells[4, i])) > 0)
            then
               begin
                  SGAndroid64.Row := i;
                  SGAndroid64.TopRow := i;
                  Break;
               end;

      end;

end;

end.
