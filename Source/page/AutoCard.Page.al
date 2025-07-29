page 62704 "JURE Auto Card"
{
    ApplicationArea = All;
    Caption = 'Auto';
    PageType = Card;
    SourceTable = "JURE Auto";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
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
            }
            group("Insurance & Inspection")
            {
                Caption = 'Insurance & Inspection';
                field("Civil Insurance Valid Until"; Rec."Civil Insurance Valid Until")
                {
                }
                field("Tech Inspection Valid Until"; Rec."Tech Inspection Valid Until")
                {
                }
            }
            group(Location)
            {
                Caption = 'Location';
                field("Location Code"; Rec."Location Code")
                {
                }
            }
            group(Rental)
            {
                Caption = 'Rental';
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
                Caption = 'View Reservation';
                ToolTip = 'View reservations for this automobile.';
                Image = View;
                trigger OnAction()
                var
                    AutoReservationRec: Record "JURE Auto Reservation";
                begin
                    AutoReservationRec.SetRange("Auto No.", Rec."No.");
                    PAGE.Run(PAGE::"JURE Auto Reservations List", AutoReservationRec);
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
