import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic error;

  const Failure({
    required this.message,
    this.code,
    this.error,
  });

  @override
  List<Object?> get props => [message, code, error];

  @override
  String toString() => '$runtimeType: $message${code != null ? ' (Code: $code)' : ''}';
}

// Network Failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.error,
  });

  factory NetworkFailure.noInternet() => const NetworkFailure(
        message: 'No internet connection',
        code: 'NO_INTERNET',
      );

  factory NetworkFailure.timeout() => const NetworkFailure(
        message: 'Request timed out',
        code: 'TIMEOUT',
      );

  factory NetworkFailure.serverError({String? message}) => NetworkFailure(
        message: message ?? 'Server error occurred',
        code: 'SERVER_ERROR',
      );

  factory NetworkFailure.unknown({String? message}) => NetworkFailure(
        message: message ?? 'Network error occurred',
        code: 'NETWORK_ERROR',
      );
}

// Server Failures
class ServerFailure extends Failure {
  final int? statusCode;
  final Map<String, dynamic>? response;

  const ServerFailure({
    required super.message,
    this.statusCode,
    this.response,
    super.code,
    super.error,
  });

  factory ServerFailure.badRequest({String? message}) => ServerFailure(
        message: message ?? 'Bad request',
        statusCode: 400,
        code: 'BAD_REQUEST',
      );

  factory ServerFailure.unauthorized({String? message}) => ServerFailure(
        message: message ?? 'Unauthorized',
        statusCode: 401,
        code: 'UNAUTHORIZED',
      );

  factory ServerFailure.forbidden({String? message}) => ServerFailure(
        message: message ?? 'Forbidden',
        statusCode: 403,
        code: 'FORBIDDEN',
      );

  factory ServerFailure.notFound({String? message}) => ServerFailure(
        message: message ?? 'Not found',
        statusCode: 404,
        code: 'NOT_FOUND',
      );

  factory ServerFailure.conflict({String? message}) => ServerFailure(
        message: message ?? 'Conflict',
        statusCode: 409,
        code: 'CONFLICT',
      );

  factory ServerFailure.internalError({String? message}) => ServerFailure(
        message: message ?? 'Internal server error',
        statusCode: 500,
        code: 'INTERNAL_ERROR',
      );

  @override
  List<Object?> get props => [...super.props, statusCode, response];
}

// Authentication Failures
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
    super.error,
  });

  factory AuthFailure.invalidCredentials() => const AuthFailure(
        message: 'Invalid email or password',
        code: 'INVALID_CREDENTIALS',
      );

  factory AuthFailure.userNotFound() => const AuthFailure(
        message: 'User not found',
        code: 'USER_NOT_FOUND',
      );

  factory AuthFailure.userDisabled() => const AuthFailure(
        message: 'User account has been disabled',
        code: 'USER_DISABLED',
      );

  factory AuthFailure.emailAlreadyInUse() => const AuthFailure(
        message: 'Email is already registered',
        code: 'EMAIL_ALREADY_IN_USE',
      );

  factory AuthFailure.weakPassword() => const AuthFailure(
        message: 'Password is too weak',
        code: 'WEAK_PASSWORD',
      );

  factory AuthFailure.sessionExpired() => const AuthFailure(
        message: 'Session has expired',
        code: 'SESSION_EXPIRED',
      );

  factory AuthFailure.tokenExpired() => const AuthFailure(
        message: 'Token has expired',
        code: 'TOKEN_EXPIRED',
      );

  factory AuthFailure.tooManyRequests() => const AuthFailure(
        message: 'Too many failed attempts. Please try again later',
        code: 'TOO_MANY_REQUESTS',
      );
}

// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
    super.error,
  });

  factory CacheFailure.notFound() => const CacheFailure(
        message: 'Cache not found',
        code: 'CACHE_NOT_FOUND',
      );

  factory CacheFailure.expired() => const CacheFailure(
        message: 'Cache has expired',
        code: 'CACHE_EXPIRED',
      );

  factory CacheFailure.corrupted() => const CacheFailure(
        message: 'Cache data is corrupted',
        code: 'CACHE_CORRUPTED',
      );
}

// Database Failures
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    super.code,
    super.error,
  });

  factory DatabaseFailure.notFound() => const DatabaseFailure(
        message: 'Record not found',
        code: 'RECORD_NOT_FOUND',
      );

  factory DatabaseFailure.duplicate() => const DatabaseFailure(
        message: 'Duplicate record exists',
        code: 'DUPLICATE_RECORD',
      );

  factory DatabaseFailure.constraint() => const DatabaseFailure(
        message: 'Database constraint violation',
        code: 'CONSTRAINT_VIOLATION',
      );

  factory DatabaseFailure.connectionError() => const DatabaseFailure(
        message: 'Database connection error',
        code: 'CONNECTION_ERROR',
      );
}

