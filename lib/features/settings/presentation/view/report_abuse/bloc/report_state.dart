// report_abuse_state.dart
abstract class ReportAbuseState {}

class ReportInitial extends ReportAbuseState {}

class ReportLoading extends ReportAbuseState {}

class ReportSuccess extends ReportAbuseState {}

class ReportError extends ReportAbuseState {
  final String message;

  ReportError(this.message);
}
