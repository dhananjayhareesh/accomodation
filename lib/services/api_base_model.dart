
class ApiBaseModel {
  String message;
  int code;
  dynamic dataResult;
  ApiBaseData data;

  ApiBaseModel({
    required this.message,
    required this.code,
    required this.data,
    required this.dataResult
  });

  factory ApiBaseModel.fromJson(Map<String, dynamic> json) => ApiBaseModel(
    message: json["message"],
    code: json["code"],
    dataResult: json["data"],
    data: ApiBaseData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "code": code,
    "data": data.toJson(),
  };
}

class ApiBaseData {
  int? responseCode;
  dynamic result;

  ApiBaseData({
    required this.responseCode,
    required this.result,
  });

  factory ApiBaseData.fromJson(Map<String, dynamic> json) => ApiBaseData(
    responseCode: json["responseCode"],
    result: json["result"],
  );

  Map<String, dynamic> toJson() => {
    "responseCode": responseCode,
    "result": result,
  };
}