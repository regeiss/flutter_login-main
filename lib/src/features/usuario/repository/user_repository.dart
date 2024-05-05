import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/api/endpoints.dart';
import '../../../core/api/error_data.dart';
import '../../usuario/request/user_request.dart';
import '../../usuario/data/user_data.dart';

abstract class UserRepository 
{
  Future<dynamic> login(UserRequest req);
}

class UserRepositoryImpl implements UserRepository 
{
  late Dio _dio;

  UserRepositoryImpl() 
  {
    _dio = Dio(
      BaseOptions(
        baseUrl: Endpoints.baseURL,
        responseType: ResponseType.json,
      ),
    );
  }

  @override
  Future<dynamic> login(UserRequest request) async 
  {
    try   
    {
      final response = await _dio.post(Endpoints.loginURL, data: request.toJson());
      return UserResponse.fromJson(response.data);
    }
    on DioException   
    catch (ex) 
    {
      return ErrorResponse.fromJson(ex.response?.data);
    }
  }
}

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) 
{
  return UserRepositoryImpl();
});
