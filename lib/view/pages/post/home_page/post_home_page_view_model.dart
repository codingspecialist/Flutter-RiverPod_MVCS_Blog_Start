
// 창고 관리자
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_blog_start/dto/response_dto.dart';
import 'package:flutter_riverpod_blog_start/model/post/post.dart';
import 'package:flutter_riverpod_blog_start/model/post/post_repository.dart';
import 'package:flutter_riverpod_blog_start/provider/session_provider.dart';
import 'package:logger/logger.dart';


final postHomePageProvider = StateNotifierProvider.autoDispose<PostHomePageViewModel, PostHomePageModel?>((ref) {
  Logger().d("postHomePageProvider");
  SessionUser sessionUser = ref.read(sessionProvider);
  return PostHomePageViewModel(null)..notifyInit(sessionUser.jwt!);
});

// 창고 데이터
class PostHomePageModel{
  List<Post> posts;
  PostHomePageModel({required this.posts});
}

// 창고
class PostHomePageViewModel extends StateNotifier<PostHomePageModel?>{
  PostHomePageViewModel(super.state);

  void notifyInit(String jwt) async{
    Logger().d("notifyInit");
    ResponseDTO responseDTO = await PostRepository().fetchPostList(jwt);
    state = PostHomePageModel(posts: responseDTO.data);
  }

  void notifyAdd(Post post){
    List<Post> posts = state!.posts;
    List<Post> newPosts = [...posts, post];
    state = PostHomePageModel(posts: newPosts);
  }

  void notifyRemove(int id){
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.where((e) => e.id != id).toList();
    state = PostHomePageModel(posts: newPosts);
  }

  void notifyUpdate(Post post){
    List<Post> posts = state!.posts;
    List<Post> newPosts = posts.map((e) => e.id == post.id ? post : e).toList();
    state = PostHomePageModel(posts: newPosts);
  }
}