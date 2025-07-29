page 62706 "JURE Active Auto Reserv List"
{
    ApplicationArea = All;
    Caption = 'Active Auto Reservations';
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

    trigger OnOpenPage()
    var
        TodayDate: Date;
    begin
        TodayDate := Today;
        Rec.SetRange("Reserved To", TodayDate, DMY2Date(31, 12, 9999));
    end;
}
