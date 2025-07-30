page 62709 "JURE Auto Rent Contracts List"
{
    ApplicationArea = All;
    Caption = 'Auto Rent Contracts';
    PageType = List;
    SourceTable = "JURE Auto Rent Header";
    UsageCategory = Lists;
    Editable = false;

    CardPageId = "JURE Auto Rent Contract Card";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                }
                field("Customer No."; Rec."Customer No.")
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
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
}
