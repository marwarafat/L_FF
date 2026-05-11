// report_abuse_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'report_event.dart';
import 'report_state.dart';

class ReportAbuseBloc extends Bloc<ReportAbuseEvent, ReportAbuseState> {
  ReportAbuseBloc() : super(ReportInitial()) {
    on<ReportSubmitted>(_onSubmit);
  }

  Future<void> _onSubmit(
    ReportSubmitted event,
    Emitter<ReportAbuseState> emit,
  ) async {
    emit(ReportLoading());

    try {
      // هنا بعدين هتوصلي API
      await Future.delayed(const Duration(seconds: 2));

      emit(ReportSuccess());
    } catch (e) {
      emit(ReportError("Something went wrong"));
    }
  }
}
