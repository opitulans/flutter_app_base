class ListResponse<record> {
  final List<record> filteredRecords;
  final int page;
  final int limit;
  final int total;

  ListResponse({
    required this.filteredRecords,
    required this.page,
    required this.limit,
    required this.total,
  });

  factory ListResponse.fromJson(Map<String, dynamic> json) {
    return ListResponse(
      filteredRecords: json['filteredRecords'],
      page: json['page'],
      limit: json['limit'],
      total: json['total'],
    );
  }
}

class UpdateResponse {
  final String message;

  UpdateResponse({required this.message});

  factory UpdateResponse.fromJson(Map<String, dynamic> json) {
    return UpdateResponse(message: json['message']);
  }
}
