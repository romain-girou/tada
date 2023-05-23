import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';
import '../entities/entities.dart';

class DataModelPost extends Equatable {
	int id;
	String title;
	String body;
	int userId;
	MyUser? myUser;
	List<Comment>? comments;

	DataModelPost({
		required this.id,
		required this.title,
		required this.body,
		required this.userId,
		this.myUser,
		this.comments,
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = DataModelPost(
		id: 0, 
		title: '', 
		body: '',
		userId: 0,
		myUser: MyUser.empty,
		comments: []
	);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == DataModelPost.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != DataModelPost.empty;

	DataModelPostEntity toEntity() {
    return DataModelPostEntity(
			id: id,
			title: title, 
			body: body,
			userId: userId,
			myUser: myUser,
			comments: comments,
    );
  }

  static DataModelPost fromEntity(DataModelPostEntity entity) {
    return DataModelPost(
			id: entity.id,
			title: entity.title, 
			body: entity.body,
			userId: entity.userId,
			myUser: entity.myUser,
			comments: entity.comments
    );
  }
	
	@override
	List<Object?> get props => [id, title, body, userId, myUser, comments];
	
}