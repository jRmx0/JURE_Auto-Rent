page 62711 "JURE Auto Rent Con Factbox"
{
    ApplicationArea = All;
    Caption = 'Driver''s License';
    PageType = CardPart;
    SourceTable = "JURE Auto Rent Header";

    InsertAllowed = false;
    LinksAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            field("Driver's license picture"; Rec."Driver's license picture")
            {
                ShowCaption = false;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ImportPicture)
            {
                Caption = 'Import Picture';
                Image = Import;
                ToolTip = 'Import Driver''s License Picture';
                Enabled = this.IsEditable and (Rec.Status = Rec.Status::Open);
                trigger OnAction()
                var
                    FromFileName: Text;
                    InStreamPic: InStream;
                    OverrideImageQst: Label 'Do you want to override Driver''s Licence picture?';
                begin
                    Rec.TestField("No.");

                    if Rec."Driver's license picture".Count > 0 then
                        if not Confirm(OverrideImageQst) then
                            exit;

                    if UploadIntoStream('Import', '', 'All Files (*.*)|*.*', FromFileName, InStreamPic) then begin
                        if FromFileName = '' then
                            exit;

                        Clear(Rec."Driver's license picture");
                        Rec."Driver's license picture".ImportStream(InStreamPic, FromFileName);
                        Rec.Modify(true);
                    end;
                end;
            }
            action(ExportFile)
            {
                Caption = 'Export Picture';
                Image = Export;
                ToolTip = 'Export Driver''s License Picture';
                Enabled = this.IsEditable and (Rec.Status = Rec.Status::Open);

                trigger OnAction()
                var
                    TenantMedia: Record "Tenant Media";
                    index: Integer;
                    FileName: Text;
                    InStreamPic: InStream;

                    ImgCaptionTxt: Label 'DriversLicense';
                    FileNameStringTxt: Label '%1_Image_%2.jpg', Comment = '%1 = Image Caption, %2 = Index';
                begin
                    if Rec."Driver's license picture".Count = 0 then
                        exit;

                    for index := 1 to Rec."Driver's license picture".Count do
                        if TenantMedia.Get(Rec."Driver's license picture".Item(index)) then begin
                            TenantMedia.CalcFields(Content);
                            if TenantMedia.Content.HasValue then begin
                                FileName := StrSubstNo(FileNameStringTxt, ImgCaptionTxt, index);
                                TenantMedia.Content.CreateInStream(InStreamPic);
                                DownloadFromStream(InStreamPic, '', '', '', FileName);
                            end;
                        end;

                end;
            }
            action(DeletePicture)
            {
                Caption = 'Delete Picture';
                Image = Delete;
                ToolTip = 'Delete Driver''s License Picture';
                Enabled = this.IsEditable and (Rec.Status = Rec.Status::Open);
                trigger OnAction()
                var
                    DeleteImageQst: Label 'Do you want to delete Driver''s License Picture?';
                begin
                    if Rec."Driver's license picture".Count > 0 then
                        if not Confirm(DeleteImageQst) then
                            exit;

                    Rec.TestField("No.");
                    Clear(Rec."Driver's license picture");
                    Rec.Modify(true);
                end;
            }
        }
    }

    var
    IsEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        this.IsEditable := this.Editable;
    end;
}
