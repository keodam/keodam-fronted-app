import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const factory Failure.networkFailure({
    String? message,
  }) = NetworkFailure;

  const factory Failure.serverFailure({
    String? message,
    String? code,
  }) = ServerFailure;

  const factory Failure.unauthorizedFailure({
    String? message,
  }) = UnauthorizedFailure;

  const factory Failure.cacheFailure({
    String? message,
  }) = CacheFailure;

  const factory Failure.unknownFailure({
    String? message,
  }) = UnknownFailure;

  const Failure._();
}