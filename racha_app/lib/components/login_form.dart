import 'package:flutter/material.dart';
import 'package:racha_app/data/login_data.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  final LoginData _loginData = LoginData();
  Map<String, String> _loginDataform = {
    'email': '',
    'password': '',
  };
  bool _isloading = false;

  _submit() {
    bool isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (!isValid) {
      return;
    }
    setState(() => _isloading = true);
    _formKey.currentState?.save();

    if (_loginData.isLogin) {
      //login
    } else {
      //Registrar
    }

    setState(() => _isloading = false);
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
                    if (_loginData.isSignup)
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: '  E-mail',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                        ),
                        onChanged: (value) => _loginData.email = value,
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'Forneça um E-mail válido.';
                          }
                          return null;
                        },
                      ),
                    if (_loginData.isLogin)
                      TextFormField(
                        onSaved: (email) =>
                            _loginDataform['email'] = email ?? '',
                        decoration: InputDecoration(
                          hintText: '  E-mail',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                        ),
                        onChanged: (value) => _loginData.email = value,
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
                    if (_loginData.isSignup)
                      TextFormField(
                        controller: _passwordController,
                        onSaved: (password) =>
                            _loginDataform['password'] = password ?? '',
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '  Senha',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                        ),
                        onChanged: (value) => _loginData.password = value,
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
                    if (_loginData.isSignup)
                      TextFormField(
                        onSaved: (password) =>
                            _loginDataform['password'] = password ?? '',
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '  Confirme sua Senha',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                        ),
                        onChanged: (value) => _loginData.password = value,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'As senhas informadas não conferem';
                          }
                          return null;
                        },
                      ),
                    if (_loginData.isLogin)
                      TextFormField(
                        onSaved: (password) =>
                            _loginDataform['password'] = password ?? '',
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: '  Senha',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 25.0, horizontal: 10.0),
                        ),
                        onChanged: (value) => _loginData.password = value,
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
                              if (_isloading)
                                CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              else
                                Text(
                                  _loginData.isLogin ? 'Entrar' : 'Cadastrar',
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
                        _loginData.isLogin
                            ? 'Novo por aqui? Crie uma conta!'
                            : 'Já possui uma conta?',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _loginData.toggleMode();
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (_loginData.isLogin)
                      Container(
                        child: Text(
                          'Ou',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    if (_loginData.isLogin)
                      Container(
                        height: 60,
                        width: 250,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [0.3, 1],
                            colors: [
                              Color(0xFF3b5998),
                              Color(0XFF4e71ba),
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
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: SizedBox.expand(
                          child: TextButton(
                            child: Wrap(
                              children: <Widget>[
                                Text(
                                  'Entrar com o Facebook',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 12,
                    ),
                    if (_loginData.isLogin)
                      Container(
                        height: 60,
                        width: 250,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 3),
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: SizedBox.expand(
                          child: TextButton(
                            child: Wrap(
                              children: <Widget>[
                                Text(
                                  'Entrar com o',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  ' G',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'o',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'g',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'l',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'e',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ),
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
