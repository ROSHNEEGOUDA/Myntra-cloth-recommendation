import 'package:flutter/material.dart';
import 'package:flutter_myntra_clone/common_widgets/cached_image.dart';
import 'package:flutter_myntra_clone/common_widgets/primary_button.dart';
import 'package:flutter_myntra_clone/screens/login/otp.dart';
import 'package:flutter_myntra_clone/utils/asset_constants.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _form = GlobalKey<FormState>();
  String _mobileNumber = '';

  void _validateAndLogin() {
    if (_form.currentState?.validate() ?? false) {
      _form.currentState?.save();
      Navigator.of(context).pushNamed(Otp.routeName, arguments: _mobileNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CachedImage(
                url: banner_login_landing,
                height: 165,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'Login ',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: 'or ',
                            style: TextStyle(fontSize: 16),
                          ),
                          TextSpan(
                            text: 'Signup',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: _form,
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          labelText: 'Mobile Number',
                          labelStyle: const TextStyle(color: Colors.grey),
                          alignLabelWithHint: true,
                          errorStyle: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onFieldSubmitted: (_) => _validateAndLogin(),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        validator: validateMobileNumberInput,
                        onSaved: (value) => _mobileNumber = value ?? '',
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        title: 'CONTINUE',
                        onPressed: _validateAndLogin,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? validateMobileNumberInput(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a valid mobile number (10 digits)';
    }
    if (value.length != 10 || int.tryParse(value) == null) {
      return 'Please enter a valid mobile number (10 digits)';
    }
    return null;
  }
}
