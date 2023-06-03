class Complain {
  final int id;
  final String complaineeId;
  final int organizationId;
  final int complainTypeId;
  final String bullyName;
  final String bullyId;
  final String bullyPicture;
  final String incidentDate;
  final String complainDescription;
  final bool complainValidation;
  final String complainStatus;
  final String complainDecision;
  final bool bullyGuilty;

  Complain({
    required this.id,
    required this.complaineeId,
    required this.organizationId,
    required this.complainTypeId,
    required this.bullyName,
    required this.bullyId,
    required this.bullyPicture,
    required this.incidentDate,
    required this.complainDescription,
    required this.complainValidation,
    required this.complainStatus,
    required this.complainDecision,
    required this.bullyGuilty,
  });
}
