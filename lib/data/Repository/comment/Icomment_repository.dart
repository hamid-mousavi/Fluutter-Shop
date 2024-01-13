import 'package:nike/data/Model/Entity/comment.dart';
import 'package:nike/data/Source/comment_datasource/comment_datasource.dart';
import 'package:nike/data/common/http_client.dart';

import 'comment_list_repository.dart';

final CommentListRepository commentListRepository =
    CommentListRepository(CommentRemoteDataSource(httpClient));

abstract class ICommentListRepository {
  Future<List<CommentEntity>> getAll(int productId);
}
