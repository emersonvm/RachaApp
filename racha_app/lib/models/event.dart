class Event {
  final String id;
  final double totalAmount;
  final DateTime dateEvent;
  final String address;
  bool isFavorite;

  Event({
    required this.id,
    required this.totalAmount,
    required this.dateEvent,
    required this.address,
    this.isFavorite = true,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}
