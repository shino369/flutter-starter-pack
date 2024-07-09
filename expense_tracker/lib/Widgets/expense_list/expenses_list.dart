import 'package:expense_tracker/Widgets/expense_list/expense_item.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onDismissed});

  final List<Expense> expenses;
  final void Function(Expense expense) onDismissed;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Dismissible(
            background: Card(
              color: Theme.of(context).colorScheme.error.withOpacity(0.8),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 135,
                      child: Text(
                        'DELETE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Spacer(),
                    RotatedBox(
                      quarterTurns: 45,
                      child: Text(
                        'DELETE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            key: ValueKey(expenses[index]),
            onDismissed: (direction) {
              onDismissed(expenses[index]);
            },
            child: ExpenseItem(expense: expenses[index]),
            ),
      ),
    );
  }
}
