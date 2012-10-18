unit Controller;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, PwrSave,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, XPMan, SynaSer, ShellAPI, ExtDlgs, JPeg;

const
  WM_NOTIFYICON  = WM_USER+333;

type
  TClipRegion = record
    x: Integer;
    y: Integer;
    w: Integer;
    h: Integer;
    p: PRGBQuad;
    Mode: Integer;
  end;

  TRPMForm = class(TForm)
    ControllerTabs: TPageControl;
    LightingModeTab: TTabSheet;
    PanelFile: TPanel;
    RadioFile: TRadioButton;
    PanelStill: TPanel;
    RadioStill: TRadioButton;
    GroupBox1: TGroupBox;
    ButtOff: TButton;
    ButtR: TButton;
    ButtG: TButton;
    ButtB: TButton;
    ConnectionTab: TTabSheet;
    ControllerStatus: TStatusBar;
    ButtOn: TButton;
    ImagePreview: TImage;
    PanelExpand: TPanel;
    RadioExpand: TRadioButton;
    PanelSound: TPanel;
    RadioSound: TRadioButton;
    GroupBox2: TGroupBox;
    FileList: TListBox;
    APNothing: TRadioButton;
    APFade: TRadioButton;
    APNext: TRadioButton;
    APRandom: TRadioButton;
    APLoop: TRadioButton;
    APRepeat: TRadioButton;
    Button6: TButton;
    MaxLabel: TLabel;
    LabelPreview: TLabel;
    LabelPort: TLabel;
    SPNum: TComboBox;
    RadioCW: TRadioButton;
    RadioCCW: TRadioButton;
    ScreenCaptureTimer: TTimer;
    LEDAdj: TComboBox;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    TrackFileSpeed: TTrackBar;
    Label3: TLabel;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    ByteOrder: TComboBox;
    KEY2: TEdit;
    KEY1: TEdit;
    KEY3: TEdit;
    Label4: TLabel;
    Label1: TLabel;
    BaudRate: TComboBox;
    Label6: TLabel;
    LEDNum: TComboBox;
    CheckBox1: TCheckBox;
    SaveButton: TButton;
    ButtonOpenSP: TButton;
    OpenPicture: TOpenPictureDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label7: TLabel;
    ExpandMode: TComboBox;
    ButtC: TButton;
    ButtM: TButton;
    ButtY: TButton;
    StillImage: TImage;
    Label8: TLabel;
    PwrEvent: TPwrSave;
    DemoTimer: TTimer;
    MarginTop: TComboBox;
    MarginBot: TComboBox;
    MarginRight: TComboBox;
    MarginLeft: TComboBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    GroupMult: TGroupBox;
    LabelR: TLabel;
    LabelB: TLabel;
    LabelG: TLabel;
    TrackR: TTrackBar;
    TrackB: TTrackBar;
    TrackG: TTrackBar;
    MultG: TEdit;
    MultB: TEdit;
    MultR: TEdit;
    GroupBox5: TGroupBox;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    TrackRS: TTrackBar;
    TrackBS: TTrackBar;
    TrackGS: TTrackBar;
    SubG: TEdit;
    SubB: TEdit;
    SubR: TEdit;
    TrackW: TTrackBar;
    LabelRect: TLabel;
    MultW: TEdit;
    TrackD: TTrackBar;
    MultD: TEdit;
    Label12: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioButton5: TRadioButton;
    Label22: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Track0: TTrackBar;
    TrackMax: TTrackBar;
    ColorMax: TEdit;
    ColorZero: TEdit;
    Label10: TLabel;
    ReduceBlink: TCheckBox;
    procedure RadioStillClick(Sender: TObject);
    procedure RadioExpandClick(Sender: TObject);
    procedure RadioSoundClick(Sender: TObject);
    procedure RadioFileClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FileListDblClick(Sender: TObject);
    procedure TrackRChange(Sender: TObject);
    procedure TrackGChange(Sender: TObject);
    procedure TrackBChange(Sender: TObject);
    procedure _WM_GETMINMAXINFO( var mmInfo : TWMGETMINMAXINFO );  message wm_GetMinMaxInfo;
    procedure ScreenCaptureTimerTimer(Sender: TObject);
    procedure SetLEDColor(PixelNum: Integer; R, G, B: Byte);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TrackWChange(Sender: TObject);
    procedure TrackDChange(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure ButtGClick(Sender: TObject);
    procedure RadioExpandMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SendColor(R, G, B: Byte);
    procedure ButtRClick(Sender: TObject);
    procedure ButtBClick(Sender: TObject);
    procedure ButtOnClick(Sender: TObject);
    procedure ButtOffClick(Sender: TObject);
    procedure ButtonOpenSPClick(Sender: TObject);
    procedure ButtCClick(Sender: TObject);
    procedure ButtMClick(Sender: TObject);
    procedure ButtYClick(Sender: TObject);
    procedure StillImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure StillImageClick(Sender: TObject);
    procedure StillImageDblClick(Sender: TObject);
    procedure PwrEventResume(Sender: TObject);
    procedure PwrEventSuspend(Sender: TObject);
    procedure PwrEventQuerySuspend(Sender: TObject; var Allow: Boolean);
    procedure TrackFileSpeedChange(Sender: TObject);
    procedure DemoTimerTimer(Sender: TObject);
    procedure Track0Change(Sender: TObject);
    procedure TrackMaxChange(Sender: TObject);
    procedure TrackBSChange(Sender: TObject);
    procedure TrackGSChange(Sender: TObject);
    procedure TrackRSChange(Sender: TObject);
  private
    procedure AppMessage(var Msg: TMsg; var handled: Boolean);
  public
    TrayIcon: TNotifyIconData;
    HMainIcon: HICON;
    procedure ClickTrayIcon(var msg: TMessage); message WM_NOTIFYICON;
    Procedure MinimizeClick(Sender:TObject);
  end;

var
  RPMForm: TRPMForm;
  LEDArray: Array of TRGBTriple;
  LEDRegions: Array of TClipRegion;
  DemoStrings: TStrings;
  DemoIndex: Integer;
  SP: TBlockSerial;
  TempColor: TColor;

implementation

{$R *.dfm}









//----------------------------------------------------------------------------\\
//- Utility Functions --------------------------------------------------------||
//----------------------------------------------------------------------------//

//- Set LED Color ------------------------------------------------------------\\
procedure TRPMForm.SetLEDColor(PixelNum: Integer; R, G, B: Byte);
var
  Index: Integer;
 begin
  //Apply Color max-Zero, min-Max, and multipliers.
  if (R <= StrToInt(ColorZero.Text)) or (R - StrToInt(SubR.Text) < 0) then R := 0
  else if (R > StrToInt(ColorMax.Text)) or ((R - StrToInt(SubR.Text)) * StrToFloat(MultR.Text) > 255) then R := 255
  else R := Round((R - StrToInt(SubR.Text)) * StrToFloat(MultR.Text));

  if (G <= StrToInt(ColorZero.Text)) or (G - StrToInt(SubG.Text) < 0) then G := 0
  else if (G > StrToInt(ColorMax.Text)) or ((G - StrToInt(SubG.Text)) * StrToFloat(MultG.Text) > 255) then G := 255
  else G := Round((G - StrToInt(SubG.Text)) * StrToFloat(MultG.Text));

  if (B <= StrToInt(ColorZero.Text)) or (B - StrToInt(SubB.Text) < 0) then B := 0
  else if (B > StrToInt(ColorMax.Text)) or ((B - StrToInt(SubB.Text)) * StrToFloat(MultB.Text) > 255) then B := 255
  else B := Round((B - StrToInt(SubB.Text)) * StrToFloat(MultB.Text));

  if RadioCCW.Checked then
    Index := 0 - LEDAdj.ItemIndex - PixelNum
  else
    Index := 0 + LEDAdj.ItemIndex + PixelNum;
  while Index < 0 do Index := Index + StrToInt(LEDNum.Text);
  while Index >= StrToInt(LEDNum.Text) do Index := Index - StrToInt(LEDNum.Text);
  Index := Index + 1;

  CASE ByteOrder.ItemIndex OF
   0: begin
       if ReduceBlink.Checked then
        begin
         LEDArray[Index].rgbtBlue := R + LEDArray[Index].rgbtBlue DIV 2;
         LEDArray[Index].rgbtGreen := G + LEDArray[Index].rgbtGreen DIV 2;
         LEDArray[Index].rgbtRed := B + LEDArray[Index].rgbtRed DIV 2;
        end
       else
        begin
         LEDArray[Index].rgbtBlue := R;
         LEDArray[Index].rgbtGreen := G;
         LEDArray[Index].rgbtRed := B;
        end;
      end;
   1: begin
       if ReduceBlink.Checked then
        begin
         LEDArray[Index].rgbtBlue := R + LEDArray[Index].rgbtBlue DIV 2;
         LEDArray[Index].rgbtGreen := B + LEDArray[Index].rgbtGreen DIV 2;
         LEDArray[Index].rgbtRed := G + LEDArray[Index].rgbtRed DIV 2;
        end
       else
        begin
         LEDArray[Index].rgbtBlue := R;
         LEDArray[Index].rgbtGreen := B;
         LEDArray[Index].rgbtRed := G;
        end;
      end;
   2: begin
       if ReduceBlink.Checked then
        begin
         LEDArray[Index].rgbtBlue := B + LEDArray[Index].rgbtBlue DIV 2;
         LEDArray[Index].rgbtGreen := R + LEDArray[Index].rgbtGreen DIV 2;
         LEDArray[Index].rgbtRed := G + LEDArray[Index].rgbtRed DIV 2;
        end
       else
        begin
         LEDArray[Index].rgbtBlue := B;
         LEDArray[Index].rgbtGreen := R;
         LEDArray[Index].rgbtRed := G;
        end;
      end;
   3: begin
       if ReduceBlink.Checked then
        begin
         LEDArray[Index].rgbtBlue := B + LEDArray[Index].rgbtBlue DIV 2;
         LEDArray[Index].rgbtGreen := G + LEDArray[Index].rgbtGreen DIV 2;
         LEDArray[Index].rgbtRed := R + LEDArray[Index].rgbtRed DIV 2;
        end
       else
        begin
         LEDArray[Index].rgbtBlue := B;
         LEDArray[Index].rgbtGreen := G;
         LEDArray[Index].rgbtRed := R;
        end;
      end;
   4: begin
       if ReduceBlink.Checked then
        begin
         LEDArray[Index].rgbtBlue := G + LEDArray[Index].rgbtBlue DIV 2;
         LEDArray[Index].rgbtGreen := B + LEDArray[Index].rgbtGreen DIV 2;
         LEDArray[Index].rgbtRed := R + LEDArray[Index].rgbtRed DIV 2;
        end
       else
        begin
         LEDArray[Index].rgbtBlue := G;
         LEDArray[Index].rgbtGreen := B;
         LEDArray[Index].rgbtRed := R;
        end;
      end;
   5: begin
       if ReduceBlink.Checked then
        begin
         LEDArray[Index].rgbtBlue := G + LEDArray[Index].rgbtBlue DIV 2;
         LEDArray[Index].rgbtGreen := R + LEDArray[Index].rgbtGreen DIV 2;
         LEDArray[Index].rgbtRed := B + LEDArray[Index].rgbtRed DIV 2;
        end
       else
        begin
         LEDArray[Index].rgbtBlue := G;
         LEDArray[Index].rgbtGreen := R;
         LEDArray[Index].rgbtRed := B;
        end;
      end;
   end;
  //NOTE:  ByteOrder of RGBTriple is backwards!
 end;
//- End Set LED Color --------------------------------------------------------//

//- MakeRegions --------------------------------------------------------------\\
procedure MakeRegions(NumLEDs: Integer; Top, Bot, Left, Right: Integer; MultW, MultD: Double);
var
  Index, HStep, VStep, CWidth, CHeight, HCount, VCount: Integer;
 begin
  if Right > Screen.Width then
    Right := Screen.Width;
  if Bot > Screen.Height then
    Bot := Screen.Height;

  SetLength(LEDRegions, NumLEDs);

  //Set Math Variables
  HCount := Round(NumLEDs / (2 * (Screen.Height + Screen.Width) / Screen.Width));
  VCount := (NumLEDs DIV 2) - HCount;
  HStep := Screen.Width DIV HCount;
  VStep := Screen.Height DIV VCount;
  CWidth := HStep DIV 2;
  CHeight := VStep DIV 2;
  //if CWidth>CHeight then CHeight := CHeight + 1;
  //if CWidth<CHeight then CWidth := CWidth + 1;

  //UL Corner
  LEDRegions[0].w := Round(CWidth * (MultD + MultW) / 2);
  LEDRegions[0].h := Round(CHeight * (MultD + MultW) / 2);
  LEDRegions[0].x := 0;
  LEDRegions[0].y := 0;
  LEDRegions[0].Mode := 0;
  //Top
  for Index := 1 to HCount - 1 do
   begin
    LEDRegions[Index].w := Round(HStep * MultW);
    LEDRegions[Index].h := Round(CHeight * MultD);
    LEDRegions[Index].x := Index*HStep - CWidth - ((LEDRegions[Index].w - HStep) DIV 2);
    LEDRegions[Index].y := Top;
    LEDRegions[Index].Mode := 1;
    if LEDRegions[Index].x < 0 then LEDRegions[Index].x := 0;
    if LEDRegions[Index].x > Screen.Width then LEDRegions[Index].x := Screen.Width - 1;
    if LEDRegions[Index].x + LEDRegions[Index].w > Screen.Width then LEDRegions[Index].w := Screen.Width - LEDRegions[Index].x;
    if LEDRegions[Index].h > Screen.Height then LEDRegions[Index].h := Screen.Height;
   end;
  //UR Corner
  LEDRegions[HCount].w := Round(CWidth * (MultD + MultW) / 2);
  LEDRegions[HCount].h := Round(CHeight * (MultD + MultW) / 2);
  LEDRegions[HCount].x := Screen.Width - LEDRegions[HCount].w;
  LEDRegions[HCount].y := 0;
  LEDRegions[HCount].Mode := 2;
  //Right
  for Index := 1 to VCount - 1 do
   begin
    LEDRegions[Index+HCount].w := Round(CWidth * MultD);
    LEDRegions[Index+HCount].h := Round(VStep * MultW);
    LEDRegions[Index+HCount].x := Right - LEDRegions[Index+HCount].w;
    LEDRegions[Index+HCount].y := Index*VStep - CHeight - ((LEDRegions[Index+HCount].h - VStep) DIV 2);
    LEDRegions[Index+HCount].Mode := 3;
    if LEDRegions[Index+HCount].x < 0 then LEDRegions[Index+HCount].x := 0;
    if LEDRegions[Index+HCount].x > Screen.Width then LEDRegions[Index+HCount].x := Screen.Width - 1;
    if LEDRegions[Index+HCount].x + LEDRegions[Index+HCount].w > Screen.Width then LEDRegions[Index+HCount].w := Screen.Width - LEDRegions[Index+HCount].x;
    if LEDRegions[Index+HCount].y < 0 then LEDRegions[Index+HCount].y := 0;
    if LEDRegions[Index+HCount].y > Screen.Height then LEDRegions[Index+HCount].y := Screen.Height - 1;
    if LEDRegions[Index+HCount].y + LEDRegions[Index+HCount].h > Screen.Height then LEDRegions[Index+HCount].h := Screen.Height - LEDRegions[Index+HCount].y;
   end;
  //LR Corner
  LEDRegions[HCount+VCount].w := Round(CWidth * (MultD + MultW) / 2);
  LEDRegions[HCount+VCount].h := Round(CHeight * (MultD + MultW) / 2);
  LEDRegions[HCount+VCount].x := Screen.Width - LEDRegions[HCount+VCount].w;
  LEDRegions[HCount+VCount].y := Screen.Height - LEDRegions[HCount+VCount].h;
  LEDRegions[HCount+VCount].Mode := 4;
  //Bot
  for Index := 1 to HCount - 1 do
   begin
    LEDRegions[Index+HCount+VCount].w := Round(HStep * MultW);
    LEDRegions[Index+HCount+VCount].h := Round(CHeight * MultD);
    LEDRegions[Index+HCount+VCount].x := Right - Index*HStep - CWidth - ((LEDRegions[Index+HCount+VCount].w - HStep) DIV 2);
    LEDRegions[Index+HCount+VCount].y := Bot - LEDRegions[Index+HCount+VCount].h;
    LEDRegions[Index+HCount+VCount].Mode := 5;
    if LEDRegions[Index+HCount+VCount].x < 0 then LEDRegions[Index+HCount+VCount].x := 0;
    if LEDRegions[Index+HCount+VCount].x > Screen.Width then LEDRegions[Index+HCount+VCount].x := Screen.Width - 1;
    if LEDRegions[Index+HCount+VCount].x + LEDRegions[Index+HCount+VCount].w > Screen.Width then LEDRegions[Index+HCount+VCount].w := Screen.Width - LEDRegions[Index+HCount+VCount].x;
    if LEDRegions[Index+HCount+VCount].y < 0 then LEDRegions[Index+HCount+VCount].y := 0;
    if LEDRegions[Index+HCount+VCount].y > Screen.Height then LEDRegions[Index+HCount+VCount].y := Screen.Height - 1;
    if LEDRegions[Index+HCount+VCount].y + LEDRegions[Index+HCount+VCount].h > Screen.Height then LEDRegions[Index+HCount+VCount].h := Screen.Height - LEDRegions[Index+HCount+VCount].y;
   end;
  //LL Corner
  LEDRegions[HCount+VCount+HCount].w := Round(CWidth * (MultD + MultW) / 2);
  LEDRegions[HCount+VCount+HCount].h := Round(CHeight * (MultD + MultW) / 2);
  LEDRegions[HCount+VCount+HCount].x := 0;
  LEDRegions[HCount+VCount+HCount].y := Screen.Height - LEDRegions[HCount+VCount+HCount].h - 1;
  LEDRegions[HCount+VCount+HCount].Mode := 6;
  //Left
  for Index := 1 to VCount - 1 do
   begin
    LEDRegions[Index+HCount+VCount+HCount].w := Round(CWidth * MultD);
    LEDRegions[Index+HCount+VCount+HCount].h := Round(VStep * MultW);
    LEDRegions[Index+HCount+VCount+HCount].x := Left;
    LEDRegions[Index+HCount+VCount+HCount].y := Screen.Height - Index*VStep - CHeight - ((LEDRegions[Index+HCount+VCount+HCount].h - VStep) DIV 2);
    LEDRegions[Index+HCount+VCount+HCount].Mode := 7;
    if LEDRegions[Index+HCount+VCount+HCount].w > Screen.Width then LEDRegions[Index+HCount+VCount+HCount].w := Screen.Width;
    if LEDRegions[Index+HCount+VCount+HCount].y < 0 then LEDRegions[Index+HCount+VCount+HCount].y := 0;
    if LEDRegions[Index+HCount+VCount+HCount].y > Screen.Height then LEDRegions[Index+HCount+VCount+HCount].y := Screen.Height - 1;
    if LEDRegions[Index+HCount+VCount+HCount].y + LEDRegions[Index+HCount+VCount+HCount].h > Screen.Height then LEDRegions[Index+HCount+VCount+HCount].h := Screen.Height - LEDRegions[Index+HCount+VCount+HCount].y;
   end;
 end;
//- End MakeRegions ----------------------------------------------------------//

//- Shell Exec ---------------------------------------------------------------\\
procedure ShellExec(CommandLine: String);
var
  ProgramSEI: TShellExecuteInfo;
  CLParams: String;
  PrevSpaceIndex: Integer;
 begin
  CLParams := '';
  while not(FileExists(CommandLine)) and (pos(' ', CommandLine) > 0) do
   begin
    PrevSpaceIndex := pos(' ', CommandLine);
    while (pos(' ', copy(CommandLine, PrevSpaceIndex + 1, length(CommandLine))) > 0) do
      PrevSpaceIndex := PrevSpaceIndex + pos(' ', copy(CommandLine, PrevSpaceIndex + 1, length(CommandLine)));
    CLParams := copy(CommandLine, PrevSpaceIndex + 1, length(CommandLine)) + ' ' + CLParams;
    CommandLine := copy(CommandLine, 1, PrevSpaceIndex - 1);
   end;
  if (CLParams <> '') then
   begin
    CLParams := copy(CLParams, 1, length(CLParams) - 1);
    if not(FileExists(CommandLine)) then
     begin
      CommandLine := CommandLine + ' ' + CLParams;
      CLParams := '';
     end;
   end;
  with ProgramSEI do
   begin
    cbSize := SizeOf(ProgramSEI);
    fMask := SEE_MASK_DOENVSUBST or SEE_MASK_FLAG_DDEWAIT;
    Wnd := Application.Handle;
    lpVerb := '';
    lpFile := PChar(CommandLine);
    lpParameters := PChar(CLParams);
    lpDirectory := PChar(ExtractFilePath(CommandLine));
    nShow := SW_SHOWNORMAL;
    hProcess := Application.Handle;
   end;
  ShellExecuteEx(@ProgramSEI);
 end;
//- End Shell Exec -----------------------------------------------------------//









//----------------------------------------------------------------------------\\
//- Startup Functions --------------------------------------------------------||
//----------------------------------------------------------------------------//

//- Form Create --------------------------------------------------------------\\
procedure TRPMForm.FormCreate(Sender: TObject);
 begin
  //Create Tray Icon
  HMainIcon:=LoadIcon(MainInstance, 'MAINICON');
  Shell_NotifyIcon(NIM_DELETE, @TrayIcon);
  with trayIcon do
   begin
    cbSize              := sizeof(TNotifyIconData);
    Wnd                 := handle;
    uID                 := 123;
    uFlags              := NIF_MESSAGE or NIF_ICON or NIF_TIP;
    uCallbackMessage    := WM_NOTIFYICON;
    hIcon               := HMainIcon;
    szTip               := 'Click to configure RPM Light';
   end;
  Application.OnMinimize:= MinimizeClick;

  //Handle PowerEvents
  Application.OnMessage := AppMessage;

  //Handle PowerEvents
  DemoStrings := TStringList.Create;

  //No "Flicker"
  RPMForm.DoubleBuffered := True;

  //Set Side Panels
  PanelStill.Height := 34;
  PanelExpand.Height := 34;
  PanelSound.Height := 34;
  PanelFile.Height := 34;

  //Set Image Preview to Blue Screen
//  ImagePreview.Picture.Bitmap.HandleType := bmDIB;
  ImagePreview.Canvas.Brush.Color := $FF0000;
  ImagePreview.Canvas.FillRect(Rect(0,0,640,360));

  //Position
  RPMForm.ClientHeight := 383;
  RPMForm.ClientWidth := 219;
  RPMForm.Left := (Screen.Width - 225) DIV 2;
  RPMForm.Top := (Screen.Height - 409) DIV 2;
 end;
//- End Form Create ----------------------------------------------------------//

//- Form Activate ------------------------------------------------------------\\
procedure TRPMForm.FormActivate(Sender: TObject);
var
  Temp: TStrings;
 begin
  if FileExists('RPMlight.cfg') then
   begin
    Temp := TStringList.Create;
    try
      Temp.LoadFromFile('RPMlight.cfg');

      //Load Config Tab
      if (Temp.Values['LEDNum'] <> '') then LEDNum.ItemIndex := LEDNum.Items.IndexOf(Temp.Values['LEDNum']);
      if (Temp.Values['LEDAdj'] <> '') then LEDAdj.ItemIndex := LEDAdj.Items.IndexOf(Temp.Values['LEDAdj']);
      if (Temp.Values['SPNum'] <> '') then SPNum.ItemIndex := SPNum.Items.IndexOf(Temp.Values['SPNum']);
      if (Temp.Values['KEY1'] <> '') then KEY1.Text := Temp.Values['KEY1'];
      if (Temp.Values['KEY2'] <> '') then KEY2.Text := Temp.Values['KEY2'];
      if (Temp.Values['KEY3'] <> '') then KEY3.Text := Temp.Values['KEY3'];
      if (Temp.Values['ByteOrder'] <> '') then ByteOrder.ItemIndex := ByteOrder.Items.IndexOf(Temp.Values['ByteOrder']);
      if (Temp.Values['BaudRate'] <> '') then BaudRate.ItemIndex := BaudRate.Items.IndexOf(Temp.Values['BaudRate']);
      if (Temp.Values['Direction'] = 'CCW') then RadioCCW.Checked else RadioCW.Checked;

      //Load Sliders
      if (Temp.Values['MultW'] <> '') then
       begin
        MultW.Text := Temp.Values['MultW'];
        TrackW.Position := Round(StrToFloat(MultW.Text) * 10);
       end;
      if (Temp.Values['MultD'] <> '') then
       begin
        MultD.Text := Temp.Values['MultD'];
        TrackD.Position := Round(StrToFloat(MultD.Text) * 10);
       end;
      if (Temp.Values['MultR'] <> '') then
       begin
        MultR.Text := Temp.Values['MultR'];
        TrackR.Position := Round(150 - (StrToFloat(MultR.Text) * 100));
       end;
      if (Temp.Values['MultG'] <> '') then
       begin
        MultG.Text := Temp.Values['MultG'];
        TrackG.Position := Round(150 - (StrToFloat(MultG.Text) * 100));
       end;
      if (Temp.Values['MultB'] <> '') then
       begin
        MultB.Text := Temp.Values['MultB'];
        TrackB.Position := Round(150 - (StrToFloat(MultB.Text) * 100));
       end;
      if (Temp.Values['ColorMax'] <> '') then
       begin
        ColorMax.Text := Temp.Values['ColorMax'];
        TrackMax.Position := Round(383 - StrToInt(ColorMax.Text));
       end;
      if (Temp.Values['ColorZero'] <> '') then
       begin
        ColorZero.Text := Temp.Values['ColorZero'];
        Track0.Position := Round(127 - StrToInt(ColorZero.Text));
       end;
      if (Temp.Values['SubR'] <> '') then
       begin
        SubR.Text := Temp.Values['SubR'];
        TrackRS.Position := Round(127 - StrToInt(SubR.Text));
       end;
      if (Temp.Values['SubG'] <> '') then
       begin
        SubG.Text := Temp.Values['SubG'];
        TrackGS.Position := Round(127 - StrToInt(SubG.Text));
       end;
      if (Temp.Values['SubB'] <> '') then
       begin
        SubB.Text := Temp.Values['SubB'];
        TrackBS.Position := Round(127 - StrToInt(SubB.Text));
       end;

      //Margins
      if (Temp.Values['MarginTop'] <> '') then MarginTop.ItemIndex := MarginTop.Items.IndexOf(Temp.Values['MarginTop']);
      if (Temp.Values['MarginBot'] <> '') then MarginBot.ItemIndex := MarginBot.Items.IndexOf(Temp.Values['MarginBot']);
      if (Temp.Values['MarginLeft'] <> '') then MarginLeft.ItemIndex := MarginLeft.Items.IndexOf(Temp.Values['MarginLeft']);
      if (Temp.Values['MarginRight'] <> '') then MarginRight.ItemIndex := MarginRight.Items.IndexOf(Temp.Values['MarginRight']);
    except
      ShowMessage('Error:  RPMlight.cfg has invalid values.');
     end;
    Temp.Free;
   end;

  //Show Tray Icon - Can't during Create
  Shell_NotifyIcon(NIM_Add, @TrayIcon);
  ControllerStatus.Panels[0].Text := 'Idle.';
 end;
//- End Form Activate --------------------------------------------------------//


//- Form Destroy -------------------------------------------------------------\\
procedure TRPMForm.FormDestroy(Sender: TObject);
 begin
  try
    Shell_NotifyIcon(NIM_Delete, @TrayIcon);
    DemoStrings.Free;
    LEDArray := Nil;
    LEDRegions := Nil;
    SP.Free;
  except
   end;
 end;
//- End Form Destroy ---------------------------------------------------------//

//- PowerEvent AppMessage ----------------------------------------------------\\
procedure TRPMForm.AppMessage(var Msg: TMsg; var handled: Boolean);
 begin
  if (Msg.message = WM_SYSCOMMAND) and (Msg.wParam = SC_MONITORPOWER) then
   begin
    RPMForm.Caption := RPMForm.Caption + ' Power';
    if (Msg.lParam > 0) then
     begin
      ScreenCaptureTimer.Enabled := False;
      SendColor(0, 0, 0);
      Sleep(1);
      SendColor(0, 0, 0);
      Sleep(1);
      SendColor(0, 0, 0);
     end
    else
     begin
      //Doesn't actually fire on WAKE
      if RadioExpand.Checked then
        ScreenCaptureTimer.Enabled := True;
     end;
   end
  else if (Msg.message = WM_POWERBROADCAST) then
   begin
    if (Msg.wParam = PBT_APMRESUMEAUTOMATIC) or (Msg.wParam = PBT_APMRESUMESUSPEND) or (Msg.wParam = PBT_APMRESUMECRITICAL) then
     begin
      if RadioExpand.Checked then
        ScreenCaptureTimer.Enabled := True;
     end
    else if (Msg.wParam = PBT_APMSUSPEND) then
     begin
      ScreenCaptureTimer.Enabled := False;
      SendColor(0, 0, 0);
      Sleep(1);
      SendColor(0, 0, 0);
      Sleep(1);
      SendColor(0, 0, 0);
     end;
   end
  else if (Msg.message = WM_POWER) then
   begin
    if (Msg.wParam = PWR_CRITICALRESUME) or (Msg.wParam = PWR_SUSPENDRESUME) then
     begin
      if RadioExpand.Checked then
        ScreenCaptureTimer.Enabled := True;
     end
    else if (Msg.wParam = PWR_SUSPENDREQUEST) then
     begin
      ScreenCaptureTimer.Enabled := False;
      SendColor(0, 0, 0);
      Sleep(1);
      SendColor(0, 0, 0);
      Sleep(1);
      SendColor(0, 0, 0);
     end;
   end;
 end;
//- End PowerEvent AppMessage ------------------------------------------------//

procedure TRPMForm.PwrEventSuspend(Sender: TObject);
 begin
  ScreenCaptureTimer.Enabled := False;
  SendColor(0, 0, 0);
  Sleep(1);
  SendColor(0, 0, 0);
  Sleep(1);
  SendColor(0, 0, 0);
 end;

procedure TRPMForm.PwrEventQuerySuspend(Sender: TObject; var Allow: Boolean);
 begin
  ScreenCaptureTimer.Enabled := False;
  SendColor(0, 0, 0);
  Allow := True;
 end;

procedure TRPMForm.PwrEventResume(Sender: TObject);
 begin
  if RadioExpand.Checked then
    ScreenCaptureTimer.Enabled := True;
 end;
















//----------------------------------------------------------------------------\\
//- Timer Functions ----------------------------------------------------------||
//----------------------------------------------------------------------------//

//- Screen Capture -----------------------------------------------------------\\
procedure TRPMForm.ScreenCaptureTimerTimer(Sender: TObject);
var
  Index: Integer;
  hMemoryDC, hDMemoryDC, hDesktopDC: hDC;
  hBMP, hDBMP: hBITMAP;
  biDesktop, bi: TBitmapInfo;
  P: Pointer;
  PBits: PRGBTriple;
  XRatio, YRatio: Double;
 begin
try
  XRatio := (Screen.Width / 640);
  YRatio := (Screen.Height / 360);

  //Copy Desktop to Memory Bitmap
  hDesktopDC := GetDC(0);  //or CreateDC('DISPLAY', Nil, Nil, Nil);
  FillChar (biDesktop, SizeOf(biDesktop), 0);
  with biDesktop.bmiHeader do
   begin
    biSize := SizeOf(biDesktop.bmiHeader);
    biWidth := Screen.Width;
    biHeight := -Screen.Height;
    biPlanes := 1;
    biBitCount := 32;
    biCompression := BI_RGB;
   end;
  hDMemoryDC := CreateCompatibleDC(hDesktopDC);
  hDBMP := CreateDIBSection(hDMemoryDC, biDesktop, DIB_RGB_COLORS, P, 0, 0);
  SelectObject(hDMemoryDC, hDBMP);
  BitBlt(hDMemoryDC, 0, 0, Screen.Width, Screen.Height, hDesktopDC, 0, 0, SRCCOPY); //or $40000000 aka: CAPTUREBLT

  //Set Preview Background
  if RPMForm.Width > 300 then
   begin
    //BitBlt(ImagePreview.Canvas.Handle, 0, 0, Screen.Width, Screen.Height, hDMemoryDC, 0, 0, SRCCOPY);
    ImagePreview.Canvas.Brush.Color := $FF0000;
    ImagePreview.Canvas.FillRect(Rect(0,0,640,360));
    {ImagePreview.Picture.Bitmap := hDBMP;
    PBits := P;
    SetStretchBltMode(ImagePreview.Canvas.Handle, STRETCH_HALFTONE);
    SetBrushOrgEx(ImagePreview.Canvas.Handle, 0, 0, NIL);
    StretchDIBits(ImagePreview.Canvas.Handle, 0, 0, ImagePreview.Width, ImagePreview.Height, 0, 0, Screen.Width, Screen.Height, PBits, biDesktop, DIB_RGB_COLORS, SRCCOPY);}
   end;

  for Index := 0 to Length(LEDRegions) - 1 do
   begin
    FillChar (bi, SizeOf(bi), 0);
    with bi.bmiHeader do
     begin
      biSize := SizeOf(bi.bmiHeader);
      biWidth := LEDRegions[Index].w;
      biHeight := -LEDRegions[Index].h;
      biPlanes := 1;
      biBitCount := 32;
      biCompression := BI_RGB;
     end;
    hMemoryDC := CreateCompatibleDC(hDesktopDC);
    hBMP := CreateDIBSection(hMemoryDC, bi, DIB_RGB_COLORS, P, 0, 0);
    try
      SelectObject(hMemoryDC, hBMP);
      BitBlt(hMemoryDC, 0, 0, LEDRegions[Index].w, LEDRegions[Index].h, hDMemoryDC, LEDRegions[Index].x, LEDRegions[Index].y, SRCCOPY);
      PBits := P;

      //Shrink to 1x1
      SetStretchBltMode(hMemoryDC, STRETCH_HALFTONE);
      SetBrushOrgEx(hMemoryDC, 0, 0, NIL);
      StretchDIBits(hMemoryDC, 0, 0, 1, 1, 0, 0, LEDRegions[Index].w, LEDRegions[Index].h, PBits, bi, DIB_RGB_COLORS, SRCCOPY);

      //Set LED color
      if RadioExpand.Checked then
        SetLEDColor(Index, PBits.rgbtRed, PBits.rgbtGreen, PBits.rgbtBlue);

      //Show Color Region Preview
      if (RPMForm.Width > 300) then
       begin
        ImagePreview.Canvas.Brush.Color := RGB(PBits.rgbtRed, PBits.rgbtGreen, PBits.rgbtBlue);
        ImagePreview.Canvas.FillRect(Rect(Round(LEDRegions[Index].x / XRatio), Round(LEDRegions[Index].y / YRatio), Round((LEDRegions[Index].x / XRatio) + (LEDRegions[Index].w / XRatio)), Round((LEDRegions[Index].y / YRatio) + (LEDRegions[Index].h / YRatio))));
       end;
    //Free All Memory
    finally
      ReleaseDC(hBMP, hMemoryDC);
      DeleteDC(hMemoryDC);
      DeleteObject(hBMP);
     end;
   end;
  try
    if RadioExpand.Checked then
      SP.SendBuffer(Pointer(LEDArray), length(LEDArray) * 3)
    else
      ScreenCaptureTimer.Enabled := False;
  except
    ScreenCaptureTimer.Enabled := False;
    ShowMessage('Error:  Serial Port Write Failed.  Check Configuration Tab.');
   end;

  ReleaseDC(0, hDesktopDC);
  DeleteDC(hDMemoryDC);
  DeleteObject(hDBMP);

  if RPMForm.Width > 300 then
    ImagePreview.Picture.Bitmap.Modified := True;
except
  ScreenCaptureTimer.Enabled := False;
  ShowMessage('Error:  Screen Capture Failed.  Check Configuration Tab.');
 end;
 end;
//- End Screen Capture -------------------------------------------------------//





























//------------------------------------------------------------------------------
//--- User Interface -----------------------------------------------------------
//------------------------------------------------------------------------------


//- Radio Modes --------------------------------------------------------------\\
procedure TRPMForm.RadioExpandClick(Sender: TObject);
 begin
  RadioStill.Checked := False;
  RadioSound.Checked := False;
  RadioFile.Checked := False;
  PanelStill.Height := 34;
  PanelSound.Height := 34;
  PanelFile.Height := 34;
  if PanelExpand.Height = 34 then
   begin
    try
      if ButtonOpenSP.Caption = 'Open' then
        ButtonOpenSPClick(Nil);
      MakeRegions(StrToInt(LEDNum.Text), StrToInt(MarginTop.Text), StrToInt(MarginBot.Text), StrToInt(MarginLeft.Text), StrToInt(MarginRight.Text), StrToFloat(MultW.Text), StrToFloat(MultD.Text));
      PanelExpand.Height := 234;
      ScreenCaptureTimer.Enabled := True;
      ControllerStatus.Panels[0].Text := 'Sending Screen Colors.'
    except
      ShowMessage('Error:  Could Open Port and Create Regions.');
     end;
   end
  else
   begin
    ScreenCaptureTimer.Enabled := False;
    PanelExpand.Height := 34;
    ControllerStatus.Panels[0].Text := 'Idle.'
   end;
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.RadioExpandMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
 begin
  if RadioExpand.Checked then
    RadioExpand.Checked := False;  //Causes above ELSE case to run
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.RadioFileClick(Sender: TObject);
var
 searchResult: TSearchRec;
 begin
  RadioStill.Checked := False;
  RadioExpand.Checked := False;
  RadioSound.Checked := False;
  PanelStill.Height := 34;
  PanelExpand.Height := 34;
  PanelSound.Height := 34;
  PanelFile.Height := 234;
  FileList.Items.Clear;

  if FindFirst(ExtractFilePath(ParamStr(0)) + 'Files\*', faAnyFile - faDirectory, searchResult) = 0 then
   begin
    repeat
      FileList.Items.Add(searchResult.Name);
    until FindNext(searchResult) <> 0;
    FindClose(searchResult);
   end;
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.RadioSoundClick(Sender: TObject);
 begin
  RadioStill.Checked := False;
  RadioExpand.Checked := False;
  RadioFile.Checked := False;
  PanelStill.Height := 34;
  PanelExpand.Height := 34;
  PanelSound.Height := 234;
  PanelFile.Height := 34;
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.RadioStillClick(Sender: TObject);
 begin
  RadioExpand.Checked := False;
  RadioSound.Checked := False;
  RadioFile.Checked := False;
  PanelStill.Height := 234;
  PanelExpand.Height := 34;
  PanelSound.Height := 34;
  PanelFile.Height := 34;

  ScreenCaptureTimer.Enabled := False;
  //Enable locked options
  LEDNum.Enabled := True;
  SPNum.Enabled := True;
  BaudRate.Enabled := True;
  KEY1.Enabled := True;
  KEY2.Enabled := True;
  KEY3.Enabled := True;
 end;
//- End Radio Modes ----------------------------------------------------------//





//- Track Changes ------------------------------------------------------------\\
procedure TRPMForm.TrackWChange(Sender: TObject);
 begin
  MultW.Text := FloatToStr((TrackW.Position) / 10);
  if pos('.', MultW.Text) = 0 then MultW.Text := MultW.Text + '.0';
  MakeRegions(StrToInt(LEDNum.Text), StrToInt(MarginTop.Text), StrToInt(MarginBot.Text), StrToInt(MarginLeft.Text), StrToInt(MarginRight.Text), StrToFloat(MultW.Text), StrToFloat(MultD.Text));
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.TrackDChange(Sender: TObject);
 begin
  MultD.Text := FloatToStr((TrackD.Position) / 10);
  if pos('.', MultD.Text) = 0 then MultD.Text := MultD.Text + '.0';
  MakeRegions(StrToInt(LEDNum.Text), StrToInt(MarginTop.Text), StrToInt(MarginBot.Text), StrToInt(MarginLeft.Text), StrToInt(MarginRight.Text), StrToFloat(MultW.Text), StrToFloat(MultD.Text));
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.Track0Change(Sender: TObject);
 begin
  ColorZero.Text := IntToStr(127 - Track0.Position);
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.TrackMaxChange(Sender: TObject);
 begin
  ColorMax.Text := IntToStr(383 - TrackMax.Position);
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.TrackBChange(Sender: TObject);
 begin
  MultB.Text := FloatToStr((150 - TrackB.Position) / 100);
  if pos('.', MultB.Text) = 0 then MultB.Text := MultB.Text + '.0';
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.TrackGChange(Sender: TObject);
 begin
  MultG.Text := FloatToStr((150 - TrackG.Position) / 100);
  if pos('.', MultG.Text) = 0 then MultG.Text := MultG.Text + '.0';
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.TrackRChange(Sender: TObject);
 begin
  MultR.Text := FloatToStr((150 - TrackR.Position) / 100);
  if pos('.', MultR.Text) = 0 then MultR.Text := MultR.Text + '.0';
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.TrackRSChange(Sender: TObject);
 begin
  SubR.Text := IntToStr(127 - TrackRS.Position);
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.TrackGSChange(Sender: TObject);
 begin
  SubG.Text := IntToStr(127 - TrackGS.Position);
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.TrackBSChange(Sender: TObject);
 begin
  SubB.Text := IntToStr(127 - TrackBS.Position);
 end;
//- End Track Changes --------------------------------------------------------//


procedure TRPMForm.TrackFileSpeedChange(Sender: TObject);
 begin
  DemoTimer.Interval := 1000 - (TrackFileSpeed.Position * 50);
 end;



//- Still and Picture Mode ---------------------------------------------------\\
procedure TRPMForm.SendColor(R, G, B: Byte);
var
  Index: Integer;
 begin
  ScreenCaptureTimer.Enabled := False;
  if ButtonOpenSP.Caption = 'Open' then
    ButtonOpenSPClick(Nil);

  for Index := 1 to StrToInt(LEDNum.Text) do
   begin
    LEDArray[Index].rgbtBlue := R;
    LEDArray[Index].rgbtGreen := G;
    LEDArray[Index].rgbtRed := B;
   end;
  try
    SP.SendBuffer(Pointer(LEDArray), length(LEDArray) * 3);
    ControllerStatus.Panels[0].Text := 'Color Sent (' + IntToHex(R, 2) + IntToHex(G, 2) + IntToHex(B, 2) + ')';
  except
    ShowMessage('Error:  Cannot Send to Serial Port');
   end;
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.ButtOffClick(Sender: TObject);
 begin SendColor(0, 0, 0); end;
//------------------------------------------------------------------------------
procedure TRPMForm.ButtRClick(Sender: TObject);
 begin SendColor(255, 0, 0); end;
//------------------------------------------------------------------------------
procedure TRPMForm.ButtGClick(Sender: TObject);
 begin SendColor(0, 255, 0); end;
//------------------------------------------------------------------------------
procedure TRPMForm.ButtBClick(Sender: TObject);
 begin SendColor(0, 0, 255); end;
//------------------------------------------------------------------------------
procedure TRPMForm.ButtCClick(Sender: TObject);
 begin SendColor(0, 255, 255); end;
//------------------------------------------------------------------------------
procedure TRPMForm.ButtMClick(Sender: TObject);
 begin SendColor(255, 0, 255); end;
//------------------------------------------------------------------------------
procedure TRPMForm.ButtYClick(Sender: TObject);
 begin SendColor(255, 255, 0); end;
//------------------------------------------------------------------------------
procedure TRPMForm.ButtOnClick(Sender: TObject);
 begin SendColor(255, 255, 255); end;
//------------------------------------------------------------------------------
procedure TRPMForm.StillImageClick(Sender: TObject);
 begin
  SendColor(GetRValue(TempColor), GetGValue(TempColor), GetBValue(TempColor));
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.StillImageDblClick(Sender: TObject);
var
  TempPic: TPicture;
 begin
  if OpenPicture.Execute then
   begin
    if (pos('.jpg', OpenPicture.FileName) > 0) or (pos('.jpeg', OpenPicture.FileName) > 0) then
     begin
      TempPic := TPicture.Create;
      TempPic.LoadFromFile(OpenPicture.FileName);
      StillImage.Canvas.StretchDraw(StillImage.Canvas.ClipRect, TempPic.Graphic);
      TempPic.Free;
     end
    else
      StillImage.Picture.LoadFromFile(OpenPicture.FileName);
    //now set edge pixels?
   end;
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.StillImageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
 begin
  TempColor := StillImage.Canvas.Pixels[X, Y];
 end;
//- End Still and Picture Mode -----------------------------------------------//


function FadeToBlack: Boolean;
var
  SoFarSoGood: Boolean;
  Index: Integer;
 begin
  SoFarSoGood := True;
  for Index := 0 to Length(LEDArray) - 1 do
   begin
    if LEDArray[Index].rgbtBlue > 0 then
     begin
      LEDArray[Index].rgbtBlue := LEDArray[Index].rgbtBlue - 1;
      SoFarSoGood := False;
     end;
    if LEDArray[Index].rgbtGreen > 0 then
     begin
      LEDArray[Index].rgbtGreen := LEDArray[Index].rgbtGreen - 1;
      SoFarSoGood := False;
     end;
    if LEDArray[Index].rgbtRed > 0 then
     begin
      LEDArray[Index].rgbtRed := LEDArray[Index].rgbtRed - 1;
      SoFarSoGood := False;
     end;
   end;
  FadeToBlack := SoFarSoGood;
 end;



//- Play File Mode -----------------------------------------------------------\\
procedure TRPMForm.DemoTimerTimer(Sender: TObject);
var
  Ready: Boolean;
  Index: Integer;
  TempLine: String;
 begin
  try
  //Find Valid Line
  Ready := False;
  while not(Ready) do
   begin
    DemoIndex := DemoIndex + 1;
    if DemoIndex >= DemoStrings.Count then
     begin
      //Handle End Of File
      Ready := True;
      if APNothing.Checked then DemoTimer.Enabled := False
      else if APFade.Checked then
       begin
        if FadeToBlack then
          DemoTimer.Enabled := False;
       end
      else if APLoop.Checked then
        DemoIndex := -1
      else
       begin
        if APRandom.Checked then
          FileList.ItemIndex := GetTickCount MOD FileList.Items.Count
        else
         begin
          FileList.ItemIndex := FileList.ItemIndex + 1;
          if (FileList.ItemIndex >= FileList.Items.Count) then
           begin  //End of Files
            FileList.ItemIndex := 0;
            if (APNext.Checked) then   //No Repeat
              DemoTimer.Enabled := False;
           end;

         end;
        DemoStrings.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Files\' + FileList.Items.Strings[FileList.ItemIndex]);
        DemoIndex := -1;
       end;
     end
    else if copy(DemoStrings.Strings[DemoIndex], 1, 2) <> '//' then
      Ready := True;
   end;

  //Set Line Values
  if (DemoIndex > 0) and (DemoIndex < DemoStrings.Count) then
   begin
    TempLine := DemoStrings.Strings[DemoIndex];
    TempLine := TempLine + '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000' + '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000' + '000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
    for Index := 0 to Length(LEDArray) - 1 do
     begin
      while copy(TempLine, 0, 1) = ' ' do TempLine := copy(TempLine, 1, 2000);
      LEDArray[Index].rgbtBlue := StrToInt('$' + copy(TempLine, 0, 2));
      TempLine := copy(TempLine, 2, 2000);
      while copy(TempLine, 0, 1) = ' ' do TempLine := copy(TempLine, 1, 2000);
      LEDArray[Index].rgbtGreen := StrToInt('$' + copy(TempLine, 0, 2));
      TempLine := copy(TempLine, 2, 2000);
      while copy(TempLine, 0, 1) = ' ' do TempLine := copy(TempLine, 1, 2000);
      LEDArray[Index].rgbtRed := StrToInt('$' + copy(TempLine, 0, 2));
      TempLine := copy(TempLine, 2, 2000);
     end;
   end;
  SP.SendBuffer(Pointer(LEDArray), length(LEDArray) * 3)
  except
    DemoTimer.Enabled := False;
    ShowMessage('Error Playing Demo File!')
   end;
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.Button6Click(Sender: TObject);
 begin
  if NOT DirectoryExists(ExtractFilePath(ParamStr(0)) + 'Files') then
    MkDir(ExtractFilePath(ParamStr(0)) + 'Files');
  ShellExec(ExtractFilePath(ParamStr(0)) + 'Files');
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.FileListDblClick(Sender: TObject);
 begin
  DemoStrings.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Files\' + FileList.Items.Strings[FileList.ItemIndex]);
  DemoIndex := 0;
  DemoTimer.Enabled := True;
 end;
//- End Play File Mode -------------------------------------------------------//



//- Configuration Tab --------------------------------------------------------\\
procedure TRPMForm.SaveButtonClick(Sender: TObject);
var
  Temp: TStrings;
 begin
  Temp := TStringList.Create;
  try
    //Save Config Tab
    Temp.Add('LEDNum=' + LEDNum.Text);
    Temp.Add('LEDAdj=' + LEDAdj.Text);
    Temp.Add('SPNum=' + SPNum.Text);
    Temp.Add('KEY1=' + KEY1.Text);
    Temp.Add('KEY2=' + KEY2.Text);
    Temp.Add('KEY3=' + KEY3.Text);
    Temp.Add('ByteOrder=' + ByteOrder.Text);
    Temp.Add('BaudRate=' + BaudRate.Text);
    if RadioCCW.Checked then
      Temp.Add('Direction=CCW')
    else
      Temp.Add('Direction=CW');

    //Save Sliders
    Temp.Add('MultW=' + MultW.Text);
    Temp.Add('MultD=' + MultD.Text);
    Temp.Add('MultR=' + MultR.Text);
    Temp.Add('MultG=' + MultG.Text);
    Temp.Add('MultB=' + MultB.Text);
    Temp.Add('ColorMax=' + ColorMax.Text);
    Temp.Add('ColorZero=' + ColorZero.Text);
    Temp.Add('SubR=' + SubR.Text);
    Temp.Add('SubG=' + SubG.Text);
    Temp.Add('SubB=' + SubB.Text);

    Temp.Add('MarginTop=' + MarginTop.Text);
    Temp.Add('MarginBot=' + MarginBot.Text);
    Temp.Add('MarginLeft=' + MarginLeft.Text);
    Temp.Add('MarginRight=' + MarginRight.Text);

    Temp.SaveToFile('RPMlight.cfg');
    ControllerStatus.Panels[0].Text := 'Configuration Saved.'
  except
    ShowMessage('Error:  Cannot create configruration file.  Check write access.')
   end;
  Temp.Free;
 end;
//------------------------------------------------------------------------------
procedure TRPMForm.ButtonOpenSPClick(Sender: TObject);
 begin
  if ButtonOpenSP.Caption = 'Open' then
   begin
    try
      //Create Arrays
      SetLength(LEDArray, StrToInt(LEDNum.Text) + 1);
      LEDArray[0].rgbtBlue := StrToInt('$' + KEY1.Text);
      LEDArray[0].rgbtGreen := StrToInt('$' + KEY2.Text);
      LEDArray[0].rgbtRed := StrToInt('$' + KEY3.Text);
    except
      ShowMessage('Error:  Cannot Create LED Array.');
      Exit;
     end;
    try
      //Setup SerialPort
      SP := TBlockSerial.Create;
      SP.Connect(SPNum.Text);
      SP.Config(StrToIntDef(BaudRate.Text, 115200),8,'N',0,false,false);
      SP.SendByte(StrToInt('$' + LEDNum.Text));
    except
      ShowMessage('Error:  Cannot Open Serial Port.');
      Exit;
     end;
    ButtonOpenSP.Caption := 'Close';
    //Disable Initialized Fields
    LEDNum.Enabled := False;
    SPNum.Enabled := False;
    BaudRate.Enabled := False;
    KEY1.Enabled := False;
    KEY2.Enabled := False;
    KEY3.Enabled := False;
    ControllerStatus.Panels[0].Text := SPNum.Text + ' Open.'
   end
  else
   begin
    ScreenCaptureTimer.Enabled := False;
    LEDArray := Nil;
    try SP.Free; except end;
    ButtonOpenSP.Caption := 'Open';
    //Enable Locked Options
    LEDNum.Enabled := True;
    SPNum.Enabled := True;
    BaudRate.Enabled := True;
    KEY1.Enabled := True;
    KEY2.Enabled := True;
    KEY3.Enabled := True;
    ControllerStatus.Panels[0].Text := SPNum.Text + ' Closed.'
   end;
 end;
//- End Configuration Tab ----------------------------------------------------//




//- Maximize Overwrite -------------------------------------------------------\\
procedure TRPMForm._WM_GETMINMAXINFO( var mmInfo : TWMGETMINMAXINFO );
 begin
  with mmInfo.minmaxinfo^ do
   begin
    ptmaxposition.x := RPMForm.Left; //(Screen.Width - 871) DIV 2;
    ptmaxposition.y := RPMForm.Top;  //(Screen.Height - 409) DIV 2;
    ptmaxsize.x     := 871;
    ptmaxsize.y     := 409;
   end;
 end;
//- End Maximize Overwrite ---------------------------------------------------//



//- Tray Icon ----------------------------------------------------------------\\
procedure TRPMForm.ClickTrayIcon(var msg: TMessage);
 begin
  case msg.lparam of
    WM_LBUTTONUP, WM_LBUTTONDBLCLK:
     begin
      Application.Restore;
      If WindowState = wsMinimized then
        WindowState := wsNormal;
      visible:=true;
      SetForegroundWindow(Application.Handle);
     end;
   end;
 end;
//------------------------------------------------------------------------------
Procedure TRPMForm.MinimizeClick(Sender:TObject);
 begin
   hide;  //Hide the taskbar button
   if IsWindowVisible(Application.Handle) then
     ShowWindow(Application.Handle, SW_HIDE);
 end;
//- End Tray Icon ------------------------------------------------------------//




//----------------------------------------------------------------------------\\
//--- END FILE ---------------------------------------------------------------||
//----------------------------------------------------------------------------//
end.
