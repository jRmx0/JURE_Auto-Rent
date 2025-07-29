page 62700 "JURE Auto Setup Card"
{
    ApplicationArea = All;
    Caption = 'Auto Setup';
    PageType = Card;
    SourceTable = "JURE Auto Setup";
    UsageCategory = Administration;

    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Add-ons Location"; Rec."Add-ons Location")
                {
                }
            }
            group("Number Series")
            {
                Caption = 'Number Series';
                field("Auto Nos."; Rec."Auto Nos.")
                {
                }
                field("Auto Rent Header Nos."; Rec."Auto Rent Header Nos.")
                {
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.InsertIfNotExists();
    end;
}
