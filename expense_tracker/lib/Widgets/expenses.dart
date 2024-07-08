import 'package:expense_tracker/Widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/Widgets/new_expense.dart';
import 'package:flutter/material.dart';

import '../model/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(
      title: 'Flutter Course',
      amount: 27000,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'some shit',
      amount: 1919,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void _onAddPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: _onAddPressed, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          const Text('Expense chart'),
          Expanded(
            child: ExpensesList(expenses: _registeredExpense),
          )
        ],
      ),
    );
  }
}
