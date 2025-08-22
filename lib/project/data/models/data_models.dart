import 'package:sqflite/sqflite.dart';
// Import your models here
// import 'models.dart';
// Person Model


// User Model
class User {
  final int? id;
  final int uuid;
  final int? personId;
  final String username;
  final String email;
  final String pwHashed;
  final DateTime timestampUpdated;
  final DateTime timestampCreated;

  User({
    this.id,
    required this.uuid,
    this.personId,
    required this.username,
    required this.email,
    required this.pwHashed,
    required this.timestampUpdated,
    required this.timestampCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'person_id': personId,
      'username': username,
      'email': email,
      'pw_hashed': pwHashed,
      'timestamp_updated': timestampUpdated.millisecondsSinceEpoch,
      'timestamp_created': timestampCreated.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      uuid: map['uuid'],
      personId: map['person_id'],
      username: map['username'],
      email: map['email'],
      pwHashed: map['pw_hashed'],
      timestampUpdated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_updated']),
      timestampCreated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_created']),
    );
  }

  User copyWith({
    int? id,
    int? uuid,
    int? personId,
    String? username,
    String? email,
    String? pwHashed,
    DateTime? timestampUpdated,
    DateTime? timestampCreated,
  }) {
    return User(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      personId: personId ?? this.personId,
      username: username ?? this.username,
      email: email ?? this.email,
      pwHashed: pwHashed ?? this.pwHashed,
      timestampUpdated: timestampUpdated ?? this.timestampUpdated,
      timestampCreated: timestampCreated ?? this.timestampCreated,
    );
  }
}

// Department Model
class Department {
  final int? id;
  final int uuid;
  final String name;
  final DateTime timestampUpdated;
  final DateTime timestampCreated;

  Department({
    this.id,
    required this.uuid,
    required this.name,
    required this.timestampUpdated,
    required this.timestampCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'timestamp_updated': timestampUpdated.millisecondsSinceEpoch,
      'timestamp_created': timestampCreated.millisecondsSinceEpoch,
    };
  }

  factory Department.fromMap(Map<String, dynamic> map) {
    return Department(
      id: map['id'],
      uuid: map['uuid'],
      name: map['name'],
      timestampUpdated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_updated']),
      timestampCreated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_created']),
    );
  }

  Department copyWith({
    int? id,
    int? uuid,
    String? name,
    DateTime? timestampUpdated,
    DateTime? timestampCreated,
  }) {
    return Department(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      timestampUpdated: timestampUpdated ?? this.timestampUpdated,
      timestampCreated: timestampCreated ?? this.timestampCreated,
    );
  }
}

// Department Personnel Model
class DepartmentPersonnel {
  final int? id;
  final int personId;
  final int departmentId;
  final int role;
  final bool isActive;
  final DateTime timestampUpdated;

  DepartmentPersonnel({
    this.id,
    required this.personId,
    required this.departmentId,
    required this.role,
    required this.isActive,
    required this.timestampUpdated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'person_id': personId,
      'department_id': departmentId,
      'role': role,
      'isactive': isActive ? 1 : 0,
      'timestamp_updated': timestampUpdated.millisecondsSinceEpoch,
    };
  }

  factory DepartmentPersonnel.fromMap(Map<String, dynamic> map) {
    return DepartmentPersonnel(
      id: map['id'],
      personId: map['person_id'],
      departmentId: map['department_id'],
      role: map['role'],
      isActive: map['isactive'] == 1,
      timestampUpdated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_updated']),
    );
  }

  DepartmentPersonnel copyWith({
    int? id,
    int? personId,
    int? departmentId,
    int? role,
    bool? isActive,
    DateTime? timestampUpdated,
  }) {
    return DepartmentPersonnel(
      id: id ?? this.id,
      personId: personId ?? this.personId,
      departmentId: departmentId ?? this.departmentId,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      timestampUpdated: timestampUpdated ?? this.timestampUpdated,
    );
  }
}

// Message Diary Model
class MessageDiary {
  final int? id;
  final int uuid;
  final String? remark;
  final DateTime timestampUpdated;
  final DateTime timestampCreated;

  MessageDiary({
    this.id,
    required this.uuid,
    this.remark,
    required this.timestampUpdated,
    required this.timestampCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'remark': remark,
      'timestamp_updated': timestampUpdated.millisecondsSinceEpoch,
      'timestamp_created': timestampCreated.millisecondsSinceEpoch,
    };
  }

