report 62701 "JURE Auto Rent History"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Auto; "JURE Auto")
        {
            column(AutoNo; "No.")
            {
            }
            column(AutoMark; Mark)
            {
            }
            column(AutoModel; Model)
            {
            }
            dataitem(Contracts; "JURE Finished Auto Rent Header")
            {
                RequestFilterFields = "Reserved From", "Reserved To"; // TODO: Inlcude everything in between

                DataItemLink = "Auto No." = field("No.");
                DataItemTableView = sorting("Reserved From");
                column(ReservedFrom; "Reserved From")
                {
                }
                column(ReservedTo; "Reserved To")
                {
                }
                column(CustomerNo; "Customer No.")
                {
                }
                dataitem(Customer; Customer)
                {
                    DataItemLink = "No." = field("Customer No.");
                    column(CustomerName; Name)
                    {
                    }
                }
                column(Amount; Amount)
                {
                }

                trigger OnPreDataItem()
                var
                    FromFilter: Text;
                    ToFilter: Text;
                begin
                    FromFilter := GetFilter("Reserved From");
                    ToFilter := GetFilter("Reserved To");

                    if (FromFilter <> '') then
                        SetFilter("Reserved From", FromFilter + '..');
                    if (ToFilter <> '') then
                        SetFilter("Reserved To", '..' + ToFilter);
                end;
            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'rdl/autoRentHistory.rdl';
        }
    }
}
