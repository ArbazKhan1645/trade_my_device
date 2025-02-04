// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../main.dart';

class SupabaseFetchDataClass {
  static Future<FetchResult<T>> fetchsupaBaseTablesDataLink<T>(String tablename,
      {BuildContext? contexts,
      T Function(Map<String, dynamic>)? fromJson,
      Map<String, dynamic>? eq,
      bool? delete,
      Map<String, dynamic>? updateValues}) async {
    try {
      final builder = supbaseClient.from(tablename);
      if (delete == true) {
        await _deleteRecords(tablename, eq);
        return FetchResult(success: true, data: []);
      }

      if (updateValues != null) {
        await _updateRecords(tablename, eq, updateValues);
        return FetchResult(success: true, data: []);
      }
      final response = await builder.select();

      List<Map<String, dynamic>> finalresponse =
          (response as List).cast<Map<String, dynamic>>();
      if (eq != null) {
        finalresponse = customEqFilter(finalresponse, eq);
      }
      if (fromJson != null) {
        return FetchResult(
            success: true,
            data: finalresponse.map((e) => fromJson(e)).toList());
      }
      return FetchResult(success: true, data: finalresponse as List<T>);
    } catch (e) {
      return FetchResult(success: false, message: e.toString());
    }
  }

  static handleFetchResult(FetchResult result) async {
    if (result.success) {
      if (result.data == null || result.data!.isEmpty) {
        return '';
      } else {
        return result.data;
      }
    } else {
      return 'Error: ${result.message}';
    }
  }

  static Future _updateRecords(String tablename, Map<String, dynamic>? eq,
      Map<String, dynamic> updateValues) async {
    try {
      final fetchBuilder = supbaseClient.from(tablename).select();
      final fetchResponse = await fetchBuilder.select();
      List records = fetchResponse as List;
      if (eq != null) {
        records = customEqFilter(records.cast<Map<String, dynamic>>(), eq);
      }

      for (var record in records) {
        final updateBuilder = supbaseClient
            .from(tablename)
            .update(updateValues)
            .eq('id', record['id']);
        await updateBuilder.select();
      }
      return FetchResult(success: true, message: 'Completed Successfully');
    } catch (e) {
      return FetchResult(
          success: false,
          message: 'Failed to Update data Record. Error: ${e.toString()}');
    }
  }

  static Future _deleteRecords(
      String tablename, Map<String, dynamic>? eq) async {
    try {
      final fetchBuilder = supbaseClient.from(tablename).select();
      final fetchResponse = await fetchBuilder.select();
      List records = fetchResponse as List;
      if (eq != null) {
        records = customEqFilter(records.cast<Map<String, dynamic>>(), eq);
      }
      for (var record in records) {
        final deleteBuilder =
            supbaseClient.from(tablename).delete().eq('id', record['id']);
        await deleteBuilder.select();
      }
      return FetchResult(success: true, message: 'Completed Successfully');
    } catch (e) {
      return FetchResult(
          success: false,
          message: 'Failed to Delete data Record. Error: ${e.toString()}');
    }
  }
}

List<Map<String, dynamic>> customEqFilter(
    List<Map<String, dynamic>> data, Map<String, dynamic> eq) {
  return data.where((element) {
    for (var entry in eq.entries) {
      if (element[entry.key].toString() != entry.value.toString()) {
        return false;
      }
    }
    return true;
  }).toList();
}

void showErrorDialog(BuildContext context, String errorMessage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(errorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

class FetchResult<T> {
  final bool success;
  final String? message;
  final List<T>? data;
  FetchResult({required this.success, this.message, this.data});
}

class SupabaseQueryBuilder {
  static get<T>(
      {required String tablename,
      required BuildContext context,
      required T Function(Map<String, dynamic>) fromJson}) async {
    FetchResult result =
        await SupabaseFetchDataClass.fetchsupaBaseTablesDataLink<T>(tablename,
            fromJson: (e) => fromJson(e));
    if (result.data != null) {
      if (result.data!.isEmpty) {
        return [];
      } else {
        return result.data!.map((e) => e as T).toList();
      }
    }
    return result.message;
  }

  static getEqual<T>(
      {required String tablename,
      required BuildContext context,
      required Map<String, dynamic> eq,
      required T Function(Map<String, dynamic>) fromJson}) async {
    FetchResult result =
        await SupabaseFetchDataClass.fetchsupaBaseTablesDataLink<T>(tablename,
            eq: eq, fromJson: (e) => fromJson(e));
    if (result.data != null) {
      if (result.data!.isEmpty) {
        return [];
      } else {
        return result.data!.map((e) => e as T).toList();
      }
    }
    return result.message;
  }

  static delete<T>(
      {required String tablename,
      required BuildContext context,
      required Map<String, dynamic> eq}) async {
    FetchResult result =
        await SupabaseFetchDataClass.fetchsupaBaseTablesDataLink<T>(tablename,
            delete: true, eq: eq);
    if (result.success == true) {
      return result.success;
    }
    return result.message;
  }

  static update<T>(
      {required String tablename,
      required BuildContext context,
      required Map<String, dynamic> updateValues,
      required Map<String, dynamic> eq}) async {
    FetchResult result =
        await SupabaseFetchDataClass.fetchsupaBaseTablesDataLink<T>(tablename,
            updateValues: updateValues, eq: eq);
    if (result.success == true) {
      return result.success;
    }
    return result.message;
  }
}
