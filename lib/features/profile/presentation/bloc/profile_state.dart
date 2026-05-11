import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/report_summary_entity.dart';

class ProfileState {
  final bool loading;
  final ProfileEntity? profile;
  final List<ReportSummaryEntity>? reports;
  final String? errorMessage;

  ProfileState({
    required this.loading,
    this.profile,
    this.reports,
    this.errorMessage,
  });

  ProfileState copyWith({
    bool? loading,
    ProfileEntity? profile,
    List<ReportSummaryEntity>? reports,
    String? errorMessage,
  }) {
    return ProfileState(
      loading: loading ?? this.loading,
      profile: profile ?? this.profile,
      reports: reports ?? this.reports,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
