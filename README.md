# video-call-flutter

A project created using MVVM architecture, Bloc, Flutter Modular pattern and slidy.

## PROJECT 

This project using AGORA IO as provider for to do video calls.

#### AGORA IO (agora.io)
Are a platform that has a plugin [agora_rtc_engine](https://pub.dev/packages/agora_rtc_engine) in pub dev, where we can to do many functions, like: calls, brodcasts, video calls and text messages. Besides, has 10000 minutes free to tests. 

The video and audio quality is good, and is very easy for work with him. 

#### MVVM ARCHITECTURE WITH BLOC

SERVICE: Used to handle all config and actions of Agora Engine (Like initial configs and Handle Actions);
BLOC: Used to do state's controll and set the functions that we are used with [agora_rtc_engine](https://pub.dev/packages/agora_rtc_engine);
PAGE: Used to presentation of our project (WIDGETS and some other functions).

#### PROJECT 

In the main principal we have the shield 'channel Name', we use this information to create a room (or channel) where one or more users can do connections.  
![image main](screenshot_main.jpg =250x250)

After the join in a channel, open a new module where we can see and speak with other people.

![image one user](screenshot_one_user.jpg =250x250)
![image two users](screenshot_two_users.jpg =250x250)
