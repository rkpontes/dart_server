import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

import '../../domain/dtos/product_dto.dart';
import '../../domain/models/product_model.dart';
import '../../domain/usecases/create_product_usecase.dart';
import '../../domain/usecases/get_all_products_usecase.dart';
import '../../domain/usecases/get_product_by_id_usecase.dart';

class ProductsController {
  ProductsController(
    this._getAllProductsImplUsecase,
    this._getProductByIdImplUsecase,
    this._createProductUsecase,
  );

  // final ProductsService service;
  final GetAllProductsUsecase _getAllProductsImplUsecase;
  final GetProductByIdUsecase _getProductByIdImplUsecase;
  final CreateProductUsecase _createProductUsecase;

  FutureOr<Response> getAllProducts(Request request) async {
    try {
      List<ProductModel> products = await _getAllProductsImplUsecase();
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
      ProductModel product = await _getProductByIdImplUsecase(int.parse(id));
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

  FutureOr<Response> createProduct(Request request) async {
    try {
      final String body = await request.readAsString();
      Map<String, dynamic> productMap = jsonDecode(body);
      final ProductDto newProductDto = ProductDto.fromMap(productMap);
      final ProductModel newProduct =
          await _createProductUsecase(newProductDto);
      return Response(
        201,
        body: jsonEncode({"product": newProduct.toMap()}),
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
