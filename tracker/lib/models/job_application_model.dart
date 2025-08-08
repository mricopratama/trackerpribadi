import 'package:flutter/material.dart';

// Enum untuk status lamaran kerja
enum JobApplicationStatus {
  applied,
  interview,
  offer,
  rejected,
}

class JobApplication {
  final String id;
  final String companyName;
  final String role;
  final String location;
  final String companyType;
  final DateTime dateApplied;
  final JobApplicationStatus status;

  JobApplication({
    required this.id,
    required this.companyName,
    required this.role,
    required this.location,
    required this.companyType,
    required this.dateApplied,
    required this.status,
  });
}

class JobStatusInfo {
  final String text;
  final Color color;
  final IconData icon;

  JobStatusInfo({required this.text, required this.color, required this.icon});

  static JobStatusInfo getInfo(BuildContext context, JobApplicationStatus status) {
    final colors = Theme.of(context).colorScheme;
    switch (status) {
      case JobApplicationStatus.applied:
        return JobStatusInfo(text: 'Applied', color: colors.primary, icon: Icons.send_outlined);
      case JobApplicationStatus.interview:
        return JobStatusInfo(text: 'Interview', color: Colors.orangeAccent, icon: Icons.group_outlined);
      case JobApplicationStatus.offer:
        return JobStatusInfo(text: 'Offer', color: Colors.green, icon: Icons.card_giftcard_outlined);
      case JobApplicationStatus.rejected:
        return JobStatusInfo(text: 'Rejected', color: colors.error, icon: Icons.do_not_disturb_on_outlined);
    }
  }
}
