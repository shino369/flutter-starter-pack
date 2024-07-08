import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

const double bottomSheetPadding = 24;

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory = Category.leisure;

  // void onTitleChange(String value) {
  //   print(value);
  // }

  Future<void> onCalendarPressed() async {
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

  void onCategoryChanged(Category? value) {
    if (value == null) {
      return;
    }

    setState(() {
      _selectedCategory = value;
    });
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
    return Padding(
      padding:
          // const EdgeInsets.all(16),
          EdgeInsets.fromLTRB(
              bottomSheetPadding,
              AppBar().preferredSize.height,
              bottomSheetPadding,
              MediaQuery.of(context).viewInsets.bottom + bottomSheetPadding),
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
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
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
                      onPressed: onCalendarPressed,
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
                onChanged: onCategoryChanged,
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
                onPressed: () {
                  // print(_titleController.text);
                },
                child: const Text('save'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
