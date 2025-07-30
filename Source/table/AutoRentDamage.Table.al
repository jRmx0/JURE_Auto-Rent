table 62708 "JURE Auto Rent Damage"
{
    Caption = 'Auto Rent Damage';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            ToolTip = 'Specifies the unique identifier of the auto rental contract.';
            TableRelation = "JURE Auto Rent Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the line number of the damage entry.';
            Editable = false;
        }
        field(3; "Date"; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the date when the damage was reported.';
        }
        field(4; "Description"; Text[100])
        {
            Caption = 'Damage Description';
            ToolTip = 'Specifies a description of the damage.';
        }
    }
    keys
    {
        key(PK; "Contract No.","Line No.")
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
        AutoRentDamage: Record "JURE Auto Rent Damage";
    begin
        if "Line No." = 0 then begin
            AutoRentDamage.SetRange("Contract No.", "Contract No.");
            if AutoRentDamage.FindLast() then
                "Line No." := AutoRentDamage."Line No." + 1
            else
                "Line No." := 1;
        end;
    end;
}
