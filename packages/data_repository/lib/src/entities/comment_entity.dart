import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
	final int id;
	final int postId;
	final String name;
	final String email;
	final String body;

	const CommentEntity({
		required this.id,
		required this.postId,
		required this.name,
		required this.email,
		required this.body,
	});

	Map<String, Object?> toDocument() {
    return {
     	'id': id, 
			'postId': postId, 
			'name': name,
			'email': email,
			'body': body,
    };
  }

	static CommentEntity fromDocument(Map<String, dynamic> doc) {
    return CommentEntity(
      id: doc['id'] as int,
			postId: doc['postId'] as int,
			name: doc['name'] as String,
			email: doc['email'] as String,
			body: doc['body'] as String,
    );
  }

	@override
  List<Object?> get props => [id, postId, name, email, body];

	@override
  String toString() {
    return '''CommentEntity: {
			id: $id\n
			postId: $postId\n
			name: $name\n
			email: $email\n
			body: $body\n
		}''';
  }
}