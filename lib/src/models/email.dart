import 'package:isar/isar.dart';

part 'email.g.dart';

@collection
class Email {
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  @Index(type: IndexType.value)
  String? title;

  List<Recipient>? recipients;

  @enumerated
  late Status status;
}

@embedded
class Recipient {
  String? name;

  String? address;
}

enum Status {
  draft,
  pending,
  sent,
}
