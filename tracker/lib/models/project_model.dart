enum ProjectStatus { inProgress, completed, onHold }

class Project {
  final String id;
  final String name;
  final String description;
  final DateTime deadline;
  final ProjectStatus status;
  final bool isPaid;
  final double? payment;
  final DateTime? completedAt;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.deadline,
    required this.status,
    required this.isPaid,
    this.payment,
    this.completedAt,
  });
}