import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'ai_scanning_state.dart';

class AiScanningCubit extends Cubit<AiScanningState> {
  AiScanningCubit() : super(const AiScanningState());

  final ImagePicker _picker = ImagePicker();

  Future<void> openCamera() async {
    emit(state.copyWith(status: AiScanStatus.loading));
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image == null) {
        emit(state.copyWith(status: AiScanStatus.idle));
        return;
      }
      final updated = [...state.scannedImages, image.path];
      emit(state.copyWith(
        status: AiScanStatus.success,
        scannedImages: updated,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AiScanStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> pickFromGallery() async {
    emit(state.copyWith(status: AiScanStatus.loading));
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) {
        emit(state.copyWith(status: AiScanStatus.idle));
        return;
      }
      final updated = [...state.scannedImages, image.path];
      emit(state.copyWith(
        status: AiScanStatus.success,
        scannedImages: updated,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AiScanStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void removeImage(int index) {
    final updated = [...state.scannedImages]..removeAt(index);
    emit(state.copyWith(scannedImages: updated));
  }
}
