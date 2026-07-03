import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/widgets/job_card.dart';
import 'package:job_search/widgets/search_bar.dart';
import 'package:job_search/providers/jobs_provider.dart';
import 'package:job_search/providers/favorites_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(jobsProvider);
    final favoritedJobs = ref.watch(favoriteJobsProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Job Search",
         style: TextStyle(fontWeight: FontWeight.bold),),
        ),
         body: Padding(
          padding: const EdgeInsets.all(20.0),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome Back!", style: Theme.of(context).textTheme.titleLarge,),
            Padding(padding: const EdgeInsets.all(24.0),
            // search bar
            child: JobSearchBar(),),
            Text("Popular Jobs", style: Theme.of(context).textTheme.titleMedium,),
            SizedBox(
              height: 150,
              // list of cards of available jobs
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];

                  return JobCard(job: job);
                })
            ),
            Text("Favorite Jobs", style: Theme.of(context).textTheme.titleMedium,),
            Column(
              children: [
                // show text if there are no favorited jobs
            if (favoritedJobs.isEmpty) 
            SizedBox(
              height: 150,
              child: 
            Center(child: 
            Text("No jobs favorited!", 
            style: Theme.of(context).textTheme.bodyMedium,),),)
            // if not show list of favorites
            else
            SizedBox(
              height: 150,
              child: 
              // list of cards of favorited jobs
            ListView.builder(
              scrollDirection: Axis.horizontal,
      itemCount: favoritedJobs.length,
      itemBuilder: (context, index) {
        return JobCard(job: favoritedJobs[index]);
      },),),
              ],
            ),
          ],
        ),
    ),
    );
  }
}