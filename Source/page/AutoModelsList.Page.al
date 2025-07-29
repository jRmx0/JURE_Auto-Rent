page 62702 "JURE Auto Models List"
{
    ApplicationArea = All;
    Caption = 'Auto Models';
    PageType = List;
    SourceTable = "JURE Auto Model";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                ShowCaption = false;
                field("Mark Code"; Rec."Mark Code")
                {
                }
                field("Code"; Rec.Code)
                {
                }
                field(Description; Rec.Description)
                {
                }
            }
        }
    }
}
