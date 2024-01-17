
import 'dart:convert';

class ProductosDetalladoModel {
  String? almacenesFk;
  String? cuentasContableComprasFk;
  String? cuentasContableVentasFk;
  String? empresasFk;
  String? prodCodigoBarrasPrincipal;
  String? prodDescripcion;
  String? prodEstado;
  String? prodExonerado;
  String? prodFecCreacion;
  String? prodFecModificacion;
  String? prodId;
  String? prodNombre;
  String? prodPrecio;
  String? prodPrecioCompra;
  String? prodPrecioOpcional;
  String? prodUsrCreacion;
  String? prodUsrModificacion;
  String? tipoEstanteFk;
  String? tipoSubEstanteFk;
  String? tiposFamiliaFk;
  String? tiposProductoFk;
  String? tiposUnidadMedidaFk;

  ProductosDetalladoModel({
    this.almacenesFk,
    this.cuentasContableComprasFk,
    this.cuentasContableVentasFk,
    this.empresasFk,
    this.prodCodigoBarrasPrincipal,
    this.prodDescripcion,
    this.prodEstado,
    this.prodExonerado,
    this.prodFecCreacion,
    this.prodFecModificacion,
    this.prodId,
    this.prodNombre,
    this.prodPrecio,
    this.prodPrecioCompra,
    this.prodPrecioOpcional,
    this.prodUsrCreacion,
    this.prodUsrModificacion,
    this.tipoEstanteFk,
    this.tipoSubEstanteFk,
    this.tiposFamiliaFk,
    this.tiposProductoFk,
    this.tiposUnidadMedidaFk,
  });

  factory ProductosDetalladoModel.fromJson(Map<String, dynamic> json) => ProductosDetalladoModel(
    almacenesFk: json["AlmacenesFk"],
    cuentasContableComprasFk: json["CuentasContableComprasFk"],
    cuentasContableVentasFk: json["CuentasContableVentasFk"],
    empresasFk: json["EmpresasFk"],
    prodCodigoBarrasPrincipal: json["ProdCodigoBarrasPrincipal"],
    prodDescripcion: json["ProdDescripcion"],
    prodEstado: json["ProdEstado"],
    prodExonerado: json["ProdExonerado"],
    prodFecCreacion: json["ProdFecCreacion"],
    prodFecModificacion: json["ProdFecModificacion"],
    prodId: json["ProdId"],
    prodNombre: json["ProdNombre"],
    prodPrecio: json["ProdPrecio"],
    prodPrecioCompra: json["ProdPrecioCompra"],
    prodPrecioOpcional: json["ProdPrecioOpcional"],
    prodUsrCreacion: json["ProdUsrCreacion"],
    prodUsrModificacion: json["ProdUsrModificacion"],
    tipoEstanteFk: json["TipoEstanteFk"],
    tipoSubEstanteFk: json["TipoSubEstanteFk"],
    tiposFamiliaFk: json["TiposFamiliaFk"],
    tiposProductoFk: json["TiposProductoFk"],
    tiposUnidadMedidaFk: json["TiposUnidadMedidaFk"],
  );

  Map<String, dynamic> toJson() => {
    "AlmacenesFk": almacenesFk,
    "CuentasContableComprasFk": cuentasContableComprasFk,
    "CuentasContableVentasFk": cuentasContableVentasFk,
    "EmpresasFk": empresasFk,
    "ProdCodigoBarrasPrincipal": prodCodigoBarrasPrincipal,
    "ProdDescripcion": prodDescripcion,
    "ProdEstado": prodEstado,
    "ProdExonerado": prodExonerado,
    "ProdFecCreacion": prodFecCreacion,
    "ProdFecModificacion": prodFecModificacion,
    "ProdId": prodId,
    "ProdNombre": prodNombre,
    "ProdPrecio": prodPrecio,
    "ProdPrecioCompra": prodPrecioCompra,
    "ProdPrecioOpcional": prodPrecioOpcional,
    "ProdUsrCreacion": prodUsrCreacion,
    "ProdUsrModificacion": prodUsrModificacion,
    "TipoEstanteFk": tipoEstanteFk,
    "TipoSubEstanteFk": tipoSubEstanteFk,
    "TiposFamiliaFk": tiposFamiliaFk,
    "TiposProductoFk": tiposProductoFk,
    "TiposUnidadMedidaFk": tiposUnidadMedidaFk,
  };
}





class TiposModel {
  String? tipoDescripcion;
  String? tipoDescripcionCorta;
  String? tipoEstado;
  String? tipoId;
  String? tiposGeneralFk;

  TiposModel({
    this.tipoDescripcion,
    this.tipoDescripcionCorta,
    this.tipoEstado,
    this.tipoId,
    this.tiposGeneralFk,
  });

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



