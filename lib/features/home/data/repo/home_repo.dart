import '../models/dashboard_model.dart';

abstract class HomeRepo {
 
  Future<DashboardModel> getDashboard();
}
