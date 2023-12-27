import '../../init/network/dio_manager.dart';

abstract class IAuthService {
  final DioManager dioManager;

  IAuthService(this.dioManager);

  Future<String?> login({
    required String email,
    required String username,
    required String password,
  });

  Future<String?> register({
    required String email,
    required String username,
    required String password,
  });
}
