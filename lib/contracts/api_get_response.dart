class ApiGetResponse <T> {
  final bool hasNext;
  final bool hasPrevious;
  final int? next;
  final T data;

  const ApiGetResponse({
    required this.hasNext,
    required this.hasPrevious,
    required this.data,
    this.next,
  });

  factory ApiGetResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    return ApiGetResponse<T>(
      hasNext: json['hasNext'],
      hasPrevious: json['hasPrevious'],
      next: json['next'],
      data: fromJsonT(json['data']),
    );
  }
}