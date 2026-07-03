
enum JobType {
  fullTime,
  partTime,
  remote,
  internship,
  contract
}

class Job {
  Job({
    required this.title,
    required this.type,
    required this.description,
    required this.company,
    required this.id,
    this.favorite = false
});

  final String title;
  final JobType type;
  final String description;
  final String company;
  final int id;
  bool favorite;

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title': title,
      'type': type.name,
      'description': description,
      'company': company,
      'favorite': favorite ? 1 : 0
    };
  }

  // converts a SQlite row into a Job object
  factory Job.fromMap(Map<String, dynamic> map) {
    return Job(
      id: map['id'],
      title: map['title'],
      type: JobType.values.byName(map['type']),
      description: map['description'],
      company: map['company'],
      favorite: map['favorite'] == 1
    );
  }
  // converts a GraphQL response into a Job object
  factory Job.fromJson(Map<String,dynamic> json) {
    JobType type;

     switch (json['type']) {
    case 'FULL_TIME':
      type = JobType.fullTime;
      break;
    case 'PART_TIME':
      type = JobType.partTime;
      break;
    case 'REMOTE':
      type = JobType.remote;
      break;
    case 'INTERNSHIP':
      type = JobType.internship;
      break;
    case 'CONTRACT':
      type = JobType.contract;
      break;
    default:
      throw Exception('Unknown job type: ${json["type"]}');
  }

    return Job(
      id: json["id"],
      title: json["title"],
      company: json["company"],
      description: json["description"],
      favorite: json["favorite"],
      type: type,
    );
  }
  Job copyWith({
    int? id,
    String? title,
    JobType? type,
    String? description,
    String? company,
    bool? favorite,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      company: company ?? this.company,
      favorite: favorite ?? this.favorite,
    );
  }
}