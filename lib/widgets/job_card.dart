import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/models/job.dart';
import 'package:job_search/providers/jobs_provider.dart';
import 'package:job_search/screens/job_details_screen.dart';
import 'package:job_search/providers/favorites_provider.dart';

class JobCard extends ConsumerWidget {
  const JobCard({super.key, required this.job});

  final Job job;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoritedJobs = ref.watch(favoriteJobsProvider);
    final isFavorited = favoritedJobs.contains(job);

    return GestureDetector(
      onTap: () {
        // go to Job details screen when tapped
        Navigator.push(context, MaterialPageRoute(builder: 
              (context) => JobDetailsScreen(job: job)));
      },
      child: SizedBox(
        height: 150,
        width: 200,
        child: 
      Card(
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.hardEdge,
        elevation: 2,
        child: Padding(padding: const EdgeInsets.all(8.0),
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(job.company),
              Spacer(),
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
            ],),
            Text(job.title, style: Theme.of(context).textTheme.titleMedium,),
            Text(job.type.name)
          ],
        )
      ),
      ),
      ),
    );
  }
}