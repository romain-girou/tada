import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

class MyUser extends Equatable {
	int id;
	String name;
	String username;
	String email;
	Map<String, dynamic> address;
	String phone;
  String website;
  Map<String, dynamic> company;
	bool? showData;
	
	MyUser({
		required this.id,
		required this.name,
		required this.username,
		required this.email,
		required this.address,
		required this.phone,
		required this.website,
		required this.company,
		this.showData,
	});

	/// Empty user which represents an unauthenticated user.
  static final empty = MyUser(
		id: 0, 
		name: '',
		username: '',
		email: '',
		address: {},
		phone: '',
		website: '',
		company: {},
		showData: true,
	);

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == MyUser.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != MyUser.empty;

	MyUserEntity toEntity() {
    return MyUserEntity(
			id: id,
			name: name,
			username: username,
			email: email,
			address: address,
			phone: phone,
			website: website,
			company: company,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
			id: entity.id,
			name: entity.name,
			username: entity.username,
			email: entity.email,
			address: entity.address,
			phone: entity.phone,
			website: entity.website,
			company: entity.company,
    );
  }
	
	@override
	List<Object?> get props => [id, name, username, email, address, phone, website, company];
	
}