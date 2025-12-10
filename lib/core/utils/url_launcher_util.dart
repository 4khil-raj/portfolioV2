import 'package:url_launcher/url_launcher.dart';

/// Utility class for launching URLs and handling external links
class UrlLauncherUtil {
  UrlLauncherUtil._();

  /// Launches a URL in the default browser
  static Future<bool> launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
    return false;
  }

  /// Opens the default email client with the specified email address
  static Future<bool> sendEmail(String email, {String? subject, String? body}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        if (subject != null) 'subject': subject,
        if (body != null) 'body': body,
      },
    );
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  /// Opens the phone dialer with the specified phone number
  static Future<bool> makeCall(String phoneNumber) async {
    final uri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }

  /// Opens WhatsApp with the specified phone number
  static Future<bool> openWhatsApp(String phoneNumber, {String? message}) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    final uri = Uri.parse(
      'https://wa.me/$cleanNumber${message != null ? '?text=${Uri.encodeComponent(message)}' : ''}',
    );
    if (await canLaunchUrl(uri)) {
      return await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    }
    return false;
  }

  /// Opens LinkedIn profile
  static Future<bool> openLinkedIn(String profileUrl) async {
    return launchURL(profileUrl);
  }

  /// Opens GitHub profile
  static Future<bool> openGitHub(String profileUrl) async {
    return launchURL(profileUrl);
  }

  /// Opens LeetCode profile
  static Future<bool> openLeetCode(String profileUrl) async {
    return launchURL(profileUrl);
  }
}
