import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/models/job.dart';
import 'package:job_search/providers/jobs_provider.dart';

class JobDetailsScreen extends ConsumerWidget {
  const JobDetailsScreen({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(jobsProvider);
    final currentJob = jobs.firstWhere((j) => j.id == job.id);
    final isFavorited = currentJob.favorite;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // job title
        title: Text(job.title),
        actions: [
          // favorite/unfavorite job
          IconButton(onPressed: () async {
              // show message for action and change icon based on action
              final wasAdded = await ref
                  .read(jobsProvider.notifier)
                  .toggleFavorite(job.id);
              if(!context.mounted) return;
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded ? "Job favorited." : "Job removed."),
                ),
              );
              }, icon: Icon(isFavorited ? Icons.favorite : Icons.favorite_border,
              key: ValueKey(isFavorited),),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // job description
            Text(job.company),
            Text(job.type.name),
            Text(job.description),
            Spacer(),
            TextButton(onPressed: () {}, child: const Text("Apply Now!")),
          ],
        ),
      ),
    );
  }
}
