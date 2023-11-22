import 'package:flutter/material.dart';
import 'package:guarani/guarani.dart';
import 'package:ham_certificator/core/extensions/date_time_extension.dart';
import '../../../core/services/certificate_text/certificate_text_service.dart';
import '../../../core/services/pdf/preview/pdf_preview_widget.dart';
import '../../../events/model/event_model.dart';
import '../../controller/participation_controller.dart';
import '../states/participation_state.dart';

class ParticipationsPage extends StatefulWidget {
  const ParticipationsPage({
    super.key,
    required this.certificatesController,
    required this.eventModel,
  });

  final ParticipationController certificatesController;
  final EventModel eventModel;

  @override
  State<ParticipationsPage> createState() => _ParticipationsPageState();
}

class _ParticipationsPageState extends State<ParticipationsPage> {
  ParticipationController get _controller => widget.certificatesController;
  EventModel get _eventModel => widget.eventModel;

  @override
  void initState() {
    super.initState();
    _controller.getParticipations(eventUID: _eventModel.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GuaraniHeaderMenuWidget(
        showEvent: true,
        eventName: _eventModel.name,
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, state, _) {
          if (state is ParticipationLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ParticipationSuccessState) {
            final participations = state.participations;
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const GuaraniTitleSeparatorWidget(
                      title: 'Certificados',
                      subtitle: 'A ordem respeita o nome do participante.',
                    ),
                    SizedBox(
                      width: 800,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: participations.length,
                        itemBuilder: (context, index) {
                          final participation = participations[index];

                          String title = '';

                          if (participation.callsign.isNotEmpty) {
                            title =
                                '${participation.name} - ${participation.callsign}';
                          } else {
                            title = participation.name;
                          }

                          return ListTile(
                            title: Text(
                              title,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              '${participation.city} - ${participation.state} - ${participation.country}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                final text = CertificateTextService
                                    .radioamadorParticipante(
                                  event: _eventModel,
                                  participation: participation,
                                );

                                final map = {
                                  'title': 'Certificado',
                                  'phrase': text,
                                  'enphasis': [
                                    participation.callsign,
                                    participation.name,
                                    _eventModel.name,
                                    _eventModel.owner,
                                    participation.city,
                                    participation.state,
                                    participation.country,
                                  ],
                                  'date':
                                      '${_eventModel.city}-${_eventModel.state}-${_eventModel.country}, ${_eventModel.startAt.toHumanDate()}'
                                };

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PDFPreviewWidget(
                                      data: map,
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.print,
                                size: 30,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: const GuaraniFooterWidget(),
    );
  }
}
