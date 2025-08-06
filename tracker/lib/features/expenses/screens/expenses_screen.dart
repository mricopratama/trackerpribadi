import 'package:flutter/material.dart';
import '../../../models/expense_model.dart';

class ExpensesScreen extends StatelessWidget {
  ExpensesScreen({super.key});

  final List<Expense> dummyExpenses = [
    Expense(
      id: "1",
      title: "Makan Siang",
      amount: 50000,
      category: "Makanan",
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Expense(
      id: "2",
      title: "Transportasi",
      amount: 15000,
      category: "Transport",
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Expense(
      id: "3",
      title: "Minum Kopi",
      amount: 30000,
      category: "Hiburan",
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: dummyExpenses.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final expense = dummyExpenses[index];
          return ListTile(
            leading: const Icon(Icons.attach_money),
            title: Text(expense.title),
            subtitle: Text(expense.category),
            trailing: Text(
              "Rp ${expense.amount.toStringAsFixed(0)}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open add expense dialog
          showModalBottomSheet(
            context: context,
            builder: (_) => const _AddExpenseSheet(),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Tambah Pengeluaran',
      ),
    );
  }
}

class _AddExpenseSheet extends StatelessWidget {
  const _AddExpenseSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 300,
      child: Center(
        child: Text(
          "Form Tambah Pengeluaran (Dummy)",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}