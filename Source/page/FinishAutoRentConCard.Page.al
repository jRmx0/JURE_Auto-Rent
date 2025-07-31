page 62715 "JURE Finish Auto Rent Con Card"
{
    ApplicationArea = All;
    Caption = 'Finished Auto Rent Contract';
    PageType = Card;
    SourceTable = "JURE Finished Auto Rent Header";
    UsageCategory = None;
    Editable = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field("Date"; Rec."Date")
                {
                }
            }
            group(Customer)
            {
                Caption = 'Customer Details';

                field("Customer No."; Rec."Customer No.")
                {
                }
                part(AutoRentHeaderFactbox; "JURE Auto Rent Con Factbox")
                {
                SubPageLink = "No." = field("No.");
                }
            }
            group(Reservation)
            {
                Caption = 'Reservation Details';

                field("Auto No."; Rec."Auto No.")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
                field("Reserved From"; Rec."Reserved From")
                {
                }
                field("Reserved To"; Rec."Reserved To")
                {
                }
            }
            part(ContractLines; "JURE Finish Auto Rent Line LP")
            {
                SubPageLink = "Finished Auto Rent Header No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }
}
