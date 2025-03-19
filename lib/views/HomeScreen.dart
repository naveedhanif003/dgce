import 'dart:convert';
import 'dart:io';

import 'package:dream_al_emarat_app/apis_response/login_api_response/LoginApiResponse.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../core/utils/dialogs/LogoutDialog.dart';
import '../core/utils/helpers/shared_pref_helper.dart';
import '../core/utils/helpers/status.dart';
import '../routes/routes_names.dart';
import '../viewmodels/logout_view_model.dart';
import '../viewmodels/setting_view_model.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class HomeScreen extends StatefulWidget {
  final String url;

  const HomeScreen({Key? key, required this.url}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late InAppWebViewController _webViewController;
  late PullToRefreshController _pullToRefreshController;
  LoginApiResponse? loginResponse;
  String currentUrl = "";
  int _selectedIndex = 0;
  bool isLoading = true; // Only for WebView loading state
  File? _selectedImage;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();

    _pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue, // Customize the refresh indicator color
      ),
      onRefresh: () async {
        // Reload the WebView
        await _webViewController.reload();
      },
    );
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    await _loadLoginResponse(); // Ensure login response is loaded

    if (mounted) {
      setState(() {
        // Default to the user's dashboard if available
        if (widget.url.isNotEmpty) {
          print("Current URL: ${widget.url}");
          currentUrl = widget.url;
        } else if (loginResponse?.data?.userData?.dashboardUrl != null) {
          currentUrl = loginResponse!.data!.userData!.dashboardUrl!;
        }
      });

      print("Current URL: $currentUrl");

      // Load the WebView after setting the correct URL
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _webViewController
            .loadUrl(urlRequest: URLRequest(url: WebUri(currentUrl)))
            .catchError((error) {
              debugPrint("WebView failed to load: $error");
              if (mounted) setState(() => isLoading = false);
            });
      });
    }
  }

  /// Inject JavaScript to detect file input clicks
  void _injectJavaScript() {
    _webViewController.evaluateJavascript(
      source: """
    // 🛠 Handle File Inputs (Opens Flutter File Picker)
    // document.addEventListener("click", function(event) {
    //   if (event.target.tagName === "INPUT" && event.target.type === "file") {
    //     event.preventDefault();
    //     window.FlutterFilePicker.postMessage("open");
    //   }
    // });

    // 🌐 Fix Mixed Content (Convert HTTP Images to HTTPS)
    document.querySelectorAll('img').forEach(img => {
      if (img.src.startsWith('http://')) {
        img.src = img.src.replace('http://', 'https://');
      }
    });

    // 🚀 Force Images to Load Immediately (Fix Lazy Loading)
    document.querySelectorAll('img').forEach(img => {
      img.loading = 'eager';  // Load images immediately
      img.decoding = 'sync';  // Avoid rendering delay
    });

    // 🌍 Enable CORS for Cross-Origin Images
    document.querySelectorAll('img').forEach(img => {
      img.crossOrigin = "anonymous";
    });

    // 🔄 Refresh Images in Case They Are Not Loading
    document.querySelectorAll('img').forEach(img => {
      let newSrc = img.src;
      img.src = "";
      img.src = newSrc;  // Reload image
    });

  """,
    );
  }

  void addFileSelectionListener() async {
    if (Platform.isAndroid) {
      final androidController =
          _webViewController.platform as AndroidWebViewController;
      await androidController.setOnShowFileSelector(_androidFilePicker);
    }
  }

  Future<List<String>> _androidFilePicker(FileSelectorParams params) async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null && result.files.single.path != null) {
      final file = File(result.files.single.path!);
      return [file.uri.toString()];
    }
    return [];
  }

  void _onItemTapped(int index) {
    print("${loginResponse?.data?.appLinks?.editProfile?.link}");
    List<String> urls = [
      "${loginResponse?.data?.userData?.dashboardUrl}",
      "${loginResponse?.data?.appLinks?.shopping?.link}",
      "${loginResponse?.data?.appLinks?.shareBuy?.link}",
      "${loginResponse?.data?.appLinks?.editProfile?.link}",
    ];

    setState(() {
      _selectedIndex = index;
      currentUrl = urls[index];
      isLoading = true;
    });

    _webViewController
        .loadUrl(urlRequest: URLRequest(url: WebUri(currentUrl)))
        .then((_) {
          if (mounted) setState(() => isLoading = false);
        })
        .catchError((error) {
          debugPrint("Navigation failed: $error");
          if (mounted) setState(() => isLoading = false);
        });
  }

  @override
  Widget build(BuildContext context) {
    final settingViewModel = Provider.of<SettingsViewModel>(context);
    return PopScope(
      canPop: false, // Override default pop behavior
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // If already popped, do nothing

        bool shouldExit = await _handleBackPress();
        print("canBack: $shouldExit");

        if (shouldExit && mounted) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else if (Platform.isIOS) {
            exit(0); // Force exit on iOS (Apple doesn't recommend this)
          } // Exit only if the app is still active
        }
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xFF5C4718),
          appBar: AppBar(
            backgroundColor: Color(0xFF5C4718),
            elevation: 0,
            title: Row(
              children: [
                Image.asset("assets/images/logo.png", height: 40),
                SizedBox(width: 10),
                Text(
                  "DGCE",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
            actions: [
              // 🛒 Cart Icon (Left Side of Drawer Icon)
              Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentUrl =
                            loginResponse?.data?.appLinks?.cartPage?.link ?? "";
                        isLoading = true;
                      });
                      _webViewController
                          .loadUrl(
                            urlRequest: URLRequest(url: WebUri(currentUrl)),
                          )
                          .then((_) {
                            if (mounted) setState(() => isLoading = false);
                          });
                    },
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),

              // Drawer Icon
              IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                icon: Image.asset(
                  "assets/images/drawer_icon.png",
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          endDrawer: Drawer(
            backgroundColor: Color(0xFF5C4718),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Color(0xFF5C4718)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                          "${loginResponse?.data?.userData?.image}",
                        ),
                        onBackgroundImageError: (error, stackTrace) {
                          debugPrint("Failed to load image: $error");
                        },
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.brown,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${loginResponse?.data?.userData?.name}",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                ...?settingViewModel.settings?.data?.pages?.navbarLinks?.map(
                  (item) => ListTile(
                    leading: Icon(Icons.web, color: Colors.white),
                    title: Text(
                      item.title!,
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      setState(() {
                        currentUrl = item.link!;
                        isLoading = true;
                      });
                      _webViewController
                          .loadUrl(
                            urlRequest: URLRequest(url: WebUri(currentUrl)),
                          )
                          .then((_) {
                            if (mounted) setState(() => isLoading = false);
                          });
                      Navigator.pop(context);
                    },
                  ),
                ),
                Divider(color: Colors.white54),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.white),
                  title: Text("Logout", style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pop(context);
                    showLogoutDialog(context, () => _logout(context));
                  },
                ),
              ],
            ),
          ),
          body: SizedBox(
            width: double.infinity,
            height: double.infinity, // Ensures it takes up full space
            child: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(currentUrl)),
                  onWebViewCreated: (controller) {
                    _webViewController = controller;

                    if (currentUrl.isNotEmpty) {
                      _webViewController
                          .loadUrl(
                            urlRequest: URLRequest(url: WebUri(currentUrl)),
                          )
                          .catchError((error) {
                            debugPrint("WebView failed to load: $error");
                          });
                    }
                  },
                  pullToRefreshController: _pullToRefreshController,
                  onLoadStop: (controller, url) async {
                    _pullToRefreshController.endRefreshing();
                    if (mounted) setState(() => isLoading = false);
                    _injectJavaScript(); // Inject JavaScript after the page finishes loading
                    addFileSelectionListener();
                  },
                ),
                if (isLoading)
                  Center(child: CircularProgressIndicator(color: Colors.white)),
              ],
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFFD4AF37),
            unselectedItemColor: Colors.white,
            backgroundColor: Color(0xFF8B6A2B),
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Dashboard",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag),
                label: "Shop",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/gold.png",
                  height: 25,
                  width: 25,
                ),
                label: "Gold Share",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    final logoutViewModel = Provider.of<LogoutViewModel>(
      context,
      listen: false,
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            content: Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
    );
    String? accessToken = await SharedPrefHelper().getData<String>(
      "access_token",
    );
    await logoutViewModel.fetchLogout({
      "access_token": accessToken!,
      "user_type": "customer",
    });
    Navigator.pop(context);
    if (logoutViewModel.status == Status.COMPLETE) {
      await SharedPrefHelper().clearAll();
      await SharedPrefHelper().saveData<bool>("isOnboardingAlreadyShow", true);
      Navigator.pushReplacementNamed(context, RoutesNames.signIn);
    }
  }

  Future<void> _loadLoginResponse() async {
    loginResponse = await getStoredLoginResponse();
    setState(() {}); // Update UI after data is loaded
  }

  Future<LoginApiResponse?> getStoredLoginResponse() async {
    String? loginJson = await SharedPrefHelper().getData<String>(
      "login_response",
    );

    if (loginJson != null) {
      return LoginApiResponse.fromJson(
        jsonDecode(loginJson),
      ); // Convert JSON string back to object
    }
    return null;
  }

  Future<void> onRefresh() async {
    if (_webViewController != null) {
      await _webViewController.reload();
      _refreshController
          .refreshCompleted(); // Ensure this is called after reload
    }
  }

  Future<bool> _handleBackPress() async {
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
      return false; // Prevent exiting the app
    } else {
      return true; // Exit the app
    }
  }
}
