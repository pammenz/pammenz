import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class School2FirebaseUser {
  School2FirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

School2FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<School2FirebaseUser> school2FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<School2FirebaseUser>(
        (user) => currentUser = School2FirebaseUser(user));
