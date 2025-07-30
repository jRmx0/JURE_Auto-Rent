table 62705 "JURE Auto Damage"
{
    Caption = 'Auto Damage';
    DataClassification = CustomerContent;
    DrillDownPageId = "JURE Auto Damage List";
    LookupPageId = "JURE Auto Damage List";

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
        field(3; "Date"; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the date of the damage.';
        }
        field(4; "Description"; Text[100])
        {
            Caption = 'Damage Description';
            ToolTip = 'Specifies the description of the damage to the automobile.';
        }
        field(5; Status; Enum "JURE Auto Damage Status")
        {
            Caption = 'Status';
            ToolTip = 'Specifies the status of the damage report.';
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
    var
    begin
        this.AssignLineNo();
    end;

    local procedure AssignLineNo()
    var
        AutoDamage: Record "JURE Auto Damage";
    begin
        if "Line No." = 0 then begin
            AutoDamage.SetRange("Auto No.", "Auto No.");
            if AutoDamage.FindLast() then
                "Line No." := AutoDamage."Line No." + 1
            else
                "Line No." := 1;
        end;
    end;
}
