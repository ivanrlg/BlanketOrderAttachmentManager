codeunit 51200 "Standard Events"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", OnAfterRun, '', false, false)]
    local procedure OnAfterRun(var SalesHeader: Record "Sales Header"; var SalesOrderHeader: Record "Sales Header")
    var
        RecordLinkMgt: Codeunit "Record Link Management";
    begin
        // Copy attachments from the blanket order header to the sales order header
        CopyAttachments(SalesHeader, SalesOrderHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Blanket Sales Order to Order", OnAfterInsertSalesOrderLine, '', false, false)]
    local procedure OnAfterInsertSalesOrderLine(var SalesOrderLine: Record "Sales Line"; SalesOrderHeader: Record "Sales Header"; BlanketOrderSalesLine: Record "Sales Line"; BlanketOrderSalesHeader: Record "Sales Header")
    begin
        // Copy attachments from the blanket order lines to the sales order header
        CopyAttachmentsFromLines(BlanketOrderSalesLine, SalesOrderHeader);
    end;

    // Local procedure to copy attachments from the blanket order to the sales order
    local procedure CopyAttachments(var FromBlanketHeader: Record "Sales Header"; ToSalesHeader: Record "Sales Header");
    var
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
    begin
        // Filter attachments by the blanket order number
        FromDocumentAttachment.SetRange("Table ID", Database::"Sales Header");
        FromDocumentAttachment.SetRange("No.", FromBlanketHeader."No.");

        // Exit if no attachments are found
        if not FromDocumentAttachment.FindSet() then
            exit;

        repeat
            // Clear the target record and initialize it
            Clear(ToDocumentAttachment);
            ToDocumentAttachment.Init();

            // Transfer fields from the source to the target record
            ToDocumentAttachment.TransferFields(FromDocumentAttachment);

            // Validate and set required fields
            ToDocumentAttachment.Validate("No.", ToSalesHeader."No.");
            ToDocumentAttachment.Validate("Document Type", Enum::"Attachment Document Type"::Order);

            // Insert the new attachment record and update the attached date
            if not ToDocumentAttachment.Insert(true) then;

            ToDocumentAttachment."Attached Date" := FromDocumentAttachment."Attached Date";
            ToDocumentAttachment.Modify();
        until FromDocumentAttachment.Next() = 0;
    end;

    // Local procedure to copy attachments from the blanket order lines to the sales order header
    local procedure CopyAttachmentsFromLines(var FromBlanketLines: Record "Sales Line"; ToSalesHeader: Record "Sales Header");
    var
        FromDocumentAttachment: Record "Document Attachment";
        ToDocumentAttachment: Record "Document Attachment";
    begin
        // Filter attachments by the blanket order line number and document number
        FromDocumentAttachment.SetRange("Table ID", Database::"Sales Line");
        FromDocumentAttachment.SetRange("No.", FromBlanketLines."Document No.");
        FromDocumentAttachment.SetRange("Line No.", FromBlanketLines."Line No.");

        // Exit if no attachments are found
        if not FromDocumentAttachment.FindSet() then
            exit;

        repeat
            // Clear the target record and initialize it
            Clear(ToDocumentAttachment);
            ToDocumentAttachment.Init();

            // Transfer fields from the source to the target record
            ToDocumentAttachment.TransferFields(FromDocumentAttachment);

            // Validate and set required fields
            ToDocumentAttachment.Validate("No.", ToSalesHeader."No.");
            ToDocumentAttachment.Validate("Document Type", Enum::"Attachment Document Type"::Order);

            // Insert the new attachment record and update the attached date
            if not ToDocumentAttachment.Insert(true) then;

            ToDocumentAttachment."Attached Date" := FromDocumentAttachment."Attached Date";
            ToDocumentAttachment.Modify();
        until FromDocumentAttachment.Next() = 0;
    end;
}
