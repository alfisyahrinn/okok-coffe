String priceFormat(String amount) {
  String currency = 'Rp ';

  String amountString = amount.replaceAll(',', ''); // Menghapus koma jika ada
  String formattedAmount = '';

  int digitCount = 0;
  for (int i = amountString.length - 1; i >= 0; i--) {
    formattedAmount = amountString[i] + formattedAmount;
    digitCount++;

    if (digitCount == 3 && i != 0) {
      formattedAmount = '.' + formattedAmount;
      digitCount = 0;
    }
  }

  return currency + formattedAmount;
}
