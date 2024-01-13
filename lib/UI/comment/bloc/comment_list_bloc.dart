import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike/data/Model/Entity/comment.dart';
import 'package:nike/data/Repository/comment/Icomment_repository.dart';

part 'comment_list_event.dart';
part 'comment_list_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final ICommentListRepository repository;
  final int productId;
  CommentListBloc(this.repository, this.productId)
      : super(CommentListInitial()) {
    on<CommentListEvent>((event, emit) async {
      if (event is CommentListStarted) {
        emit(CommentListLoading());
        try {
          final comments = await repository.getAll(productId);
          emit(CommentListSuccess(comments: comments));
        } catch (e) {
          emit(CommentListErr(error: e.toString()));
        }
      }
    });
  }
}
