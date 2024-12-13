import 'package:sahaj_dhan/network/api_provider.dart';
import 'package:sahaj_dhan/utils/strings.dart';

class UserRepository {
  ApiProvider apiProvider = ApiProvider();

  Future<void> sendUserToken(Map<String, dynamic>? payload) async {
    await apiProvider.post(ApiUrls.sendUserToken, payload: payload);
  }
}
