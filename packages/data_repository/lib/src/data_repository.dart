import '../data_repository.dart';


abstract class DataRepository {
	
	Future<List<DataModelPost>> fetchData();

	Future<List<Comment>> fetchComments(int postId);
	
}
