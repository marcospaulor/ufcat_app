import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static final _baseUrl = dotenv.env['API_URL'];
  static final String _createOrder = '$_baseUrl/workorders/create/';
  static final String _getCategories = '$_baseUrl/categories/';
  static final String _getDepts = '$_baseUrl/depts/';

  static String get createOrder => _createOrder;
  static String get getCategories => _getCategories;
  static String get getDepts => _getDepts;
}
