import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Authentication {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> checkBiometrics() async {
    bool? isBiometricAvailable;
    try {
      bool checkBiometrics = await auth.canCheckBiometrics;
      isBiometricAvailable = checkBiometrics;
    } on Exception catch (e) {
      isBiometricAvailable = false;

      print("exception on checking biometric $e");
    }

    return isBiometricAvailable;
  }

  Future<List<BiometricType>> gettingAvailableBiometric() async {
    List<BiometricType>? biometricType;
    try {
      biometricType = await auth.getAvailableBiometrics();
    } on Exception catch (e) {
      print("exception on listing biometric $e");
      biometricType = [];
    }

    return biometricType;
  }

  Future<bool> authenticateWithBiometrics() async {
    bool? authenticationConfirm;
    try {
      authenticationConfirm = await auth.authenticate(
        localizedReason:
            "Scan your fingerprint (or face or whatever) to authenticate",
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      authenticationConfirm = false;
      print("exception on  biomateric auth $e");
      // TODO
    }

    return authenticationConfirm;
  }
}
