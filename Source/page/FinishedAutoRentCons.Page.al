page 62716 "JURE Finished Auto Rent Cons"
{
    ApplicationArea = All;
    Caption = 'Finished Auto Rent Contracts';
    PageType = List;
    SourceTable = "JURE Finished Auto Rent Header";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
                {
                }
                field("Driver's license picture"; Rec."Driver's license picture")
                {
                }
                field("Date"; Rec."Date")
                {
                }
                field("Auto No."; Rec."Auto No.")
                {
                }
                field("Reserved From"; Rec."Reserved From")
                {
                }
                field("Reserved To"; Rec."Reserved To")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }
}
