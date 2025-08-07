import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/expense_model.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  // Data dummy yang akan dikelola oleh state
  final List<Expense> _expenses = [
    Expense(id: "1", title: "Makan Siang", amount: 50000, category: ExpenseCategory.makanan, date: DateTime.now().subtract(const Duration(days: 1))),
    Expense(id: "2", title: "Tiket Bioskop", amount: 45000, category: ExpenseCategory.hiburan, date: DateTime.now().subtract(const Duration(days: 1))),
    Expense(id: "3", title: "Naik MRT", amount: 15000, category: ExpenseCategory.transport, date: DateTime.now().subtract(const Duration(days: 2))),
    Expense(id: "4", title: "Bayar Listrik", amount: 250000, category: ExpenseCategory.tagihan, date: DateTime.now().subtract(const Duration(days: 3))),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.insert(0, expense); // Menambahkan di awal daftar
    });
  }

  void _openAddExpenseSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Penting agar sheet bisa lebih tinggi
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddExpenseSheet(onAddExpense: _addExpense),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double totalAmount = _expenses.fold(0, (sum, item) => sum + item.amount);
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengeluaran"),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Header Ringkasan
          _buildSummaryHeader(formatter.format(totalAmount)),
          // Daftar Pengeluaran
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                return _ExpenseItem(expense: _expenses[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseSheet,
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
              Text(
                "Total Bulan Ini",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                total,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- WIDGET untuk setiap item pengeluaran ---
class _ExpenseItem extends StatelessWidget {
  final Expense expense;
  const _ExpenseItem({required this.expense});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(categoryIcons[expense.category], size: 24),
        ),
        title: Text(expense.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(DateFormat('d MMMM y').format(expense.date)),
        trailing: Text(
          formatter.format(expense.amount),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}


// --- WIDGET untuk form tambah pengeluaran ---
class _AddExpenseSheet extends StatefulWidget {
  final Function(Expense) onAddExpense;
  const _AddExpenseSheet({required this.onAddExpense});

  @override
  State<_AddExpenseSheet> createState() => __AddExpenseSheetState();
}

class __AddExpenseSheetState extends State<_AddExpenseSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  ExpenseCategory _selectedCategory = ExpenseCategory.makanan;

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
      // Tampilkan pesan error jika tanggal kosong
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text( _selectedDate == null ? 'Silakan pilih tanggal.' : 'Harap isi semua kolom dengan benar.')),
      );
      return;
    }
    
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      date: _selectedDate!,
      category: _selectedCategory,
    );

    widget.onAddExpense(newExpense);
    Navigator.of(context).pop(); // Tutup bottom sheet
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding untuk mengakomodasi keyboard
      padding: EdgeInsets.fromLTRB(16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Tambah Pengeluaran Baru", style: Theme.of(context).textTheme.titleLarge),
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
                IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month),
                ),
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
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
