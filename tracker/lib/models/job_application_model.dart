enum JobApplicationStatus { applied, interview, offer, rejected }

class JobApplication {
  final String id;
  final String companyName;
  final String role;
  final DateTime dateApplied;
  final JobApplicationStatus status;

  JobApplication({
    required this.id,
    required this.companyName,
    required this.role,
    required this.dateApplied,
    required this.status,
  });
}