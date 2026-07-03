import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/providers/jobs_provider.dart';
import 'package:job_search/screens/job_details_screen.dart';

class JobSearchBar extends ConsumerWidget {
  const JobSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(jobsProvider);

    return SearchAnchor(
      // builds search bar
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          hintText: "Search for jobs...",
          hintStyle: WidgetStateProperty.all(
            const TextStyle(color: Colors.grey),
          ),
          // controls text inside search field
          controller: controller,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0),
          ),
          // opens search suggestions when bar is tapped
          onTap: () {
            controller.openView();
          },
          // updates search results as user types
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
        );
      },
      // show filtered jobs based on search query
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        // user query
        final query = controller.text.toLowerCase();
        // filtered jobs by title or company name
        final results = jobs.where((job) {
          return job.title.toLowerCase().contains(query.toLowerCase()) ||
              job.company.toLowerCase().contains(query.toLowerCase());
        }).toList();
        // show matching jobs as clickable suggestions
        return results.map((job) {
          return ListTile(
            title: Text(job.title),
            subtitle: Text(job.company),
            onTap: () {
              controller.closeView(job.title);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => JobDetailsScreen(job: job)),
              );
            },
          );
        });
      },
    );
  }
}
