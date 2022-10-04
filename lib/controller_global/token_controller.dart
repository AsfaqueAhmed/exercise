import 'package:exercise/providers/auth_provider.dart';
import 'package:exercise/utility/keys.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class TokenController extends GetxController {
  GetStorage box = GetStorage();

  String? token;

  TokenController();

  String? getToken() {
    token ??= box.read<String?>(StorageKeys.userTokenKey);
    return token;
  }

  bool haveToken() => getToken() != null;

  Future removeToken() async {
    box.remove(StorageKeys.userTokenKey);
    token = null;
  }

  setToken(String token) async {
    this.token = token;
    box.write(StorageKeys.userTokenKey, token);
  }
}
