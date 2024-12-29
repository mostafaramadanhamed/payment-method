class Link {
  final dynamic persistentToken;

  const Link({this.persistentToken});

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        persistentToken: json['persistent_token'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'persistent_token': persistentToken,
      };
}
