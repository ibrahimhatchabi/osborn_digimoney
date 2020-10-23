
class OPTransaction {
  static final String columnId = "id";
  static final String columnAgent = "agent";
  static final String columnDate = "date";
  static final String columnMontant = "montant";
  static final String columnNumero = "numero";
  static final String columnType = "type";
  static final String columnStatus = "status";
  static final String columnCreditOuCash = "creditOuCash";
  static final String columnObservations = "observations";

  OPTransaction({
    this.id,
    this.agent,
    this.date,
    this.montant,
    this.numero,
    this.type,
    this.status,
    this.creditOuCash,
    this.observations,
  });

  final String id;
  final String agent;
  final String date;
  final String montant;
  final String numero;
  final String type;
  final String status;
  final String creditOuCash;
  final String observations;

  Map toMap() {
    Map<String, dynamic> map = {
      columnId: id,
      columnAgent: agent,
      columnDate: date,
      columnMontant: montant,
      columnNumero: numero,
      columnType: type,
      columnStatus: status,
      columnCreditOuCash: creditOuCash,
      columnObservations: observations
    };
    return map;
  }

  static OPTransaction fromMap(Map map) {
    return OPTransaction(
      id: map[columnId],
      agent: map[columnAgent],
      date: map[columnDate],
      montant: map[columnMontant],
      numero: map[columnNumero],
      type: map[columnType],
      status: map[columnStatus],
      creditOuCash: map[columnCreditOuCash],
      observations: map[columnObservations]
    );
  }
}

