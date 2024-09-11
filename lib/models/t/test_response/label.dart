class Label {
  int? id;
  String? nodeId;
  String? url;
  String? name;
  String? color;
  bool? labelDefault;
  String? description;

  Label({
    this.id,
    this.nodeId,
    this.url,
    this.name,
    this.color,
    this.labelDefault,
    this.description,
  });

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        id: json['id'] as int?,
        nodeId: json['node_id'] as String?,
        url: json['url'] as String?,
        name: json['name'] as String?,
        color: json['color'] as String?,
        labelDefault: json['default'] as bool?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'node_id': nodeId,
        'url': url,
        'name': name,
        'color': color,
        'default': labelDefault,
        'description': description,
      };
}
