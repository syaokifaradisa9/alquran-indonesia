String toArabicNumber(String input) {
  const number = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const arabic = ['۰', '۱', '۲', '۳', '٤', '۵', '٦', '۷', '۸', '۹'];

  for (int i = 0; i < number.length; i++) {
    input = input.replaceAll(number[i], arabic[i]);
  }

  return input;
}