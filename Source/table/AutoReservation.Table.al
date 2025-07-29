table 62704 "JURE Auto Reservation"
{
    Caption = 'Auto Reservation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Auto No."; Code[20])
        {
            Caption = 'Auto No.';
            Tooltip = 'Specifies the number of the automobile being reserved.';
            TableRelation = "JURE Auto"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            Editable = false;
            ToolTip = 'Specifies the line number of the reservation.';
        }
        field(3; "Customer.No."; Code[20])
        {
            Caption = 'Customer.No.';
            ToolTip = 'Specifies the customer for whom the automobile is reserved.';
            TableRelation = Customer."No.";
        }
        field(4; "Reserved From"; Date)
        {
            Caption = 'Reserved From';
            ToolTip = 'Specifies the date from which the automobile is reserved.';

            trigger OnValidate()
            begin
                this.CheckReservationDates();
                this.CheckReservationConflict();
            end;
        }
        field(5; "Reserved To"; Date)
        {
            Caption = 'Reserved To';
            ToolTip = 'Specifies the date until which the automobile is reserved.';

            trigger OnValidate()
            begin
                this.CheckReservationDates();
                this.CheckReservationConflict();
            end;
        }
    }

    keys
    {
        key(PK; "Auto No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        this.AssignLineNo();
    end;

    local procedure AssignLineNo()
    var
        AutoReservation: Record "JURE Auto Reservation";
        MaxLineNo: Integer;
        LineNoIncrement: Integer;
    begin
        LineNoIncrement := 10000;

        AutoReservation.SetRange("Auto No.", "Auto No.");
        if AutoReservation.FindLast() then
            MaxLineNo := AutoReservation."Line No."
        else
            MaxLineNo := 0;

        "Line No." := MaxLineNo + LineNoIncrement;

        AutoReservation.ReadIsolation(IsolationLevel::ReadUncommitted);
        AutoReservation.SetLoadFields("Auto No.", "Line No.");
        AutoReservation.SetRange("Auto No.", "Auto No.");

        while AutoReservation.Get("Line No.") do
            "Line No." += LineNoIncrement;
    end;

    local procedure CheckReservationDates()
    var
        ReservationDateErr: Label 'The start date cannot be greater than the end date.';
    begin
        if "Reserved From" = 0D then
            exit;
        if "Reserved To" = 0D then
            exit;

        if "Reserved From" > "Reserved To" then
            Error(ReservationDateErr);
    end;

    local procedure CheckReservationConflict()
    var
        AutoReservation: Record "JURE Auto Reservation";
        ConflictErr: Label 'The automobile is already reserved for the specified period.';
    begin
        if Rec."Reserved From" = 0D then
            exit;
        if Rec."Reserved To" = 0D then
            exit;

        AutoReservation.SetRange("Auto No.", Rec."Auto No.");
        AutoReservation.SetFilter("Line No.", '<>%1', Rec."Line No.");
        AutoReservation.SetFilter("Reserved From", '<=%1', Rec."Reserved To");
        AutoReservation.SetFilter("Reserved To", '>=%1', Rec."Reserved From");

        if not AutoReservation.IsEmpty() then
            Error(ConflictErr);
    end;
}
