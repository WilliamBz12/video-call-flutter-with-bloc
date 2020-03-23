import 'package:flutter_modular/flutter_modular.dart';
import 'package:videocallflutter/app/modules/video_call/video_call_page.dart';

import 'services/agora_engine_service.dart';
import 'video_call_bloc.dart';

class VideoCallModule extends ChildModule {
  @override
  List<Bind> get binds => [
    Bind((i) => AgoraEngineService()),
    Bind((i) => VideoCallBloc(agoraEngineService: i.get())),
  ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => VideoCallPage(channelName: args.data)),
      ];

  static Inject get to => Inject<VideoCallModule>.of();
}
