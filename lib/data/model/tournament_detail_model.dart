class TournamentDetailModel {
  final String city;
  final String startingPoint;
  final String endingPoint;
  final String map;
  final int distance;
  final String waterFree;
  final int totalNumber;
  final int cost;
  final String donors;

  TournamentDetailModel(
      {required this.city,
      required this.startingPoint,
      required this.endingPoint,
      required this.map,
      required this.distance,
      required this.waterFree,
      required this.totalNumber,
      required this.cost,
      required this.donors});
}
