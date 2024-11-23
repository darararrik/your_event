import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:yourevent/core/data/data.dart';
import 'package:yourevent/core/data/repositories/models/agency/agency_dto.dart';
import 'package:yourevent/core/data/repositories/models/agency_service/agency_service_dto.dart';
import 'package:yourevent/core/data/repositories/models/tokens_response/tokes_response_dto.dart';
import 'package:yourevent/core/data/repositories/models/user/update_email_request/update_email_request.dart';
import 'package:yourevent/core/data/repositories/models/user/update_name/update_name_request.dart';
import 'package:yourevent/core/data/repositories/models/user/update_password_request/update_password_request.dart';

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

  @POST("auth/refresh")
  Future<TokesResponseDto> refreshAccessToken(
      @Body() RefreshTokenRequestDto refreshTokenRequest);

  @GET("user/me")
  Future<UserDto> getCurrentUser();

  @PATCH("user/me/update/password")
  Future<AuthResponseDto> updatePassword(@Body() UpdatePasswordRequest request);

  @PATCH("user/me/update/email")
  Future<AuthResponseDto> updateEmail(@Body() UpdateEmailRequest request);

  @PATCH("user/me/update/name")
  Future<UserDto> updateName(@Body() UpdateNameRequest request);

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
