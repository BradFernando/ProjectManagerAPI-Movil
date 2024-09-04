class ReportResponse {
  final String downloadUrl;
  final int employeeId;
  final int reportId;

  ReportResponse({
    required this.downloadUrl,
    required this.employeeId,
    required this.reportId,
  });

  factory ReportResponse.fromJson(Map<String, dynamic> json) {
    return ReportResponse(
      downloadUrl: json['downloadUrl'],
      employeeId: json['employeeId'],
      reportId: json['reportId'],
    );
  }
}
