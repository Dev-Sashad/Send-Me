import 'package:firebase_auth/firebase_auth.dart';
import 'package:send_me/core/repository/firestore_repo.dart';
import 'package:send_me/core/services/auth_data_service.dart';
import '../../../_lib.dart';

class DashboardVm extends BaseModel {
  DashboardVm();
  final FireStoreRepo _fireStoreRepo = locator<FireStoreRepo>();
  final AuthService _authService = locator<AuthService>();

  //User _user;
  User get user => _authService.user!;
  String get uid => user.uid;

  getMyOrders() {
    return _fireStoreRepo.getMyOrders(uid);
  }

  deleteOrder({required String id}) async {
    try {
      setBusy(true);
      final response = await _fireStoreRepo.deleteRequest(id);
      setBusy(false);
      showOkayDialog(message: response.message!);
    } catch (e) {
      setBusy(false);
      showOkayDialog(message: 'an error occured');
    }
  }
}

final dashboardVm = ChangeNotifierProvider<DashboardVm>(
  (ref) => DashboardVm(),
);
