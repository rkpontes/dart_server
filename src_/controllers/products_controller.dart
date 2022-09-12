import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../dto/product_dto.dart';
import '../models/product_model.dart';
import '../services/products_services.dart';

class ProductsController {
  ProductsController(this.service);

  final ProductsService service;

  FutureOr<Response> getAllProducts(Request request) async {
    try {
      List<ProductModel> products = await service.findAllProducts();
      return Response.ok(
        jsonEncode(
          {"products": products.map((product) => product.toMap()).toList()},
        ),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      );
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode(
          {
            "error": "Ocorreu um erro inesperado!",
          },
        ),
      );
    }
  }

  FutureOr<Response> getproductById(Request request, String id) async {
    try {
      ProductModel product = await service.findProductById(int.parse(id));
      return Response.ok(
        jsonEncode(
          {"product": product.toMap()},
        ),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      );
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          "error": "Ocorreu um erro inesperado!",
        }),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      );
    }
  }

  FutureOr<Response> createproduct(Request request) async {
    try {
      final String body = await request.readAsString();
      Map<String, dynamic> productMap = jsonDecode(body);
      final ProductDto newProductDto = ProductDto.fromMap(productMap);
      final ProductModel newProduct =
          await service.createProduct(newProductDto);
      return Response(
        201,
        body: jsonEncode(
          {"product": newProduct.toMap()},
        ),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      );
    } catch (e) {
      return Response.internalServerError(
        body: jsonEncode({
          "error": e.toString(),
        }),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
      );
    }
  }
}
