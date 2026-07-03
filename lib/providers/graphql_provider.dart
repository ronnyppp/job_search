import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/data/graphql_service.dart';

final graphqlServiceProvider = Provider((ref) {
  return GraphQLService();
});