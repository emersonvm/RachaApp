import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_app/Exceptions/auth_exception.dart';
import 'package:racha_app/models/auth.dart';

enum AuthMode { Signup, Login }

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _showPassword = false;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _loginDataForm = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um Erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        // Login
        await auth.login(
          _loginDataForm['email']!,
          _loginDataForm['password']!,
        );
      } else {
        // Registrar
        await auth.signup(
          _loginDataForm['email']!,
          _loginDataForm['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.transparent,
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      width: 128,
                      height: 128,
                      child: Image.asset("assets/logo.png"),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    if (_isSignup())
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '  E-mail',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                        ),
                        onSaved: (email) =>
                            _loginDataForm['email'] = email ?? '',
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'Forneça um E-mail válido.';
                          }
                          return null;
                        },
                      ),
                    if (_isLogin())
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '  E-mail',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                        ),
                        onSaved: (email) =>
                            _loginDataForm['email'] = email ?? '',
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'Informe seu E-mail.';
                          }
                          return null;
                        },
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    if (_isSignup())
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: '  Senha',
                          suffixIcon: GestureDetector(
                            child: Icon(
                              _showPassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black12,
                            ),
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                        ),
                        obscureText: _showPassword == false ? true : false,
                        onSaved: (password) =>
                            _loginDataForm['password'] = password ?? '',
                        validator: (value) {
                          if (value == null || value.trim().length < 8) {
                            return 'A Senha deve ter no mínimo 8 caracteres.';
                          }
                          return null;
                        },
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    if (_isSignup())
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '  Confirme sua Senha',
                          suffixIcon: GestureDetector(
                            child: Icon(
                              _showPassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black12,
                            ),
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                        ),
                        obscureText: _showPassword == false ? true : false,
                        onSaved: (password) =>
                            _loginDataForm['password'] = password ?? '',
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'As senhas informadas não conferem';
                          }
                          return null;
                        },
                      ),
                    if (_isLogin())
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '  Senha',
                          suffixIcon: GestureDetector(
                            child: Icon(
                              _showPassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black12,
                            ),
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                        ),
                        obscureText: _showPassword == false ? true : false,
                        onSaved: (password) =>
                            _loginDataForm['password'] = password ?? '',
                        validator: (value) {
                          if (value == null || value.trim().length < 8) {
                            return 'Informe sua Senha.';
                          }
                          return null;
                        },
                      ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 60,
                      width: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                          stops: [0.3, 1],
                          colors: [
                            Color(0xFF9acd32),
                            Color(0XFF28a428),
                          ],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: SizedBox.expand(
                        child: TextButton(
                          child: Wrap(
                            children: <Widget>[
                              if (_isLoading)
                                CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              else
                                Text(
                                  _isLogin() ? 'Entrar' : 'Cadastrar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                            ],
                          ),
                          onPressed: _submit,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      thickness: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                    TextButton(
                      child: Text(
                        _isLogin()
                            ? 'Novo por aqui? Crie uma conta!'
                            : 'Já possui uma conta?',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onPressed: _switchAuthMode,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
