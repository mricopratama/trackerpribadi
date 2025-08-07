import 'package:flutter/material.dart';

// Enum untuk Status dan Urgensi
enum ProgressStatus { ongoing, completed, inReview, pending }
enum Urgency { critical, moderate, minor }

class Project {
  final String id;
  final String name;
  final ProgressStatus status;
  final Urgency urgency;
  final List<String> assignees;
  final DateTime deadline;
  final bool isPaid;
  final double? payment;
  final DateTime? completedAt;

  Project({
    required this.id,
    required this.name,
    required this.status,
    required this.urgency,
    required this.assignees,
    required this.deadline,
    this.isPaid = false,
    this.payment,
    this.completedAt,
  });
}

// Helper untuk mendapatkan properti dari Urgency dan Status
class ProjectInfo {
  final String text;
  final Color color;
  final IconData? icon;

  ProjectInfo({required this.text, required this.color, this.icon});

  static ProjectInfo getStatusInfo(BuildContext context, ProgressStatus status) {
    final colors = Theme.of(context).colorScheme;
    switch (status) {
      case ProgressStatus.ongoing:
        return ProjectInfo(text: 'Ongoing', color: colors.primary);
      case ProgressStatus.completed:
        return ProjectInfo(text: 'Completed', color: Colors.green);
      case ProgressStatus.inReview:
        return ProjectInfo(text: 'In Review', color: Colors.purpleAccent);
      case ProgressStatus.pending:
        return ProjectInfo(text: 'Pending', color: Colors.grey);
    }
  }

  static ProjectInfo getUrgencyInfo(BuildContext context, Urgency urgency) {
    switch (urgency) {
      case Urgency.critical:
        return ProjectInfo(text: 'Critical', color: Theme.of(context).colorScheme.error, icon: Icons.priority_high_rounded);
      case Urgency.moderate:
        return ProjectInfo(text: 'Moderate', color: Colors.orangeAccent, icon: Icons.arrow_right_alt_rounded);
      case Urgency.minor:
        return ProjectInfo(text: 'Minor', color: Colors.grey, icon: Icons.arrow_downward_rounded);
    }
  }
}
