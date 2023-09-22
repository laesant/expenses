import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
                  .map((transaction) => Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: FittedBox(
                                  child: Text(
                                      "R\$ ${transaction.value.toStringAsFixed(2).replaceAll('.', ',')}"),
                                ),
                              )),
                          title: Text(transaction.title,
                              style: Theme.of(context).textTheme.titleMedium),
                          subtitle: Text(
                            DateFormat.yMMMd('pt').format(transaction.date),
                          ),
                          trailing: IconButton(
                              color: Theme.of(context).colorScheme.error,
                              onPressed: () => onRemove(transaction.id),
                              icon: const Icon(Icons.delete)),
                        ),
                      ))
                  .toList(),
              const SizedBox(height: 80)
            ],
    );
  }
}
