report 62700 "JURE Auto Rent Contract Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = LayoutName;

    dataset
    {
        dataitem(Header; "JURE Auto Rent Header")
        {
            column(AutoNo; "Auto No.")
            {
            }
            dataitem(Auto; "JURE Auto")
            {
                DataItemLink = "No." = field("Auto No.");
                column(Mark; Mark)
                {
                }
                column(Model; Model)
                {
                }
            }
            column(ReservedFrom; "Reserved From")
            {
            }
            column(ReservedTo;"Reserved To")
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
            dataitem(Line; "JURE Auto Rent Line")
            {
                DataItemLink = "Auto Rent Header No." = field("No.");
                column(Type; Type)
                {
                }
                column(Description; Description)
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(Price; Price)
                {
                }
                column(Amount; Amount)
                {
                }
            }
            dataitem(Rental; "JURE Auto Rent Line")
            {
                DataItemLink = "Auto Rent Header No." = field("No.");
                DataItemTableView = where("Line No." = const(1));
                column(RentalAmount; Rental.Amount)
                {
                }


            }
        }
    }

    rendering
    {
        layout(LayoutName)
        {
            Type = RDLC;
            LayoutFile = 'rdl/autoRentContractReport.rdl';
        }
    }
}
