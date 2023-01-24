import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_chat/widgets/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitForm, this.isLoading, {Key? key}) : super(key: key);

  final void Function(
    String email,
    String password,
    String username,
    File? userImage,
    bool isLogin,
  ) submitForm;
  final bool isLoading;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;

  String _userEmail = '';
  String _userPassword = '';
  String _userName = '';
  File? _userImageFile;

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }

    bool matchesPattern = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!matchesPattern) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username cannot be empty';
    }

    if (value.length < 4) {
      return 'Username must be at least 4 characters long';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }

    if (value.length < 7) {
      return 'Password must be at least 7 characters long';
    }
    return null;
  }

  void _pickImage(File? image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus(); //close the keyboard

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Please pick the image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitForm(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1, 0.9],
            colors: [
              Color.fromRGBO(51, 58, 67, 1),
              Color.fromRGBO(24, 28, 31, 1),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                if (!_isLogin) UserImagePicker(_pickImage),
                const SizedBox(height: 25),
                TextFormField(
                  key: const ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email address'),
                  validator: emailValidator,
                  onSaved: (value) => _userEmail = value!,
                ),
                const SizedBox(height: 10),
                if (!_isLogin)
                  TextFormField(
                    key: const ValueKey('username'),
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: usernameValidator,
                    onSaved: (value) => _userName = value!,
                  ),
                const SizedBox(height: 10),
                TextFormField(
                  key: const ValueKey('password'),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: passwordValidator,
                  onSaved: (value) => _userPassword = value!,
                ),
                const SizedBox(height: 12),
                if (widget.isLoading) const CircularProgressIndicator(),
                if (!widget.isLoading)
                  ElevatedButton(
                    onPressed: _trySubmit,
                    style:
                        ElevatedButton.styleFrom(foregroundColor: Colors.white),
                    child: Text(_isLogin ? 'Login' : 'Sign Up'),
                  ),
                if (!widget.isLoading)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'),
                  )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
