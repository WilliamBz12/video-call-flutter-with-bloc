import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/widgets.dart';
import 'package:videocallflutter/app/core/constants.dart';


class AgoraEngineService {
  
  Future initConfigs({String channel}) async {
    //Init agora engine
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    //Set the properties
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":
        {\"width\":320,\"height\":180,\"frameRate\":
        15,\"bitRate\":140}}''');
    //Join with the chanell
    await AgoraRtcEngine.joinChannel(null, channel, null, 0);
  }

  /// Create agora sdk instance and initialize
  Future<void> initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
  }

  void handleActions({
    @required Function(String) addMessage,
    @required Function(int) addUser,
    @required Function(int) removeUser,
    @required Function clearUsers,
  }) {
    AgoraRtcEngine.onError = (dynamic code) => addMessage('onError: $code');

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      addMessage('onJoinChannel: $channel, uid: $uid');
      addUser(uid);
    };

    AgoraRtcEngine.onLeaveChannel = () => clearUsers();

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      addMessage('userJoined: $uid');
      addUser(uid);
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      addMessage('userOffline: $uid');
      removeUser(uid);
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame = (
      int uid,
      int width,
      int height,
      int elapsed,
    ) {
      addMessage('firstRemoteVideo: $uid ${width}x $height');
    };
  }

  void onToggleMute(bool muted) {
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  void onClose() {
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
  }
}
