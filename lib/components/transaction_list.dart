import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {super.key, required this.transactions, required this.onRemove});
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.isEmpty
          ? <Widget>[
              const SizedBox(height: 20),
              Text(
                'Nenhuma Transacao Cadastrada!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/waiting.png',
                fit: BoxFit.cover,
                height: 200,
              )
            ]
          : [
              ...transactions
                  .map((transaction) => TransactionItem(
                        transaction: transaction,
                        onRemove: onRemove,
                      ))
                  .toList(),
              const SizedBox(height: 80)
            ],
    );
  }
}


