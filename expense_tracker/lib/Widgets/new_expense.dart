import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double bottomSheetPadding = 16;

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  Category? _selectedCategory = Category.leisure;

  // void onTitleChange(String value) {
  //   print(value);
  // }

  Future<void> _onCalendarPressed() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(
        now.year - 1,
        now.month,
        now.day,
      ),
      lastDate: now,
    );

    setState(() {
      _selectedDate = selected;
    });
  }

  void _onCategoryChanged(Category? value) {
    if (value == null) {
      return;
    }

    setState(() {
      _selectedCategory = value;
    });
  }

  void _onSubmit() {
    final text = _titleController.text.trim();
    final amount = double.tryParse(_amountController.text);
    print('amount: $amount');
    final isAmountValid = amount != null && amount > 0;
    if (text.isEmpty || !isAmountValid || _selectedDate == null) {
      // show error
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ],
        ),
      );

      return;
    }

    widget.onAddExpense(Expense(
      title: _titleController.text.trim(),
      amount: amount,
      date: _selectedDate!,
      category: _selectedCategory!,
    ));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = _selectedDate == null
        ? 'Please select date'
        : formatter.format(_selectedDate!);

    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            bottomSheetPadding,
            AppBar().preferredSize.height,
            bottomSheetPadding,
            keyboardSpace + bottomSheetPadding,
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                // onChanged: onTitleChange,
                controller: _titleController,
                maxLength: 50,
                // keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '¥',
                        label: Text('Amount'),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(formattedDate),
                        IconButton(
                          onPressed: _onCalendarPressed,
                          icon: const Icon(Icons.date_range),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (cat) => DropdownMenuItem(
                            value: cat,
                            child: Text(
                              cat.name.toString().toUpperCase(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: _onCategoryChanged,
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('cancel'),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: _onSubmit,
                    child: const Text('save'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
