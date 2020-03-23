import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/subjects.dart';

import 'agora_engine_service.dart';

class VideoCallBloc extends Disposable {
  AgoraEngineService agoraEngineService;

  VideoCallBloc({this.agoraEngineService});

  List<String> messages = [];
  List<int> users = [];

  final _messagesController = BehaviorSubject<List<String>>();
  Stream get outMessages => _messagesController.stream;

  final _usersController = BehaviorSubject<List<int>>();
  Stream<List<int>> get outUsers => _usersController.stream;

  void initAgoraEngine({@required String channel}) async {
    //init engine
    await agoraEngineService.initAgoraRtcEngine();
    //Init handle actions of engine
    agoraEngineService.handleActions(
      addMessage: _addMessage,
      addUser: _addUser,
      removeUser: _removeUser,
      clearUsers: _clearUsers,
    );
    //init configs with channel 
    await agoraEngineService.initConfigs(channel: channel);
  }

  void _addMessage(String message) {
    messages.add(message);
    _messagesController.add(messages);
  }

  void _addUser(int uid) {
    users.add(uid);
    _usersController.add(users);
  }

  void _removeUser(int uid) {
    users.remove(uid);
    _usersController.add(users);
  }

  void _clearUsers(int uid) {
    users.clear();
    _usersController.add(users);
  }

  void switchCamera() => agoraEngineService.onSwitchCamera();

  void muteAudio(bool muted) => agoraEngineService.onToggleMute(muted);

  @override
  void dispose() {
    _messagesController.close();
    _usersController.close();
    agoraEngineService.onClose();
  }
}
