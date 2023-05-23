// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:math';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada/extension/extension.dart';

import '../../bloc/comment_bloc/comment_bloc.dart';

class PostDetailsScreen extends StatefulWidget {
	final DataModelPost dataModelPost;
  const PostDetailsScreen({super.key, required this.dataModelPost});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
	final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			extendBodyBehindAppBar: true,
      appBar: AppBar(
				backgroundColor: Colors.transparent,
				elevation: 0.0,
			),
			floatingActionButton: BlocBuilder<CommentBloc, CommentState>(
				builder: (context, myState) {
					if(myState is FetchCommentsSuccess) {
						return FloatingActionButton(
							backgroundColor: Theme.of(context).colorScheme.primary,
							child: Icon(
								CupertinoIcons.add,
								color: Theme.of(context).colorScheme.onPrimary,
							),
							onPressed: () async {
								Comment? myComments = await showDialog(
									context: context, 
									builder: (context) {
										return AlertDialog(
											backgroundColor: Colors.white,
											title: Text(
												'Créer un Post'
											),
											content: Form(
												key: _formKey,
												child: Column(
													mainAxisSize: MainAxisSize.min,
													children: [
														TextFormField(
															controller: emailController,
															validator: (val) {
																if(val!.isEmpty) {
																	return 'Veuillez remplir ce champ';													
																} else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
																	return 'Veuillez saisir un email valide';
																}
															},
															keyboardType: TextInputType.emailAddress,
															style: TextStyle(fontSize: 14),
															decoration: InputDecoration(
																contentPadding: EdgeInsets.all(10),
																border: OutlineInputBorder(
																	borderRadius: BorderRadius.circular(10)
																),
																filled: true,
																labelText: 'Votre email',
																hintText: 'john@gmail.com'
															),
														),
														SizedBox(height: 20),
														TextFormField(
															controller: titleController,
															validator: (val) {
																if(val!.isEmpty) {
																	return 'Veuillez remplir ce champ';													
																} else if(val.length > 50) {
																	return 'Nom trop long';
																}
															},
															style: TextStyle(fontSize: 14),
															decoration: InputDecoration(
																contentPadding: EdgeInsets.all(10),
																border: OutlineInputBorder(
																	borderRadius: BorderRadius.circular(10)
																),
																filled: true,
																labelText: 'Titre du post',
																hintText: 'Pourquoi la Terre est plate ?'
															),
														),
														SizedBox(height: 20),
														TextFormField(
															controller: bodyController,
															validator: (val) {
																if(val!.isEmpty) {
																	return 'Veuillez remplir ce champ';													
																} else if(val.length > 100) {
																	return 'Nom trop long';
																}
															},
															style: TextStyle(fontSize: 14),
															maxLines: 5,
															minLines: 1,
															maxLength: 100,
															decoration: InputDecoration(
																contentPadding: EdgeInsets.all(10),
																border: OutlineInputBorder(
																	borderRadius: BorderRadius.circular(10)
																),
																filled: true,
																labelText: 'Contenu du post',
																hintText: 'Lorem Ipsum...'
															),
														),
														SizedBox(height: 20),
														
													]
												)
											),
											actions: [
												Row(
													mainAxisAlignment: MainAxisAlignment.end,
													children: [
														TextButton(
															onPressed: () {
																Navigator.pop(context);
															}, 
															child: Text(
																'Annuler'
															)
														),
														SizedBox(width: 10),
														TextButton(
															style: ButtonStyle(
																backgroundColor: MaterialStateColor.resolveWith((states) => Theme.of(context).colorScheme.primary)
															),
															onPressed: () {
																if(_formKey.currentState!.validate()) {
																	Comment dataModelPost = Comment(
																		id: Random().nextInt(5000), 
																		postId: widget.dataModelPost.id, 
																		name: titleController.text, 
																		email: emailController.text, 
																		body: bodyController.text
																	);
																	Navigator.pop(context, dataModelPost);
																}
															}, 
															child: Text(
																'Créer',
																style: TextStyle(
																	color:Theme.of(context).colorScheme.onPrimary
																),
															)
														)
													],
												)
											],
										);
									}
								);
								if(myComments != null) {
									setState(() {
										myState.comments.insert(0, myComments);
										titleController.clear();
										bodyController.clear();
										emailController.clear();
									});
								}
							}
						);
					} else {
						return Container();
					}
				},
			),
      body: SingleChildScrollView(
        child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisAlignment: MainAxisAlignment.start,
        	children: [
        		Stack(
							children: [
								Stack(
									children: [
										Container(
											height: 300,
											width: MediaQuery.of(context).size.width,
											decoration: BoxDecoration(
												image: DecorationImage(
													fit: BoxFit.cover,
													image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
												)
											),
										),
									Container(
											color: Colors.black12,
											height: 300,
											width: MediaQuery.of(context).size.width,
										),
									],
								),
								SizedBox(
									height: 320,
									child: Align(
										alignment: Alignment.bottomLeft,
										child: Padding(
											padding: EdgeInsets.only(left: 20.0),
											child: Container(
												decoration: BoxDecoration(
													color: Colors.white,
													borderRadius: BorderRadius.circular(100),
													boxShadow: [
														BoxShadow(
															color: Colors.black12,
															spreadRadius: 5,
															blurRadius: 7,
															offset: Offset(0, 3),
														),
													],
												),
												child: Padding(
													padding: EdgeInsets.fromLTRB(5, 5, 20, 5),
													child: Row(
														mainAxisSize: MainAxisSize.min,
														children: [
															Container(
																height: 32,
																width: 32,
																decoration: BoxDecoration(
																	shape: BoxShape.circle,
																	image: DecorationImage(
																		fit: BoxFit.cover,
																		image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
																	)
																),
															),
															SizedBox(width: 10),
															Text(
																widget.dataModelPost.myUser!.name,
																style: TextStyle(
																	fontWeight: FontWeight.w400,
																	fontSize: 16
																),
															),
														],
													),
												),
											),
										),
									),
								)
							]
						),
						Padding(
							padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								mainAxisAlignment: MainAxisAlignment.start,
								mainAxisSize: MainAxisSize.min,
								children: [
									Text(
										widget.dataModelPost.title.capitalize(),
										style: TextStyle(
											fontWeight: FontWeight.bold,
											fontSize: 18
										),
									),
									SizedBox(height: 20),
									Text(
										widget.dataModelPost.body.capitalize(),
										style: TextStyle(
											fontWeight: FontWeight.normal,
											fontSize: 16
										),
									),
									SizedBox(height: 20),
									Divider(),
									SizedBox(height: 20),
									Text(
										'Commentaires',
										style: TextStyle(
											fontWeight: FontWeight.w600,
											fontSize: 18
										),
									),
									SizedBox(height: 20),
									BlocBuilder<CommentBloc, CommentState>(
										builder: (context, state) {
											if(state is FetchCommentsSuccess) {
												if(state.comments.length > 0) {
													return ListView.builder(
														shrinkWrap: true,
														physics: NeverScrollableScrollPhysics(),
														padding: EdgeInsets.zero,
														itemCount: state.comments.length,
														itemBuilder: (context, int i) {
															return Padding(
																padding: EdgeInsets.symmetric(vertical: 8.0),
																child: Container(
																	width: MediaQuery.of(context).size.width,
																	decoration: BoxDecoration(
																		color: Colors.white,
																		borderRadius: BorderRadius.circular(10),
																		boxShadow: [
																			BoxShadow(
																				color: Colors.grey.shade200,
																				spreadRadius: 5,
																				blurRadius: 7,
																				offset: Offset(0, 3),
																			),
																		],
																	),
																	child: Padding(
																		padding: const EdgeInsets.all(15.0),
																		child: Column(
																			crossAxisAlignment: CrossAxisAlignment.start,
																			mainAxisAlignment: MainAxisAlignment.start,
																			children: [
																				Text(
																					state.comments[i].name,
																					style: TextStyle(
																						fontWeight: FontWeight.w600,
																						fontSize: 16
																					),
																				),
																				SizedBox(height: 2),
																				Text(
																					state.comments[i].email,
																					style: TextStyle(
																						fontWeight: FontWeight.w300,
																						fontSize: 12
																					),
																				),
																				SizedBox(height: 8),
																				Text(
																					state.comments[i].body.capitalize(),
																					style: TextStyle(
																						fontWeight: FontWeight.normal,
																						fontSize: 14
																					),
																				)
																			],
																		),
																	),
																),
															);
														}
													);
												} else {
													return Center(
														child: Text(
															"Il n'y a pas de commentaires pour ce post."
														),
													);
												}
											} else if(state is FetchCommentsLoading) {
												return Center(
													child: CircularProgressIndicator(),
												);
											} else {
												return Center(
													child: Text('An error has occured...'),
												);
											}
										},
									)
								],
							),
						)
        	]
        )
			)
		);
  }
}