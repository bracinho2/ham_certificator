import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:guarani/guarani.dart';
import 'package:ham_certificator/core/extensions/date_time_extension.dart';
import 'package:ham_certificator/events/view/pages/controller/event_page_controller.dart';
import 'package:ham_certificator/events/view/pages/state/event_state_page.dart';
import 'package:localization/localization.dart';

import '../../../participations/view/widgets/certificates_list_widget.dart';

class EventPage extends StatefulWidget {
  const EventPage({
    Key? key,
    required this.uid,
  }) : super(
          key: key,
        );

  final String uid;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  String get _uid => widget.uid;
  final _controller = GetIt.I.get<EventPageController>();
  double bannerHeight = 400;

  void setHeight(double width) {
    setState(() {
      bannerHeight = width * .4;
    });
  }

  @override
  void initState() {
    super.initState();
    getEvent();
  }

  void getEvent() async {
    await _controller.getEvent(uid: _uid);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

    setHeight(mediaQueryData.size.width);

    final locale = Localizations.localeOf(context);
    return ValueListenableBuilder(
      valueListenable: _controller,
      builder: (context, state, child) {
        if (state is EventPageLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is EventPageSuccessState) {
          final event = state.event;

          final isOpen = event.endAt.isAfter(DateTime.now());

          List<String> description = event.description.split('.');

          return Scaffold(
            appBar: GuaraniHeaderMenuWidget(
              showEvent: true,
              eventName: event.name,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(
                            event.imageUrl.isEmpty
                                ? 'assets/placeholder.jpg'
                                : event.imageUrl,
                          ).image,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      event.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ...description
                      .map(
                        (p) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${p.trim()}.',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  const SizedBox(
                    height: 20,
                  ),
                  if (isOpen)
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        InfoWidget(
                          icon: Icons.start_outlined,
                          label: event.startAt.toHumanDate(locale: locale),
                        ),
                        if (event.price.isNotEmpty)
                          InfoWidget(
                            icon: Icons.monetization_on,
                            label: event.price,
                          ),
                        InfoWidget(
                          icon: Icons.room,
                          label: event.location,
                        ),
                        if (event.language.isNotEmpty)
                          InfoWidget(
                            icon: Icons.language,
                            label: event.language,
                          ),
                        if (event.contact.isNotEmpty)
                          InfoWidget(
                            icon: Icons.contact_support,
                            label: event.contact,
                          ),
                        if (event.hasCertification)
                          InfoWidget(
                            icon: Icons.card_membership,
                            label: 'has-certification'.i18n(),
                          ),
                        InfoWidget(
                          icon: Icons.event_available,
                          label: event.endAt.toHumanDate(locale: locale),
                        ),
                      ],
                    ),
                  if (event.hasAvailableCertificates)
                    CertificatesListWidget(
                      event: event,
                    )
                ],
              ),
            ),
            bottomNavigationBar: const GuaraniFooterWidget(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          height: 300,
          width: 300,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadiusDirectional.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
