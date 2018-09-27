object frmTestOmniQueue: TfrmTestOmniQueue
  Left = 0
  Top = 0
  Caption = 'OTL Queue'
  ClientHeight = 612
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lbLog: TListBox
    Left = 176
    Top = 0
    Width = 459
    Height = 612
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object btnSetMessage: TButton
    Left = 16
    Top = 32
    Width = 138
    Height = 33
    Caption = 'Enqueue'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = btnSetMessageClick
  end
end
