import 'package:flutter/material.dart';
import 'package:lendingmobile/core/common/widgets/Gap.dart';
import 'package:lendingmobile/core/services/keycloak/keycloak_wrapper.dart';

final keycloakConfig = KeycloakConfig(
  bundleIdentifier: 'com.example.lendingmobile',
  clientId: 'keycloak-mobile',
  frontendUrl: 'http://10.0.2.2:8080',
  realm: 'Keycloak-POC',
);

final keycloakWrapper = KeycloakWrapper(config: keycloakConfig);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  keycloakWrapper.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const LoginPage(),
      home: StreamBuilder<bool>(
          stream: keycloakWrapper.authenticationStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.data!) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<bool> login() async {
    final isLoggedIn = await keycloakWrapper.login();
    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Lending Platform',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: login,
                  child: Ink(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: const Color(0xff65558f),
                        borderRadius: BorderRadius.circular(16)),
                    child: const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Logout from the current realm.

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  Future<void> _onPullToRefresh() async {
    setState(() {
      keycloakWrapper.updateToken;
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: FutureBuilder(
        future: keycloakWrapper.getUserInfo(),
        builder: (context, snapshot) {
          final name = snapshot.data?['name'];
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: _onPullToRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_selectedIndex == 0)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Lending',
                                style: TextStyle(
                                    color: Color(0xff65558f),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 40),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'App',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text('Welcome, $name!'),
                            const Gap(),
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffa49bba),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '100,000',
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Remaining Balance',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(),
                          ],
                        ),
                      ),
                    if (_selectedIndex == 2)
                      ProfilePage(
                        snapshotData: snapshot,
                      )
                  ],
                ),
              ),
            ),
          );

          //
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final dynamic snapshotData;
  const ProfilePage({
    super.key,
    required this.snapshotData,
  });

  Future<bool> logout() async {
    // Check if user has successfully logged out.
    final isLoggedOut = await keycloakWrapper.logout();

    return isLoggedOut;
  }

  @override
  Widget build(BuildContext context) {
    final name = snapshotData.data?['name'] ?? '';
    final givenName = snapshotData.data?['given_name'] ?? '';
    final familyName = snapshotData.data?['family_name'] ?? '';
    final username = snapshotData.data?['preferred_username'] ?? '';
    final email = snapshotData.data?['email'] ?? '';
    final accessToken = keycloakWrapper.accessToken ?? '';
    final refreshToken = keycloakWrapper.refreshToken ?? '';
    final idToken = keycloakWrapper.idToken ?? '';
    // final authenticationStream =
    //     keycloakWrapper.authenticationStream;
    return Padding(
      padding: const EdgeInsets.only(
        top: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Profile ',
                        style: TextStyle(
                            color: Color(0xff65558f),
                            fontWeight: FontWeight.w600,
                            fontSize: 40),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Page',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xff65558f),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        const Gap(
                          height: 0,
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              email,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text('Username: $username '),
                    const Gap(),
                    Text(
                        'accessToken: ${accessToken.substring(0, 30)}.....${accessToken.substring(accessToken.length - 20, accessToken.length)} '),
                    const Gap(),
                    Text(
                        'refreshToken: ${refreshToken.substring(0, 30)}.....${refreshToken.substring(refreshToken.length - 20, refreshToken.length)} '),
                    const Gap(),
                    Text(
                        'idToken: ${idToken.substring(0, 30)}.....${idToken.substring(idToken.length - 20, idToken.length)} '),
                    const Gap(),
                  ]),
            ),
          ),
          InkWell(
            onTap: logout,
            child: Ink(
              height: 50,
              width: double.infinity,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Icon(Icons.power_settings_new),
                      Gap(
                        height: 0,
                        width: 8,
                      ),
                      Text(
                        'Log Out Your Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
