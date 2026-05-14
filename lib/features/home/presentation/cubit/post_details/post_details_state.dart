part of 'post_details_cubit.dart';

enum PostDetailsStatus { idle, loading, success, failure }

class PostDetailsState {
  final PostDetailsStatus status;
  final bool isMarkedAsFound;
  final String? errorMessage;

  const PostDetailsState({
    this.status = PostDetailsStatus.idle,
    this.isMarkedAsFound = false,
    this.errorMessage,
  });

  PostDetailsState copyWith({
    PostDetailsStatus? status,
    bool? isMarkedAsFound,
    String? errorMessage,
  }) {
    return PostDetailsState(
      status: status ?? this.status,
      isMarkedAsFound: isMarkedAsFound ?? this.isMarkedAsFound,
      errorMessage: errorMessage,
    );
  }
}
