import 'package:dio/dio.dart';
import 'package:nike/data/Model/Entity/comment.dart';
import 'package:nike/data/common/validator_response.dart';

abstract class ICommentDataSaourc {
  Future<List<CommentEntity>> getAll(int productId);
}

class CommentRemoteDataSource
    with ValditorResponse
    implements ICommentDataSaourc {
  final Dio httpClient;
  CommentRemoteDataSource(this.httpClient);
  @override
  Future<List<CommentEntity>> getAll(int productId) async {
    final response = await httpClient.get('comment/list?product_id=$productId');
    validateResponse(response);
    final List<CommentEntity> comments = [];
    (response.data as List).forEach((element) {
      comments.add(CommentEntity.fromJson(element));
    });
    return comments;
  }
}
