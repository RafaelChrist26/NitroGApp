class DiscountCount {
  static int mathDiscount(int priceBeforeDiscount, int discount) {
    int priceAfterDiscount =
        priceBeforeDiscount - ((priceBeforeDiscount * discount) ~/ 100);
    return priceAfterDiscount;
  }
}