  factory MessageDiary.fromMap(Map<String, dynamic> map) {
    return MessageDiary(
      id: map['id'],
      uuid: map['uuid'],
      remark: map['remark'],
      timestampUpdated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_updated']),
      timestampCreated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_created']),
    );
  }

  MessageDiary copyWith({
    int? id,
    int? uuid,
    String? remark,
    DateTime? timestampUpdated,
    DateTime? timestampCreated,
  }) {
    return MessageDiary(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      remark: remark ?? this.remark,
      timestampUpdated: timestampUpdated ?? this.timestampUpdated,
      timestampCreated: timestampCreated ?? this.timestampCreated,
    );
  }
}

// Message Entries Model
class MessageEntry {
  final int? id;
  final int diaryId;
  final int type;
  final String? sender;
  final String? receiver;
  final String message;
  final DateTime timestampCreated;

  MessageEntry({
    this.id,
    required this.diaryId,
    required this.type,
    this.sender,
    this.receiver,
    required this.message,
    required this.timestampCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'diary_id': diaryId,
      'type': type,
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'timestamp_created': timestampCreated.millisecondsSinceEpoch,
    };
  }

  factory MessageEntry.fromMap(Map<String, dynamic> map) {
    return MessageEntry(
      id: map['id'],
      diaryId: map['diary_id'],
      type: map['type'],
      sender: map['sender'],
      receiver: map['receiver'],
      message: map['message'],
      timestampCreated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_created']),
    );
  }

  MessageEntry copyWith({
    int? id,
    int? diaryId,
    int? type,
    String? sender,
    String? receiver,
    String? message,
    DateTime? timestampCreated,
  }) {
    return MessageEntry(
      id: id ?? this.id,
      diaryId: diaryId ?? this.diaryId,
      type: type ?? this.type,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      message: message ?? this.message,
      timestampCreated: timestampCreated ?? this.timestampCreated,
    );
  }
}

// ATS Team Model
class AtsTeam {
  final int? id;
  final int wtfId; // Wehrführer/Team Leader
  final int atfId; // Atemschutztruppführer
  final int atmId; // Atemschutztruppmann
  final int surveillancerId; // Überwachungsmann
  final DateTime timestampUpdated;
  final DateTime timestampCreated;

  AtsTeam({
    this.id,
    required this.wtfId,
    required this.atfId,
    required this.atmId,
    required this.surveillancerId,
    required this.timestampUpdated,
    required this.timestampCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wtf_id': wtfId,
      'atf_id': atfId,
      'atm_id': atmId,
      'surveillancer_id': surveillancerId,
      'timestamp_updated': timestampUpdated.millisecondsSinceEpoch,
      'timestamp_created': timestampCreated.millisecondsSinceEpoch,
    };
  }

  factory AtsTeam.fromMap(Map<String, dynamic> map) {
    return AtsTeam(
      id: map['id'],
      wtfId: map['wtf_id'],
      atfId: map['atf_id'],
      atmId: map['atm_id'],
      surveillancerId: map['surveillancer_id'],
      timestampUpdated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_updated']),
      timestampCreated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_created']),
    );
  }

  AtsTeam copyWith({
    int? id,
    int? wtfId,
    int? atfId,
    int? atmId,
    int? surveillancerId,
    DateTime? timestampUpdated,
    DateTime? timestampCreated,
  }) {
    return AtsTeam(
      id: id ?? this.id,
      wtfId: wtfId ?? this.wtfId,
      atfId: atfId ?? this.atfId,
      atmId: atmId ?? this.atmId,
      surveillancerId: surveillancerId ?? this.surveillancerId,
      timestampUpdated: timestampUpdated ?? this.timestampUpdated,
      timestampCreated: timestampCreated ?? this.timestampCreated,
    );
  }
}

// Emergency ATS Model
class EmergencyAts {
  final int? id;
  final int uuid;
  final String remark;
  final int diaryId;
  final int wtfId;
  final int atfId;
  final int atmId;
  final int surveillancerId;
  final int emStatus;
  final int emType;
  final int emSeconds;
  final DateTime dtimeBegin;
  final DateTime dtimeEnd;
  final DateTime timestampCreated;

