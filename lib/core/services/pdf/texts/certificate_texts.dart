class CertificateTexts {
  static radioamadorParticipante({
    required String callsign,
    required String operatorName,
    required String eventName,
    required String ownerName,
    required String location,
  }) {
    return 'Certificamos que #$callsign# - #$operatorName# participou do #$eventName#, promovido pelo #$ownerName#, nas dependências do $location.';
  }
}
