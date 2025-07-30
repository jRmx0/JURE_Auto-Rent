table 62702 "JURE Auto Model"
{
    Caption = 'Auto Model';
    DataClassification = CustomerContent;
    DrillDownPageId = "JURE Auto Models List";
    LookupPageId = "JURE Auto Models List";

    fields
    {
        field(1; "Mark Code"; Code[10])
        {
            Caption = 'Mark Code';
            NotBlank = true;
            TableRelation = "JURE Auto Mark".Code;
            ToolTip = 'Specifies a mark code for automobile.';
        }
        field(2; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
            ToolTip = 'Specifies a model code for given automobile mark.';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            Tooltip = 'Specifies the description of the specific automobile model.';
        }
    }

    keys
    {
        key(PK; "Mark Code", "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}