  EmergencyAts({
    this.id,
    required this.uuid,
    required this.remark,
    required this.diaryId,
    required this.wtfId,
    required this.atfId,
    required this.atmId,
    required this.surveillancerId,
    required this.emStatus,
    required this.emType,
    required this.emSeconds,
    required this.dtimeBegin,
    required this.dtimeEnd,
    required this.timestampCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'remark': remark,
      'diary_id': diaryId,
      'wtf_id': wtfId,
      'atf_id': atfId,
      'atm_id': atmId,
      'surveillancer_id': surveillancerId,
      'em_status': emStatus,
      'em_type': emType,
      'em_seconds': emSeconds,
      'dtime_begin': dtimeBegin.millisecondsSinceEpoch,
      'dtime_end': dtimeEnd.millisecondsSinceEpoch,
      'timestamp_created': timestampCreated.millisecondsSinceEpoch,
    };
  }

  factory EmergencyAts.fromMap(Map<String, dynamic> map) {
    return EmergencyAts(
      id: map['id'],
      uuid: map['uuid'],
      remark: map['remark'],
      diaryId: map['diary_id'],
      wtfId: map['wtf_id'],
      atfId: map['atf_id'],
      atmId: map['atm_id'],
      surveillancerId: map['surveillancer_id'],
      emStatus: map['em_status'],
      emType: map['em_type'],
      emSeconds: map['em_seconds'],
      dtimeBegin: DateTime.fromMillisecondsSinceEpoch(map['dtime_begin']),
      dtimeEnd: DateTime.fromMillisecondsSinceEpoch(map['dtime_end']),
      timestampCreated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_created']),
    );
  }

  EmergencyAts copyWith({
    int? id,
    int? uuid,
    String? remark,
    int? diaryId,
    int? wtfId,
    int? atfId,
    int? atmId,
    int? surveillancerId,
    int? emStatus,
    int? emType,
    int? emSeconds,
    DateTime? dtimeBegin,
    DateTime? dtimeEnd,
    DateTime? timestampCreated,
  }) {
    return EmergencyAts(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      remark: remark ?? this.remark,
      diaryId: diaryId ?? this.diaryId,
      wtfId: wtfId ?? this.wtfId,
      atfId: atfId ?? this.atfId,
      atmId: atmId ?? this.atmId,
      surveillancerId: surveillancerId ?? this.surveillancerId,
      emStatus: emStatus ?? this.emStatus,
      emType: emType ?? this.emType,
      emSeconds: emSeconds ?? this.emSeconds,
      dtimeBegin: dtimeBegin ?? this.dtimeBegin,
      dtimeEnd: dtimeEnd ?? this.dtimeEnd,
      timestampCreated: timestampCreated ?? this.timestampCreated,
    );
  }
}

// Pressure Bottle Model
class PressureBottle {
  final int? id;
  final int emergencyAtsId;
  final int personId;
  final int pressureStart;
  final int pressure10min;
  final int pressure20min;
  final int pressureEnd;
  final DateTime timestampCreated;
  final DateTime timestampUpdated;

  PressureBottle({
    this.id,
    required this.emergencyAtsId,
    required this.personId,
    required this.pressureStart,
    required this.pressure10min,
    required this.pressure20min,
    required this.pressureEnd,
    required this.timestampCreated,
    required this.timestampUpdated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emergency_ats_id': emergencyAtsId,
      'person_id': personId,
      'pressure_start': pressureStart,
      'pressure_10min': pressure10min,
      'pressure_20min': pressure20min,
      'pressure_end': pressureEnd,
      'timestamp_created': timestampCreated.millisecondsSinceEpoch,
      'timestamp_updated': timestampUpdated.millisecondsSinceEpoch,
    };
  }

  factory PressureBottle.fromMap(Map<String, dynamic> map) {
    return PressureBottle(
      id: map['id'],
      emergencyAtsId: map['emergency_ats_id'],
      personId: map['person_id'],
      pressureStart: map['pressure_start'],
      pressure10min: map['pressure_10min'],
      pressure20min: map['pressure_20min'],
      pressureEnd: map['pressure_end'],
      timestampCreated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_created']),
      timestampUpdated: DateTime.fromMillisecondsSinceEpoch(map['timestamp_updated']),
    );
  }

