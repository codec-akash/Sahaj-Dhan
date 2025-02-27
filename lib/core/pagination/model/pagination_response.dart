class PaginatedResponse<T> {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int itemsPerPage;
  final List<T> data;
  final bool hasNextPage;
  final bool hasPreviousPage;

  PaginatedResponse({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemsPerPage,
    required this.data,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return PaginatedResponse(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      itemsPerPage: json['itemsPerPage'],
      data: (json['data'] as List).map((item) => fromJsonT(item)).toList(),
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
    );
  }
}
