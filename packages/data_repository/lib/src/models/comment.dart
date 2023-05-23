import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class Comment extends Equatable {
	int id;
	int postId;
	String name;
	String email;
	String body;

	Comment({
		required this.id,
		required this.postId,
		required this.name,
		required this.email,
		required this.body,
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = Comment(
		id: 0, 
		postId: 0, 
		name: '',
		email: '',
		body: '',
	);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == Comment.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != Comment.empty;

	CommentEntity toEntity() {
    return CommentEntity(
			id: id,
			postId: postId, 
			name: name,
			email: email,
			body: body,
    );
  }

  static Comment fromEntity(CommentEntity entity) {
    return Comment(
			id: entity.id,
			postId: entity.postId, 
			name: entity.name,
			email: entity.email,
			body: entity.body,
    );
  }
	
	@override
	List<Object?> get props => [id, postId, name, email, body];
	
}