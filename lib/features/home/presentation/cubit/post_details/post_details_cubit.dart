import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  PostDetailsCubit() : super(const PostDetailsState());

  Future<void> markAsFound() async {
    emit(state.copyWith(status: PostDetailsStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 400));
      emit(
        state.copyWith(
          status: PostDetailsStatus.success,
          isMarkedAsFound: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: PostDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> contactReporter() async {
    emit(state.copyWith(status: PostDetailsStatus.loading));
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(state.copyWith(status: PostDetailsStatus.idle));
    } catch (e) {
      emit(
        state.copyWith(
          status: PostDetailsStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
