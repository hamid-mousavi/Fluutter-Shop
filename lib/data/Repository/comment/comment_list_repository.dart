import 'package:nike/data/Model/Entity/comment.dart';
import 'package:nike/data/Repository/comment/Icomment_repository.dart';
import 'package:nike/data/Source/comment_datasource/comment_datasource.dart';
import 'package:nike/data/common/http_client.dart';

final CommentListRepository commentListRepository =
    CommentListRepository(CommentRemoteDataSource(httpClient));

class CommentListRepository implements ICommentListRepository {
  final ICommentDataSaourc dataSource;

  CommentListRepository(this.dataSource);

  @override
  Future<List<CommentEntity>> getAll(int productId) {
    return dataSource.getAll(productId);
  }
}
