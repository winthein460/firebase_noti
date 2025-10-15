import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  initFCM()async{
   await _firebaseMessaging.requestPermission();
   final fcmToken = await _firebaseMessaging.getToken();
   print(fcmToken);
   FirebaseMessaging.onMessage.listen((RemoteMessage message){
     print('Message: ${message.notification?.title}');
   });
   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
      print('OpenedApp Message: ${message.notification?.title}');
   });
   FirebaseMessaging.onBackgroundMessage((RemoteMessage message)async{
      print('Background Message: ${message.notification?.title}');
   });
   
   FirebaseMessaging.instance.getInitialMessage().then((message){
      if (message!=null) {
         print('Terminated Message: ${message.notification?.title}');
      }
   });

  }
  Future<void> subscribeToTopic({required String topic}) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unSubscribeToTopic({required String topic}) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}