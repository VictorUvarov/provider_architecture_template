import '../../models/alert_request/alert_request.dart';
import '../../models/alert_response/alert_response.dart';

abstract class DialogService {
  Future<AlertResponse> showDialog(AlertRequest alertRequest);

  void completeDialog(AlertResponse response);
}
