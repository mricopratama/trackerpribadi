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

// Helper untuk mendapatkan properti dari status
class JobStatusInfo {
  final String text;
  final Color color;
  final IconData icon;

  JobStatusInfo({required this.text, required this.color, required this.icon});

  static JobStatusInfo getInfo(BuildContext context, JobApplicationStatus status) {
    final colors = Theme.of(context).colorScheme;
    switch (status) {
      case JobApplicationStatus.applied:
        return JobStatusInfo(text: 'Applied', color: colors.primary, icon: Icons.send);
      case JobApplicationStatus.interview:
        return JobStatusInfo(text: 'Interview', color: Colors.orangeAccent, icon: Icons.group);
      case JobApplicationStatus.offer:
        return JobStatusInfo(text: 'Offer', color: Colors.green, icon: Icons.card_giftcard);
      case JobApplicationStatus.rejected:
        return JobStatusInfo(text: 'Rejected', color: colors.error, icon: Icons.do_not_disturb);
    }
  }
}
