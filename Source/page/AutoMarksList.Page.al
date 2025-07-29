page 62701 "JURE Auto Marks List"
{
    ApplicationArea = All;
    Caption = 'Auto Marks';
    PageType = List;
    SourceTable = "JURE Auto Mark";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                ShowCaption = false;
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
