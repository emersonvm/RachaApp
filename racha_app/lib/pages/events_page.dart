import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:racha_app/components/event_item.dart';
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
    final EventList events = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Eventos',
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
