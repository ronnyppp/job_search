import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/data/database_service.dart';

final databaseServiceProvider = Provider((ref) {
  return DatabaseService.instance;
});