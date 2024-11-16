import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:yourevent/core/Data/data.dart';

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
  @GET("categories")
  Future<List<EventTypeModel>> getListCategories();

  @POST("events")
  Future<List<EventTypeModel>> createEvent(@Body() EventModel event);
}
