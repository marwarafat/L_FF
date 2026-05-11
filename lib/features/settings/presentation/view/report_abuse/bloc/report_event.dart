// report_abuse_event.dart
abstract class ReportAbuseEvent {}

class ReportSubmitted extends ReportAbuseEvent {
  final String reason;
  final String description;

  ReportSubmitted({required this.reason, required this.description});
}
