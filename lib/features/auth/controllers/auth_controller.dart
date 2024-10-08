import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_todo/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void verifyOtp(
      {required BuildContext context,
      required String smsId,
      required String smsCode,
      required bool mounted}) {
    authRepository.verifyOtp(

        context: context, smsId: smsId, smsCode: smsCode, mounted: mounted);
  }

  void sendSms({required BuildContext context, required String phone}) {
    authRepository.sendOtp(context: context, phone: phone);
  }
}
