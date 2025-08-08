import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:xml/xml.dart';
import '../../domain/entities/product.dart';

class DataExportService {
  // Export products to CSV
  String exportProductsToCSV(List<Product> products) {
    final List<List<dynamic>> rows = [
      ['ID', 'Name', 'SKU', 'Category', 'Current Stock', 'Unit Price', 'Status'],
      ...products.map((p) => [
        p.id,
        p.name,
        p.sku,
        p.categoryId ?? '',
        p.currentStock,
        p.sellingPrice ?? 0,
        p.isActive ? 'Active' : 'Inactive',
      ]),
    ];
    
    return const ListToCsvConverter().convert(rows);
  }

  // Export products to JSON
  String exportProductsToJSON(List<Product> products) {
    final data = products.map((p) => p.toJson()).toList();
    return const JsonEncoder.withIndent('  ').convert(data);
  }

  // Export products to XML
  String exportProductsToXML(List<Product> products) {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element('products', nest: () {
      for (final product in products) {
        builder.element('product', nest: () {
          builder.element('id', nest: product.id);
          builder.element('name', nest: product.name);
          builder.element('sku', nest: product.sku);
          builder.element('currentStock', nest: product.currentStock.toString());
          builder.element('sellingPrice', nest: (product.sellingPrice ?? 0).toString());
        });
      }
    });
    
    return builder.buildDocument().toXmlString(pretty: true);
  }
}