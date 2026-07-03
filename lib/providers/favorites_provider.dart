import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_search/models/job.dart';
import 'package:job_search/providers/jobs_provider.dart';

class FavoriteJobsNotifier extends StateNotifier<List<Job>> {
  FavoriteJobsNotifier() : super([]);

  bool toggleJobFavoriteStatus(Job job) {
    final jobIsFavorite = state.contains(job);

    if(jobIsFavorite) {
      // create new list that excludes job to remove from favorites
      state = state.where((j) => j.id != job.id).toList();
      return false;
    } else {
      // set list by combining all past values of list and newly favorited job
      state = [...state, job];
      return true;
    }
  }
}

final favoriteJobsProvider = Provider<List<Job>>((ref) {
  final jobs = ref.watch(jobsProvider);

  return jobs.where((job) => job.favorite).toList();
});