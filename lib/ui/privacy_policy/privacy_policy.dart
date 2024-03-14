import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/theme/theme.dart';




class PrivacyPolicy extends ConsumerWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    WebViewController webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadHtmlString(htmlSting);
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy",style: AppTextStyle.w6.copyWith(fontSize: 20.sp),),
      ),
      body: WebViewWidget(controller: webViewController,),
    );
  }
}




var htmlSting = "<p><strong>Privacy Policy</strong></p><p>Thank you for using our food delivery application FoodFly. This Privacy Policy is here to explain to you how we collect, use, disclose, and protect your personal information when you use our App. We take your privacy seriously and are committed to ensuring that your personal information is secure.</p><p><strong>Information We Collect</strong></p><p>When you use our App, we may collect the following types of information:</p><ol><li><p><strong>Personal Information</strong>: This includes your name, email address, phone number, delivery address, and payment information.</p></li><li><p><strong>Usage Information</strong>: We may collect information about how you interact with our App, such as the pages or features you access, the time and date of your visits, and other statistics.</p></li><li><p><strong>Device Information</strong>: We may collect information about the device you use to access our App, including the device type, operating system, unique device identifiers, and mobile network information.</p></li><li><p><strong>Location Information</strong>: With your permission, we may collect information about your precise or approximate location when you use our App to provide location-based services, such as delivery tracking.</p></li><li><p><strong>Cookies and Similar Technologies</strong>: We may use cookies, web beacons, and other tracking technologies to collect information about your activities on our App and to improve your experience.</p></li></ol><p><strong>How We Use Your Information</strong></p><p>We may use the information we collect for the following purposes:</p><ol><li><p><strong>To Provide and Improve Our Services</strong>: We use your information to process orders, facilitate deliveries, and improve the functionality and performance of our App.</p></li><li><p><strong>To Personalize Your Experience</strong>: We may use your information to customize your experience on our App, such as by providing personalized recommendations and promotions.</p></li><li><p><strong>To Communicate with You</strong>: We may use your contact information to send you transactional communications, such as order confirmations and delivery updates, as well as marketing communications, such as promotional offers and newsletters. You can opt out of marketing communications at any time.</p></li><li><p><strong>To Ensure Security</strong>: We may use your information to detect and prevent fraud, unauthorized access, and other security incidents.</p></li><li><p><strong>For Legal Compliance</strong>: We may use your information to comply with applicable laws, regulations, and legal processes.</p></li></ol><p><strong>How We Share Your Information</strong></p><p>We may share your information with the following parties:</p><ol><li><p><strong>Service Providers</strong>: We may share your information with third-party service providers who help us operate our App, process payments, deliver orders, and perform other functions.</p></li><li><p><strong>Business Partners</strong>: We may share your information with our business partners, such as restaurants and delivery drivers, to fulfill your orders and provide you with the services you request.</p></li><li><p><strong>Legal and Regulatory Authorities</strong>: We may share your information with law enforcement, government authorities, or other third parties when required by law or in response to legal process, such as a court order or subpoena.</p></li><li><p><strong>Business Transfers</strong>: If we are involved in a merger, acquisition, financing, or sale of all or a portion of our assets, your information may be transferred as part of that transaction.</p></li></ol><p><strong>Your Choices</strong></p><p>You have certain choices regarding the collection, use, and sharing of your information:</p><ol><li><p><strong>Opt-Out of Marketing Communications</strong>: You can opt out of receiving marketing communications from us by following the instructions provided in the communications or by contacting us directly.</p></li><li><p><strong>Location Information</strong>: You can control whether we collect location information from your device through your device settings. However, disabling location information may limit certain features of our App.</p></li><li><p><strong>Cookies and Tracking Technologies</strong>: You can manage your cookie preferences through your browser settings and opt out of certain tracking technologies as described in our Cookie Policy.</p></li></ol><p><strong>Security Measures</strong></p><p>We take reasonable measures to protect your personal information from unauthorized access, use, or disclosure. However, no method of transmission over the Internet or electronic storage is 100% secure, so we cannot guarantee absolute security.</p><p><strong>Changes to This Privacy Policy</strong></p><p>We may update this Privacy Policy from time to time to reflect changes in our practices or applicable laws. We will notify you of any material changes by posting the updated Privacy Policy on our App or by other means.</p><p><strong>Contact Us</strong></p><p>If you have any questions or concerns about this Privacy Policy or our practices regarding your personal information, please contact us at rathodparth160@gmail.com.</p>";



