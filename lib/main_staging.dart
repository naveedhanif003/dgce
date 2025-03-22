import 'package:dream_al_emarat_app/core/utils/constants/colors.dart';
import 'package:dream_al_emarat_app/routes/app_routes.dart';
import 'package:dream_al_emarat_app/routes/routes_names.dart';
import 'package:dream_al_emarat_app/viewmodels/forgot_view_model.dart';
import 'package:dream_al_emarat_app/viewmodels/login_view_model.dart';
import 'package:dream_al_emarat_app/viewmodels/logout_view_model.dart';
import 'package:dream_al_emarat_app/viewmodels/otp_view_model.dart';
import 'package:dream_al_emarat_app/viewmodels/reset_pass_view_model.dart';
import 'package:dream_al_emarat_app/viewmodels/setting_view_model.dart';
import 'package:dream_al_emarat_app/viewmodels/signup_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AppConfig.dart';
import 'core/utils/helpers/shared_pref_helper.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:dream_al_emarat_app/main_staging.dart';

/// Global key for navigation
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Initialize Local Notifications
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Handles messages when the app is in the background
Future<void> _backgroundHandler(RemoteMessage message) async {
  print("Background Message Received: ${message.notification?.title}");
}

/// Function to show local notification when the app is in foreground
Future<void> showNotification(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null) {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'channel_id', // Unique channel ID
          'Channel Name',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: true,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
      payload: message.data['message'] ?? '', // Pass message data
    );
  }
}

void main() async {
  AppConfig.appFlavor = Flavor.staging;
  WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.goldColor, // Set the status bar color
    statusBarIconBrightness: Brightness.light, // Icons will be white
  ));

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for notifications
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  // Get FCM Token
  String? token = await messaging.getToken();
  await SharedPrefHelper().saveData<String>("fcm_token", token ?? "");
  print('FCM Registration Token: $token');

  // Initialize local notifications
  const AndroidInitializationSettings androidInitSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(
    android: androidInitSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload != null) {
        print("Notification Clicked: ${response.payload}");
        _handleNotificationClick(response.payload!);
      }
    },
  );

  // Handle background messages
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  // Handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Foreground Message Received: ${message.notification?.title}");
    showNotification(message);
  });

  // Handle notification click when app is in background or terminated
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Notification Clicked (Background): ${message.data}");
    _handleNotificationClick(message.data);
  });

  runApp(MyApp());
}

void _handleNotificationClick(dynamic data) async {
  Map<String, dynamic> payloadData = {};

  // Convert payload string to map if needed
  if (data is String) {
    payloadData = Uri.splitQueryString(data).map((key, value) => MapEntry(key, value));
  } else if (data is Map<String, dynamic>) {
    payloadData = data;
  }

  print("Notification Payload: $payloadData");

  // Check if the payload contains a URL and redirect flag
  if (payloadData.containsKey("redirect_flag") &&
      payloadData["redirect_flag"] == "true" &&
      payloadData.containsKey("url")) {
    final String url = payloadData["url"];
    print("Navigating to HomeScreen with URL: $url");


    navigatorKey.currentState?.pushReplacementNamed(
      RoutesNames.home,
      arguments: {"url": url},
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SettingsViewModel()),
        ChangeNotifierProvider(create: (context) => LoginViewModel()),
        ChangeNotifierProvider(create: (context) => LogoutViewModel()),
        ChangeNotifierProvider(create: (context) => SignUpViewModel()),
        ChangeNotifierProvider(create: (context) => ForgotViewModel()),
        ChangeNotifierProvider(create: (context) => OTPViewModel()),
        ChangeNotifierProvider(create: (context) => ResetViewModel()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        // Assign navigator key
        theme: ThemeData(primarySwatch: Colors.amber),
        initialRoute: RoutesNames.splash,
        onGenerateRoute: AppRoutes.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
