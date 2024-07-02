import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FacebookLoginExample extends StatefulWidget {
  @override
  _FacebookLoginExampleState createState() => _FacebookLoginExampleState();
}

class _FacebookLoginExampleState extends State<FacebookLoginExample> {
  AccessToken? _accessToken;
  User? _user; // if using Firebase Auth

  Future<void> _loginWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      // Optionally: Use Firebase Auth
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(_accessToken!.token);
      final userCredential = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);
      _user = userCredential.user;

      setState(() {});
    } else {
      print(result.status);
      print(result.message);
    }
  }

  Future<void> _logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _user = null; // if using Firebase Auth
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facebook Login"),
      ),
      body: Center(
        child: _accessToken == null
            ? ElevatedButton(
                onPressed: _loginWithFacebook,
                child: Text("Login with Facebook"),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Logged in as ${_user?.displayName ?? 'Unknown User'}"),
                  ElevatedButton(
                    onPressed: _logout,
                    child: Text("Logout"),
                  ),
                ],
              ),
      ),
    );
  }
}
