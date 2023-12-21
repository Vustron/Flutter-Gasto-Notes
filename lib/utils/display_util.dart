import 'package:intl/intl.dart';

class DisplayUtil {
  //title display formatter
  String limitCharacters(String title, int limit) {
    if (title.length > limit) {
      return '${title.substring(0, limit)}...';
    } else {
      return title;
    }
  }

  // default number formatter
  String formatAmount(double amount) {
    NumberFormat formatter =
        NumberFormat.currency(symbol: '₱', decimalDigits: 2);
    return formatter.format(amount);
  }

  // for display positive amount
  String getDisplayAmount(double amount) {
    NumberFormat currencyFormatter = NumberFormat.currency(symbol: '₱');
    if (amount >= 1e12) {
      // Display in trillions using scientific notation
      return ' ${currencyFormatter.format(amount / 1e12)} T+';
    } else if (amount >= 1e9) {
      // Display in billions using scientific notation
      return ' ${currencyFormatter.format(amount / 1e9)} B';
    } else if (amount >= 1e6) {
      // Display in millions using scientific notation
      return ' ${currencyFormatter.format(amount / 1e6)} M';
    } else if (amount >= 1000) {
      // Display in thousands
      return ' ${currencyFormatter.format(amount / 1000)} K';
    } else {
      // Display as is
      return currencyFormatter.format(amount);
    }
  }

  // for display negative amount
  String getDisplayNegativeAmount(double amount) {
    NumberFormat currencyFormatter = NumberFormat.currency(symbol: '₱');
    double absAmount = amount.abs();
    if (absAmount >= 1e12) {
      // Display in trillions using scientific notation
      return ' -${currencyFormatter.format(absAmount / 1e12)} T-';
    } else if (absAmount >= 1e9) {
      // Display in billions using scientific notation
      return ' -${currencyFormatter.format(absAmount / 1e9)} B';
    } else if (absAmount >= 1e6) {
      // Display in millions using scientific notation
      return ' -${currencyFormatter.format(absAmount / 1e6)} M';
    } else if (absAmount >= 1000) {
      // Display in thousands
      return ' -${currencyFormatter.format(absAmount / 1000)} K';
    } else {
      // Display as is
      return ' -${currencyFormatter.format(absAmount)}';
    }
  }
}
