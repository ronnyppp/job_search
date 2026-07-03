import 'package:job_search/data/database_service.dart';
import 'package:job_search/models/job.dart';
import 'package:job_search/data/dummy_data.dart';

class JobDao {
  final DatabaseService _databaseService = DatabaseService.instance;
  // actions for database
  Future<void> insertJob(Job job) async {
    final db = await _databaseService.database;

    await db.insert('jobs', job.toMap());
  }

  Future<List<Job>> getJobs() async {
    final db = await _databaseService.database;

    final List<Map<String, dynamic>> maps = await db.query('jobs');

    return maps.map((map) => Job.fromMap(map)).toList();
  }

  Future<void> updateJob(Job job) async {
    final db = await _databaseService.database;

    await db.update('jobs', job.toMap(), where: 'id = ?', whereArgs: [job.id]);
  }

  Future<void> deleteJob(int id) async {
    final db = await _databaseService.database;

    await db.delete('jobs', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> seedDatabase() async {
    final jobs = await getJobs();

    if (jobs.isEmpty) {
      for (final job in dummyJobs) {
        await insertJob(job);
      }
    }
  }
}