  PressureBottle copyWith({
    int? id,
    int? emergencyAtsId,
    int? personId,
    int? pressureStart,
    int? pressure10min,
    int? pressure20min,
    int? pressureEnd,
    DateTime? timestampCreated,
    DateTime? timestampUpdated,
  }) {
    return PressureBottle(
      id: id ?? this.id,
      emergencyAtsId: emergencyAtsId ?? this.emergencyAtsId,
      personId: personId ?? this.personId,
      pressureStart: pressureStart ?? this.pressureStart,
      pressure10min: pressure10min ?? this.pressure10min,
      pressure20min: pressure20min ?? this.pressure20min,
      pressureEnd: pressureEnd ?? this.pressureEnd,
      timestampCreated: timestampCreated ?? this.timestampCreated,
      timestampUpdated: timestampUpdated ?? this.timestampUpdated,
    );
  }
}





// Base Controller Class
abstract class BaseController<T> {
  final Database database;
  final String tableName;

  BaseController(this.database, this.tableName);

  Future<int> insert(T item);
  Future<List<T>> getAll();
  Future<T?> getById(int id);
  Future<int> update(T item);
  Future<int> delete(int id);
  T fromMap(Map<String, dynamic> map);
}



// User Controller
class UserController extends BaseController<User> {
  UserController(Database database) : super(database, 'user');

  @override
  Future<int> insert(User user) async {
    return await database.insert(tableName, user.toMap());
  }

  @override
  Future<List<User>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  @override
  Future<User?> getById(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<int> update(User user) async {
    return await database.update(
      tableName,
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  User fromMap(Map<String, dynamic> map) => User.fromMap(map);

  // Additional methods specific to User
  Future<User?> getByUsername(String username) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'username = ?',
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> getByEmail(String email) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'email = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<User?> authenticateUser(String username, String hashedPassword) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'username = ? AND pw_hashed = ?',
      whereArgs: [username, hashedPassword],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }
}

// Department Controller
class DepartmentController extends BaseController<Department> {
  DepartmentController(Database database) : super(database, 'department');

  @override
  Future<int> insert(Department department) async {
    return await database.insert(tableName, department.toMap());
  }

  @override
  Future<List<Department>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) => Department.fromMap(maps[i]));
  }

  @override
  Future<Department?> getById(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Department.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<int> update(Department department) async {
    return await database.update(
      tableName,
      department.toMap(),
      where: 'id = ?',
      whereArgs: [department.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Department fromMap(Map<String, dynamic> map) => Department.fromMap(map);

  // Additional methods specific to Department
  Future<Department?> getByName(String name) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'name = ?',
      whereArgs: [name],
    );
    if (maps.isNotEmpty) {
      return Department.fromMap(maps.first);
    }
    return null;
  }
}

// Department Personnel Controller
class DepartmentPersonnelController extends BaseController<DepartmentPersonnel> {
  DepartmentPersonnelController(Database database) : super(database, 'department_personell');

  @override
  Future<int> insert(DepartmentPersonnel personnel) async {
    return await database.insert(tableName, personnel.toMap());
  }

  @override
  Future<List<DepartmentPersonnel>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) => DepartmentPersonnel.fromMap(maps[i]));
  }

  @override
  Future<DepartmentPersonnel?> getById(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return DepartmentPersonnel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<int> update(DepartmentPersonnel personnel) async {
    return await database.update(
      tableName,
      personnel.toMap(),
      where: 'id = ?',
      whereArgs: [personnel.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  DepartmentPersonnel fromMap(Map<String, dynamic> map) => DepartmentPersonnel.fromMap(map);

  // Additional methods specific to Department Personnel
  Future<List<DepartmentPersonnel>> getByDepartmentId(int departmentId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'department_id = ?',
      whereArgs: [departmentId],
    );
    return List.generate(maps.length, (i) => DepartmentPersonnel.fromMap(maps[i]));
  }

  Future<List<DepartmentPersonnel>> getByPersonId(int personId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'person_id = ?',
      whereArgs: [personId],
    );
    return List.generate(maps.length, (i) => DepartmentPersonnel.fromMap(maps[i]));
  }

  Future<List<DepartmentPersonnel>> getActivePersonnelByDepartment(int departmentId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'department_id = ? AND isactive = ?',
      whereArgs: [departmentId, 1],
    );
    return List.generate(maps.length, (i) => DepartmentPersonnel.fromMap(maps[i]));
  }
}

// Message Diary Controller
class MessageDiaryController extends BaseController<MessageDiary> {
  MessageDiaryController(Database database) : super(database, 'message_diary');

