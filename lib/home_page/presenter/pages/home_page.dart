import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guarani/guarani.dart';
import 'package:ham_certificator/core/extensions/date_time_extension.dart';
import 'package:ham_certificator/events/model/event_model.dart';
import 'package:ham_certificator/home_page/presenter/controller/home_page_controller.dart';
import 'package:ham_certificator/home_page/presenter/states/home_page_state.dart';
import 'package:localization/localization.dart';
import 'widgets/alert_dialog_translate_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.controller,
  });

  final HomePageController controller;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    return Scaffold(
      appBar: GuaraniHeaderMenuWidget(
        translate: () {
          showDialog(
            context: context,
            builder: (context) {
              return const ModalTranslateWidget();
            },
          );
        },
      ),
      body: ValueListenableBuilder<HomePageState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          if (state is HomePageLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is HomePageSuccessState) {
            final events = state.events;
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      GuaraniCarouselWidget(
                        items: events
                            .map(
                              (e) => GuaraniCarouselItem(
                                eventName: e.name,
                                eventLocal:
                                    '${e.city} - ${e.state} - ${e.country}',
                                eventDate:
                                    e.startAt.toHumanDate(locale: locale),
                                eventMessage: e.startAt.isBefore(DateTime.now())
                                    ? 'event-past'.i18n()
                                    : 'event-future'.i18n(),
                                imageUrl: e.imageUrl.isEmpty
                                    ? 'assets/placeholder.jpg'
                                    : e.imageUrl,
                                onTap: (value) {},
                              ),
                            )
                            .toList(),
                      ),
                      if (constraints.maxWidth < 800)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: GuaraniTitleWidget(
                                label: 'system-title'.i18n(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: GuaraniTextDescriptionWidget(
                                label: 'hamcertificator-description'.i18n(),
                              ),
                            ),
                          ],
                        ),
                      if (constraints.maxWidth > 800)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 50),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: GuaraniTitleWidget(
                                  label: 'system-title'.i18n(),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                flex: 6,
                                child: GuaraniTextDescriptionWidget(
                                  label: 'hamcertificator-description'.i18n(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const Divider(
                        thickness: 2,
                      ),
                      GuaraniTitleSeparatorWidget(
                        title: 'event-scheduler'.i18n(),
                        subtitle: 'event-info'.i18n(),
                      ),
                      EventListWidget(
                        events: events
                            .where((event) =>
                                event.startAt.isAfter(DateTime.now()))
                            .toList(),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      GuaraniTitleSeparatorWidget(
                        title: 'certificate-title'.i18n(),
                        subtitle: 'certificate-info'.i18n(),
                      ),
                      EventListWidget(
                        events: events
                            .where((event) =>
                                event.startAt.isBefore(DateTime.now()))
                            .toList(),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: GuaraniFooterWidget(
        onLongPress: () => context.go('/login'),
      ),
    );
  }
}

class EventListWidget extends StatefulWidget {
  const EventListWidget({
    super.key,
    required this.events,
  });

  final List<EventModel> events;

  @override
  State<EventListWidget> createState() => _EventListWidgetState();
}

class _EventListWidgetState extends State<EventListWidget> {
  List<EventModel> get _events => widget.events;

  @override
  Widget build(BuildContext context) {
    return GuaraniEventListWidget(
      items: _events
          .map(
            (event) => GuaraniEventListItem(
              name: event.name,
              local: '${event.city} - ${event.state} - ${event.country}',
              startDate: event.startAt,
              imageUrl: event.imageUrl.isEmpty
                  ? 'assets/placeholder.jpg'
                  : event.imageUrl,
              onTap: (_) {
                if (event.hasPageDetails) {
                  context.go('/home/event/${event.uid}');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'event-details-no-available'.i18n(),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  );
                }
              },
            ),
          )
          .toList(),
    );
  }
}
