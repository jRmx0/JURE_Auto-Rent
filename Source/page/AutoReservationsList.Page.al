page 62705 "JURE Auto Reservations List"
{
    ApplicationArea = All;
    Caption = 'Auto Reservations';
    PageType = List;
    SourceTable = "JURE Auto Reservation";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                ShowCaption = false;
                field("Auto No."; Rec."Auto No.")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field("Customer.No."; Rec."Customer.No.")
                {
                }
                field("Reserved From"; Rec."Reserved From")
                {
                }
                field("Reserved To"; Rec."Reserved To")
                {
                }
            }
        }
    }
}
