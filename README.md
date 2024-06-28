# BlanketOrderAttachmentManager

## Overview
This repository contains the source code for "BlanketOrderAttachmentManager," a solution designed to enhance Dynamics 365 Business Central by copying Attachments from Blanket Orders to Sales Orders. This project addresses a native limitation in Business Central, ensuring that important information is seamlessly transferred during the order conversion process.

## Features
- Automatic transfer of Attachments from Blanket Orders to Sales Orders.
- Supports copying of document attachments at both header and line levels.
- Customizable codeunit for handling the copying process.
- Simplifies order management by preserving critical information across document types.

## Components
- **Codeunit "Standard Events"**: Main orchestrator for copying Attachments.
- **EventSubscriber "OnAfterRun"**: Copies attachments from Blanket Order headers to Sales Order headers after the order conversion.
- **EventSubscriber "OnAfterInsertSalesOrderLine"**: Copies attachments from Blanket Order lines to Sales Order headers when a sales order line is inserted.
- **Procedure "CopyAttachments"**: Handles copying attachments from Blanket Order headers to Sales Order headers.
- **Procedure "CopyAttachmentsFromLines"**: Manages copying attachments from Blanket Order lines to Sales Order headers.

## Usage
To implement the copying of Attachments from Blanket Orders to Sales Orders in Business Central, integrate the provided codeunit and procedures. This will ensure that all necessary information is transferred automatically during the order conversion process.

## Video
Demonstration: Native Process in Business Central

https://github.com/ivanrlg/BlanketOrderAttachmentManager/assets/21310111/8550535c-2209-4721-a857-cd7020e52908



Enhanced Process: Copying Attachments from Blanket Orders to Sales Orders


https://github.com/ivanrlg/BlanketOrderAttachmentManager/assets/21310111/2251c2c5-7b10-497c-99e0-731100410516



## Contribution
Contributions to this project are welcome! If you have suggestions for improvements or have found issues, please follow our Contribution Guidelines.

## License
This project is available under the MIT License - see the LICENSE.md file for details.

## Acknowledgements
Special thanks to Dmitry Katson for his inspiring work, which formed the foundation for further exploration in this project. Additionally, gratitude to the community and all contributors for their support and input.

## Learn More
For a comprehensive understanding of how this project was conceived and developed, please refer to the detailed blog post on [How to Transfer Attachments from Blanket Orders to Sales Orders in Business Central](https://ivansingleton.dev/how-to-transfer-Attachments-from-blanket-orders-to-sales-orders-in-business-central/).

## Additional Notes
This project simplifies the transfer of Attachments within Business Central, ensuring critical information is maintained across document types. By automating the copying process, it enhances order management and efficiency. As technology evolves, this approach can be expanded and improved. I welcome feedback and further development, hoping this method will enhance order management practices in Business Central. Visit our [GitHub repository](https://github.com/ivanrlg/BlanketOrderAttachmentManager) to explore the code and contribute.
