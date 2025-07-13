import 'package:dio/dio.dart';
import '../api/status_codes.dart';
import '../utils/app_strings.dart';
import 'failure.dart';

class ServerFailure extends Failure {
  ServerFailure({String? failureMsg}) : super(failureMsg: failureMsg);

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(failureMsg: 'Connection Timeout With ApiServer');

      case DioExceptionType.sendTimeout:
        return ServerFailure(failureMsg: 'Send Timeout With ApiServer');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(failureMsg: 'Receive Timeout With ApiServer');

      case DioExceptionType.badCertificate:
        return ServerFailure(
          failureMsg: 'Your request not found, please try again later!',
        );

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );

      case DioExceptionType.cancel:
        return ServerFailure(failureMsg: 'Request to ApiServer was canceled');

      case DioExceptionType.connectionError:
        return ServerFailure(failureMsg: AppStrings.noInternet);

      case DioExceptionType.unknown:
        return ServerFailure(failureMsg: "Unexpected Error, please try again!");
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == StatusCodes.badRequest ||
        statusCode == StatusCodes.unAuthorized ||
        statusCode == StatusCodes.forbidden) {
      return ServerFailure(failureMsg: response['message']);
    } else if (statusCode == StatusCodes.internalServerError) {
      return ServerFailure(failureMsg: response['error']);
    }
    return ServerFailure(failureMsg: AppStrings.opps);
  }
}
