page 62713 "JURE Auto Rent Line ListPart"
{
    ApplicationArea = All;
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "JURE Auto Rent Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Auto Rent Contract Header No."; Rec."Auto Rent Contract Header No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Type"; Rec."Type")
                {
                    Editable = (Rec."Line No." <> 1);
                }
                field("No."; Rec."No.")
                {
                    Editable = (Rec."Line No." <> 1);
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
                    Editable = (Rec."Line No." <> 1);
                }
                field(Price; Rec.Price)
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
}
