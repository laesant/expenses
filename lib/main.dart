import 'dart:io';
import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatefulWidget {
  const ExpensesApp({super.key});

  @override
  State<ExpensesApp> createState() => _ExpensesAppState();
}

class _ExpensesAppState extends State<ExpensesApp> {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() => setState(() => themeMode =
      themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.light, seedColor: Colors.deepOrange),
          useMaterial3: true),
      darkTheme: ThemeData(
          fontFamily: 'OpenSans',
          textTheme: ThemeData.dark().textTheme.copyWith(
              titleMedium:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          colorScheme: ColorScheme.fromSeed(
              brightness: Brightness.dark, seedColor: Colors.deepOrange),
          useMaterial3: true),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: const Locale('pt'),
      supportedLocales: const [Locale('pt')],
      home: MyHomePage(
        toggleTheme: toggleTheme,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.toggleTheme});
  final void Function() toggleTheme;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
            (transaction) => transaction.date.isAfter(DateTime.now().subtract(
                  const Duration(days: 7),
                )))
        .toList();
  }

  void _addTransaction(String title, double value, DateTime dateTime) {
    final Transaction newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: dateTime);

    setState(() => _transactions.add(newTransaction));

    Navigator.of(context).pop();
  }

  void _removeTransaction(String id) => setState(
      () => _transactions.removeWhere((transaction) => transaction.id == id));

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => TransactionForm(onSubmit: _addTransaction));
  }

  Widget _getIconButton({required IconData icon, required Function() fn}) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    const title = Text("Despesas Pessoais");

    final iconList = Platform.isIOS ? CupertinoIcons.refresh : Icons.list_alt;
    final iconChart = Platform.isIOS ? CupertinoIcons.refresh : Icons.bar_chart;
    final iconAdd = Platform.isIOS ? CupertinoIcons.add : Icons.add;

    final actions = <Widget>[
      if (isLandscape)
        _getIconButton(
            fn: () => setState(() => _showChart = !_showChart),
            icon: _showChart ? iconList : iconChart),
      _getIconButton(
          fn: () => _openTransactionFormModal(context), icon: iconAdd)
    ];

    final leading = _getIconButton(
        fn: widget.toggleTheme,
        icon: Theme.of(context).brightness == Brightness.dark
            ? Icons.light_mode
            : Icons.dark_mode);

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_showChart || !isLandscape)
              Chart(recentTransaction: _recentTransactions),
            if (!_showChart || !isLandscape)
              TransactionList(
                transactions: _transactions,
                onRemove: _removeTransaction,
              ),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              leading: leading,
              middle: title,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: actions,
              ),
            ),
            child: bodyPage)
        : Scaffold(
            appBar: AppBar(
              leading: leading,
              title: title,
              centerTitle: true,
              actions: actions,
            ),
            floatingActionButton: Platform.isIOS
                ? null
                : FloatingActionButton(
                    onPressed: () => _openTransactionFormModal(context),
                    child: const Icon(Icons.add),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: bodyPage);
  }
}
