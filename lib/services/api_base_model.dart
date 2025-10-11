class ApiBaseModel {
  String? message;
  int? code;
  dynamic rawResponse;
  ApiBaseData data;

  ApiBaseModel(
      {required this.message,
      required this.code,
      required this.data,
      required this.rawResponse});

  factory ApiBaseModel.fromJson(Map<String, dynamic> json) => ApiBaseModel(
        message: json["message"],
        code: json["code"],
        rawResponse: json,
        data: json["data"] == null
            ? ApiBaseData(responseCode: 132)
            : ApiBaseData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "code": code,
        "data": data?.toJson(),
      };
}

class ApiBaseData {
  int? responseCode;
  String? message;
  dynamic baseDataResponse;
  dynamic result;

  ApiBaseData({
    required this.responseCode,
    this.baseDataResponse,
    this.message,
    this.result,
  });

  factory ApiBaseData.fromJson(Map<String, dynamic> json) => ApiBaseData(
        responseCode: json["responseCode"],
        message: json["message"],
        result: json["result"],
        baseDataResponse: json,
      );

  Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "result": result,
      };
}
