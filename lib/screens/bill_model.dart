class Bill {
  double rent;
  double water;
  double electricity;
  bool isPaid;

  Bill({
    required this.rent,
    required this.water,
    required this.electricity,
    this.isPaid = false,
  });

  double get total => rent + water + electricity;
}
