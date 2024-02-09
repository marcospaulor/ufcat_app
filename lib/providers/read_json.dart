import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ReadJson {
  Future<List<Map<String, dynamic>>> getJson() async {
    print("Reading json file...");
    final String jsonFilePath = await _getJsonFilePath();
    final File file = File(jsonFilePath);
    if (!await file.exists()) {
      throw const FileSystemException('File does not exist');
    }

    final String fileContent = await file.readAsString();
    return jsonDecode(fileContent).cast<Map<String, dynamic>>();
  }

  Future<String> _getJsonFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/data.json';
  }
}
