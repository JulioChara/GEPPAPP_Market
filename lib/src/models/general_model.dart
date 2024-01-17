



class TiposModel {
  TiposModel({
    this.tipoDescripcion,
    this.tipoDescripcionCorta,
    this.tipoEstado,
    this.tipoId,
    this.tiposGeneralFk,
  });

  String? tipoDescripcion;
  String? tipoDescripcionCorta;
  String? tipoEstado;
  String? tipoId;
  String? tiposGeneralFk;

  factory TiposModel.fromJson(Map<String, dynamic> json) => TiposModel(
    tipoDescripcion: json["TipoDescripcion"],
    tipoDescripcionCorta: json["TipoDescripcionCorta"],
    tipoEstado: json["TipoEstado"],
    tipoId: json["TipoId"],
    tiposGeneralFk: json["TiposGeneralFk"],
  );

  Map<String, dynamic> toJson() => {
    "TipoDescripcion": tipoDescripcion,
    "TipoDescripcionCorta": tipoDescripcionCorta,
    "TipoEstado": tipoEstado,
    "TipoId": tipoId,
    "TiposGeneralFk": tiposGeneralFk,
  };
}
