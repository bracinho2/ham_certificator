import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:guarani/guarani.dart';
import 'package:ham_certificator/participations/controller/participation_controller.dart';
import 'package:localization/localization.dart';

import '../../../core/services/certificate_text/certificate_text_service.dart';
import '../../../core/services/pdf/preview/pdf_preview_widget.dart';
import '../../../events/model/event_model.dart';
import '../states/participation_state.dart';

class CertificatesListWidget extends StatefulWidget {
  const CertificatesListWidget({
    super.key,
    required this.event,
  });

  final EventModel event;

  @override
  State<CertificatesListWidget> createState() => _CertificatesListWidgetState();
}

class _CertificatesListWidgetState extends State<CertificatesListWidget> {
  final controller = GetIt.I.get<ParticipationController>();

  @override
  void initState() {
    super.initState();
    controller.getParticipations(eventUID: widget.event.uid);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
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
                  GuaraniTitleSeparatorWidget(
                    title: 'certificate-title'.i18n(),
                    subtitle: 'certificate-index'.i18n(),
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
                                event: widget.event,
                                participation: participation,
                              );

                              final map = {
                                'title': 'Certificado',
                                'phrase': text,
                                'enphasis': [
                                  participation.callsign,
                                  participation.name,
                                  widget.event.name,
                                  widget.event.owner,
                                  participation.city,
                                  participation.state,
                                  participation.country,
                                ],
                                'date':
                                    '${widget.event.city}-${widget.event.state}-${widget.event.country}, ${widget.event.startAt}'
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
    );
  }
}
