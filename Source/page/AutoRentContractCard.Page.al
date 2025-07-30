page 62710 "JURE Auto Rent Contract Card"
{
    ApplicationArea = All;
    Caption = 'Auto Rent Contract';
    PageType = Card;
    SourceTable = "JURE Auto Rent Header";
    UsageCategory = None;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = Rec.Status = this.Status::Open;

                field("No."; Rec."No.")
                {
                }
                field("Date"; Rec."Date")
                {
                }
                field(Status; Rec.Status)
                {
                }
            }
            group(Customer)
            {
                Caption = 'Customer Details';
                Editable = Rec.Status = this.Status::Open;

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
                Editable = Rec.Status = this.Status::Open;

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
            part(ContractLines; "JURE Auto Rent Line ListPart")
            {
                Editable = Rec.Status = this.Status::Open;
                Enabled = Rec.Status = this.Status::Open;
                SubPageLink = "Auto Rent Contract Header No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Return Auto") // TODO: Implementation
            {
                Caption = 'Return Auto';
                Image = Return;
                ToolTip = 'Return the auto for this rental contract.';

                trigger OnAction()
                begin
                    Message('OK');
                end;
            }
            action(Reopen)
            {
                Caption = 'Reopen';
                Image = ReOpen;
                ToolTip = 'Reopen the auto rental header.';
                Enabled = Rec.Status = this.Status::Released;

                trigger OnAction()
                begin
                    Rec.SetStatus(Rec.Status::Open);
                end;
            }
            action(Release)
            {
                Caption = 'Release';
                Image = ReleaseDoc;
                ToolTip = 'Release the auto rental header.';
                Enabled = Rec.Status = this.Status::Open;

                trigger OnAction()
                begin
                    Rec.SetStatus(Rec.Status::Released);
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';

                actionref(ReturnAutoRef; "Return Auto")
                {
                }
                actionref(ReopenRef; Reopen)
                {
                }
                actionref(ReleaseRef; Release)
                {
                }
            }
        }
    }

    var
        Status: Enum "JURE Auto Rent Header Status";
}
