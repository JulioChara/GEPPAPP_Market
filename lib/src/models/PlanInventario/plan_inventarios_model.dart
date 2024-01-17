
import 'dart:convert';


class PlanInventarioModel {
  String? fechaCreacion;
  String? fechaModificacion;
  String? id;
  String? piEstado;
  String? piFechaApertura;
  String? piFechaCierre;
  String? piFinalizado;
  String? usuarioCreacion;
  String? usuarioCreacionDesc;
  String? usuarioCreacionEntidadDesc;
  String? usuarioModificacion;
  String? usuarioModificacionDesc;
  String? usuarioModificacionEntidadDesc;
  List<PlanInventarioDetalleModel>? detalle;

  PlanInventarioModel({
    this.fechaCreacion,
    this.fechaModificacion,
    this.id,
    this.piEstado,
    this.piFechaApertura,
    this.piFechaCierre,
    this.piFinalizado,
    this.usuarioCreacion,
    this.usuarioCreacionDesc,
    this.usuarioCreacionEntidadDesc,
    this.usuarioModificacion,
    this.usuarioModificacionDesc,
    this.usuarioModificacionEntidadDesc,
    this.detalle,

  });

  factory PlanInventarioModel.fromJson(Map<String, dynamic> json) => PlanInventarioModel(
    fechaCreacion: json["fechaCreacion"],
    fechaModificacion: json["fechaModificacion"],
    id: json["id"],
    piEstado: json["piEstado"],
    piFechaApertura: json["piFechaApertura"],
    piFechaCierre: json["piFechaCierre"],
    piFinalizado: json["piFinalizado"],
    usuarioCreacion: json["usuarioCreacion"],
    usuarioCreacionDesc: json["usuarioCreacionDesc"],
    usuarioCreacionEntidadDesc: json["usuarioCreacionEntidadDesc"],
    usuarioModificacion: json["usuarioModificacion"],
    usuarioModificacionDesc: json["usuarioModificacionDesc"],
    usuarioModificacionEntidadDesc: json["usuarioModificacionEntidadDesc"],
    detalle: List<PlanInventarioDetalleModel>.from(json["detalle"]?.map((x) => PlanInventarioDetalleModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fechaCreacion": fechaCreacion,
    "fechaModificacion": fechaModificacion,
    "id": id,
    "piEstado": piEstado,
    "piFechaApertura": piFechaApertura,
    "piFechaCierre": piFechaCierre,
    "piFinalizado": piFinalizado,
    "usuarioCreacion": usuarioCreacion,
    "usuarioCreacionDesc": usuarioCreacionDesc,
    "usuarioCreacionEntidadDesc": usuarioCreacionEntidadDesc,
    "usuarioModificacion": usuarioModificacion,
    "usuarioModificacionDesc": usuarioModificacionDesc,
    "usuarioModificacionEntidadDesc": usuarioModificacionEntidadDesc,
    "detalle":detalle != null ? List<dynamic>.from(detalle!.map((x) => x.toJson())): null,
  };
}




class PlanInventarioDetalleModel {
  String? fechaCreacion;
  String? fechaModificacion;
  String? id;
  String? pdCantidadApertura;
  String? pdCantidadCierre;
  String? pdCantidadSistemas;
  String? pdProcesadoCierre;
  String? pdProductoCodigoBarras;
  String? pdProductoNombre;
  String? pdProductoPrecio;
  String? planInventarioFk;
  String? productoFk;
  String? tipoUnidadMedidaFk;
  String? tipoUnidadMedidaFkDesc;
  String? usuarioCreacion;
  String? usuarioCreacionDesc;
  String? usuarioCreacionEntidadDesc;
  String? usuarioModificacion;
  String? usuarioModificacionDesc;
  String? usuarioModificacionEntidadDesc;

  PlanInventarioDetalleModel({
    this.fechaCreacion,
    this.fechaModificacion,
    this.id,
    this.pdCantidadApertura,
    this.pdCantidadCierre,
    this.pdCantidadSistemas,
    this.pdProcesadoCierre,
    this.pdProductoCodigoBarras,
    this.pdProductoNombre,
    this.pdProductoPrecio,
    this.planInventarioFk,
    this.productoFk,
    this.tipoUnidadMedidaFk,
    this.tipoUnidadMedidaFkDesc,
    this.usuarioCreacion,
    this.usuarioCreacionDesc,
    this.usuarioCreacionEntidadDesc,
    this.usuarioModificacion,
    this.usuarioModificacionDesc,
    this.usuarioModificacionEntidadDesc,
  });

  factory PlanInventarioDetalleModel.fromJson(Map<String, dynamic> json) => PlanInventarioDetalleModel(
    fechaCreacion: json["fechaCreacion"],
    fechaModificacion: json["fechaModificacion"],
    id: json["id"],
    pdCantidadApertura: json["pdCantidadApertura"],
    pdCantidadCierre: json["pdCantidadCierre"],
    pdCantidadSistemas: json["pdCantidadSistemas"],
    pdProcesadoCierre: json["pdProcesadoCierre"],
    pdProductoCodigoBarras: json["pdProductoCodigoBarras"],
    pdProductoNombre: json["pdProductoNombre"],
    pdProductoPrecio: json["pdProductoPrecio"],
    planInventarioFk: json["planInventarioFk"],
    productoFk: json["productoFk"],
    tipoUnidadMedidaFk: json["tipoUnidadMedidaFk"],
    tipoUnidadMedidaFkDesc: json["tipoUnidadMedidaFkDesc"],
    usuarioCreacion: json["usuarioCreacion"],
    usuarioCreacionDesc: json["usuarioCreacionDesc"],
    usuarioCreacionEntidadDesc: json["usuarioCreacionEntidadDesc"],
    usuarioModificacion: json["usuarioModificacion"],
    usuarioModificacionDesc: json["usuarioModificacionDesc"],
    usuarioModificacionEntidadDesc: json["usuarioModificacionEntidadDesc"],
  );

  Map<String, dynamic> toJson() => {
    "fechaCreacion": fechaCreacion,
    "fechaModificacion": fechaModificacion,
    "id": id,
    "pdCantidadApertura": pdCantidadApertura,
    "pdCantidadCierre": pdCantidadCierre,
    "pdCantidadSistemas": pdCantidadSistemas,
    "pdProcesadoCierre": pdProcesadoCierre,
    "pdProductoCodigoBarras": pdProductoCodigoBarras,
    "pdProductoNombre": pdProductoNombre,
    "pdProductoPrecio": pdProductoPrecio,
    "planInventarioFk": planInventarioFk,
    "productoFk": productoFk,
    "tipoUnidadMedidaFk": tipoUnidadMedidaFk,
    "tipoUnidadMedidaFkDesc": tipoUnidadMedidaFkDesc,
    "usuarioCreacion": usuarioCreacion,
    "usuarioCreacionDesc": usuarioCreacionDesc,
    "usuarioCreacionEntidadDesc": usuarioCreacionEntidadDesc,
    "usuarioModificacion": usuarioModificacion,
    "usuarioModificacionDesc": usuarioModificacionDesc,
    "usuarioModificacionEntidadDesc": usuarioModificacionEntidadDesc,
  };
}






