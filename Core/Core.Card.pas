unit Core.Card;

interface

type
  ICard = interface
    ['{1BD19858-F354-498C-AF3D-E363122019A3}']
    function GetFacingUp : boolean;

    function Flip : boolean;
    property FacingUp : boolean read GetFacingUp;
  end;

  TCard = class(TInterfacedObject, ICard)
  private
    FFacingUp : boolean;
  public
    constructor Create;
    function GetFacingUp : boolean;
    function Flip : boolean;
    function TurnFaceDown : boolean;
  end;

implementation

{ TCard }

constructor TCard.Create;
begin
  inherited;
  //By default the card is facing up.
  FFacingUp := True;
end;

function TCard.Flip: boolean;
begin
  //Change the card from facing the way it is to the facing the other way.
  //A card can either be facing up, or down.
  FFacingUp := not FFacingUp;

  //Return the current facing up status.
  result := FFacingUp;
end;

function TCard.GetFacingUp: boolean;
begin
  //Return whether the card is facing up or not.
  result := FFacingUp;
end;

function TCard.TurnFaceDown: boolean;
begin
  //Make the card face down.
  FFacingUp := false;
  //Return the current facing up status.
  result := FFacingUp;
end;

end.
