import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/dashboard/screens/dashboard_screen.dart';
import 'features/expenses/screens/expenses_screen.dart';
import 'features/projects/screens/projects_screen.dart';
import 'features/jobs/screens/jobs_screen.dart';

final bottomNavProvider = StateProvider<int>((ref) => 0);

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  static final List<Widget> _screens = [
    DashboardScreen(),
    ExpensesScreen(),
    ProjectsScreen(),
    JobsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(bottomNavProvider);

    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => ref.read(bottomNavProvider.notifier).state = index,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: "Dashboard",
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: "Pengeluaran",
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline),
            selectedIcon: Icon(Icons.work),
            label: "Proyek",
          ),
          NavigationDestination(
            icon: Icon(Icons.business_center_outlined),
            selectedIcon: Icon(Icons.business_center),
            label: "Lamaran",
          ),
        ],
      ),
    );
  }
}