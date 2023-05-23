part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class FetchComments extends CommentEvent {
	final int postId;

	const FetchComments(this.postId);

	@override
  List<Object> get props => [postId];

}