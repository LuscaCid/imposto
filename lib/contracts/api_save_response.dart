class ApiSaveResponse <T>{
  final bool success;
  final T data;
  final String message;

  const ApiSaveResponse({
    required this.data,
    required this.success,
    required this.message
  });

  factory ApiSaveResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT
  ) {
    return ApiSaveResponse(
      // in this part will serialize the data returned from api to json
      data: fromJsonT(json['data']), 
      success: json['success'],
      message: json['message']
    );
  }
}