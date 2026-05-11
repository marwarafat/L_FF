import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../storage/token_storage.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en')) {
    _loadLocale();
  }

  static const String _localeKey = 'app_locale';

  void _loadLocale() {
    final String? cachedLocale = CacheHelper.getData(key: _localeKey);
    if (cachedLocale != null) {
      emit(Locale(cachedLocale));
    }
  }

  Future<void> changeLocale(String languageCode) async {
    await CacheHelper.saveData(key: _localeKey, value: languageCode);
    emit(Locale(languageCode));
  }
}
