table 62707 "JURE Auto Rent Line"
{
    Caption = 'Auto Rent Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Auto Rent Header No."; Code[20])
        {
            Caption = 'Auto Rent Contract No.';
            ToolTip = 'Specifies the number of the auto rent header to which this line belongs.';
            Editable = false;
            TableRelation = "JURE Auto Rent Header"."No.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            ToolTip = 'Specifies the line number of the auto rent line. This field is filled automatically.';
            Editable = false;
        }
        field(3; Type; Enum "JURE Auto Rent Line Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the type of the auto rent line, such as Item or Resource.';
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the number of the item or resource associated with this auto rent line.';
            TableRelation =
                if (Type = const(Item)) Item."No."
                else if (Type = const(Resource)) Resource."No.";

            trigger OnValidate()
            var
                Item: Record Item;
                Resource: Record Resource;
                AutoRentLineType: Enum "JURE Auto Rent Line Type";
            begin
                if "No." = '' then
                    exit;

                if Type = AutoRentLineType::Item then begin
                    Item.Get("No.");
                    Description := Item.Description;
                    Price := Item."Unit Price";
                end;

                if Type = AutoRentLineType::Resource then begin
                    Resource.Get("No.");
                    Description := Resource.Name;
                    Price := Resource."Unit Price";
                end;
            end;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the description of the item or resource associated with this auto rent line.';
            Editable = false;
        }
        field(6; Quantity; Integer)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the quantity of the item or resource associated with this auto rent line.';

            trigger OnValidate()
            begin
                Amount := Quantity * Price;
            end;
        }
        field(7; Price; Decimal)
        {
            Caption = 'Price';
            ToolTip = 'Specifies the price of the item or resource associated with this auto rent line.';
            Editable = false;
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            ToolTip = 'Specifies the total amount for the rental item / resource.';
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Auto Rent Header No.","Line No.")
        {
            Clustered = true;
            SumIndexFields = Amount;
        }
    }

    trigger OnInsert()
    var
    begin
        this.AssignLineNo();
    end;

    trigger OnModify()
    var
        LineErr: Label 'This line cannot be modified.';
    begin
        if "Line No." = 1 then
            Error(LineErr);
    end;

    trigger OnDelete()
    var
        LineErr: Label 'This line cannot be deleted.';
    begin
        if "Line No." = 1 then
            Error(LineErr);
    end;



    local procedure AssignLineNo()
    var
        AutoRentLine: Record "JURE Auto Rent Line";
    begin
        if "Line No." = 0 then begin
            AutoRentLine.SetRange("Auto Rent Header No.", "Auto Rent Header No.");
            if AutoRentLine.FindLast() then
                "Line No." := AutoRentLine."Line No." + 1
            else
                "Line No." := 2;
        end;
    end;
}
