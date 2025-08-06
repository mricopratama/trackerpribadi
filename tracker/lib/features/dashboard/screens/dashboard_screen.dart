import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final double totalExpenses = 2500000.0;
    final int activeProjects = 3;
    final int sentApplications = 8;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(
            "Ringkasan Bulan Ini",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _SummaryCard(
                title: "Total Pengeluaran",
                value: "Rp ${totalExpenses.toStringAsFixed(0)}",
                icon: Icons.account_balance_wallet,
                color: Colors.red[100]!,
              ),
              const SizedBox(width: 12),
              _SummaryCard(
                title: "Proyek Aktif",
                value: "$activeProjects",
                icon: Icons.work,
                color: Colors.blue[100]!,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _SummaryCard(
                title: "Lamaran Terkirim",
                value: "$sentApplications",
                icon: Icons.send,
                color: Colors.green[100]!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Column(
            children: [
              Icon(icon, size: 32),
              const SizedBox(height: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}