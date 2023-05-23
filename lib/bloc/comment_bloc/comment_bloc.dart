import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:data_repository/data_repository.dart';
import 'package:equatable/equatable.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final DataRepository _dataRepository;

  CommentBloc({
		required DataRepository dataRepository,
	}) : 	_dataRepository = dataRepository,
	super(CommentInitial()) {
    on<FetchComments>((event, emit) async {
			emit(FetchCommentsLoading());
      try {
				log(event.postId.toString());
				List<Comment> comments = await _dataRepository.fetchComments(event.postId);
				emit(FetchCommentsSuccess(comments));
      } catch (e) {
				emit(FetchCommentsFailure());
      }
    });
  }
}
