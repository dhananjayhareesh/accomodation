import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../local_storage/shared_pref.dart';
import 'api_base_model.dart';
import 'internet_connectivity.dart';
import 'network.dart';

enum RequestType { get, post, put, delete }

class BaseClient {
  static final BaseClient shared = BaseClient._privateConstructor();

  BaseClient._privateConstructor();

  final Dio dioInstance = Dio();

  get dio => dioInstance;

  /// Safe API call
  safeApiCall(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(ApiBaseModel response) onSuccess,
    Function(Either<ApiException, dynamic>)? onError,
    Function(int value, int progress)? onReceiveProgress,
    Function(int total, int progress)? onSendProgress,
    Function? onLoading,
    String? accessToken,
    bool isAddBaseUrl = true,
    bool? includeAuth = true,
    dynamic data,
  }) async {
    // Base Dio options
    dioInstance.options = BaseOptions(
      headers: {'Accept': 'application/json', "client": "OMS"},
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      sendTimeout:
          (requestType == RequestType.get || requestType == RequestType.delete)
              ? null
              : const Duration(seconds: 5),
    );

    if (isAddBaseUrl) {
      dioInstance.options.baseUrl = ApiConstants.baseUrl;
    } else {
      dioInstance.options.baseUrl = "";
    }

    dioInstance.interceptors.clear();
    dioInstance.interceptors.add(CustomLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
      dio: dioInstance,
    ));

    try {
      // loading indicator
      await onLoading?.call();

      late Response response;

      var authToken = "${accessToken ?? MySharedPref.getAuthToken()}";

      if (includeAuth! || accessToken != null) {
        headers = {
          "Authorization": "Bearer $authToken",
        };
      }

      var option = Options(headers: headers);

      // check internet connectivity
      var connectivity = await InternetConnectivity.checkConnectivity();
      if (connectivity != null) {
        if (onError != null) onError(Left(SocketException(connectivity)));
        return;
      }

      // Perform request
      switch (requestType) {
        case RequestType.get:
          response = await dioInstance.get(
            url,
            queryParameters: queryParameters,
            options: option,
            onReceiveProgress: onReceiveProgress,
          );
          break;

        case RequestType.post:
          response = await dioInstance.post(
            url,
            data: data,
            queryParameters: queryParameters,
            options: option,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
          break;

        case RequestType.put:
          response = await dioInstance.put(
            url,
            data: data,
            queryParameters: queryParameters,
            options: option,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
          );
          break;

        case RequestType.delete:
          response = await dioInstance.delete(
            url,
            queryParameters: queryParameters,
            options: option,
          );
          break;
      }

      // Parse response
      if (response.data is String) {
        onSuccess(ApiBaseModel.fromJson(jsonDecode(response.data)));
      } else {
        onSuccess(ApiBaseModel.fromJson(response.data));
      }
    } on DioException catch (error) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          if (onError != null) onError(Left(TimeOutException(url)));
          break;

        case DioExceptionType.connectionError:
          if (onError != null) onError(Left(UndefinedException()));
          break;

        case DioExceptionType.badResponse:
          if (onError != null) {
            try {
              var errorApi = ApiBaseModel.fromJson(error.response!.data);
              onError(Right(errorApi));
            } catch (e) {
              onError(Left(FetchDataException(error.response?.data is String
                  ? error.response!.data
                  : jsonEncode(error.response!.data))));
            }
          }
          break;

        case DioExceptionType.cancel:
          if (onError != null) {
            onError(Left(FetchDataException(
                'Request Cancelled\n\n${error.message}', url)));
          }
          break;

        default:
          if (onError != null)
            onError(Left(FetchDataException(error.message, url)));
      }
    } on SocketException {
      if (onError != null) onError(Left(SocketException(url)));
    } catch (error) {
      if (onError != null) onError(Left(UndefinedException(error, url)));
    }
  }
}
