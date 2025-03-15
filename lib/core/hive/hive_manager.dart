import 'package:hive/hive.dart';

abstract class HiveManager {
  Future<void> putData();

  Type getData(String key);
}

class HiveManagerImpl extends HiveManager {
  final Box _box;

  HiveManagerImpl(this._box);

  @override
  Type getData(String key) {
    return _box.get(key);
  }

  @override
  Future<void> putData() async {
    return await _box.put("key", "value");
  }
}
