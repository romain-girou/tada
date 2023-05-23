part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
  
  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class FetchCommentsFailure extends CommentState {}
class FetchCommentsLoading extends CommentState {}
class FetchCommentsSuccess extends CommentState {
	final List<Comment> comments;

	const FetchCommentsSuccess(this.comments);

	@override
  List<Object> get props => [comments];
}
