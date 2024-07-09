import 'package:expense_tracker/Widgets/chart/chart.dart';
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

  void _onAddNewExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _onAddPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewExpense(onAddExpense: _onAddNewExpense),
    );
  }

  void _onRemoveExpense(Expense expense) {
    final expenseIndex = _registeredExpense.indexOf(expense);

    setState(() {
      _registeredExpense.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(
        seconds: 5,
      ),
      content: const Text('Expense deleted'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpense.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = _registeredExpense.isNotEmpty
        ? ExpensesList(
            expenses: _registeredExpense,
            onDismissed: _onRemoveExpense,
          )
        : const Center(
            child: Text('No expenses found.'),
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(onPressed: _onAddPressed, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpense),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
