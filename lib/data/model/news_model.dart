class NewsModel {
  final String name;
  final String address;
  final DateTime dateTime;
  final int price;
  final String donors;
  final String poster;
  final int distance;
  final String description;

  NewsModel(
      {required this.name,
      required this.poster,
      this.distance = 60,
      this.description =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
      required this.address,
      required this.dateTime,
      required this.price,
      required this.donors});
}
