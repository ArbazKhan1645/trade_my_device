// ignore_for_file: deprecated_member_use, avoid_print, use_build_context_synchronously, depend_on_referenced_packages

import 'package:flutter/material.dart';

import '../../main.dart';

class FetchSupabaseRepository {
  static Future fetch<T>(
    String tablename, {
    BuildContext? contexts,
    T Function(Map<String, dynamic>)? fromJson,
    Map<String, dynamic>? eq,
    bool? delete,
    Map<String, dynamic>? updateValues,
  }) async {
    try {
      final builder = supbaseClient.from(tablename).select();
      if (delete == true) {
        await _deleteRecords(tablename, eq, contexts!);
        return [];
      }

      if (updateValues != null) {
        await _updateRecords(tablename, eq, updateValues, contexts!);
        return [];
      }
      if (eq != null) {
        for (var entry in eq.entries) {
          builder.eq(entry.key, entry.value);
        }
      }
      final response = await builder.select();
      List? finalresponse;

      if (fromJson == null) {
        finalresponse = response;
      } else {
        finalresponse = response.map((e) => fromJson(e)).toList();
      }

      return finalresponse;
    } catch (e) {
      String errorMessage = extractErrorMessage(e.toString());
      print(errorMessage);
      return <T>[];
    }
  }

  static Future<void> _deleteRecords(
    String tablename,
    Map<String, dynamic>? eq,
    BuildContext? contexts,
  ) async {
    try {
      final deleteBuilder = supbaseClient.from(tablename).delete();

      if (eq != null) {
        for (var entry in eq.entries) {
          deleteBuilder.eq(entry.key, entry.value);
        }
      }

      await deleteBuilder.select();
    } catch (e) {
      String errorMessage = extractErrorMessage(e.toString());
      if (contexts != null) {
        showErrorDialog(contexts, errorMessage);
      }
    }
  }

  static Future<void> _updateRecords(
    String tablename,
    Map<String, dynamic>? eq,
    Map<String, dynamic> updateValues,
    BuildContext? contexts,
  ) async {
    try {
      final updateBuilder = supbaseClient.from(tablename).update(updateValues);

      if (eq != null) {
        for (var entry in eq.entries) {
          updateBuilder.eq(entry.key, entry.value);
        }
      }

      await updateBuilder.select();
    } catch (e) {
      String errorMessage = extractErrorMessage(e.toString());
      if (contexts != null) {
        showErrorDialog(contexts, errorMessage);
      }
    }
  }
}

String extractErrorMessage(String errorString) {
  int startIndex = errorString.indexOf('message: ') + 'message: '.length;
  int endIndex = errorString.indexOf(', code:');

  String errorMessage = errorString.substring(startIndex, endIndex).trim();

  return errorMessage;
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
