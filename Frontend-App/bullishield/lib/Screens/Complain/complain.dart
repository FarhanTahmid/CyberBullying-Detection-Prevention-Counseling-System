class Complains {
  final int id;
  final String title;
  final String status;
  final String details;

  Complains(
      {required this.id,
      required this.title,
      required this.status,
      required this.details});
}

class ComplainModel {
  static final list = [
    Complains(
        id: 01,
        title: "Complain-01",
        status: "Processing",
        details: "Campus harassment complain agianst ID: 2031458642")
  ];
}

class DetailScreen {
  final int id;
  final String title;
  final String status;
  final String details;

  DetailScreen(
      {required this.id,
      required this.title,
      required this.status,
      required this.details});
}

class DetailsModel {
  static final list = [
    Complains(
        id: 01,
        title: "Complain-01",
        status: "Processing",
        details: "Campus harassment complain agianst ID: 2031458642")
  ];
}
