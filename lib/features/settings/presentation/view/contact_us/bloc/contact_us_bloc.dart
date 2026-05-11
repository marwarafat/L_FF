import 'package:flutter_bloc/flutter_bloc.dart';
import 'contact_us_event.dart';
import 'contact_us_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactState()) {
    on<UpdateSubject>((event, emit) {
      print(
        "New Subject: ${event.subject}",
      ); // 👈 جربي دي وشوفي الـ Console بيطبع ولا لا
      emit(state.copyWith(subject: event.subject, error: null, success: false));
    });

    on<UpdateMessage>((event, emit) {
      print(
        "New Message: ${event.message}",
      ); // 👈 جربي دي وشوفي الـ Console بيطبع ولا لا
      emit(state.copyWith(message: event.message, error: null, success: false));
    });

    on<SendMessage>(_sendMessage);
  }

  Future<void> _sendMessage(
    SendMessage event,
    Emitter<ContactState> emit,
  ) async {
    /// ✅ Validation
    if (state.subject.isEmpty || state.message.isEmpty) {
      emit(state.copyWith(error: "All fields are required ❌", success: false));
      return;
    }

    /// 🔄 Loading
    emit(state.copyWith(loading: true, error: null, success: false));

    await Future.delayed(const Duration(seconds: 1));

    /// ✅ Success
    emit(state.copyWith(loading: false, success: true));
  }
}
