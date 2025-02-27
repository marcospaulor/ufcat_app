import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final baseUrl = dotenv.env['API_URL'];
  static final createOrder = '$baseUrl/workorders/create/';
  static final getCategories = '$baseUrl/categories/';
  static final String getDepts = '$baseUrl/depts/';
}
