import 'package:flutter/material.dart';
import 'package:testing/core/providers/auth_provider.dart';
import 'package:testing/core/services/auth.dart';

class Validator {
  static String validateEmail(String value) {
    if (value.isNotEmpty) {
      if (value.contains("@")) {
        return null;
      } else {
        return "Email need to be contain @ expression";
      }
    } else if (value.isEmpty) {
      return 'Email can\'t be empty';
    } else {
      return null;
    }
  }

  static String validatePassword(String value) {
    if (value.isNotEmpty) {
      if (value.length > 6) {
        return null;
      } else {
        return "Password characther need to be more than 6";
      }
    } else {
      return 'Password can\'t be empty';
    }
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final Auth auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          final String response =
              await auth.signInWithEmailAndPassword(_email, _password);
          /* print('Signed in: $userId'); */
          if(response == "Success"){
            widget.onSignedIn();
          }
        } else {
          final String response =
              await auth.createUserWithEmailAndPassword(_email, _password);
          if(response == "Success"){
            widget.onSignedIn();
          }
        }
        /*  */
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter login demo'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInputs() + buildSubmitButtons(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return <Widget>[
      TextFormField(
        key: Key('email'),
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? "Email can't be empty": null,
        onSaved: (String value) => _email = value.trim(),
      ),
      TextFormField(
        key: Key('password'),
        decoration: InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: Validator.validatePassword,
        onSaved: (String value) => _password = value.trim(),
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return <Widget>[
        ElevatedButton(
          key: Key('signIn'),
          child: Text('Login', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        TextButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return <Widget>[
        ElevatedButton(
          child: Text('Create an account', style: TextStyle(fontSize: 20.0)),
          onPressed: validateAndSubmit,
        ),
        TextButton(
          child:
              Text('Have an account? Login', style: TextStyle(fontSize: 20.0)),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
