import 'package:veridflutterplugin/veridflutterplugin.dart';
import 'package:veridflutterplugin/src/VerID.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:veridflutterplugin/src/RegistrationSessionSettings.dart';
import 'package:veridflutterplugin/src/SessionResult.dart';

const verIdNotInitialized = 'VerID Instance not initialized';

class LiveTests {
  VerID verID;
  // Todo add more test functions
  Future<SessionResult> registerUser(String userId) async {
    if (verID != null) {
      RegistrationSessionSettings settings = new RegistrationSessionSettings(userId: userId);
      settings.showResult = true;
      return verID.register(settings: settings).then((value) {
        if (value == null) {
          throw 'Session canceled';
        }
        return value;
      });
    } else {
      throw verIdNotInitialized;
    }
  }

  Future<VerID> load() {
    // Platform messages may fail, so we use a try/catch PlatformException.
    return Veridflutterplugin
        .load().then((instance) =>
            verID = instance
        );//.load('efe89f85-b71f-422b-a068-605c3f62603b');
  }
}
