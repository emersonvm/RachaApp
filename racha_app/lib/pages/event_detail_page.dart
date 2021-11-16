import 'package:flutter/material.dart';
import 'package:racha_app/models/event.dart';

class EventDetailPage extends StatelessWidget {
  const EventDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context)!.settings.arguments as Event;
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: ListView(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.asset(
              'assets/gol.png',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Valor total R\$ ${event.totalValue}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 30,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Valor faltante: R\$ ${event.missingValue}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Local do Evento:  ${event.address}',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
