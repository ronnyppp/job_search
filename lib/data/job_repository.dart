import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:job_search/models/job.dart';
import 'graphql_service.dart';
import 'package:job_search/data/database_service.dart';

class JobRepository {
  final GraphQLService graphql;
  final DatabaseService database;

  JobRepository(this.graphql, this.database);

  // fetch jobs form the GraphQL API and cache them locally
  Future<List<Job>> fetchJobs() async {
    final cached = await database.getJobs();

    if (cached.isNotEmpty) {
      return cached;
    }

    final result = await graphql.client.query(
      QueryOptions(
        document: gql("""
        query {
          jobs {
            id
            title
            company
            type
            description
            favorite
          }
        }
      """),
      ),
    );

    final jobs = (result.data!["jobs"] as List)
        .map((e) => Job.fromJson(e))
        .toList();

    await database.insertJobs(jobs);

    return jobs;
  }

  // toggle a favorite job through the GraphQL backend
  Future<Job> toggleFavorite(int id) async {
    final result = await graphql.client.mutate(
      MutationOptions(
        document: gql("""
      mutation {
        toggleFavorite(id:$id) {
          id
          title
          company
          type
          description
          favorite
        }
      }
    """),
      ),
    );

    final json = result.data!["toggleFavorite"];

    return Job.fromJson(json);
  }
}