// Validation Failures
class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;

  const ValidationFailure({
    required super.message,
    this.errors,
    super.code,
    super.error,
  });

  factory ValidationFailure.invalidInput({
    String? message,
    Map<String, List<String>>? errors,
  }) =>
      ValidationFailure(
        message: message ?? 'Invalid input provided',
        errors: errors,
        code: 'INVALID_INPUT',
      );

  factory ValidationFailure.requiredField(String fieldName) => ValidationFailure(
        message: '$fieldName is required',
        code: 'REQUIRED_FIELD',
        errors: {
          fieldName: ['This field is required']
        },
      );

  factory ValidationFailure.invalidFormat(String fieldName, String format) =>
      ValidationFailure(
        message: 'Invalid $format format for $fieldName',
        code: 'INVALID_FORMAT',
        errors: {
          fieldName: ['Invalid $format format']
        },
      );

  @override
  List<Object?> get props => [...super.props, errors];
}

// Business Logic Failures
class BusinessFailure extends Failure {
  const BusinessFailure({
    required super.message,
    super.code,
    super.error,
  });

  factory BusinessFailure.insufficientStock({
    required String productName,
    required int available,
    required int requested,
  }) =>
      BusinessFailure(
        message:
            'Insufficient stock for $productName. Available: $available, Requested: $requested',
        code: 'INSUFFICIENT_STOCK',
      );

  factory BusinessFailure.orderProcessing({String? message}) => BusinessFailure(
        message: message ?? 'Order processing failed',
        code: 'ORDER_PROCESSING_ERROR',
      );

  factory BusinessFailure.paymentFailed({String? message}) => BusinessFailure(
        message: message ?? 'Payment processing failed',
        code: 'PAYMENT_FAILED',
      );

  factory BusinessFailure.limitExceeded({String? message, String? limit}) =>
      BusinessFailure(
        message: message ?? 'Limit exceeded${limit != null ? ': $limit' : ''}',
        code: 'LIMIT_EXCEEDED',
      );

  factory BusinessFailure.operationNotAllowed({String? message}) =>
      BusinessFailure(
        message: message ?? 'Operation not allowed',
        code: 'OPERATION_NOT_ALLOWED',
      );
}

// Permission Failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
    super.error,
  });

  factory PermissionFailure.denied({String? message, String? permission}) =>
      PermissionFailure(
        message: message ??
            'Permission denied${permission != null ? ' for $permission' : ''}',
        code: 'PERMISSION_DENIED',
      );

  factory PermissionFailure.featureNotAvailable({String? feature}) =>
      PermissionFailure(
        message:
            '${feature ?? 'This feature'} is not available in your current plan',
        code: 'FEATURE_NOT_AVAILABLE',
      );

  factory PermissionFailure.roleRequired({String? role}) => PermissionFailure(
        message:
            'This action requires ${role ?? 'higher'} role',
        code: 'ROLE_REQUIRED',
      );
}

// File Failures
class FileFailure extends Failure {
  const FileFailure({
    required super.message,
    super.code,
    super.error,
  });

  factory FileFailure.notFound({String? fileName}) => FileFailure(
        message: 'File${fileName != null ? ' $fileName' : ''} not found',
        code: 'FILE_NOT_FOUND',
      );

  factory FileFailure.sizeExceeded({int? maxSize}) => FileFailure(
        message:
            'File size exceeds maximum allowed size${maxSize != null ? ' of ${maxSize}MB' : ''}',
        code: 'FILE_SIZE_EXCEEDED',
      );

  factory FileFailure.unsupportedType({String? type}) => FileFailure(
        message: 'Unsupported file type${type != null ? ': $type' : ''}',
        code: 'UNSUPPORTED_FILE_TYPE',
      );

  factory FileFailure.uploadFailed({String? message}) => FileFailure(
        message: message ?? 'File upload failed',
        code: 'UPLOAD_FAILED',
      );
}

// Device Failures
class DeviceFailure extends Failure {
  const DeviceFailure({
    required super.message,
    super.code,
    super.error,
  });

  factory DeviceFailure.cameraNotAvailable() => const DeviceFailure(
        message: 'Camera is not available',
        code: 'CAMERA_NOT_AVAILABLE',
      );

  factory DeviceFailure.locationNotAvailable() => const DeviceFailure(
        message: 'Location services are not available',
        code: 'LOCATION_NOT_AVAILABLE',
      );

  factory DeviceFailure.locationPermissionDenied() => const DeviceFailure(
        message: 'Location permission denied',
        code: 'LOCATION_PERMISSION_DENIED',
      );

  factory DeviceFailure.storageNotAvailable() => const DeviceFailure(
        message: 'Storage is not available',
        code: 'STORAGE_NOT_AVAILABLE',
      );
}

// Parsing Failures
class ParsingFailure extends Failure {
  const ParsingFailure({
    required super.message,
    super.code,
    super.error,
  });

  factory ParsingFailure.json({String? message}) => ParsingFailure(
        message: message ?? 'Failed to parse JSON',
        code: 'JSON_PARSING_ERROR',
      );

  factory ParsingFailure.xml({String? message}) => ParsingFailure(
        message: message ?? 'Failed to parse XML',
        code: 'XML_PARSING_ERROR',
      );

  factory ParsingFailure.dataType({String? expected, String? actual}) =>
      ParsingFailure(
        message:
            'Invalid data type${expected != null ? '. Expected: $expected' : ''}${actual != null ? ', Got: $actual' : ''}',
        code: 'INVALID_DATA_TYPE',
      );
}

// Unknown Failure
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unknown error occurred',
    String? code,
    super.error,
  }) : super(code: code ?? 'UNKNOWN_ERROR');
}