import 'package:equatable/equatable.dart';
import '../models/models.dart';
import 'entities.dart';

class MyUserEntity extends Equatable {
	final int id;
	final String name;
	final String username;
	final String email;
	final Map<String, dynamic> address;
	final String phone;
  final String website;
  final Map<String, dynamic> company;

	const MyUserEntity({
		required this.id,
		required this.name,
		required this.username,
		required this.email,
		required this.address,
		required this.phone,
		required this.website,
		required this.company,
	});

	Map<String, Object?> toDocument() {
    return {
      'id': id,
			'name': name,
			'username': username,
			'email': email,
			'address': address,
			'phone': phone,
			'website': website,
			'company': company,
    };
  }

	static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as int,
			name: doc['name'] as String,
			username: doc['username'] as String,
			email: doc['email'] as String,
			address: doc['address'] as Map<String, dynamic>,
			phone: doc['phone'] as String,
			website: doc['website'] as String,
			company: doc['company'] as Map<String, dynamic>,
    );
  }

	@override
  List<Object?> get props => [id, name, username, email, address, phone, website, company];

	@override
  String toString() {
    return '''MyUserEntity: {
			id: $id\n
			name: $name\n
			username: $username\n
			email: $email\n
			address: $address\n
			phone: $phone\n
			website: $website\n
			company: $company\n
		}''';
  }
}