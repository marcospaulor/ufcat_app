import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final String _baseUrl = dotenv.env['API_URL'] ?? (throw Exception('API_URL not found in .env'));

  // Usar o getter baseUrl para obter o valor de _baseUrl
  static final String _createOrder = '$baseUrl/workorders/create/';
  static final String _getCategories = '$baseUrl/categories/';
  static final String _getDepts = '$baseUrl/depts/';

  // Getter para o _baseUrl
  static String get baseUrl => _baseUrl;

  // Getters para os endpoints
  static String get createOrder => _createOrder;
  static String get getCategories => _getCategories;
  static String get getDepts => _getDepts;
}
