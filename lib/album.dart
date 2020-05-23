class Album {
  final int code;
  final String msg;

  Album({this.code, this.msg});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(code: json['code'], msg: json['msg']);
  }
}
