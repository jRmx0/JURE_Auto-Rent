table 62709 "JURE Finished Auto Rent Header"
{
    Caption = 'Finished Auto Rent Header';
    DataClassification = CustomerContent;
    LookupPageId = "JURE Finished Auto Rent Cons";

    fields
    {

        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the number of the document. The field is filled automatically from a defined number series.';
            Editable = false;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            ToolTip = 'Specifies the customer number for the auto rental.';
            Editable = false;
            TableRelation = Customer."No.";
        }
        field(3; "Driver's license picture"; MediaSet)
        {
            Caption = 'Driver''s license picture';
            ToolTip = 'Specifies the driver''s license picture associated with the auto rental.';
            Editable = false;
        }
        field(4; "Date"; Date)
        {
            Caption = 'Date';
            ToolTip = 'Specifies the date of the document.';
            Editable = false;
        }
        field(5; "Auto No."; Code[20])
        {
            Caption = 'Auto No.';
            ToolTip = 'Specifies the number of the auto being rented.';
            Editable = false;
            TableRelation = "JURE Auto"."No.";
        }
        field(6; "Reserved From"; Date)
        {
            Caption = 'Reserved From';
            ToolTip = 'Specifies the start date of the reservation.';
            Editable = false;
        }
        field(7; "Reserved To"; Date)
        {
            Caption = 'Reserved To';
            ToolTip = 'Specifies the end date of the reservation.';
            Editable = false;
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            ToolTip = 'Specifies the total amount for the rental.';
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
}
