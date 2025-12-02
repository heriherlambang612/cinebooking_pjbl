class PriceCalculator_yus {
  static int calculateSeatPrice(int basePrice, String seatCode, String movieTitle) {

    int tax = 0;
    if (movieTitle.length > 10) {
      tax = 2500;
    }


    int discount = 0;
    String numberStr = seatCode.replaceAll(RegExp(r'[^0-9]'), '');
    if (numberStr.isNotEmpty) {
      int seatNumber = int.parse(numberStr);
      if (seatNumber % 2 == 0) {
        discount = (basePrice * 0.1).round();
      }
    }

    return basePrice - discount + tax;
  }
}