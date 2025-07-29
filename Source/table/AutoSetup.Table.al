table 62700 "JURE Auto Setup"
{
    Caption = 'Auto Setup';
    DataClassification = CustomerContent;
    DrillDownPageId = "JURE Auto Setup Card";
    LookupPageId = "JURE Auto Setup Card";

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }
        field(2; "Auto Nos."; Code[20])
        {
            Caption = 'Auto Nos.';
            TableRelation = "No. Series".Code;
            Tooltip = 'Specifies the code for the number series that will be used to assign numbers to automobiles.';
        }
        field(3; "Auto Rent Header Nos."; Code[20])
        {
            Caption = 'Auto Rent Header Nos.';
            TableRelation = "No. Series".Code;
            Tooltip = 'Specifies the code for the number series that will be used to assign numbers to automobile rent document.';
        }
        field(4; "Add-ons Location"; Code[10])
        {
            Caption = 'Add-ons Location';
            TableRelation = Location.Code;
            Tooltip = 'Specifies the location code that will be assigned to add-ons.';
        }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if this.RecordHasBeenRead then
            exit;
        this.Get();
        this.RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        this.Reset();
        if not this.Get() then begin
            this.Init();
            this.Insert(true);
        end;
    end;
}
