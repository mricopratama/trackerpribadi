import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data untuk demonstrasi
    final String userName = "User"; // Nantinya bisa diambil dari data login
    final double totalExpenses = 2540500.0;
    final int activeProjects = 3;
    final int sentApplications = 8;
    final int interviewsScheduled = 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Navigasi ke halaman profil atau pengaturan
            },
            icon: const Icon(Icons.account_circle_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHeader(context, userName),
          const SizedBox(height: 24),
          _buildSummaryGrid(context, totalExpenses, activeProjects, sentApplications, interviewsScheduled),
          const SizedBox(height: 24),
          _buildSectionTitle(context, "Analisis Pengeluaran"),
          const SizedBox(height: 16),
          _buildExpensesChart(context),
          const SizedBox(height: 24),
          _buildSectionTitle(context, "Aktivitas Terkini"),
          const SizedBox(height: 16),
          _buildRecentActivityList(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Tampilkan dialog untuk menambah data baru (pengeluaran/proyek)
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Bagian Header Sambutan
  Widget _buildHeader(BuildContext context, String userName) {
    return Text(
      "Selamat Datang, $userName!",
      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  // Bagian Grid untuk Kartu Ringkasan
  Widget _buildSummaryGrid(BuildContext context, double expenses, int projects, int apps, int interviews) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _SummaryCard(
          title: "Pengeluaran",
          value: formatter.format(expenses),
          icon: Icons.wallet_outlined,
          iconColor: Colors.redAccent,
        ),
        _SummaryCard(
          title: "Proyek Aktif",
          value: projects.toString(),
          icon: Icons.lightbulb_outline,
          iconColor: Colors.blueAccent,
        ),
        _SummaryCard(
          title: "Lamaran Terkirim",
          value: apps.toString(),
          icon: Icons.send_outlined,
          iconColor: Colors.green,
        ),
        _SummaryCard(
          title: "Jadwal Interview",
          value: interviews.toString(),
          icon: Icons.calendar_today_outlined,
          iconColor: Colors.orangeAccent,
        ),
      ],
    );
  }

  // Bagian Judul untuk setiap seksi
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  // Bagian Grafik Pengeluaran
  Widget _buildExpensesChart(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 20, // Nilai maksimum Y (misal: 20 = 2 juta)
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                show: true,
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(fontSize: 10);
                      String text = '';
                      switch (value.toInt()) {
                        case 0: text = 'Mei'; break;
                        case 1: text = 'Jun'; break;
                        case 2: text = 'Jul'; break;
                        case 3: text = 'Agu'; break;
                      }
                      return SideTitleWidget(axisSide: meta.axisSide, child: Text(text, style: style));
                    },
                    reservedSize: 28,
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              barGroups: [ // Data dummy untuk 4 bulan
                BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: colors.primary, width: 15, borderRadius: BorderRadius.circular(4))]),
                BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: colors.primary, width: 15, borderRadius: BorderRadius.circular(4))]),
                BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: colors.primary, width: 15, borderRadius: BorderRadius.circular(4))]),
                BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: colors.primary, width: 15, borderRadius: BorderRadius.circular(4))]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Bagian Daftar Aktivitas Terkini
  Widget _buildRecentActivityList(BuildContext context) {
    // Data dummy
    final List<Map<String, dynamic>> recentActivities = [
      {'icon': Icons.shopping_cart, 'title': 'Makan Siang', 'subtitle': 'Pengeluaran', 'value': '-Rp 50.000'},
      {'icon': Icons.work_history, 'title': 'Update Proyek "Portfolio"', 'subtitle': 'Proyek', 'value': 'Selesai'},
      {'icon': Icons.mail, 'title': 'Lamaran ke Google', 'subtitle': 'Lamaran', 'value': 'Terkirim'},
      {'icon': Icons.payment, 'title': 'Bayar Internet', 'subtitle': 'Pengeluaran', 'value': '-Rp 350.000'},
    ];

    return Column(
      children: recentActivities.map((activity) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: Icon(activity['icon'], color: Theme.of(context).colorScheme.primary),
            title: Text(activity['title'], style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text(activity['subtitle']),
            trailing: Text(activity['value'], style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
        );
      }).toList(),
    );
  }
}


// --- WIDGET Kustom untuk Kartu Ringkasan ---
class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: iconColor),
            const Spacer(),
            Text(
              value,
              style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: textTheme.bodyMedium?.copyWith(color: colors.onSurface.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}
