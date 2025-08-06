import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/project_model.dart';

class ProjectsScreen extends StatelessWidget {
  ProjectsScreen({super.key});

  // Data dummy tetap sama
  final List<Project> dummyProjects = [
    Project(
      id: "p1",
      name: "Improve Navigation & Menu",
      description: "Optimalkan alur navigasi utama",
      deadline: DateTime(2025, 9, 15),
      status: ProjectStatus.inProgress,
      isPaid: false,
      payment: null,
      completedAt: null,
    ),
    Project(
      id: "p2",
      name: "Enhance Search Functionality",
      description: "Tambahkan filter dan sorting",
      deadline: DateTime(2025, 8, 20),
      status: ProjectStatus.completed,
      isPaid: true,
      payment: 5000000,
      completedAt: DateTime(2025, 8, 1),
    ),
    Project(
      id: "p3",
      name: "Dark Mode Implementation",
      description: "Implementasi tema gelap di seluruh app",
      deadline: DateTime(2025, 9, 30),
      status: ProjectStatus.inProgress,
      isPaid: false,
      payment: null,
      completedAt: null,
    ),
    Project(
      id: "p4",
      name: "Redesign Checkout Flow",
      description: "Sederhanakan proses checkout",
      deadline: DateTime(2025, 10, 5),
      status: ProjectStatus.onHold,
      isPaid: false,
      payment: null,
      completedAt: null,
    ),
    Project(
      id: "p5",
      name: "Reduce Load Time for Data Sets",
      description: "Optimasi query database",
      deadline: DateTime(2025, 8, 25),
      status: ProjectStatus.completed,
      isPaid: true,
      payment: 3500000,
      completedAt: DateTime(2025, 8, 10),
    ),
  ];

  // Helper function untuk warna status (tetap sama)
  Color _statusColor(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.inProgress:
        return Colors.blue.shade700;
      case ProjectStatus.completed:
        return Colors.green.shade700;
      case ProjectStatus.onHold:
        return Colors.orange.shade700;
    }
  }

  // Helper function untuk teks status (tetap sama)
  String _statusText(ProjectStatus status) {
    switch (status) {
      case ProjectStatus.inProgress:
        return "In Progress";
      case ProjectStatus.completed:
        return "Completed";
      case ProjectStatus.onHold:
        return "On Hold";
    }
  }

  // Widget untuk membuat status "Pill" yang bisa digunakan kembali
  Widget _buildStatusPill(ProjectStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _statusColor(status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        _statusText(status),
        style: TextStyle(
          color: _statusColor(status),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // Widget untuk membuat baris header tabel
  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 4, // Memberi lebih banyak ruang untuk nama proyek
            child: Text(
              'PROYEK',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black54),
            ),
          ),
          const Expanded(
            flex: 2,
            child: Text(
              'STATUS',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.black54),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              child: const Text(
                'TENGGAT',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.black54),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat baris data proyek
  Widget _buildProjectRow(Project project) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  project.description,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
          ),
          // Kolom 2: Status Proyek
          Expanded(
            flex: 2,
            child: Center(child: _buildStatusPill(project.status)),
          ),
          // Kolom 3: Tanggal Tenggat
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              child: Text(
                DateFormat('d MMM yyyy').format(project.deadline),
                style: const TextStyle(color: Colors.black54, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Latar belakang putih bersih
      appBar: AppBar(
        title: const Text('Projects', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        shadowColor: Colors.grey.shade300,
      ),
      body: Column(
        children: [
          _buildHeaderRow(), // Menampilkan header
          Expanded(
            // ListView sekarang berada di dalam Expanded
            child: ListView.builder(
              itemCount: dummyProjects.length,
              itemBuilder: (context, index) {
                final project = dummyProjects[index];
                // Setiap item sekarang adalah baris data yang sudah kita buat
                return _buildProjectRow(project);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => const _AddProjectSheet(),
            isScrollControlled: true,
          );
        },
        tooltip: "Tambah Proyek",
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Widget untuk bottom sheet tambah proyek (tetap sama)
class _AddProjectSheet extends StatelessWidget {
  const _AddProjectSheet();

  @override
  Widget build(BuildContext context) {
    // Memberi padding untuk keyboard
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: 400, // Tinggi bisa disesuaikan
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tambah Proyek Baru",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nama Proyek',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Simpan Proyek'),
              ),
            )
          ],
        ),
      ),
    );
  }
}