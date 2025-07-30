page 62714 "JURE Auto Rent Damages List"
{
    ApplicationArea = All;
    Caption = 'Auto Rent Damages';
    PageType = List;
    SourceTable = "JURE Auto Rent Damage";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Contract No."; Rec."Contract No.")
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
            }
        }
    }
}
