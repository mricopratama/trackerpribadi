import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/job_application_model.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final List<JobApplication> _jobs = [
    JobApplication(id: "j1", companyName: "PT. Teknologi Cerdas", role: "Flutter Developer", dateApplied: DateTime.now().subtract(const Duration(days: 3)), status: JobApplicationStatus.applied),
    JobApplication(id: "j2", companyName: "Startup AI", role: "Backend Engineer", dateApplied: DateTime.now().subtract(const Duration(days: 8)), status: JobApplicationStatus.interview),
    JobApplication(id: "j3", companyName: "Bank Digital", role: "QA Tester", dateApplied: DateTime.now().subtract(const Duration(days: 15)), status: JobApplicationStatus.rejected),
    JobApplication(id: "j4", companyName: "E-commerce Raksasa", role: "Product Manager", dateApplied: DateTime.now().subtract(const Duration(days: 20)), status: JobApplicationStatus.offer),
  ];

  void _addJobApplication(JobApplication job) {
    setState(() {
      _jobs.insert(0, job);
    });
  }

  void _openAddJobSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddJobSheet(onAddJob: _addJobApplication),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lamaran Kerja"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildSummaryHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _jobs.length,
              itemBuilder: (context, index) {
                return _JobItem(job: _jobs[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddJobSheet,
        child: const Icon(Icons.add),
        tooltip: "Tambah Lamaran",
      ),
    );
  }

  Widget _buildSummaryHeader() {
    final int applied = _jobs.where((j) => j.status == JobApplicationStatus.applied).length;
    final int interview = _jobs.where((j) => j.status == JobApplicationStatus.interview).length;
    final int offer = _jobs.where((j) => j.status == JobApplicationStatus.offer).length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _SummaryChip(count: applied, label: "Applied"),
          _SummaryChip(count: interview, label: "Interview"),
          _SummaryChip(count: offer, label: "Offer"),
        ],
      ),
    );
  }
}

// --- WIDGET untuk setiap item lamaran ---
class _JobItem extends StatelessWidget {
  final JobApplication job;
  const _JobItem({required this.job});

  @override
  Widget build(BuildContext context) {
    final statusInfo = JobStatusInfo.getInfo(context, job.status);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: CircleAvatar(
          backgroundColor: statusInfo.color.withOpacity(0.1),
          child: Icon(statusInfo.icon, color: statusInfo.color),
        ),
        title: Text(job.companyName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(job.role),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusInfo.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                statusInfo.text,
                style: TextStyle(color: statusInfo.color, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('d MMM y').format(job.dateApplied),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

// --- WIDGET untuk chip ringkasan ---
class _SummaryChip extends StatelessWidget {
  final int count;
  final String label;
  const _SummaryChip({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}


// --- WIDGET untuk form tambah lamaran ---
class _AddJobSheet extends StatefulWidget {
  final Function(JobApplication) onAddJob;
  const _AddJobSheet({required this.onAddJob});

  @override
  State<_AddJobSheet> createState() => __AddJobSheetState();
}

class __AddJobSheetState extends State<_AddJobSheet> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _roleController = TextEditingController();
  DateTime? _selectedDate;
  JobApplicationStatus _selectedStatus = JobApplicationStatus.applied;

  @override
  void dispose() {
    _companyController.dispose();
    _roleController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitData() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_selectedDate == null ? 'Silakan pilih tanggal.' : 'Harap isi semua kolom.')),
      );
      return;
    }

    final newJob = JobApplication(
      id: DateTime.now().toString(),
      companyName: _companyController.text,
      role: _roleController.text,
      dateApplied: _selectedDate!,
      status: _selectedStatus,
    );

    widget.onAddJob(newJob);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Tambah Lamaran Baru", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            TextFormField(
              controller: _companyController,
              decoration: const InputDecoration(labelText: 'Nama Perusahaan'),
              validator: (value) => (value == null || value.isEmpty) ? 'Nama perusahaan tidak boleh kosong' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _roleController,
              decoration: const InputDecoration(labelText: 'Posisi yang Dilamar'),
              validator: (value) => (value == null || value.isEmpty) ? 'Posisi tidak boleh kosong' : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null ? 'Pilih Tanggal Lamar' : DateFormat('d MMMM y').format(_selectedDate!)),
                ),
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<JobApplicationStatus>(
              value: _selectedStatus,
              items: JobApplicationStatus.values.map((status) {
                final statusInfo = JobStatusInfo.getInfo(context, status);
                return DropdownMenuItem(
                  value: status,
                  child: Text(statusInfo.text),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedStatus = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Status'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Simpan Lamaran'),
            ),
          ],
        ),
      ),
    );
  }
}
