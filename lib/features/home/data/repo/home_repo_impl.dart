import '../../../../core/networking/dio_consumer.dart';
import '../models/dashboard_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final DioConsumer _dio;

  HomeRepoImpl(this._dio);

  @override
  Future<DashboardModel> getDashboard() async {
    final response = await _dio.get('home/dashboard');
    final body = response as Map<String, dynamic>;
    return DashboardModel.fromJson(body['data'] as Map<String, dynamic>);
  }
}
