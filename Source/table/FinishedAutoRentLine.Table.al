table 62710 "JURE Finished Auto Rent Line"
{
    Caption = 'Finished Auto Rent Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Finished Auto Rent Header No."; Code[20])
        {
            Caption = 'Finished Auto Rent Contract No.';
            ToolTip = 'Specifies the number of the auto rent header to which this line belongs.';
            Editable = false;
            TableRelation = "JURE Finished Auto Rent Header"."No.";
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
            Editable = false;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the number of the item or resource associated with this auto rent line.';
            Editable = false;
            TableRelation =
                if (Type = const(Item)) Item."No."
                else if (Type = const(Resource)) Resource."No.";
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
            Editable = false;
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
        key(PK; "Finished Auto Rent Header No.","Line No.")
        {
            Clustered = true;
        }
    }
}
