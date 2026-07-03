import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {

  final client = GraphQLClient(
    cache: GraphQLCache(),
    link: HttpLink('http://10.0.2.2:4000/')
  );
  // creates the GraphQL client used in app
  Future<QueryResult> getJobs() async {

    return client.query(
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
  }
}