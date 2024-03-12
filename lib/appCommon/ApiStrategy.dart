import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as getClass;
import 'package:ums_demo/Models/LoginModel.dart';
import 'package:ums_demo/Pages/LoginScreen/Screen.dart';
import 'package:ums_demo/Utilities/SharedPreferences.dart';
import 'package:ums_demo/Themes/AppStrings.dart';
import 'package:ums_demo/Widgets/Dialogs/CustomDialog.dart';

class ApiStrategy {
  static final ApiStrategy _instance = ApiStrategy._internal();

  static const int connectTimeOut = 30 * 1000;
  static const int receiveTimeOut = 60 * 1000;
  static const int downloadTimeOut = 30 * 1000;

  Dio? _client;

  static ApiStrategy getInstance() {
    return _instance;
  }

  static String getBaseUrl() {
    return BASEURL;
    // return LIVEURL;
  }

  ApiStrategy._internal() {
    if (_client == null) {
      BaseOptions options = BaseOptions();
      options.connectTimeout = const Duration(milliseconds: connectTimeOut);
      options.receiveTimeout = const Duration(milliseconds: receiveTimeOut);
      options.baseUrl = getBaseUrl();
      options.validateStatus = (status) {
        return status! < 500;
      };
      _client = Dio(options);

      _client!.interceptors.add(InterceptorsWrapper(
          onRequest: (options, handler) => tokenInterceptor(options, handler)));

      _client!.interceptors.add(LogInterceptor(
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
      ));
    }
  }

