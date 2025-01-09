// ignore_for_file: public_member_api_docs, sort_constructors_first
const int PER_PAGE_LIMIT = 20;

class PaginatedResponse<T> {
  final int total;
  final int skip;

  static const limit = PER_PAGE_LIMIT;

  final List<T> data;
  PaginatedResponse({
    required this.total,
    required this.skip,
    required this.data,
  });

  factory PaginatedResponse.fromJson(dynamic json, List<T> data,
          {Function(dynamic json)? fixture}) =>
      PaginatedResponse(
          total: json['total'] ?? 0,
          skip: json['skip'] ?? 0,
          data: json['data']
              .map((e) => fixture != null ? fixture(e) : e)
              .toList());

  @override
  String toString() =>
      'PaginatedResponse(total: $total, skip: $skip, data: $data)';
}
