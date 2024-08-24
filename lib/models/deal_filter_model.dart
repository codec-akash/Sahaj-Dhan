class SymbolFilter {
  final String key;
  final List<ValueItem> values;

  SymbolFilter({
    required this.key,
    required this.values,
  });

  factory SymbolFilter.fromJson(Map<String, dynamic> json) {
    return SymbolFilter(
      key: json['key'],
      values: (json['values'] as List<dynamic>).map((item) {
        return ValueItem.fromJson(item);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'values': values.map((item) {
        return item.toJson();
      }).toList(),
    };
  }
}

class ValueItem {
  final String value;
  final String name;

  ValueItem({
    required this.value,
    required this.name,
  });

  factory ValueItem.fromJson(Map<String, dynamic> json) {
    return ValueItem(
      value: json['value'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'name': name,
    };
  }
}
