class AuthException implements Exception {
  const AuthException({
    this.code,
  });
  final String? code;

  @override
  String toString() {
    String theMessage = "";
    switch (code) {
      case 'wrong-password':
        theMessage = "Wrong password";
        return theMessage;
      case 'user-not-found':
        theMessage = "User not found";
        return theMessage;
      case 'email-already-in-use':
        theMessage = "Email already in use";
        return theMessage;
      case 'invalid-email':
        theMessage = "Email is not valid";
        return theMessage;
      case 'operation-not-allowed':
        theMessage = "Operation is not allowed";
        return theMessage;
      case 'weak-password':
        theMessage = "The password is weak";
        return theMessage;
      case 'sign_in_failed':
        theMessage = "Sign in failed";
        return theMessage;
      default:
        theMessage = "Something happened";
        return theMessage;
    }
  }
}
