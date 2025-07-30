page 62707 "JURE Auto Damage List"
{
    ApplicationArea = All;
    Caption = 'Auto Damage';
    PageType = List;
    SourceTable = "JURE Auto Damage";
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
                field("Date"; Rec."Date")
                {
                }
                field("Description"; Rec."Description")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
        }
    }
}