  Future<dynamic> tokenInterceptor(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      if (SharedPrefs.isContains(LOGINDATA)) {
        LoginModel loginModel =
            LoginModel.fromJson(SharedPrefs.getCustomObject(LOGINDATA));
        options.headers
            .addAll({"Authorization": "Bearer ${loginModel.accessToken}"});
      }
      options.headers
          .addAll({"Content-Type": "application/x-www-form-urlencoded"});
    } catch (e) {
      debugPrint('tokenInterceptor catchError: $e');
    }
    handler.next(options);
  }

  Dio get client => _client!;
  static const String GET = "get";
  static const String POST = "post";
  static const String PUT = "put";
  static const String DELETE = "delete";
  static const String PATCH = "patch";

  // class Methods{
  // Methods._();
  // static const GET = 'get';
  // static const POST = 'post';
  // static const PUT = 'put';
  // static const DELETE = 'delete';
  // static const PATCH = 'patch';
  // }

  //Get Method Call
  void get(
    String url,
    Function callBack, {
    Map<String, dynamic>? params,
    Function? errorCallBack,
    CancelToken? token,
  }) async {
    _request(
      url,
      callBack,
      method: GET,
      params: params,
      errorCallBack: errorCallBack,
      token: token,
    );
  }

  //Post Method Call
  void post(
    String url,
    Function callBack,
    ProgressCallback progressCallBack, {
    FormData? formData,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    Function? errorCallBack,
    CancelToken? token,
    bool addHeader = false,
  }) async {
    _request(
      url,
      callBack,
      method: POST,
      params: params,
      formData: formData,
      queryParams: queryParams,
      errorCallBack: errorCallBack,
      progressCallBack: progressCallBack,
      token: token,
      addHeader: addHeader,
    );
  }

  //PUT Method Call
  //Post Method Call
  void put(
    String url,
    Function callBack,
    ProgressCallback progressCallBack, {
    FormData? formData,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    Function? errorCallBack,
    CancelToken? token,
  }) async {
    _request(
      url,
      callBack,
      method: PUT,
      params: params,
      formData: formData,
      queryParams: queryParams,
      errorCallBack: errorCallBack,
      progressCallBack: progressCallBack,
      token: token,
    );
  }

  void _request(
    String url,
    Function callBack, {
    String? method,
    Map<String, dynamic>? params,
    Map<String, dynamic>? queryParams,
    FormData? formData,
    Function? errorCallBack,
    ProgressCallback? progressCallBack,
    CancelToken? token,
    bool addHeader = false,
  }) async {
    try {
      //Check Connectivity
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        // _handError(errorCallBack, NOINTERNETCONNECTION);
        // showGetXBar(APP_NAME, NOINTERNETCONNECTION);
        if (!getClass.Get.isDialogOpen!) {
          await getClass.Get.dialog(
            CustomDialog(
              title: 'No Internet',
              message: noInternetErrorMsg,
              okText: 'Close',
              okPress: () => getClass.Get.back(),
            ),
          );
          _handError(errorCallBack, noInternetErrorMsg);
        }
        return;
      }

      /*
      Create Header section of the API to send
      Content-type, Authorization, Cookies, etc
       */

      if (SharedPrefs.isContains(LOGINDATA)) {
        LoginModel loginModel =
            LoginModel.fromJson(SharedPrefs.getCustomObject(LOGINDATA));
        _client!.options.headers = {
          "Authorization": "bearer ${loginModel.accessToken}"
        };
      }

      if (addHeader) {
        _client!.options.headers = {
          "Content-Type": "application/x-www-form-urlencoded"
        };
      }

      //_client!.options.headers.forEach((k, v) => debugPrint('*** Header ***: $k: $v'));

      Response response;
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          response = await _client!.get(
            getBaseUrl() + url,
            queryParameters: params,
            cancelToken: token,
          );
        } else {
          response = await _client!.get(
            getBaseUrl() + url,
            cancelToken: token,
          );
        }
      } else if (method == POST) {
        if ((params != null && params.isNotEmpty) ||
            (queryParams != null && queryParams.isNotEmpty) ||
            formData != null) {
          response = await _client!.post(
            getBaseUrl() + url,
            data: formData ?? params,
            queryParameters: queryParams,
            options: Options(contentType: Headers.formUrlEncodedContentType),
            onSendProgress: progressCallBack,
            cancelToken: token,
          );
          print("response");
          print(response);
        } else {
          response = await _client!.post(
            getBaseUrl() + url,
            cancelToken: token,
          );
        }
      } else if (method == DELETE) {
        if (params != null && params.isNotEmpty) {
          response = await _client!.delete(
            getBaseUrl() + url,
            queryParameters: params,
            cancelToken: token,
          );
        } else {
          response = await _client!.delete(
            getBaseUrl() + url,
            cancelToken: token,
          );
        }
      } else if (method == PUT) {
        if ((params != null && params.isNotEmpty) ||
            (queryParams != null && queryParams.isNotEmpty) ||
            formData != null) {
          response = await _client!.put(
            getBaseUrl() + url,
            data: formData ?? params,
            queryParameters: queryParams,
            options: Options(contentType: Headers.formUrlEncodedContentType),
            onSendProgress: progressCallBack,
            cancelToken: token,
          );
        } else {
          response = await _client!.put(
            getBaseUrl() + url,
            cancelToken: token,
          );
        }
      } else if (method == PATCH) {
        if (params != null && params.isNotEmpty) {
          response = await _client!.patch(
            getBaseUrl() + url,
            data: formData ?? FormData.fromMap(params),
            onSendProgress: progressCallBack,
            cancelToken: token,
          );
        } else {
          response = await _client!.patch(
            getBaseUrl() + url,
            cancelToken: token,
          );
        }
      } else {
        if (params != null && params.isNotEmpty) {
          response = await _client!.get(
            getBaseUrl() + url,
            queryParameters: params,
            cancelToken: token,
          );
        } else {
          response = await _client!.get(
            getBaseUrl() + url,
            cancelToken: token,
          );
        }
      }

      debugPrint('Status Code --> ${response.statusCode}');

      switch (response.statusCode) {
        case 200:
        case 201:
          callBack(response.data);
          break;
        case 401:
          SharedPrefs.clearLoginData();
          getClass.Get.offAll(() => const LoginScreen());
          _handError(errorCallBack, apiUnAuthorizeAccessMsg);
          break;
        case 400:
        case 409:
          debugPrint("Response it is in :");
          print(response);
          _handError(errorCallBack, apiUnAuthorizeAccessMsg);
          break;
        case 404:
        case 500:
        case 503:
        default:
          _handError(errorCallBack, apiServerErrorMsg);
          break;
      }
    } catch (e) {
      if (e is DioException) {
        DioException error = e;

        debugPrint('error data ${error.response}');

        if (e.type != DioExceptionType.badResponse) {
          print("Dio bhai ni error");
          _handError(errorCallBack, apiServerErrorMsg);
        } else {
          switch (error.response!.statusCode) {
            case 401:
              SharedPrefs.clearLoginData();
              getClass.Get.offAll(() => const LoginScreen());
              _handError(errorCallBack, apiUnAuthorizeAccessMsg);
              break;
            case 400:
            case 403:
            case 409:
              debugPrint("Response it is :");

              print(error);
              _handError(errorCallBack, "No problem");

              break;
            case 404:
            case 500:
            case 503:
            default:
              print("Error bhai ");
              _handError(errorCallBack, apiServerErrorMsg);
              break;
          }
        }
      } else {
        _handError(errorCallBack, "");
      }
    }
  }

  static void _handError(Function? errorCallback, String errorMsg) {
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
  }
}
