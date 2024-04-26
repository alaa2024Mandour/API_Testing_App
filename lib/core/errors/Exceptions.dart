import 'package:api_test/core/errors/ErrorModel.dart';

class ServerException {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}