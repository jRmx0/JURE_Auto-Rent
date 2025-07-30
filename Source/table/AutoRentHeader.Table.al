table 62706 "JURE Auto Rent Header"
{
    Caption = 'Auto Rent Header';
    DataClassification = CustomerContent;
    LookupPageId = "JURE Auto Rent Contracts List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            ToolTip = 'Specifies the number of the document. The field is filled automatically from a defined number series.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            ToolTip = 'Specifies the customer number for the auto rental.';
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                this.IsBlocked();
                this.HasDebt();
            end;
        }
        field(3; "Driver's license picture"; MediaSet)
        {
            Caption = 'Driver''s license picture';
            ToolTip = 'Specifies the driver''s license picture associated with the auto rental.';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the date of the document.';

            trigger OnValidate()
            begin
                if Rec.Date = 0D then
                    Rec.Date := Today();
            end;
        }
        field(5; "Auto No."; Code[20])
        {
            Caption = 'Auto No.';
            ToolTip = 'Specifies the number of the auto being rented.';
            TableRelation = "JURE Auto"."No.";
        }
        field(6; "Reserved From"; Date)
        {
            Caption = 'Reserved From';
            ToolTip = 'Specifies the start date of the reservation.';

            trigger OnValidate()
            begin
                this.IsValidReservation()
            end;
        }
        field(7; "Reserved To"; Date)
        {
            Caption = 'Reserved To';
            ToolTip = 'Specifies the end date of the reservation.';

            trigger OnValidate()
            begin
                this.IsValidReservation()
            end;
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            ToolTip = 'Specifies the total amount for the rental.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("JURE Auto Rent Line"."Amount" where("Auto Rent Header No." = field("No.")));
        }
        field(9; Status; Enum "JURE Auto Rent Header Status")
        {
            Caption = 'Status';
            ToolTip = 'Specifies the status of the rental.';
            Editable = false;
        }

        field(100; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series".Code;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        AutoSetup: Record "JURE Auto Setup";
        AutoRentContractHeader: Record "JURE Auto Rent Header";
        NoSeries: Codeunit "No. Series";
    begin
        AutoSetup.GetRecordOnce();

        if NoSeries.AreRelated(AutoSetup."Auto Rent Header Nos.", xRec."No. Series") then
            "No. Series" := xRec."No. Series"
        else
            "No. Series" := AutoSetup."Auto Rent Header Nos.";

        "No." := NoSeries.GetNextNo("No. Series");

        AutoRentContractHeader.ReadIsolation(IsolationLevel::ReadUncommitted);
        AutoRentContractHeader.SetLoadFields("No.");

        while AutoRentContractHeader.Get("No.") do
            "No." := NoSeries.GetNextNo("No. Series");
    end;

    trigger OnModify()
    begin
        this.IsOpen();

        this.OnAfterReservationSelection(Rec, xRec);
    end;

    trigger OnRename()
    var
        RenameNotAllowedErr: Label 'Renaming is not allowed for this table.';
    begin
        Error(RenameNotAllowedErr);
    end;


    local procedure IsBlocked()
    var
        Customer: Record Customer;
        BlockedErr: Label 'Customer is blocked.';
    begin
        Customer.Get(Rec."Customer No.");
        if Customer.Blocked <> Customer.Blocked::" " then
            Error(BlockedErr);
    end;

    local procedure HasDebt()
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        TotalAmount: Decimal;
        DebtErr: Label 'Customer has outstanding debts.';
    begin
        TotalAmount := 0;
        CustLedgerEntry.SetRange("Customer No.", Rec."Customer No.");
        if CustLedgerEntry.FindSet() then
            repeat
                CustLedgerEntry.CalcFields(Amount);
                TotalAmount += CustLedgerEntry.Amount;
            until CustLedgerEntry.Next() = 0;

        if TotalAmount > 0 then
            Error(DebtErr);

    end;

    local procedure IsValidReservation()
    var
        AutoReservation: Record "JURE Auto Reservation";
        InvalidDateErr: Label 'Couldn''t find reservation for this date.';
    begin
        if (Rec."Reserved From" = 0D) or (Rec."Reserved To" = 0D) then
            exit;

        AutoReservation.SetRange("Auto No.", Rec."Auto No.");
        AutoReservation.SetRange("Customer.No.", Rec."Customer No.");
        AutoReservation.SetRange("Reserved From", Rec."Reserved From");
        AutoReservation.SetRange("Reserved To", Rec."Reserved To");

        if AutoReservation.IsEmpty then
            Error(InvalidDateErr);
    end;

    local procedure IsOpen()
    var
        OpenErr: Label 'The auto rental header must be Open to modify the record.';
    begin
        if Rec.Status <> Rec.Status::Open then
            Error(OpenErr);
    end;

    procedure SetStatus(NewStatus: Enum "JURE Auto Rent Header Status")
    var
        StatusMsg: Label 'Status is already set to %1.', Comment = '%1 = NewStatus';
    begin
        if Rec.Status = NewStatus then begin
            Message(StatusMsg, NewStatus);
            exit;
        end;

        Rec.Status := NewStatus;
        Rec.Modify(false);
    end;


    [IntegrationEvent(false, false)]
    procedure OnAfterReservationSelection(AutoRentHeader: Record "JURE Auto Rent Header"; xAutoRentHeader: Record "JURE Auto Rent Header")
    begin
    end;
}
