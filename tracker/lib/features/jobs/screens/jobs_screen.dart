import 'package:flutter/material.dart';
import '../../../models/job_application_model.dart';

class JobsScreen extends StatelessWidget {
  JobsScreen({super.key});

  final List<JobApplication> dummyJobs = [
    JobApplication(
      id: "j1",
      companyName: "PT. Teknologi Cerdas",
      role: "Flutter Developer",
      dateApplied: DateTime.now().subtract(const Duration(days: 3)),
      status: JobApplicationStatus.applied,
    ),
    JobApplication(
      id: "j2",
      companyName: "Startup AI",
      role: "Backend Engineer",
      dateApplied: DateTime.now().subtract(const Duration(days: 8)),
      status: JobApplicationStatus.interview,
    ),
    JobApplication(
      id: "j3",
      companyName: "Bank Digital",
      role: "QA Tester",
      dateApplied: DateTime.now().subtract(const Duration(days: 15)),
      status: JobApplicationStatus.rejected,
    ),
  ];

  Color _statusColor(JobApplicationStatus status) {
    switch (status) {
      case JobApplicationStatus.applied:
        return Colors.blue;
      case JobApplicationStatus.interview:
        return Colors.orange;
      case JobApplicationStatus.offer:
        return Colors.green;
      case JobApplicationStatus.rejected:
        return Colors.red;
    }
  }

  String _statusText(JobApplicationStatus status) {
    switch (status) {
      case JobApplicationStatus.applied:
        return "Applied";
      case JobApplicationStatus.interview:
        return "Interview";
      case JobApplicationStatus.offer:
        return "Offer";
      case JobApplicationStatus.rejected:
        return "Rejected";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyJobs.length,
        itemBuilder: (context, index) {
          final job = dummyJobs[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.business_center),
              title: Text(job.companyName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(job.role),
                  const SizedBox(height: 4),
                  Text(
                    "Tanggal Lamar: ${job.dateApplied.day}/${job.dateApplied.month}/${job.dateApplied.year}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _statusColor(job.status).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _statusText(job.status),
                  style: TextStyle(
                    color: _statusColor(job.status),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open add job application dialog
          showModalBottomSheet(
            context: context,
            builder: (_) => const _AddJobSheet(),
          );
        },
        child: const Icon(Icons.add),
        tooltip: "Tambah Lamaran",
      ),
    );
  }
}

class _AddJobSheet extends StatelessWidget {
  const _AddJobSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          "Form Tambah Lamaran (Dummy)",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}