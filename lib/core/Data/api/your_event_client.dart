import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:yourevent/core/data/api/apiModels/refresh_token_request.dart';
import 'package:yourevent/core/data/repositories/models/models.dart';
import 'apiModels/models.dart';

part 'your_event_client.g.dart';

@RestApi(baseUrl: '')
abstract class YourEventClient {
  factory YourEventClient(Dio dio, {String baseUrl}) = _YourEventClient;
  factory YourEventClient.create({String? apiUrl, required Dio dio}) {
    if (apiUrl != null) {
      return YourEventClient(dio, baseUrl: apiUrl);
    }
    return YourEventClient(dio);
  }

  @POST("auth/register")
  Future<AuthResponse> register(@Body() RegisterRequest authRequest);

  @POST("auth/login")
  Future<AuthResponse> login(@Body() LoginRequest authLoginRequest);
  @GET("user/me")
  Future<UserDto> getCurrentUser(@Header('Authorization') String authHeader);
  @POST("auth/refresh") // Новый метод для обновления токена
  Future<AuthResponse> refreshAccessToken(
      @Body() RefreshTokenRequest refreshTokenRequest);
}
