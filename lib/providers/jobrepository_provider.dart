import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/data/job_repository.dart';
import 'package:job_search/providers/graphql_provider.dart';
import 'package:job_search/providers/db_service_provider.dart';

final jobRepositoryProvider = Provider((ref) {
  return JobRepository(
    ref.watch(graphqlServiceProvider),
    ref.watch(databaseServiceProvider)
  );
});