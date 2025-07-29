page 62703 "JURE Autos List"
{
    ApplicationArea = All;
    Caption = 'Autos';
    PageType = List;
    SourceTable = "JURE Auto";
    UsageCategory = Lists;

    CardPageId = "JURE Auto Card";
    Editable = false;

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
                field(Name; Rec.Name)
                {
                }
                field(Mark; Rec.Mark)
                {
                }
                field(Model; Rec.Model)
                {
                }
                field("Year of Manufacture"; Rec."Year of Manufacture")
                {
                }
                field("Civil Insurance Valid Until"; Rec."Civil Insurance Valid Until")
                {
                }
                field("Tech Inspection Valid Until"; Rec."Tech Inspection Valid Until")
                {
                }
                field("Location Code"; Rec."Location Code")
                {
                }
                field("Rental Service No."; Rec."Rental Service No.")
                {
                }
                field("Rental Price"; Rec."Rental Price")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ViewReservations)
            {
                Caption = 'View Reservations';
                ToolTip = 'View all reservations for all automobiles.';
                Image = View;
                ApplicationArea = All;
                trigger OnAction()
                var
                    AutoReservationList: Page "JURE Auto Reservations List";
                begin
                    AutoReservationList.Run();
                end;
            }
        }
        area(Promoted)
        {
            actionref(ViewReservationsRef; ViewReservations)
            {
            }
        }
    }
}
