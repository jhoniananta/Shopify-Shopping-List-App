class Account {
  final String id;
  final String name;
  final String email;
  final String birthdayDate;
  final String birthdayPlace;
  final String phoneNumber;
  final int listMade;
  final int listDone;

  Account(
      {required this.id,
      required this.name,
      required this.email,
      required this.birthdayDate,
      required this.birthdayPlace,
      required this.listDone,
      required this.listMade,
      required this.phoneNumber});

  factory Account.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Account(
      id: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? 0,
      birthdayPlace: data['birthdayPlace'] ?? '',
      birthdayDate: data['birthdayDate'] ?? '',
      listMade: data['listMade'] ?? 0,
      listDone: data['listDone'] ?? 0,
    );
  }
}
