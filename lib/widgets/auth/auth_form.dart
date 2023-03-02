import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stumble/pickers/user_image_picker.dart';

import '../../data/constants.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitFn, this.isLoading, {Key? key}) : super(key: key);

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String firstName,
    String lastName,
    File? image,
    Gender? _selectedGender,
    bool isLogin,
  ) submitFn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userFirstName = '';
  String _userLastName = '';
  String _userPassword = '';
  File? _userImageFile;
  Gender? _selectedGender;
  final _passwordController = TextEditingController();

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please pick an image"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (_selectedGender == null && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please pick a gender"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid != null && isValid) {
      _formKey.currentState!.save();

      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userFirstName.trim(),
        _userLastName.trim(),
        _userImageFile,
        _selectedGender,
        _isLogin,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    SizedBox(
                      height: 170,
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 16),
                            child: UserImagePicker(_pickedImage),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  key: const ValueKey('firstname'),
                                  decoration: const InputDecoration(
                                      labelText: 'First Name'),
                                  validator: (value) {
                                    if (value == null || value!.isEmpty) {
                                      return "Please enter a valid first name";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _userFirstName = value!;
                                  },
                                ),
                                TextFormField(
                                  key: const ValueKey('lastname'),
                                  decoration: const InputDecoration(
                                      labelText: 'Last Name'),
                                  validator: (value) {
                                    if (value == null || value!.isEmpty) {
                                      return "Please enter a valid last name";
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _userLastName = value!;
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value!)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    controller: _passwordController,
                    // validator: (value) {
                    //   if (value == null ||
                    //       value!.isEmpty ||
                    //       !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                    //           .hasMatch(value!)) {
                    //     return ("Your password should contain at least:\n"
                    //         " one upper case\n one lower case\n one digit\n one special character\n 8 characters in length");
                    //   }
                    //   return null;
                    // },
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match!';
                        }
                      },
                    ),
                  if (!_isLogin)
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Center(
                            child: Text(
                              'Select a gender:',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: DropdownButtonFormField<Gender>(
                              value: _selectedGender,
                              onChanged: (newValue) {
                                setState(() {
                                  _selectedGender = newValue!;
                                });
                              },
                              items: Gender.values.map((Gender value) {
                                return DropdownMenuItem<Gender>(
                                  value: value,
                                  child: Text(value.toString().split('.').last),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? "Login" : "Register"),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? "Create new account"
                          : "I already have an account"),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
