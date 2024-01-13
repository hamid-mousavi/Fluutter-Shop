part of 'comment_list_bloc.dart';

sealed class CommentListState extends Equatable {
  const CommentListState();

  @override
  List<Object> get props => [];
}

final class CommentListInitial extends CommentListState {}

final class CommentListSuccess extends CommentListState {
  final List<CommentEntity> comments;

  const CommentListSuccess({required this.comments});
}

final class CommentListErr extends CommentListState {
  final String error;

  const CommentListErr({required this.error});
}

final class CommentListLoading extends CommentListState {}
