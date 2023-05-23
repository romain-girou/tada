// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tada/extension/extension.dart';
import 'package:tada/screens/post_details/post_details_screen.dart';
import '../../bloc/comment_bloc/comment_bloc.dart';
import '../../bloc/data_bloc/my_data_bloc.dart';
import '../../global/global.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {	
	List<MyUser> myUsersInactive = [];
  final _formKey = GlobalKey<FormState>();
	final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyDataBloc, MyDataState>(
			builder: (context, state) {
				if(state.status == MyDataStatus.success) {
					return Scaffold(
						floatingActionButton: FloatingActionButton(
							backgroundColor: Theme.of(context).colorScheme.primary,
							child: Icon(
								CupertinoIcons.add,
								color: Theme.of(context).colorScheme.onPrimary,
							),
							onPressed: () async {
								DataModelPost? myDataModelPost = await showDialog(
									context: context, 
									builder: (context) {
										List<String> myUserString = [];
										myUsers.forEach((element) {
											myUserString.add(element.name);
										});
										String dropdownValue = myUserString.first;
			
										return StatefulBuilder(
											builder: (context, setState) {
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
																DropdownButton<String>(
																	value: dropdownValue,
																	icon: const Icon(
																		CupertinoIcons.chevron_down,
																		size: 20,
																	),
																	elevation: 16,
																	style: const TextStyle(color: Colors.deepPurple),
																	underline: Container(
																		height: 2,
																		color: Colors.deepPurpleAccent,
																	),
																	onChanged: (String? value) {
																		setState(() {
																			dropdownValue = value!;
																		});
																	},
																	items: myUserString.map<DropdownMenuItem<String>>((String value) {
																		return DropdownMenuItem<String>(
																			value: value,
																			child: Text(value),
																		);
																	}).toList(),
																),
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
																			DataModelPost dataModelPost = DataModelPost(
																				id: Random().nextInt(5000), 
																				title: titleController.text,
																				body: bodyController.text, 
																				userId: myUsers.where((element) => element.name == dropdownValue).first.id,
																				myUser: myUsers.where((element) => element.name == dropdownValue).first
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
									}
								);
								if(myDataModelPost != null) {
									setState(() {
									  state.myData.insert(0, myDataModelPost);
										titleController.clear();
										bodyController.clear();
									});
								}
							}
						),
						appBar: AppBar(
							elevation: 0.0,
							title: Text('Vivoka Test'),
						),
						body: SingleChildScrollView(
							child: Padding(
								padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
								child: Column(
									mainAxisSize: MainAxisSize.min,
									crossAxisAlignment: CrossAxisAlignment.end,
									children: [
										TextButton(
											style: ButtonStyle(
												backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
												shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
													side: BorderSide(color: Colors.grey.shade300),
													borderRadius: BorderRadius.circular(10)
												))
											),
											onPressed: () async{
												var userInactive = await showModalBottomSheet(
													backgroundColor: Theme.of(context).colorScheme.background,
													isDismissible: false,
													shape: RoundedRectangleBorder(
														borderRadius: BorderRadius.circular(20),
													),
													context: context,
													builder: (_) {
														return StatefulBuilder(
															builder: (context, setState) {
																return Column(
																	children: [
																		Expanded(
																			child: ListView.builder(
																				itemCount: myUsers.length,
																				itemBuilder: (_, int index) {
																					return Padding(
																						padding: EdgeInsets.all(8.0),
																						child: ListTile(
																							title: Text(
																								myUsers[index].name
																							),
																							trailing: Checkbox(
																								value: myUsers[index].showData,
																								onChanged: (value) {
																									if(value!) {
																										setState(() {
																											state.myData.forEach((element) {
																												element.myUser == myUsers[index]
																													? element.myUser!.showData = true
																													: null;
																											});
																											myUsers[index].showData = true;
																										});
																									} else {
																										setState(() {
																											state.myData.forEach((element) {
																												element.myUser == myUsers[index]
																													? element.myUser!.showData = false
																													: null;
																											});
																											myUsers[index].showData = false;
																										});
																									}
																								},
																							),
																						),
																					);
																				}
																			),
																		),
																		Padding(
																			padding: const EdgeInsets.fromLTRB(20, 0, 20, kToolbarHeight),
																			child: TextButton(
																				style: ButtonStyle(
																					backgroundColor: MaterialStateColor.resolveWith((states) => 
																						Theme.of(context).colorScheme.primary),
																					shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
																						side: BorderSide(color: Colors.grey.shade300),
																						borderRadius: BorderRadius.circular(10)
																					))
																				),
																				onPressed: () {
																					Navigator.pop(context, true);
																				}, 
																				child: Container(
																					width: double.infinity,
																					height: 30,
																						child: Center(
																							child: Text(
																								'Appliquer',
																								style: TextStyle(
																									fontSize: 18,
																									color: Theme.of(context).colorScheme.onPrimary
																								),
																							),
																						),
																					)
																			),
																		)
																	],
																);
															}
														);
													},
												);
												if(userInactive != null) {
													setState(() {});
												}
											}, 
											child: Padding(
												padding: EdgeInsets.symmetric(horizontal: 20),
												child: Row(
													mainAxisSize: MainAxisSize.min,
													children: [
														Icon(CupertinoIcons.line_horizontal_3_decrease),
														SizedBox(width: 5),
														Text(
															'Filtrer',
														),
													],
												),
											),
										),
										ListView.builder(
											shrinkWrap: true,
											physics: NeverScrollableScrollPhysics(),
											itemCount: state.myData.length,
											itemBuilder: (context, int i) {
												return state.myData[i].myUser!.showData!
													? Padding(
															padding: EdgeInsets.symmetric(vertical: 10.0),
															child: Container(
																decoration: BoxDecoration(
																	color: Colors.white,
																	borderRadius: BorderRadius.circular(10),
																	boxShadow: [
																		BoxShadow(
																			color: Colors.grey.shade100,
																			spreadRadius: 5,
																			blurRadius: 7,
																			offset: Offset(0, 3),
																		),
																	],
																),
																child: ListTile(
																	onTap: () => Navigator.push(
																		context, 
																		MaterialPageRoute(
																			builder: (BuildContext context) => 
																				BlocProvider(
																					create: (context) => CommentBloc(
																						dataRepository: context.read<MyDataBloc>().dataRepository
																					)..add(FetchComments(state.myData[i].id)),
																					child: PostDetailsScreen(dataModelPost: state.myData[i]
																					),
																				),
																		),
																	),
																	contentPadding: EdgeInsets.all(10),
																	title: Text(state.myData[i].title.capitalize()),
																	subtitle: Padding(
																		padding: EdgeInsets.only(top: 8.0),
																		child: Text(state.myData[i].myUser!.name.capitalize()),
																	),
																	trailing: IconButton(
																		onPressed: () {
																			setState(() {
																				state.myData.remove(state.myData[i]);
																			});
																		}, 
																		icon: Icon(CupertinoIcons.delete)
																	),
																),
															),
														)
													: Container();
											}
										)
									],
								),
							),
						),
					);
				} else {
					return Container();
				}
			},
		);
  }
}
