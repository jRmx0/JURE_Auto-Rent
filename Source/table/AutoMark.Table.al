table 62701 "JURE Auto Mark"
{
    Caption = 'Auto Mark';
    DataClassification = CustomerContent;
    DrillDownPageId = "JURE Auto Marks List";
    LookupPageId = "JURE Auto Marks List";


    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            ToolTip = 'Specifies a mark code for automobile.';
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            Tooltip = 'Specifies the description of the automobile mark.';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
