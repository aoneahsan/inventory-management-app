// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RegisterImpl _$$RegisterImplFromJson(Map<String, dynamic> json) =>
    _$RegisterImpl(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      branchId: json['branchId'] as String,
      name: json['name'] as String,
      location: json['location'] as String?,
      openingBalance: (json['openingBalance'] as num?)?.toDouble() ?? 0,
      currentBalance: (json['currentBalance'] as num?)?.toDouble() ?? 0,
      expectedBalance: (json['expectedBalance'] as num?)?.toDouble() ?? 0,
      status: $enumDecode(_$RegisterStatusEnumMap, json['status']),
      openedBy: json['openedBy'] as String,
      openedAt: DateTime.parse(json['openedAt'] as String),
      closedBy: json['closedBy'] as String?,
      closedAt: json['closedAt'] == null
          ? null
          : DateTime.parse(json['closedAt'] as String),
      denominations: (json['denominations'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      syncedAt: json['syncedAt'] == null
          ? null
          : DateTime.parse(json['syncedAt'] as String),
      totalSales: (json['totalSales'] as num?)?.toDouble() ?? 0,
      totalRefunds: (json['totalRefunds'] as num?)?.toDouble() ?? 0,
      totalCashIn: (json['totalCashIn'] as num?)?.toDouble() ?? 0,
      totalCashOut: (json['totalCashOut'] as num?)?.toDouble() ?? 0,
      transactionCount: (json['transactionCount'] as num?)?.toInt() ?? 0,
      paymentMethodTotals:
          (json['paymentMethodTotals'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, (e as num).toDouble()),
              ) ??
              const {},
      notes: json['notes'] as String?,
      recentTransactions: (json['recentTransactions'] as List<dynamic>?)
              ?.map((e) =>
                  RegisterTransaction.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      terminalId: json['terminalId'] as String?,
      requiresFloatCount: json['requiresFloatCount'] as bool? ?? false,
      lastActivityAt: json['lastActivityAt'] == null
          ? null
          : DateTime.parse(json['lastActivityAt'] as String),
    );

Map<String, dynamic> _$$RegisterImplToJson(_$RegisterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organizationId': instance.organizationId,
      'branchId': instance.branchId,
      'name': instance.name,
      'location': instance.location,
      'openingBalance': instance.openingBalance,
      'currentBalance': instance.currentBalance,
      'expectedBalance': instance.expectedBalance,
      'status': _$RegisterStatusEnumMap[instance.status]!,
      'openedBy': instance.openedBy,
      'openedAt': instance.openedAt.toIso8601String(),
      'closedBy': instance.closedBy,
      'closedAt': instance.closedAt?.toIso8601String(),
      'denominations': instance.denominations,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'syncedAt': instance.syncedAt?.toIso8601String(),
      'totalSales': instance.totalSales,
      'totalRefunds': instance.totalRefunds,
      'totalCashIn': instance.totalCashIn,
      'totalCashOut': instance.totalCashOut,
      'transactionCount': instance.transactionCount,
      'paymentMethodTotals': instance.paymentMethodTotals,
      'notes': instance.notes,
      'recentTransactions': instance.recentTransactions,
      'metadata': instance.metadata,
      'terminalId': instance.terminalId,
      'requiresFloatCount': instance.requiresFloatCount,
      'lastActivityAt': instance.lastActivityAt?.toIso8601String(),
    };

const _$RegisterStatusEnumMap = {
  RegisterStatus.open: 'open',
  RegisterStatus.closed: 'closed',
  RegisterStatus.suspended: 'suspended',
  RegisterStatus.counting: 'counting',
  RegisterStatus.reconciling: 'reconciling',
};

_$RegisterTransactionImpl _$$RegisterTransactionImplFromJson(
        Map<String, dynamic> json) =>
    _$RegisterTransactionImpl(
      id: json['id'] as String,
      registerId: json['registerId'] as String,
      type: $enumDecode(_$RegisterTransactionTypeEnumMap, json['type']),
      amount: (json['amount'] as num).toDouble(),
      reason: json['reason'] as String?,
      performedBy: json['performedBy'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      referenceId: json['referenceId'] as String?,
      referenceType: json['referenceType'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$RegisterTransactionImplToJson(
        _$RegisterTransactionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'registerId': instance.registerId,
      'type': _$RegisterTransactionTypeEnumMap[instance.type]!,
      'amount': instance.amount,
      'reason': instance.reason,
      'performedBy': instance.performedBy,
      'createdAt': instance.createdAt.toIso8601String(),
      'referenceId': instance.referenceId,
      'referenceType': instance.referenceType,
      'paymentMethod': instance.paymentMethod,
      'metadata': instance.metadata,
      'notes': instance.notes,
    };

const _$RegisterTransactionTypeEnumMap = {
  RegisterTransactionType.sale: 'sale',
  RegisterTransactionType.refund: 'refund',
  RegisterTransactionType.cashIn: 'cash_in',
  RegisterTransactionType.cashOut: 'cash_out',
  RegisterTransactionType.adjustment: 'adjustment',
  RegisterTransactionType.floatAddition: 'float_addition',
  RegisterTransactionType.floatRemoval: 'float_removal',
  RegisterTransactionType.tips: 'tips',
};

_$RegisterReportImpl _$$RegisterReportImplFromJson(Map<String, dynamic> json) =>
    _$RegisterReportImpl(
      registerId: json['registerId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      openingBalance: (json['openingBalance'] as num).toDouble(),
      closingBalance: (json['closingBalance'] as num).toDouble(),
      expectedBalance: (json['expectedBalance'] as num).toDouble(),
      discrepancy: (json['discrepancy'] as num).toDouble(),
      salesByPaymentMethod:
          (json['salesByPaymentMethod'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      refundsByPaymentMethod:
          (json['refundsByPaymentMethod'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      totalSales: (json['totalSales'] as num).toDouble(),
      totalRefunds: (json['totalRefunds'] as num).toDouble(),
      totalCashIn: (json['totalCashIn'] as num).toDouble(),
      totalCashOut: (json['totalCashOut'] as num).toDouble(),
      netRevenue: (json['netRevenue'] as num).toDouble(),
      transactionCount: (json['transactionCount'] as num).toInt(),
      denominationCounts:
          Map<String, int>.from(json['denominationCounts'] as Map),
      notes: json['notes'] as String?,
      preparedBy: json['preparedBy'] as String?,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      approvedBy: json['approvedBy'] as String?,
    );

Map<String, dynamic> _$$RegisterReportImplToJson(
        _$RegisterReportImpl instance) =>
    <String, dynamic>{
      'registerId': instance.registerId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'openingBalance': instance.openingBalance,
      'closingBalance': instance.closingBalance,
      'expectedBalance': instance.expectedBalance,
      'discrepancy': instance.discrepancy,
      'salesByPaymentMethod': instance.salesByPaymentMethod,
      'refundsByPaymentMethod': instance.refundsByPaymentMethod,
      'totalSales': instance.totalSales,
      'totalRefunds': instance.totalRefunds,
      'totalCashIn': instance.totalCashIn,
      'totalCashOut': instance.totalCashOut,
      'netRevenue': instance.netRevenue,
      'transactionCount': instance.transactionCount,
      'denominationCounts': instance.denominationCounts,
      'notes': instance.notes,
      'preparedBy': instance.preparedBy,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'approvedBy': instance.approvedBy,
    };
