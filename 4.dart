import 'dart:math';

class BankAccount {
  final String accountNumber;
  double _balance = 0.0;
  final String ownerName;
  BankAccount._internal(this.accountNumber, this.ownerName);
  factory BankAccount.create(String ownerName, Set<String> existingNumbers) {
    String newNumber;
    do {
      newNumber = _generateAccountNumber();
    } while (existingNumbers.contains(newNumber));
    return BankAccount._internal(newNumber, ownerName);
  }
  static String _generateAccountNumber() {
    final random = Random();
    return List.generate(10, (_) => random.nextInt(10)).join();
  }

  double get balance => _balance;
  void deposit(double amount) {
    if (amount < 0) {
      print('Ошибка: сумма депозита не может быть отрицательной.');
      return;
    }
    _balance += amount;
    print('Счет $accountNumber пополнен на $amount. Баланс: $_balance');
  }

  void withdraw(double amount) {
    if (amount < 0) {
      print('Ошибка: сумма снятия не может быть отрицательной.');
      return;
    }
    if (amount > _balance) {
      print('Ошибка: недостаточно средств на счете $accountNumber.');
      return;
    }
    _balance -= amount;
    print('Со счета $accountNumber снято $amount. Баланс: $_balance');
  }

  void displayBalance() {
    print('Счет $accountNumber (владелец: $ownerName): баланс = $_balance');
  }

  @override
  String toString() => 'BankAccount($accountNumber, $ownerName, $_balance)';
}

class Bank {
  final List<BankAccount> _accounts = [];
  BankAccount addAccount(String ownerName) {
    final existingNumbers = _accounts.map((acc) => acc.accountNumber).toSet();
    final newAccount = BankAccount.create(ownerName, existingNumbers);
    _accounts.add(newAccount);
    print(
      'Создан новый счет: ${newAccount.accountNumber} (владелец: $ownerName)',
    );
    return newAccount;
  }

  BankAccount? findAccount(String accountNumber) {
    try {
      return _accounts.firstWhere((acc) => acc.accountNumber == accountNumber);
    } on StateError {
      return null;
    }
  }

  void transfer(
    String fromAccountNumber,
    String toAccountNumber,
    double amount,
  ) {
    if (amount < 0) {
      print('Ошибка: сумма перевода не может быть отрицательной.');
      return;
    }
    final from = findAccount(fromAccountNumber);
    final to = findAccount(toAccountNumber);
    if (from == null) {
      print('Ошибка: счет отправителя $fromAccountNumber не найден.');
      return;
    }
    if (to == null) {
      print('Ошибка: счет получателя $toAccountNumber не найден.');
      return;
    }
    if (from.balance < amount) {
      print(
        'Ошибка: недостаточно средств на счете отправителя $fromAccountNumber.',
      );
      return;
    }
    from.withdraw(amount);
    to.deposit(amount);
    print(
      'Перевод $amount со счета $fromAccountNumber на счет $toAccountNumber выполнен.',
    );
  }

  void printAllAccounts() {
    print('Список всех счетов:');
    for (var acc in _accounts) {
      acc.displayBalance();
    }
  }
}

void main() {
  final bank = Bank();
  final acc1 = bank.addAccount('Иван Иванов');
  final acc2 = bank.addAccount('Петр Петров');
  final acc3 = bank.addAccount('Анна Сидорова');
  acc1.deposit(1000);
  acc2.deposit(500);
  acc3.deposit(2000);
  acc2.withdraw(200);
  acc2.withdraw(400);
  print('\n--- Текущие балансы ---');
  bank.printAllAccounts();
  print('\n--- Перевод ---');
  bank.transfer(acc1.accountNumber, acc3.accountNumber, 300);
  bank.transfer(acc1.accountNumber, acc2.accountNumber, 1000);
  bank.transfer('1111111111', acc2.accountNumber, 100);
  print('\n--- Итоговые балансы ---');
  bank.printAllAccounts();
}
