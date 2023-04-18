

import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/dto/user_request.dart';
import 'package:flutter_riverpod_blog_start/model/user/user_repository.dart';

void main() async {
  //await fetchJoin_test();
  await fetchLogin_test();
}

Future<void> fetchJoin_test() async{
  JoinReqDTO joinReqDTO = JoinReqDTO(username: "meta2", password: "1234", email: "meta@nate.com");
  ResponseDTO responseDTO = await UserRepository().fetchJoin(joinReqDTO);
  print(responseDTO.code);
  print(responseDTO.msg);
}

Future<void> fetchLogin_test() async{
  LoginReqDTO loginReqDTO = LoginReqDTO(username: "meta2", password: "1234");
  ResponseDTO responseDTO = await UserRepository().fetchLogin(loginReqDTO);
  print(responseDTO.code);
  print(responseDTO.msg);
  print(responseDTO.token);
}