class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic error;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.error,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException: $message${code != null ? ' (Code: $code)' : ''}';
}

// Network Exceptions
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class NoInternetException extends NetworkException {
  const NoInternetException()
      : super(
          message: 'No internet connection available',
          code: 'NO_INTERNET',
        );
}

class ServerException extends NetworkException {
  final int? statusCode;
  final Map<String, dynamic>? response;

  const ServerException({
    required super.message,
    this.statusCode,
    this.response,
    String? code,
    super.error,
    super.stackTrace,
  }) : super(
          code: code ?? 'SERVER_ERROR',
        );
}

class TimeoutException extends NetworkException {
  const TimeoutException({
    super.message = 'Request timed out',
    String? code,
  }) : super(
          code: code ?? 'TIMEOUT',
        );
}

// Authentication Exceptions
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class UnauthorizedException extends AuthException {
  const UnauthorizedException({
    super.message = 'Unauthorized access',
    String? code,
  }) : super(
          code: code ?? 'UNAUTHORIZED',
        );
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException({
    super.message = 'Invalid credentials provided',
    String? code,
  }) : super(
          code: code ?? 'INVALID_CREDENTIALS',
        );
}

class SessionExpiredException extends AuthException {
  const SessionExpiredException({
    super.message = 'Session has expired',
    String? code,
  }) : super(
          code: code ?? 'SESSION_EXPIRED',
        );
}

class TokenExpiredException extends AuthException {
  const TokenExpiredException({
    super.message = 'Token has expired',
    String? code,
  }) : super(
          code: code ?? 'TOKEN_EXPIRED',
        );
}

// Cache Exceptions
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class CacheNotFoundExecption extends CacheException {
  const CacheNotFoundExecption({
    super.message = 'Cache not found',
    String? code,
  }) : super(
          code: code ?? 'CACHE_NOT_FOUND',
        );
}

class CacheExpiredException extends CacheException {
  const CacheExpiredException({
    super.message = 'Cache has expired',
    String? code,
  }) : super(
          code: code ?? 'CACHE_EXPIRED',
        );
}

// Database Exceptions
class DatabaseException extends AppException {
  const DatabaseException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class RecordNotFoundException extends DatabaseException {
  const RecordNotFoundException({
    super.message = 'Record not found',
    String? code,
  }) : super(
          code: code ?? 'RECORD_NOT_FOUND',
        );
}

class DuplicateRecordException extends DatabaseException {
  const DuplicateRecordException({
    super.message = 'Duplicate record exists',
    String? code,
  }) : super(
          code: code ?? 'DUPLICATE_RECORD',
        );
}

// Validation Exceptions
class ValidationException extends AppException {
  final Map<String, List<String>>? errors;

  const ValidationException({
    required super.message,
    this.errors,
    String? code,
    super.error,
    super.stackTrace,
  }) : super(
          code: code ?? 'VALIDATION_ERROR',
        );
}

class InvalidInputException extends ValidationException {
  const InvalidInputException({
    required super.message,
    super.errors,
    String? code,
  }) : super(
          code: code ?? 'INVALID_INPUT',
        );
}

// Business Logic Exceptions
class BusinessException extends AppException {
  const BusinessException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class InsufficientStockException extends BusinessException {
  final String productId;
  final int requestedQuantity;
  final int availableQuantity;

  const InsufficientStockException({
    required this.productId,
    required this.requestedQuantity,
    required this.availableQuantity,
    String? message,
    String? code,
  }) : super(
          message: message ?? 'Insufficient stock available',
          code: code ?? 'INSUFFICIENT_STOCK',
        );
}

class OrderProcessingException extends BusinessException {
  final String orderId;

  const OrderProcessingException({
    required this.orderId,
    required super.message,
    String? code,
  }) : super(
          code: code ?? 'ORDER_PROCESSING_ERROR',
        );
}

class PaymentException extends BusinessException {
  const PaymentException({
    required super.message,
    String? code,
  }) : super(
          code: code ?? 'PAYMENT_ERROR',
        );
}

// Permission Exceptions
class PermissionException extends AppException {
  const PermissionException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class AccessDeniedException extends PermissionException {
  const AccessDeniedException({
    super.message = 'Access denied',
    String? code,
  }) : super(
          code: code ?? 'ACCESS_DENIED',
        );
}

class FeatureNotAvailableException extends PermissionException {
  const FeatureNotAvailableException({
    super.message = 'This feature is not available',
    String? code,
  }) : super(
          code: code ?? 'FEATURE_NOT_AVAILABLE',
        );
}

// File Exceptions
class FileException extends AppException {
  const FileException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class FileNotFoundException extends FileException {
  const FileNotFoundException({
    super.message = 'File not found',
    String? code,
  }) : super(
          code: code ?? 'FILE_NOT_FOUND',
        );
}

class FileSizeExceededException extends FileException {
  final int maxSize;
  final int actualSize;

  const FileSizeExceededException({
    required this.maxSize,
    required this.actualSize,
    String? message,
    String? code,
  }) : super(
          message: message ?? 'File size exceeds maximum allowed size',
          code: code ?? 'FILE_SIZE_EXCEEDED',
        );
}

class UnsupportedFileTypeException extends FileException {
  final String fileType;
  final List<String> supportedTypes;

  const UnsupportedFileTypeException({
    required this.fileType,
    required this.supportedTypes,
    String? message,
    String? code,
  }) : super(
          message: message ?? 'Unsupported file type',
          code: code ?? 'UNSUPPORTED_FILE_TYPE',
        );
}

// Parsing Exceptions
class ParsingException extends AppException {
  const ParsingException({
    required super.message,
    String? code,
    super.error,
    super.stackTrace,
  }) : super(
          code: code ?? 'PARSING_ERROR',
        );
}

class JsonParsingException extends ParsingException {
  const JsonParsingException({
    super.message = 'Failed to parse JSON',
    String? code,
    super.error,
    super.stackTrace,
  }) : super(
          code: code ?? 'JSON_PARSING_ERROR',
        );
}

// Device Exceptions
class DeviceException extends AppException {
  const DeviceException({
    required super.message,
    super.code,
    super.error,
    super.stackTrace,
  });
}

class CameraException extends DeviceException {
  const CameraException({
    super.message = 'Camera error',
    String? code,
  }) : super(
          code: code ?? 'CAMERA_ERROR',
        );
}

class LocationException extends DeviceException {
  const LocationException({
    super.message = 'Location error',
    String? code,
  }) : super(
          code: code ?? 'LOCATION_ERROR',
        );
}

// Third Party Service Exceptions
class ThirdPartyException extends AppException {
  final String service;

  const ThirdPartyException({
    required this.service,
    required super.message,
    String? code,
    super.error,
    super.stackTrace,
  }) : super(
          code: code ?? 'THIRD_PARTY_ERROR',
        );
}

// Unknown Exception
class UnknownException extends AppException {
  const UnknownException({
    super.message = 'An unknown error occurred',
    String? code,
    super.error,
    super.stackTrace,
  }) : super(
          code: code ?? 'UNKNOWN_ERROR',
        );
}