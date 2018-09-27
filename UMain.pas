unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  OtlCommon,
  OtlComm,
  OtlTask,
  OtlTaskControl,
  OtlContainers,
  OtlContainerObserver,
  OtlSync, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmTestOmniQueue = class(TForm)
    lbLog: TListBox;
    btnSetMessage: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSetMessageClick(Sender: TObject);
  private
    { Private declarations }
    FBlockSize: Integer;
    FMsgQueue: TOmniQueue;
    FObserver: TOmniContainerWindowsEventObserver;
    FEvent: TOmniTransitionEvent;
    FOnMessage: TOmniMessageQueueMessageEvent;
    FTask: IOmniTaskControl;
    procedure ReportMessage(const task: IOmniTaskControl; const msg: TOmniMessage);
    procedure OnNewMesssage(const Task: IOmniTask);

  public
    { Public declarations }
    property MsgQueue: TOmniQueue read FMsgQueue write FMsgQueue;
    property Observer: TOmniContainerWindowsEventObserver read FObserver  write FObserver;
    property Event: TOmniTransitionEvent read FEvent  write FEvent;
    property OnMessage: TOmniMessageQueueMessageEvent read FOnMessage  write FOnMessage;
    property Task: IOmniTaskControl read FTask  write FTask;

  end;

var
  frmTestOmniQueue: TfrmTestOmniQueue;

implementation

{$R *.dfm}

procedure TfrmTestOmniQueue.btnSetMessageClick(Sender: TObject);
begin
  MsgQueue.Enqueue(FormatDateTime('dd.mm.yy hh.nn.ss.zzz', Now));
end;

procedure TfrmTestOmniQueue.FormCreate(Sender: TObject);
begin
  FBlockSize := 64;
  MsgQueue := TOmniQueue.Create(FBlockSize * 1024);
  Observer := CreateContainerWindowsEventObserver;
  MsgQueue.ContainerSubject.Attach(Observer, coiNotifyOnAllInserts);
  Observer.Activate;

  Task := CreateTask(OnNewMesssage);
  Task.OnMessage(ReportMessage).WaitFor(Observer.GetEvent);
end;

procedure TfrmTestOmniQueue.FormDestroy(Sender: TObject);
begin
  if assigned(MsgQueue) and assigned(Observer) then
    MsgQueue.ContainerSubject.Detach(Observer, coiNotifyOnAllInserts);

  FreeAndNil(FObserver);
  FMsgQueue.Free;

  if Assigned(FTask) then
  begin
    FTask.Terminate;
    FTask := nil;
  end;
end;


procedure TfrmTestOmniQueue.OnNewMesssage(const Task: IOmniTask);
var
  value: TOmniValue;
begin
  while MsgQueue.TryDequeue(value) do
    lbLog.Items.Add(value);
end;

procedure TfrmTestOmniQueue.ReportMessage(const task: IOmniTaskControl; const msg: TOmniMessage);
begin
  lbLog.ItemIndex := lbLog.Items.Add(msg.MsgData);
end;

end.
