codeunit 62701 "JURE Auto Contract"
{
    [EventSubscriber(ObjectType::Page, Page::"JURE Auto Rent Contract Card", OnAfterReturnAuto, '', false, false)]
    local procedure ReturnAuto(AutoRentHeader: Record "JURE Auto Rent Header")
    var
        AutoRentLine: Record "JURE Auto Rent Line";
        FinishedAutoRentHeader: Record "JURE Finished Auto Rent Header";
        FinishedAutoRentLine: Record "JURE Finished Auto Rent Line";
        AutoRentDamage: Record "JURE Auto Rent Damage";
        AutoDamage: Record "JURE Auto Damage";
        AutoDamageStatus: Enum "JURE Auto Damage Status";
        OpenStatusErr: Label 'Auto cannot be returned because it is in Open status.';
    begin
        if AutoRentHeader.Status = AutoRentHeader.Status::Open then
            Error(OpenStatusErr);

        // Move AutoRentHeader to FinishedAutoRentHeader
        FinishedAutoRentHeader.Init();
        FinishedAutoRentHeader."No." := AutoRentHeader."No.";
        FinishedAutoRentHeader."Customer No." := AutoRentHeader."Customer No.";
        FinishedAutoRentHeader."Driver's license picture" := AutoRentHeader."Driver's license picture"; // BUG: Does not save
        FinishedAutoRentHeader."Date" := AutoRentHeader."Date";
        FinishedAutoRentHeader."Auto No." := AutoRentHeader."Auto No.";
        FinishedAutoRentHeader."Reserved From" := AutoRentHeader."Reserved From";
        FinishedAutoRentHeader."Reserved To" := AutoRentHeader."Reserved To";
        FinishedAutoRentHeader.Amount := AutoRentHeader.Amount;
        FinishedAutoRentHeader.Insert(false);


        // Move AutoRentLines to FinishedAutoRentLines
        AutoRentLine.SetRange("Auto Rent Header No.", AutoRentHeader."No.");
        if AutoRentLine.FindSet() then
            repeat
                FinishedAutoRentLine.Init();
                FinishedAutoRentLine."Finished Auto Rent Header No." := FinishedAutoRentHeader."No.";
                FinishedAutoRentLine."Line No." := AutoRentLine."Line No.";
                FinishedAutoRentLine.Type := AutoRentLine.Type;
                FinishedAutoRentLine."No." := AutoRentLine."No.";
                FinishedAutoRentLine."Description" := AutoRentLine."Description";
                FinishedAutoRentLine.Quantity := AutoRentLine.Quantity;
                FinishedAutoRentLine.Price := AutoRentLine.Price;
                FinishedAutoRentLine.Amount := AutoRentLine.Amount;
                FinishedAutoRentLine.Insert(false);

                AutoRentLine.Delete(false);
            until AutoRentLine.Next() = 0;

        // Move AutoRentDamage to AutoDamage
        AutoRentDamage.SetRange("Contract No.", AutoRentHeader."No.");
        if AutoRentDamage.FindSet() then
            repeat
                AutoDamage.Init();
                AutoDamage."Auto No." := AutoRentHeader."Auto No.";
                AutoDamage.Date := AutoRentDamage.Date;
                AutoDamage."Description" := AutoRentDamage."Description";
                AutoDamage.Status := AutoDamageStatus::Relevant;
                AutoDamage.Insert(true);

                AutoRentDamage.Delete(false);
            until AutoRentDamage.Next() = 0;

        AutoRentHeader.Delete(false);
    end;
}