  @override
  Future<int> insert(MessageDiary diary) async {
    return await database.insert(tableName, diary.toMap());
  }

  @override
  Future<List<MessageDiary>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) => MessageDiary.fromMap(maps[i]));
  }

  @override
  Future<MessageDiary?> getById(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return MessageDiary.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<int> update(MessageDiary diary) async {
    return await database.update(
      tableName,
      diary.toMap(),
      where: 'id = ?',
      whereArgs: [diary.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  MessageDiary fromMap(Map<String, dynamic> map) => MessageDiary.fromMap(map);

  // Additional methods specific to Message Diary
  Future<MessageDiary?> getByUuid(int uuid) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
    if (maps.isNotEmpty) {
      return MessageDiary.fromMap(maps.first);
    }
    return null;
  }

  Future<List<MessageDiary>> getDiariesByDateRange(DateTime start, DateTime end) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'timestamp_created >= ? AND timestamp_created <= ?',
      whereArgs: [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
      orderBy: 'timestamp_created DESC',
    );
    return List.generate(maps.length, (i) => MessageDiary.fromMap(maps[i]));
  }
}

// Message Entry Controller
class MessageEntryController extends BaseController<MessageEntry> {
  MessageEntryController(Database database) : super(database, 'message_entries');

  @override
  Future<int> insert(MessageEntry entry) async {
    return await database.insert(tableName, entry.toMap());
  }

  @override
  Future<List<MessageEntry>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) => MessageEntry.fromMap(maps[i]));
  }

  @override
  Future<MessageEntry?> getById(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return MessageEntry.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<int> update(MessageEntry entry) async {
    return await database.update(
      tableName,
      entry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  MessageEntry fromMap(Map<String, dynamic> map) => MessageEntry.fromMap(map);

  // Additional methods specific to Message Entry
  Future<List<MessageEntry>> getByDiaryId(int diaryId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'diary_id = ?',
      whereArgs: [diaryId],
      orderBy: 'timestamp_created ASC',
    );
    return List.generate(maps.length, (i) => MessageEntry.fromMap(maps[i]));
  }

  Future<List<MessageEntry>> getByType(int type) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'type = ?',
      whereArgs: [type],
      orderBy: 'timestamp_created DESC',
    );
    return List.generate(maps.length, (i) => MessageEntry.fromMap(maps[i]));
  }

  Future<List<MessageEntry>> getBySender(String sender) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'sender = ?',
      whereArgs: [sender],
      orderBy: 'timestamp_created DESC',
    );
    return List.generate(maps.length, (i) => MessageEntry.fromMap(maps[i]));
  }
}

// ATS Team Controller
class AtsTeamController extends BaseController<AtsTeam> {
  AtsTeamController(Database database) : super(database, 'ats_team');

  @override
  Future<int> insert(AtsTeam team) async {
    return await database.insert(tableName, team.toMap());
  }

