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

class ClientNames {
  late final String key;
  late final List<String> values;

  ClientNames({required this.key, required this.values});

  ClientNames.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    values = json['values'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['values'] = values;
    return data;
  }
}

class Filters {
  SymbolFilter symbolFilter;
  ClientNames clientNames;

  Filters({
    required this.symbolFilter,
    required this.clientNames,
  });

  factory Filters.fromJson(Map<String, dynamic> json) {
    return Filters(
      symbolFilter: SymbolFilter.fromJson(json['result'][0]),
      clientNames: ClientNames.fromJson(json['result'][2]),
    );
  }
}
