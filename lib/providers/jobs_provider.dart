import 'package:flutter_riverpod/legacy.dart';
import 'package:job_search/models/job.dart';
import 'package:job_search/providers/jobrepository_provider.dart';
import 'package:job_search/data/job_repository.dart';

class JobsNotifier extends StateNotifier<List<Job>> {
  JobsNotifier(this.repository) : super([]) {
    loadJobs();
  }

  final JobRepository repository;

  // load jobs when provider is first created
  Future<void> loadJobs() async {
    final jobs = await repository.fetchJobs();

    state = jobs;
  }

  // updates a job's favorite status and updates state
  Future<bool> toggleFavorite(int id) async {
    final updated = await repository.toggleFavorite(id);

    state = state.map((job) {
      if (job.id == id) {
        return updated;
      }

      return job;
    }).toList();
    return updated.favorite;
  }
}

final jobsProvider = StateNotifierProvider<JobsNotifier, List<Job>>((ref) {
  final repo = ref.watch(jobRepositoryProvider);

  return JobsNotifier(repo);
});
