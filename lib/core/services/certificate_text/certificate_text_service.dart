import '../../../events/model/event_model.dart';
import '../../../participations/model/participation_model.dart';
import '../../enums/event_type_enum.dart';

class CertificateTextService {
  static radioamadorParticipante({
    required EventModel event,
    required ParticipationModel participation,
  }) {
    if (participation.callsign.isEmpty) {
      return '''É com grande satisfação e apreço que certificamos #${participation.name}# pela sua notável presença e participação no evento #${event.name}#. \n\nSua presença calorosa e alegre trouxe um brilho especial ao evento, evidenciando sua habilidade única em cultivar amizades e contribuir positivamente para o Radioamadorismo. Seu espírito afável e acolhedor certamente deixou uma marca indelével nos corações dos participantes. \n\nDestacamos, com especial reconhecimento, o esforço significativo em atravessar fronteiras, saindo de sua cidade para se fazer presente neste encontro memorável. \n\nTal dedicação em participar ativamente do evento, superando distâncias geográficas, é digna de profundo apreço. Seu empenho em cultivar relações positivas e sua disposição em compartilhar alegria são exemplos notáveis. \n\nEste evento, foi promovido com distinção pelo(a) respeitável #${event.owner}#.\n\nAmigo(a): #${participation.name}#\n\nOrigem: #${participation.city}# - #${participation.state}# - #${participation.country}#\n\nSua participação é sempre especial. Muito Obrigado!
     ''';
    }

    switch (event.type) {
      case EventTypeEnum.fieldDay:
        return 'Certificamos que #${participation.callsign}# - #${participation.name}# participou do #${event.name}#, promovido pelo #${event.owner}#, no dia ${event.startAt} nas dependências do ${event.location}, na cidade ${event.city}/${event.state}/${event.country}.';

      case EventTypeEnum.party:
        return '''É com grande satisfação e apreço que certificamos à Estação de #${participation.callsign}# - #${participation.name}# pela sua notável presença e participação no evento #${event.name}#. \n\nSua presença calorosa e alegre trouxe um brilho especial ao evento, evidenciando sua habilidade única em cultivar amizades e contribuir positivamente para o Radioamadorismo. Seu espírito afável e acolhedor certamente deixou uma marca indelével nos corações dos participantes. \n\nDestacamos, com especial reconhecimento, o esforço significativo em atravessar fronteiras, saindo de sua cidade para se fazer presente neste encontro memorável. \n\nTal dedicação em participar ativamente do evento, superando distâncias geográficas, é digna de profundo apreço. Seu empenho em cultivar relações positivas e sua disposição em compartilhar alegria são exemplos notáveis. \n\nEste evento, foi promovido com distinção pelo(a) respeitável #${event.owner}#.\n\nEstação: #${participation.callsign}# - #${participation.name}#\n\nOrigem: #${participation.city}# - #${participation.state}# - #${participation.country}#\n\nSua participação é sempre especial. Muito Obrigado!
     ''';
    }
  }
}
