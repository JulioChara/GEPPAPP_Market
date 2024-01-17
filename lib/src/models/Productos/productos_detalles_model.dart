

import 'dart:convert';




class ProductosDetallesModel {
  String? descripcion;
  String? fecha;
  String? idProducto;
  String? ingresos;
  String? producto;
  String? referencia;
  String? precioUnitario;
  String? proveedor;
  String? salidas;
  String? mensaje;
  String? resultado;

  ProductosDetallesModel({
    this.descripcion,
    this.fecha,
    this.idProducto,
    this.ingresos,
    this.producto,
    this.referencia,
    this.precioUnitario,
    this.proveedor,
    this.salidas,
    this.mensaje,
    this.resultado,
  });

  factory ProductosDetallesModel.fromJson(Map<String, dynamic> json) => ProductosDetallesModel(
    descripcion: json["Descripcion"],
    fecha: json["Fecha"],
    idProducto: json["IdProducto"],
    ingresos: json["Ingresos"],
    producto: json["Producto"],
    referencia: json["Referencia"],
    precioUnitario: json["PrecioUnitario"],
    proveedor: json["Proveedor"],
    salidas: json["Salidas"],
    mensaje: json["mensaje"],
    resultado: json["resultado"],
  );

  Map<String, dynamic> toJson() => {
    "Descripcion": descripcion,
    "Fecha": fecha,
    "IdProducto": idProducto,
    "Ingresos": ingresos,
    "Producto": producto,
    "Referencia": referencia,
    "PrecioUnitario": precioUnitario,
    "Proveedor": proveedor,
    "Salidas": salidas,
    "mensaje": mensaje,
    "resultado": resultado,
  };
}
