// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receipt.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReceiptImpl _$$ReceiptImplFromJson(Map<String, dynamic> json) =>
    _$ReceiptImpl(
      id: json['id'] as String,
      saleId: json['saleId'] as String,
      receiptNumber: json['receiptNumber'] as String,
      template: json['template'] as String? ?? 'default',
      customFields: json['customFields'] as Map<String, dynamic>? ?? const {},
      format: json['format'] as String? ?? 'thermal',
      isPrinted: json['isPrinted'] as bool? ?? false,
      printedAt: json['printedAt'] == null
          ? null
          : DateTime.parse(json['printedAt'] as String),
      printerName: json['printerName'] as String?,
      digitalReceipt: json['digitalReceipt'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      organizationId: json['organizationId'] as String?,
      branchId: json['branchId'] as String?,
      registerId: json['registerId'] as String?,
      cashierId: json['cashierId'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      qrCode: json['qrCode'] as String?,
      barcode: json['barcode'] as String?,
      isReprint: json['isReprint'] as bool? ?? false,
      reprintCount: (json['reprintCount'] as num?)?.toInt(),
      reprintReason: json['reprintReason'] as String?,
      emailedAt: json['emailedAt'] == null
          ? null
          : DateTime.parse(json['emailedAt'] as String),
      emailedTo: json['emailedTo'] as String?,
      smsAt: json['smsAt'] == null
          ? null
          : DateTime.parse(json['smsAt'] as String),
      smsTo: json['smsTo'] as String?,
      signatureUrl: json['signatureUrl'] as String?,
      headerData: json['headerData'] as Map<String, dynamic>? ?? const {},
      footerData: json['footerData'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$$ReceiptImplToJson(_$ReceiptImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'saleId': instance.saleId,
      'receiptNumber': instance.receiptNumber,
      'template': instance.template,
      'customFields': instance.customFields,
      'format': instance.format,
      'isPrinted': instance.isPrinted,
      'printedAt': instance.printedAt?.toIso8601String(),
      'printerName': instance.printerName,
      'digitalReceipt': instance.digitalReceipt,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'organizationId': instance.organizationId,
      'branchId': instance.branchId,
      'registerId': instance.registerId,
      'cashierId': instance.cashierId,
      'metadata': instance.metadata,
      'qrCode': instance.qrCode,
      'barcode': instance.barcode,
      'isReprint': instance.isReprint,
      'reprintCount': instance.reprintCount,
      'reprintReason': instance.reprintReason,
      'emailedAt': instance.emailedAt?.toIso8601String(),
      'emailedTo': instance.emailedTo,
      'smsAt': instance.smsAt?.toIso8601String(),
      'smsTo': instance.smsTo,
      'signatureUrl': instance.signatureUrl,
      'headerData': instance.headerData,
      'footerData': instance.footerData,
    };
