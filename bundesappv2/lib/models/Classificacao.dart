class Classificacao {
  List<Clube> clube;

  Classificacao({this.clube});

  Classificacao.fromJson(Map<String, dynamic> json) {
    if (json['Clube'] != null) {
      clube = new List<Clube>();
      json['Clube'].forEach((v) {
        clube.add(new Clube.fromJson(v));
      });
    }
  }
}

class Clube {
  String posicao;
  String logoUrl;
  String time;
  String pontos;
  String vitorias;
  String empates;
  String derrotas;
  String golsmarcados;
  String golsofridos;
  String aproveitamento;

  Clube(
      {this.posicao,
      this.logoUrl,
      this.time,
      this.pontos,
      this.vitorias,
      this.empates,
      this.derrotas,
      this.golsmarcados,
      this.golsofridos,
      this.aproveitamento});

  Clube.fromJson(Map<String, dynamic> json) {
    posicao = json['posicao'];
    logoUrl = json['logo_url'];
    time = json['time'];
    pontos = json['pontos'];
    vitorias = json['vitorias'];
    empates = json['empates'];
    derrotas = json['derrotas'];
    golsmarcados = json['golsmarcados'];
    golsofridos = json['golsofridos'];
    aproveitamento = json['aproveitamento'];
  }
}
