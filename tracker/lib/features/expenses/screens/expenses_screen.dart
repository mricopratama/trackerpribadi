import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/expense_model.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final CollectionReference _expensesCollection = FirebaseFirestore.instance.collection('expenses');

  Future<void> _addExpense(Expense expense) async {
    await _expensesCollection.add(expense.toJson());
  }

  Future<void> _updateExpense(Expense expense) async {
    await _expensesCollection.doc(expense.id).update(expense.toJson());
  }

  Future<void> _deleteExpense(String id) async {
    await _expensesCollection.doc(id).delete();
  }

  void _openExpenseSheet({Expense? expense}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddEditExpenseSheet(
        expense: expense,
        onSave: (newExpense) {
          if (expense == null) {
            _addExpense(newExpense);
          } else {
            _updateExpense(newExpense);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengeluaran"),
        centerTitle: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _expensesCollection.orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Belum ada pengeluaran."));
          }

          final expenses = snapshot.data!.docs.map((doc) {
            return Expense.fromJson(doc.id, doc.data() as Map<String, dynamic>);
          }).toList();

          final double totalAmount = expenses.fold(0, (sum, item) => sum + item.amount);
          final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

          return Column(
            children: [
              _buildSummaryHeader(formatter.format(totalAmount)),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return Dismissible(
                      key: ValueKey(expense.id),
                      direction: DismissDirection.endToStart,
                      onDismissed: (_) => _deleteExpense(expense.id),
                      background: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20.0),
                        child: const Icon(Icons.delete_outline, color: Colors.white),
                      ),
                      child: _ExpenseItem(
                        expense: expense,
                        onTap: () => _openExpenseSheet(expense: expense),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openExpenseSheet(),
        child: const Icon(Icons.add),
        tooltip: 'Tambah Pengeluaran',
      ),
    );
  }

  Widget _buildSummaryHeader(String total) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total Bulan Ini", style: Theme.of(context).textTheme.titleMedium),
              Text(total, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpenseItem extends StatelessWidget {
  final Expense expense;
  final VoidCallback onTap;
  const _ExpenseItem({required this.expense, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          child: Icon(categoryIcons[expense.category], size: 24),
        ),
        title: Text(expense.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(DateFormat('d MMMM y').format(expense.date)),
        trailing: Text(formatter.format(expense.amount), style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _AddEditExpenseSheet extends StatefulWidget {
  final Expense? expense;
  final Function(Expense) onSave;
  const _AddEditExpenseSheet({this.expense, required this.onSave});

  @override
  State<_AddEditExpenseSheet> createState() => __AddEditExpenseSheetState();
}

class __AddEditExpenseSheetState extends State<_AddEditExpenseSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _amountController;
  DateTime? _selectedDate;
  ExpenseCategory _selectedCategory = ExpenseCategory.makanan;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.expense?.title ?? '');
    _amountController = TextEditingController(text: widget.expense?.amount.toStringAsFixed(0) ?? '');
    _selectedDate = widget.expense?.date;
    _selectedCategory = widget.expense?.category ?? ExpenseCategory.makanan;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(now.year - 1, now.month, now.day),
      lastDate: now,
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _submitData() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid || _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_selectedDate == null ? 'Silakan pilih tanggal.' : 'Harap isi semua kolom.')),
      );
      return;
    }

    final expenseData = Expense(
      id: widget.expense?.id ?? DateTime.now().toString(),
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      date: _selectedDate!,
      category: _selectedCategory,
    );

    widget.onSave(expenseData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.expense != null;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(isEditing ? "Edit Pengeluaran" : "Tambah Pengeluaran Baru", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
              validator: (value) => (value == null || value.isEmpty) ? 'Judul tidak boleh kosong' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Jumlah (Rp)'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0) {
                  return 'Masukkan jumlah yang valid';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(_selectedDate == null ? 'Pilih Tanggal' : DateFormat('d MMMM y').format(_selectedDate!)),
                ),
                IconButton(onPressed: _presentDatePicker, icon: const Icon(Icons.calendar_month)),
              ],
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<ExpenseCategory>(
              value: _selectedCategory,
              items: ExpenseCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category.name[0].toUpperCase() + category.name.substring(1)),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedCategory = value;
                });
              },
              decoration: const InputDecoration(labelText: 'Kategori'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitData,
              child: Text(isEditing ? 'Simpan Perubahan' : 'Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
