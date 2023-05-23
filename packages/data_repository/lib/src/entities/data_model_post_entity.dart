import 'package:equatable/equatable.dart';
import '../models/models.dart';
import 'entities.dart';

class DataModelPostEntity extends Equatable {
	final int id;
	final String title;
	final String body;
	final int userId;
	final MyUser? myUser;
	final List<Comment>? comments;

	const DataModelPostEntity({
		required this.id,
		required this.title,
		required this.body,
		required this.userId,
		this.myUser,
		this.comments
	});

	Map<String, Object?> toDocument() {
    return {
      'id': id,
			'title': title,
			'body': body,
			'userId': userId,
    };
  }

	static DataModelPostEntity fromDocument(Map<String, dynamic> doc) {
    return DataModelPostEntity(
      id: doc['id'] as int,
			title: doc['title'] as String,
			body: doc['body'] as String,
			userId: doc['userId'] as int,
    );
  }

	@override
  List<Object?> get props => [id, title, body, userId, myUser, comments];

	@override
  String toString() {
    return '''DataModelPostEntity: {
			id: $id\n
			title: $title\n
			body: $body\n
			userId: $userId\n
			myUser: $myUser\n
			comments: $comments\n
		}''';
  }
}