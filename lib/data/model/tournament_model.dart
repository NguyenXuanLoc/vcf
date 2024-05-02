class TournamentModel {
  final String name;
  final String address;
  final DateTime dateTime;
  final int price;
  final String donors;
  final String poster;
  final int distance;

  TournamentModel(
      {required this.name,
        required this.poster,
        this.distance = 60,
        required this.address,
        required this.dateTime,
        required this.price,
        required this.donors});
}
