import 'package:jet_app/modules/posts/auth/login/data/models/post.dart';
import 'package:jet_framework/jet_framework.dart';
import 'package:retrofit/retrofit.dart';

part 'post_service.g.dart';

@RestApi()
abstract class PostsService {
  factory PostsService(Dio dio) = _PostsService;

  @GET('/postss')
  Future<List<Post>?> posts();
}
