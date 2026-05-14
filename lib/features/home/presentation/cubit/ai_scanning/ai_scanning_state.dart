part of 'ai_scanning_cubit.dart';

enum AiScanStatus { idle, loading, success, failure }

class AiScanningState {
  final AiScanStatus status;
  final List<String> scannedImages; 
  final String? errorMessage;

  const AiScanningState({
    this.status = AiScanStatus.idle,
    this.scannedImages = const [],
    this.errorMessage,
  });

  AiScanningState copyWith({
    AiScanStatus? status,
    List<String>? scannedImages,
    String? errorMessage,
  }) {
    return AiScanningState(
      status: status ?? this.status,
      scannedImages: scannedImages ?? this.scannedImages,
      errorMessage: errorMessage,
    );
  }
}
