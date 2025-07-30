page 62717 "JURE Finish Auto Rent Line LP"
{
    ApplicationArea = All;
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "JURE Finished Auto Rent Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Finished Auto Rent Header No."; Rec."Finished Auto Rent Header No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Type; Rec."Type")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Quantity; Rec.Quantity)
                {
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
