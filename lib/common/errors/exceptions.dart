import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'exceptions.freezed.dart';

@freezed
class CustomException with _$CustomException implements Exception {
  const factory CustomException.networkException() = NetworkException;
  const factory CustomException.serverException() = ServerException;
}
