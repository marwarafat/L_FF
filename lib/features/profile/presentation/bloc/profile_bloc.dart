import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/entities/report_summary_entity.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/get_user_reports_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserProfileUseCase _getUserProfileUseCase;
  final GetUserReportsUseCase _getUserReportsUseCase;

  ProfileBloc({
    required GetUserProfileUseCase getUserProfileUseCase,
    required GetUserReportsUseCase getUserReportsUseCase,
  }) : _getUserProfileUseCase = getUserProfileUseCase,
       _getUserReportsUseCase = getUserReportsUseCase,
       super(ProfileState(loading: true)) {
    on<LoadProfileEvent>((event, emit) async {
      emit(state.copyWith(loading: true, errorMessage: null));

      try {
        final profileFuture = _getUserProfileUseCase();
        final reportsFuture = _getUserReportsUseCase();

        final results = await Future.wait([profileFuture, reportsFuture]);

        final profile = results[0] as ProfileEntity;
        final reports = results[1] as List<ReportSummaryEntity>;

        emit(
          state.copyWith(loading: false, profile: profile, reports: reports),
        );
      } catch (e) {
        emit(state.copyWith(loading: false, errorMessage: e.toString()));
      }
    });
  }
}
