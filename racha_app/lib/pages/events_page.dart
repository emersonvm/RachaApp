import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_app/components/event_item.dart';
import 'package:racha_app/models/event.dart';
import 'package:racha_app/models/event_list.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<EventList>(
      context,
      listen: false,
    ).loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventList>(context);
    final List<Event> loadedEvents = provider.items;

    final EventList events = Provider.of(context);
    if (loadedEvents.length == 0)
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Gerenciar Eventos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        body: Container(
          height: 200,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shadowColor: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const ListTile(
                  title: Text(
                    'Você não possui nenhum\revento! \n\n Para adicionar um evento volte na tela inicial.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Gerenciar Eventos',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: events.itemsCount,
              itemBuilder: (ctx, i) => Column(
                children: [
                  EventItem(events.items[i]),
                  Divider(),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
