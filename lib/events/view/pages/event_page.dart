import 'package:flutter/material.dart';
import 'package:guarani/guarani.dart';

import '../../model/event_model.dart';

class EventPage extends StatefulWidget {
  const EventPage({
    Key? key,
    required this.eventModel,
  }) : super(key: key);

  final EventModel eventModel;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  EventModel get _event => widget.eventModel;
  double bannerHeight = 400;

  void setHeight(double width) {
    setState(() {
      bannerHeight = width * .4;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    setHeight(mediaQueryData.size.width);
    return Scaffold(
      appBar: GuaraniHeaderMenuWidget(
        showEvent: true,
        eventName: _event.name,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: bannerHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    _event.imageUrl.isEmpty
                        ? 'assets/placeholder.jpg'
                        : _event.imageUrl,
                  ).image,
                ),
              ),
            ),
            Text(
              _event.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 50,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              _event.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              height: 200,
              color: Colors.green,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.calendar_month,
                    size: 40,
                  ),
                  Icon(
                    Icons.monetization_on,
                    size: 40,
                  ),
                  Icon(
                    Icons.room,
                    size: 40,
                  ),
                  Icon(
                    Icons.language,
                    size: 40,
                  ),
                  Icon(
                    Icons.contact_support,
                    size: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const GuaraniFooterWidget(),
    );
  }
}
