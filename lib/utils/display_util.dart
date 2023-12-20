class DisplayUtil {
  // for display postive amount
  String getDisplayAmount(double amount) {
    if (amount >= 1e9) {
      // Display in billions using scientific notation
      return '₱ ${(amount / 1e9).toStringAsFixed(1)}B';
    } else if (amount >= 1e6) {
      // Display in millions using scientific notation
      return '₱ ${(amount / 1e6).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      // Display in thousands
      return '₱ ${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      // Display as is
      return '₱ $amount';
    }
  }

  // for display negative amount
  String getDisplayNegativeAmount(double amount) {
    double absAmount = amount.abs();
    if (absAmount >= 1e9) {
      // Display in billions using scientific notation
      return ' -₱ ${(absAmount / 1e9).toStringAsFixed(1)}B';
    } else if (absAmount >= 1e6) {
      // Display in millions using scientific notation
      return ' -₱ ${(absAmount / 1e6).toStringAsFixed(1)}M';
    } else if (absAmount >= 1000) {
      // Display in thousands
      return ' -₱ ${(absAmount / 1000).toStringAsFixed(1)}K';
    } else {
      // Display as is
      return ' -₱ $absAmount';
    }
  }
}
