
// 창고 관리자
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';
import 'package:flutter_riverpod_blog_start/view/pages/post/home_page/post_home_page_view_model.dart';
import 'package:logger/logger.dart';


final postDetailPageProvider = StateNotifierProvider.family.autoDispose<PostDetailPageViewModel, PostDetailPageModel?, int>((ref, postId) {
  Logger().d("postDetailPageProvider");
  SessionUser sessionUser = ref.read(sessionProvider);
  return PostDetailPageViewModel(null, ref)..notifyInit(postId, sessionUser.jwt!);
});

// 창고 데이터
class PostDetailPageModel{
  Post post;
  PostDetailPageModel({required this.post});
}

// 창고
class PostDetailPageViewModel extends StateNotifier<PostDetailPageModel?>{
  Ref ref;
  PostDetailPageViewModel(super.state, this.ref);

  void notifyInit(int id, String jwt) async{
    Logger().d("notifyInit");
    ResponseDTO responseDTO = await PostRepository().fetchPost(id, jwt);
    state = PostDetailPageModel(post: responseDTO.data);
  }

  void notifyRemove(int id){
    Post post = state!.post;
    if(post.id == id){
      state = null;
    }
  }

  // api 수정 요청 -> 수정된 Post를 돌려받음.
  void notifyUpdate(Post updatePost){
    state = PostDetailPageModel(post: updatePost);
  }
}