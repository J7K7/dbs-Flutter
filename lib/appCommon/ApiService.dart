import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'ApiStrategy.dart';

class ApiService {
  factory ApiService() => _getInstance();

  static ApiService get instance => _getInstance();
  static final ApiService _instance = ApiService._internal();

  static const int requestSucceed = 0;
  static const int requestFailed = 1;

  ApiService._internal();

  static ApiService _getInstance() {
    return _instance;
  }

  static void get(
    String url, {
    Function? success,
    Function? failed,
    Function? error,
    Map<String, dynamic>? params,
    CancelToken? token,
    int? startPage,
  }) {
    print("Inside the api Sertvice get");
    print(url);
    ApiStrategy.getInstance().get(
      url,
      (data) {
        // print("Data bhai at 34:");
        // print
        if (data["Status"] == false) {
          failed!(data);
        } else {
          success!(data);
        }
        //--> below code removed coz Bid T&C description received 'error' text.
        // if (data.toString().contains("error") || data.toString().contains("errors")) {
        //   failed!(data);
        // } else {
        //    success!(data);
        // }
      },
      params: params,
      errorCallBack: (errorMessage) {
        error!(errorMessage);
      },
      token: token,
    );
  }

  static void post(
    String url, {
    FormData? formData,
    Map<String, dynamic>? param,
    Map<String, dynamic>? queryParams,
    Function? success,
    Function? failed,
    Function? error,
    CancelToken? token,
    bool addHeader = false,
  }) {
    ApiStrategy.getInstance().post(
      url,
      (data) {
        if (data["Status"] == false) {
          failed!(data);
        } else {
          success!(data);
        }
      },
      (count, total) {},
      params: param,
      formData: formData,
      queryParams: queryParams,
      errorCallBack: (errorMessage) {
        error!(errorMessage);
      },
      addHeader: addHeader,
    );
  }

  static void put(String url,
      {FormData? formData,
      Map<String, dynamic>? param,
      Map<String, dynamic>? queryParams,
      Function? success,
      Function? failed,
      Function? error,
      CancelToken? token}) {
    ApiStrategy.getInstance().put(
        url,
        (data) {
          if (data["Status"] == false) {
            failed!(data);
          } else {
            success!(data);
          }
        },
        (count, total) {},
        params: param,
        formData: formData,
        queryParams: queryParams,
        errorCallBack: (errorMessage) {
          error!(errorMessage);
        });
  }
}
