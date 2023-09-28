import 'dart:convert';

class Model {
  final String id;
  final int created;
  final String root;
  Model({
    required this.id,
    required this.created,
    required this.root,
  });

  Model copyWith({
    String? id,
    int? created,
    String? root,
  }) {
    return Model(
      id: id ?? this.id,
      created: created ?? this.created,
      root: root ?? this.root,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'created': created});
    result.addAll({'root': root});

    return result;
  }

  factory Model.fromMap(Map<String, dynamic> map) {
    return Model(
      id: map['id'] ?? '',
      created: map['created']?.toInt() ?? 0,
      root: map['root'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Model.fromJson(Map<String, dynamic> json) =>
      Model(id: json['id'], created: json['created'], root: json['root']);

  static List<Model> modelSnapshot(List modelList) {
    return modelList.map((data) {
      return Model.fromJson(data);
    }).toList();
  }

  @override
  String toString() => 'Model(id: $id, created: $created, root: $root)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Model &&
        other.id == id &&
        other.created == created &&
        other.root == root;
  }

  @override
  int get hashCode => id.hashCode ^ created.hashCode ^ root.hashCode;
}
