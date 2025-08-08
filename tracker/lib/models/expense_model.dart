import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum ExpenseCategory { makanan, transport, hiburan, tagihan, lainnya }

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

  factory Expense.fromJson(String id, Map<String, dynamic> json) {
    return Expense(
      id: id,
      title: json['title'],
      amount: json['amount'],
      date: (json['date'] as Timestamp).toDate(),
      category: ExpenseCategory.values.byName(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': Timestamp.fromDate(date),
      'category': category.name,
    };
  }
}
