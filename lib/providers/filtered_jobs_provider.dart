import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/models/job.dart';
import 'package:job_search/providers/jobs_provider.dart';
import 'package:job_search/providers/search_provider.dart';

final filteredJobsProvider = Provider<List<Job>>((ref) {
  final jobs = ref.watch(jobsProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase();

  if(query.isEmpty) return jobs;
// revert back to old code by adding state notifier
  return jobs.where((job) {
    return job.title.toLowerCase().contains(query) ||
    job.company.toLowerCase().contains(query);
  }).toList();
});