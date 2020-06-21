import 'package:json_annotation/json_annotation.dart';
part 'common.g.dart';

@JsonSerializable()
class CommonResponse {
  final int code;
  final String msg;

  CommonResponse(this.code, this.msg);

  factory CommonResponse.fromJson(Map<String, dynamic> json) => _$CommonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CommonResponseToJson(this);
}
