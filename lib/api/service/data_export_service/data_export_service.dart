import 'dart:convert';
import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:meta/meta.dart';
import 'package:quiz/api/data/question.dart';
import 'package:quiz/api/data/result/result.dart';

class ExportData {
  final String data;
  final String fileType;

  ExportData({
    required this.data,
    required this.fileType,
  });
}

//ignore:one_member_abstracts
abstract class DataExportService {
  void exportResults(List<QuizResult> results, List<Question> questions);

  @protected
  void saveFile(String ext, String data) {
    final bytes = utf8.encode(data);
    FileSaver.instance.saveFile('export.$ext', Uint8List.fromList(bytes), ext);
  }
}
