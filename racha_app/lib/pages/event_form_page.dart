import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:racha_app/models/event.dart';
import 'package:racha_app/models/event_list.dart';

class EventFormPage extends StatefulWidget {
  const EventFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<EventFormPage> {
  final _addressFocus = FocusNode();
  final _valueFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final event = arg as Event;
        _formData['id'] = event.id;
        _formData['name'] = event.name;
        _formData['address'] = event.address;
        _formData['totalValue'] = event.totalValue;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _addressFocus.dispose();
    _valueFocus.dispose();
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() => _isLoading = true);

    try {
      await Provider.of<EventList>(
        context,
        listen: false,
      ).saveEvent(_formData);

      Navigator.of(context).pop();
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Ocorreu um erro!'),
          content: Text('Ocorreu um erro para salvar o evento.'),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Novo Evento',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_addressFocus);
                      },
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';

                        if (name.trim().isEmpty) {
                          return 'Nome é obrigatório';
                        }

                        if (name.trim().length < 8) {
                          return 'Nome do evento precisa no mínimo de 8 letras.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['address']?.toString(),
                      decoration: InputDecoration(
                        labelText: 'Endereço',
                      ),
                      textInputAction: TextInputAction.next,
                      focusNode: _addressFocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_valueFocus);
                      },
                      onSaved: (address) =>
                          _formData['address'] = address ?? '',
                      validator: (_address) {
                        final address = _address ?? '';

                        if (address.trim().isEmpty) {
                          return 'Endereço é obrigatório';
                        }

                        if (address.trim().length < 8) {
                          return 'O endereço deve ter no mínimo 8 letras.';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['totalValue']?.toString(),
                      decoration: InputDecoration(labelText: 'Valor Total'),
                      focusNode: _valueFocus,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onSaved: (totalValue) => _formData['totalValue'] =
                          double.parse(totalValue ?? '0'),
                      validator: (_totalValue) {
                        final totalValue = _totalValue ?? '';
                        final value = double.tryParse(totalValue) ?? -1;

                        if (value <= 0) {
                          return 'Informe um preço válido.';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 60,
                      width: 20,
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
                                  'Salvar',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                            ],
                          ),
                          onPressed: _submitForm,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
