table 62703 "JURE Auto"
{
    Caption = 'Auto';
    DataClassification = CustomerContent;
    DrillDownPageId = "JURE Autos List";
    LookupPageId = "JURE Autos List"; // REVIEW: Page Ids

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;
            ToolTip = 'Specifies the number of the automobile. The field is filled automatically from a defined number series.';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            Tooltip = 'Specifies the name of the automobile.';
        }
        field(3; Mark; Code[10])
        {
            Caption = 'Mark';
            ToolTip = 'Specifies the mark of the automobile.';
            TableRelation = "JURE Auto Mark".Code;
        }
        field(4; Model; Code[10])
        {
            Caption = 'Model';
            ToolTip = 'Specifies the model of the automobile.';
            TableRelation = "JURE Auto Model".Code where("Mark Code" = field(Mark));
        }
        field(5; "Year of Manufacture"; Integer)
        {
            Caption = 'Year of Manufacture';
            ToolTip = 'Specifies the year of manufacture of the automobile.';

            trigger OnValidate()
            var
                CurrentYear: Integer;
                InvalidYearErr: Label 'Please enter a valid year (1886-%1).', Comment = '%1 sstands for the current year + 1';
            begin
                CurrentYear := Date2DMY(TODAY, 3);
                if (("Year of Manufacture" < 1886) and ("Year of Manufacture" <> 0)) or
                   ("Year of Manufacture" > CurrentYear + 1)
                then
                    Error(InvalidYearErr, CurrentYear + 1);
            end;
        }
        field(6; "Civil Insurance Valid Until"; Date)
        {
            Caption = 'Civil Insurance Valid Until';
            ToolTip = 'Specifies the date until the civil insurance of the automobile is valid.';
        }
        field(7; "Tech Inspection Valid Until"; Date)
        {
            Caption = 'Technical Inspection Valid Until';
            ToolTip = 'Specifies the date until the technical inspection of the automobile is valid.';
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the location code where the automobile is stored.';
            TableRelation = Location.Code;
        }
        field(9; "Rental Service No."; Code[20])
        {
            Caption = 'Rental Service Code';
            ToolTip = 'Specifies the rental service code associated with the automobile.';
            TableRelation = Resource."No.";
        }
        field(10; "Rental Price"; Decimal)
        {
            Caption = 'Rental Price';
            ToolTip = 'Shows the unit price of the selected rental service.';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Unit Price" where ("No." = field("Rental Service No.")));
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
        Auto: Record "JURE Auto";
        NoSeries: Codeunit "No. Series";
    begin
        AutoSetup.GetRecordOnce();

        if NoSeries.AreRelated(AutoSetup."Auto Nos.", xRec."No. Series") then
            "No. Series" := xRec."No. Series"
        else
            "No. Series" := AutoSetup."Auto Nos.";

        "No." := NoSeries.GetNextNo("No. Series");

        Auto.ReadIsolation(IsolationLevel::ReadUncommitted);
        Auto.SetLoadFields("No.");

        while Auto.Get("No.") do
            "No." := NoSeries.GetNextNo("No. Series");
    end;

    trigger OnRename()
    var
        RenameNotAllowedErr: Label 'Renaming is not allowed for this table.';
    begin
        Error(RenameNotAllowedErr);
    end;
}