  @override
  Future<List<AtsTeam>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) => AtsTeam.fromMap(maps[i]));
  }

  @override
  Future<AtsTeam?> getById(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return AtsTeam.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<int> update(AtsTeam team) async {
    return await database.update(
      tableName,
      team.toMap(),
      where: 'id = ?',
      whereArgs: [team.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  AtsTeam fromMap(Map<String, dynamic> map) => AtsTeam.fromMap(map);

  // Additional methods specific to ATS Team
  Future<List<AtsTeam>> getTeamsByLeader(int wtfId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'wtf_id = ?',
      whereArgs: [wtfId],
    );
    return List.generate(maps.length, (i) => AtsTeam.fromMap(maps[i]));
  }

  Future<List<AtsTeam>> getTeamsByMember(int personId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'wtf_id = ? OR atf_id = ? OR atm_id = ? OR surveillancer_id = ?',
      whereArgs: [personId, personId, personId, personId],
    );
    return List.generate(maps.length, (i) => AtsTeam.fromMap(maps[i]));
  }
}

// Emergency ATS Controller
class EmergencyAtsController extends BaseController<EmergencyAts> {
  EmergencyAtsController(Database database) : super(database, 'emergency_ats');

  @override
  Future<int> insert(EmergencyAts emergency) async {
    return await database.insert(tableName, emergency.toMap());
  }

  @override
  Future<List<EmergencyAts>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) => EmergencyAts.fromMap(maps[i]));
  }

  @override
  Future<EmergencyAts?> getById(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return EmergencyAts.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<int> update(EmergencyAts emergency) async {
    return await database.update(
      tableName,
      emergency.toMap(),
      where: 'id = ?',
      whereArgs: [emergency.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  EmergencyAts fromMap(Map<String, dynamic> map) => EmergencyAts.fromMap(map);

  // Additional methods specific to Emergency ATS
  Future<List<EmergencyAts>> getActiveEmergencies() async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'em_status = ?', // Assuming 1 = active
      whereArgs: [1],
      orderBy: 'dtime_begin DESC',
    );
    return List.generate(maps.length, (i) => EmergencyAts.fromMap(maps[i]));
  }

  Future<List<EmergencyAts>> getByStatus(int status) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'em_status = ?',
      whereArgs: [status],
      orderBy: 'dtime_begin DESC',
    );
    return List.generate(maps.length, (i) => EmergencyAts.fromMap(maps[i]));
  }

  Future<List<EmergencyAts>> getByType(int type) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'em_type = ?',
      whereArgs: [type],
      orderBy: 'dtime_begin DESC',
    );
    return List.generate(maps.length, (i) => EmergencyAts.fromMap(maps[i]));
  }

  Future<List<EmergencyAts>> getByDateRange(DateTime start, DateTime end) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'dtime_begin >= ? AND dtime_begin <= ?',
      whereArgs: [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
      orderBy: 'dtime_begin DESC',
    );
    return List.generate(maps.length, (i) => EmergencyAts.fromMap(maps[i]));
  }

  Future<EmergencyAts?> getByUuid(int uuid) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'uuid = ?',
      whereArgs: [uuid],
    );
    if (maps.isNotEmpty) {
      return EmergencyAts.fromMap(maps.first);
    }
    return null;
  }
}

// Pressure Bottle Controller
class PressureBottleController extends BaseController<PressureBottle> {
  PressureBottleController(Database database) : super(database, 'pressure_bottle');

  @override
  Future<int> insert(PressureBottle bottle) async {
    return await database.insert(tableName, bottle.toMap());
  }

  @override
  Future<List<PressureBottle>> getAll() async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return List.generate(maps.length, (i) => PressureBottle.fromMap(maps[i]));
  }

  @override
  Future<PressureBottle?> getById(int id) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return PressureBottle.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<int> update(PressureBottle bottle) async {
    return await database.update(
      tableName,
      bottle.toMap(),
      where: 'id = ?',
      whereArgs: [bottle.id],
    );
  }

  @override
  Future<int> delete(int id) async {
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  PressureBottle fromMap(Map<String, dynamic> map) => PressureBottle.fromMap(map);

  // Additional methods specific to Pressure Bottle
  Future<List<PressureBottle>> getByEmergencyId(int emergencyAtsId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'emergency_ats_id = ?',
      whereArgs: [emergencyAtsId],
      orderBy: 'timestamp_created ASC',
    );
    return List.generate(maps.length, (i) => PressureBottle.fromMap(maps[i]));
  }

  Future<List<PressureBottle>> getByPersonId(int personId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'person_id = ?',
      whereArgs: [personId],
      orderBy: 'timestamp_created DESC',
    );
    return List.generate(maps.length, (i) => PressureBottle.fromMap(maps[i]));
  }

  Future<PressureBottle?> getLatestByPersonAndEmergency(int personId, int emergencyAtsId) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'person_id = ? AND emergency_ats_id = ?',
      whereArgs: [personId, emergencyAtsId],
      orderBy: 'timestamp_created DESC',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return PressureBottle.fromMap(maps.first);
    }
    return null;
  }

  // Method to get bottles with critical pressure levels
  Future<List<PressureBottle>> getCriticalPressureBottles(int threshold) async {
    final List<Map<String, dynamic>> maps = await database.query(
      tableName,
      where: 'pressure_end < ? OR pressure_20min < ?',
      whereArgs: [threshold, threshold],
      orderBy: 'timestamp_created DESC',
    );
    return List.generate(maps.length, (i) => PressureBottle.fromMap(maps[i]));
  }
}


/*
// Beispiel-Verwendung:
final database = await openDatabase('firecage.db');
final personController = PersonController(database);

// Person hinzufügen
final newPerson = Person(/* ... */);
int id = await personController.insert(newPerson);

// Alle aktiven Personen abrufen
List<Person> activePersons = await personController.getActivePersons();


 */