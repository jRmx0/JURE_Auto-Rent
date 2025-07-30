codeunit 62700 "JUREAuto Rent Line Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::"JURE Auto Rent Header", 'OnAfterReservationSelection', '', false, false)]
    local procedure InsertAutoResource(AutoRentHeader: Record "JURE Auto Rent Header"; xAutoRentHeader: Record "JURE Auto Rent Header")
    var
        AutoRentLine: Record "JURE Auto Rent Line";
        Resource: Record Resource;
        Auto: Record "JURE Auto";
        AutoRentLineType: Enum "JURE Auto Rent Line Type";
        AutoErr: Label 'Auto with No. %1 not found.', Comment = '%1 = AutoNo';
        ResourceErr: Label 'Resource with No. %1 not found.', Comment = '%1 = Auto."Rental Service No."';
        NumberOfDays: Integer;
    begin
        if (xAutoRentHeader."Auto No." = AutoRentHeader."Auto No.") and
            (xAutoRentHeader."Reserved From" = AutoRentHeader."Reserved From") and
            (xAutoRentHeader."Reserved To" = AutoRentHeader."Reserved To") then
            exit;

        if AutoRentLine.Get(AutoRentHeader."No.", 1) and (AutoRentHeader."Auto No." = '') then begin
            AutoRentLine.Delete(false);
            exit;
        end;

        if AutoRentLine.Get(AutoRentHeader."No.", 1) then
            AutoRentLine.Delete(false);

        if not Auto.Get(AutoRentHeader."Auto No.") then
            Error(AutoErr, AutoRentHeader."Auto No.");
        if not Resource.Get(Auto."Rental Service No.") then
            Error(ResourceErr, Auto."Rental Service No.");

        NumberOfDays := (AutoRentHeader."Reserved To" - AutoRentHeader."Reserved From") + 1;

        AutoRentLine.Init();
        AutoRentLine."Auto Rent Header No." := AutoRentHeader."No.";
        AutoRentLine."Line No." := 1;
        AutoRentLine.Type := AutoRentLineType::Resource;
        AutoRentLine."No." := Resource."No.";
        AutoRentLine.Quantity := NumberOfDays;
        AutoRentLine.Insert(true);
    end;
}
