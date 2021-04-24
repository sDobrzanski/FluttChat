import 'package:flutt_chat/bloc/chatsStream/chats_stream_bloc.dart';
import 'package:flutt_chat/bloc/usersStream/users_stream_state.dart';
import 'package:flutt_chat/services/firestore_service.dart';
import 'package:flutt_chat/streams/chats_stream.dart';
import 'package:flutt_chat/bloc/chatsStream/chats_Stream_event.dart';
import 'package:flutt_chat/widgets/text_fields/custom_search_field.dart';
import 'package:flutt_chat/streams/users_stream.dart';
import 'package:flutter/material.dart';
import 'package:flutt_chat/widgets/messages_bar_label.dart';
import 'package:flutt_chat/widgets/custom_app_bar.dart';
import 'package:flutt_chat/streams/searched_users_stream.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutt_chat/bloc/usersStream/users_stream_bloc.dart';
import 'package:flutt_chat/bloc/usersStream/users_stream_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatefulWidget {
  final User user;
  UsersScreen({this.user});
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        user: widget.user,
      ),
      body: SafeArea(child: BlocBuilder<UsersStreamBloc, UsersStreamState>(
        builder: (context, state) {
          if (state is RandomUsersLoaded) {
            return Users(
              user: widget.user,
              stream: state.usersStream,
            );
          }

          if (state is SearchedUsersLoaded) {
            return Users(
              user: widget.user,
              stream: state.usersStream,
            );
          }

          if (state is RandomUsersError) {
            return Text('${state.error}');
          }

          if (state is SearchedUsersError) {
            return Text('${state.error}');
          }

          return Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}

class Users extends StatefulWidget {
  final User user;
  final Stream stream;
  Users({this.user, this.stream});

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool isSearched = false;

  @override
  Widget build(BuildContext context) {
    final firestoreService = RepositoryProvider.of<FirestoreService>(context);
    final _usersBloc = BlocProvider.of<UsersStreamBloc>(context);
    return Container(
        child: BlocProvider<UsersStreamBloc>(
      create: (context) => UsersStreamBloc(firestoreService),
      child: Row(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  MessageBarLabel(),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: ChatsStream(
                      user: widget.user,
                    ),
                  ),
                ],
              ),
            ),
          ),
          VerticalDivider(
            width: 1,
            thickness: 1,
            color: Colors.black,
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                children: [
                  CustomSearchField(
                    icon: Icons.search,
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          isSearched = true;
                          _usersBloc.add(LoadSearchedUsers(searchKey: value));
                        } else {
                          isSearched = false;
                          _usersBloc.add(LoadRandomUsers());
                        }
                      });
                    },
                  ),
                  Expanded(
                      child: !isSearched
                          ? UsersStream(
                              user: widget.user,
                              stream: widget.stream,
                            )
                          : SearchedUsersStream(
                              user: widget.user,
                              stream: widget.stream,
                            ))
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
