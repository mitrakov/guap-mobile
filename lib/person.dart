class PersonResponse {
  final int code;
  final List<String> persons;

  PersonResponse(this.code, this.persons);

  factory PersonResponse.fromJson(Map<String, dynamic> json) {
    return PersonResponse(json['code'], (json['msg'] as List).map((i) => i as String).toList());
  }
}
