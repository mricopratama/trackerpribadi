import 'package:flutter/material.dart';

// Enum untuk kategori pengeluaran
enum ExpenseCategory {
  makanan,
  transport,
  hiburan,
  tagihan,
  lainnya
}

// Map untuk mengaitkan kategori dengan ikonnya
final Map<ExpenseCategory, IconData> categoryIcons = {
  ExpenseCategory.makanan: Icons.fastfood_outlined,
  ExpenseCategory.transport: Icons.directions_bus_outlined,
  ExpenseCategory.hiburan: Icons.movie_outlined,
  ExpenseCategory.tagihan: Icons.receipt_long_outlined,
  ExpenseCategory.lainnya: Icons.more_horiz_outlined,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}
