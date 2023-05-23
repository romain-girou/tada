// ignore_for_file: omit_local_variable_types, prefer_final_locals, lines_longer_than_80_chars, sort_constructors_first

import 'dart:developer';

import 'package:data_repository/data_repository.dart';
import 'package:data_repository/src/entities/entities.dart';
import 'package:dio/dio.dart';

class FetchDataException implements Exception {}

class DataRepositoryOperations implements DataRepository {
	final Dio dio;

  DataRepositoryOperations({required this.dio});
	
	@override
	Future<List<DataModelPost>> fetchData() async {
		try {
			final Response responsePost = await dio.get('https://jsonplaceholder.typicode.com/posts');

			if(responsePost.statusCode == 200) {
				final List<Map<String, dynamic>> postDataConvert = List<Map<String, dynamic>>.from(responsePost.data as List);
				List<DataModelPost> myData = [];
				
				for (var element in postDataConvert) {
					DataModelPost dataModelPost = DataModelPost.fromEntity(DataModelPostEntity.fromDocument(element));
					log(dataModelPost.userId.toString());
					final Response responseUser = await dio.get('https://jsonplaceholder.typicode.com/users/${dataModelPost.userId}');

					if(responseUser.statusCode == 200) {
						final Map<String, dynamic> userDataConvert = Map<String, dynamic>.from(responseUser.data);
						dataModelPost.myUser = MyUser.fromEntity(MyUserEntity.fromDocument(userDataConvert));
						dataModelPost.myUser!.showData = true;

						myData.add(dataModelPost);
					}
				}
				return myData;
			} else {
				return [];
			}
		} catch (e) {
			throw FetchDataException();
		}
	}

	@override
	Future<List<Comment>> fetchComments(int postId) async {
		try {
			final Response responsePost = await dio.get('https://jsonplaceholder.typicode.com/posts/$postId/comments');

			if(responsePost.statusCode == 200) {
				final List<Map<String, dynamic>> commentDataConvert = List<Map<String, dynamic>>.from(responsePost.data as List);
				List<Comment> comments = [];
				
				for (var element in commentDataConvert) {
					Comment dataModelPost = Comment.fromEntity(CommentEntity.fromDocument(element));
					comments.add(dataModelPost);
				}
				return comments;
			} else {
				return [];
			}
		} catch (e) {
			throw FetchDataException();
		}
	}

}
