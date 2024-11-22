import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:yourevent/core/data/data.dart';
import 'package:yourevent/core/data/repositories/models/agency/agency_dto.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';

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
  Future<AuthResponseDto> register(@Body() RegisterRequestDto authRequest);

  @POST("auth/login")
  Future<AuthResponseDto> login(@Body() LoginRequestDto authLoginRequest);
  @GET("user/me")
  Future<UserDto> getCurrentUser(@Header('Authorization') String authHeader);
  @POST("auth/refresh") // Новый метод для обновления токена
  Future<AuthResponseDto> refreshAccessToken(
      @Body() RefreshTokenRequestDto refreshTokenRequest);
  @GET("categories")
  Future<List<EventTypeDto>> getListCategories();

  @POST("events")
  Future<int> createEvent(@Body() EventDto event);
  @GET("events/{id}")
  Future<List<EventDto>> getListEvents(@Path("id") int userId);

  @GET("agencies")
  Future<List<AgencyDto>> getListAgencies(@Query("page") int pageIndex);

  @GET("agencies/{id}")
  Future<AgencyDto> getAgencyById(@Path("id") int agencyId);

  @GET("agencies/{id}/services")
  Future<List<AgencyServiceDto>> getListAgencyServicesById(
      @Path("id") int agencyId);
      
  @GET("agencies/all/services")
  Future<List<AgencyServiceDto>> getAllAgencyServices();
}
