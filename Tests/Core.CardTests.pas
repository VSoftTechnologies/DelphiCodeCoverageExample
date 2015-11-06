unit Core.CardTests;

interface

uses
  DUnitX.TestFramework;

type
  {$M+}
  [TestFixture]
  TCardTest = class
  published
    [Test]
    procedure A_Card_FacingUp_Once_Flipped_Is_Facing_Down;
  end;

implementation

uses
  Core.Card;

{ TCardTest }

procedure TCardTest.A_Card_FacingUp_Once_Flipped_Is_Facing_Down;
var
  sutCard : ICard;
begin
  //CREATE: Create the card under test
  sutCard := TCard.Create;
  //TEST: The flip call is being tested, so we call it.
  sutCard.Flip;
  //ASSERT: The card should now be facing Down
  Assert.AreEqual(False, sutCard.FacingUp);
end;

initialization

TDUnitX.RegisterTestFixture(TCardTest);

end.
