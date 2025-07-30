codeunit 62700 "JUREAuto Rent Line Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"JURE Auto Rent Header", 'OnAfterAutoSelection', '', false, false)]
    local procedure InsertAutoResource(ContractNo: Code[20]; AutoNo: Code[20])
    var
        AutoRentLine: Record "JURE Auto Rent Line";
        Resource: Record Resource;
        Auto: Record "JURE Auto";
        AutoRentLineType: Enum "JURE Auto Rent Line Type";
        AutoErr: Label 'Auto with No. %1 not found.', Comment = '%1 = AutoNo';
        ResourceErr: Label 'Resource with No. %1 not found.', Comment = '%1 = Auto."Rental Service No."';
    begin
        if AutoRentLine.Get(ContractNo, 1) and (AutoNo = '') then begin
            AutoRentLine.Delete(false);
            exit;
        end;

        if AutoRentLine.Get(ContractNo, 1) then
            AutoRentLine.Delete(false);

        if not Auto.Get(AutoNo) then
            Error(AutoErr, AutoNo);
        if not Resource.Get(Auto."Rental Service No.") then
            Error(ResourceErr, Auto."Rental Service No.");

        AutoRentLine.Init();
        AutoRentLine."Auto Rent Header No." := ContractNo;
        AutoRentLine."Line No." := 1;
        AutoRentLine.Type := AutoRentLineType::Resource;
        AutoRentLine."No." := Resource."No.";
        AutoRentLine.Quantity := 1;

        AutoRentLine.Insert(true);
    end;
}
