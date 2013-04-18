unit NewDUnit.Listeners.GUIForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, NewDUnit.TestInterfaces, NewDUnit.TestRunner, Vcl.ComCtrls, Vcl.ImgList;

type
  TGUIFormRunner = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    StateImages: TImageList;
    RunImages: TImageList;
    ActionsImages: TImageList;
    Treeview1: TTreeView;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  GUIFormRunner: TGUIFormRunner;




implementation

uses  NewDUnit.Listeners.GUI;

{$R *.dfm}
const
  {: Indexes of the images used for test tree checkboxes }
  imgDISABLED        = 1;
  imgPARENT_DISABLED = 2;
  imgENABLED         = 3;

procedure TGUIFormRunner.Button1Click(Sender: TObject);
var
  TestRunner: TTestRunner;
  TempFixtures: ITestFixtures;
  TempFixture: ITestFixture;
  TempTest: ITest;
  CurrentNode: TTreeNode;
  TempNode: TTreeNode;
begin
    TestRunner := TTestRunner.Create(TGUIListener.Create(Self));


   // TestRunner.AddListener(TConsoleTestListener.Create);
    try
      TempFixtures := TestRunner.RunTests;
      CurrentNode := Treeview1.Items.AddFirst(TreeView1.Items.GetFirstNode, 'Tests');
      for TempFixture in TempFixtures.Fixtures do
      begin

        CurrentNode := Treeview1.Items.AddChild(TreeView1.Items.GetFirstNode, TempFixture.Name);
        for TempTest in TempFixture.Tests do
        begin
          TempNode := Treeview1.Items.AddChild(CurrentNode, TempTest.TestName);
          if TempTest.Enabled then
          begin
            TempNode.StateIndex := imgENABLED
          end else
          begin
            TempNode.StateIndex := imgDISABLED;
          end;
        end;
      end;


      Treeview1.Items.GetFirstNode.Expand(True);
    finally
      TestRunner.Free;
    end;
end;

end.
