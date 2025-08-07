import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/project_model.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final List<Project> _projects = [
    Project(id: 'TSK-8', name: 'Improve Navigation & Menu Organization', status: ProgressStatus.ongoing, urgency: Urgency.moderate, assignees: ['AP', 'BD'], deadline: DateTime(2025, 9, 15), isPaid: false),
    Project(id: 'TSK-20', name: 'Enhance Search Functionality', status: ProgressStatus.completed, urgency: Urgency.critical, assignees: ['CJ'], deadline: DateTime(2025, 8, 20), isPaid: true, payment: 5000000, completedAt: DateTime(2025, 8, 1)),
    Project(id: 'TSK-22', name: 'Dark Mode Implementation', status: ProgressStatus.inReview, urgency: Urgency.minor, assignees: ['AP', 'DD', 'EM'], deadline: DateTime(2025, 9, 30), isPaid: false),
    Project(id: 'TSK-6', name: 'Redesign Checkout Flow', status: ProgressStatus.ongoing, urgency: Urgency.critical, assignees: ['FK', 'GL'], deadline: DateTime(2025, 10, 5), isPaid: true, payment: 7500000),
    Project(id: 'TSK-40', name: 'Reduce Load Time for Large Data Sets', status: ProgressStatus.pending, urgency: Urgency.minor, assignees: ['AP'], deadline: DateTime(2025, 8, 25), isPaid: false),
    Project(id: 'TSK-12', name: 'Optimize Image Compression', status: ProgressStatus.completed, urgency: Urgency.moderate, assignees: ['CJ', 'FK'], deadline: DateTime(2025, 11, 10), isPaid: true, payment: 3500000, completedAt: DateTime(2025, 10, 30)),
  ];

  void _addProject(Project project) {
    setState(() {
      _projects.insert(0, project);
    });
  }

  void _openAddProjectSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddProjectSheet(onAddProject: _addProject),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Proyek"),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: _openAddProjectSheet,
              icon: const Icon(Icons.add_circle_outline),
              tooltip: "Tambah Proyek Baru",
            ),
            const SizedBox(width: 8),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'All Tasks'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOverviewTab(),
            _buildTasksListTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewTab() {
    final int ongoing = _projects.where((p) => p.status == ProgressStatus.ongoing).length;
    final int inReview = _projects.where((p) => p.status == ProgressStatus.inReview).length;
    final double totalEarned = _projects.where((p) => p.isPaid && p.status == ProgressStatus.completed).fold(0, (sum, item) => sum + (item.payment ?? 0));
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text("Ringkasan Proyek", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.2,
          children: [
            _OverviewCard(title: "Ongoing", value: ongoing.toString(), icon: Icons.autorenew),
            _OverviewCard(title: "In Review", value: inReview.toString(), icon: Icons.rate_review_outlined),
            _OverviewCard(title: "Total Earned", value: formatter.format(totalEarned), icon: Icons.monetization_on_outlined, isPrimary: true),
          ],
        ),
        const SizedBox(height: 24),
        Text("Deadline Mendatang", style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ..._projects.where((p) => p.status != ProgressStatus.completed).take(3).map((p) => _ProjectItemCard(project: p)),
      ],
    );
  }

  Widget _buildTasksListTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _projects.length,
      itemBuilder: (context, index) {
        return _ProjectItemCard(project: _projects[index]);
      },
    );
  }
}

// --- WIDGET Kustom ---

class _OverviewCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool isPrimary;

  const _OverviewCard({required this.title, required this.value, required this.icon, this.isPrimary = false});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      color: isPrimary ? colors.primary : colors.surface,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 32, color: isPrimary ? colors.onPrimary : colors.onSurface),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold, color: isPrimary ? colors.onPrimary : colors.onSurface)),
                Text(title, style: TextStyle(color: (isPrimary ? colors.onPrimary : colors.onSurface).withOpacity(0.8))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectItemCard extends StatelessWidget {
  final Project project;
  const _ProjectItemCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final statusInfo = ProjectInfo.getStatusInfo(context, project.status);
    final urgencyInfo = ProjectInfo.getUrgencyInfo(context, project.urgency);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.id, style: Theme.of(context).textTheme.bodySmall),
            Text(project.name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoPill(info: statusInfo),
                _InfoPill(info: urgencyInfo),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _AssigneeAvatars(assignees: project.assignees),
                Row(
                  children: [
                    const Icon(Icons.calendar_today_outlined, size: 14),
                    const SizedBox(width: 4),
                    Text(DateFormat('d MMM y').format(project.deadline), style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final ProjectInfo info;
  const _InfoPill({required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: info.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          if (info.icon != null) ...[
            Icon(info.icon, color: info.color, size: 14),
            const SizedBox(width: 6),
          ],
          Text(info.text, style: TextStyle(color: info.color, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }
}

class _AssigneeAvatars extends StatelessWidget {
  final List<String> assignees;
  const _AssigneeAvatars({required this.assignees});

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.blue, Colors.green, Colors.purple, Colors.orange, Colors.pink];
    List<Widget> avatarWidgets = [];
    int maxAvatars = 3;
    for (int i = 0; i < assignees.length && i < maxAvatars; i++) {
      avatarWidgets.add(
        Positioned(
          left: (i * 18).toDouble(),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: colors[i % colors.length].shade200,
            child: Text(assignees[i], style: TextStyle(fontSize: 10, color: colors[i % colors.length].shade900, fontWeight: FontWeight.bold)),
          ),
        ),
      );
    }
    if (assignees.length > maxAvatars) {
      avatarWidgets.add(
        Positioned(
          left: (maxAvatars * 18).toDouble(),
          child: CircleAvatar(
            radius: 14,
            backgroundColor: Colors.grey.shade300,
            child: Text('+${assignees.length - maxAvatars}', style: const TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold)),
          ),
        ),
      );
    }
    return SizedBox(width: (assignees.length * 18) + 15, height: 28, child: Stack(children: avatarWidgets));
  }
}

class _AddProjectSheet extends StatefulWidget {
  final Function(Project) onAddProject;
  const _AddProjectSheet({required this.onAddProject});

  @override
  State<_AddProjectSheet> createState() => __AddProjectSheetState();
}

class __AddProjectSheetState extends State<_AddProjectSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  DateTime? _selectedDate;
  Urgency _selectedUrgency = Urgency.moderate;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 2)),
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitData() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_selectedDate == null ? 'Silakan pilih deadline.' : 'Harap isi semua kolom.')),
      );
      return;
    }

    final newProject = Project(
      id: "TSK-${DateTime.now().millisecond}",
      name: _nameController.text,
      status: ProgressStatus.pending,
      urgency: _selectedUrgency,
      assignees: ['ME'], // Default assignee
      deadline: _selectedDate!,
    );

    widget.onAddProject(newProject);
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
            Text("Tambah Proyek Baru", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama Proyek/Fitur'),
              validator: (value) => (value == null || value.isEmpty) ? 'Nama tidak boleh kosong' : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null ? 'Pilih Deadline' : DateFormat('d MMMM y').format(_selectedDate!)),
                ),
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month),
                ),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<Urgency>(
              value: _selectedUrgency,
              items: Urgency.values.map((urgency) {
                final urgencyInfo = ProjectInfo.getUrgencyInfo(context, urgency);
                return DropdownMenuItem(
                  value: urgency,
                  child: Text(urgencyInfo.text),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedUrgency = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Urgensi'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Simpan Proyek'),
            ),
          ],
        ),
      ),
    );
  }
}
