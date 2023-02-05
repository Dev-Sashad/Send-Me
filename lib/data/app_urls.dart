class AppEndpoint {
  static const String baseUrl = 'https://api.bossbusworld.com/api/v1/';
  static String getCars(int page) => 'cars?page=$page';
}
