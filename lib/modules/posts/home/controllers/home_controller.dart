import 'package:jet_app/modules/posts/auth/login/data/models/post.dart';
import 'package:jet_framework/controllers/jet_async_controller.dart';

class HomeController extends JetFutureController {
  @override
  Future init() => service.get<List<Post>>(
        '/posts',
      );
}
