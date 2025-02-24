import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> sendOrderProcessingEmail(String email, String name) async {
  final String url =
      "https://trademydevice.pythonanywhere.com/send-order-processing-email";

  final client = http.Client();
  try {
    final response = await client.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"email": email, "name": name}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data["message"] ?? "Success";
    } else {
      return "Error: ${response.statusCode} - ${response.reasonPhrase}";
    }
  } catch (e) {
    return "Unexpected error: $e";
  } finally {
    client.close();
  }
}
