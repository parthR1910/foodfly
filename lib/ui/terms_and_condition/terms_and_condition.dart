import 'package:food_fly/ui/utils/theme/app_text_style.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/theme/theme.dart';




class TermsAndCondition extends ConsumerWidget {
  const TermsAndCondition({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    WebViewController webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadHtmlString(htmlSting);
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms and Condition",style: AppTextStyle.w6.copyWith(fontSize: 20.sp),),
      ),
      body: WebViewWidget(controller: webViewController,),
    );
  }
}




var htmlSting = "<p><strong>Terms and Conditions</strong></p> <p>Welcome to FoodFly! These Terms and Conditions govern your use of our platform and services. By accessing or using our app, you agree to abide by these terms. Please read them carefully.</p> <p><strong>1. Acceptance of Terms</strong></p> <p>By accessing or using our app, you agree to be bound by these Terms and Conditions, our Privacy Policy, and any additional terms and conditions that may apply to specific features or services. If you do not agree to these terms, please do not use our app.</p> <p><strong>2. Services</strong></p> <p>Our app provides a platform that connects users with restaurants and facilitates food delivery services. We do not provide the food ourselves; rather, we act as an intermediary between users and restaurants.</p> <p><strong>3. User Accounts</strong></p> <p>To use certain features of our app, you may need to create a user account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.</p> <p><strong>4. Ordering and Delivery</strong></p> <p>When you place an order through our app, you are entering into a contract directly with the restaurant. We facilitate the ordering process but do not assume any responsibility for the quality or timeliness of the food delivery.</p> <p><strong>5. Payment</strong></p> <p>Payment for orders placed through our app is processed securely using third-party payment providers. By placing an order, you agree to pay the specified amount for the goods and services received.</p> <p><strong>6. Cancellations and Refunds</strong></p> <p>Orders may be canceled or refunded in accordance with the policies of the individual restaurants. We do not guarantee refunds but will assist users in resolving any issues that may arise.</p> <p><strong>7. User Conduct</strong></p> <p>You agree to use our app in accordance with all applicable laws and regulations. You may not use our app for any unlawful or prohibited purpose, including but not limited to fraud, harassment, or infringement of intellectual property rights.</p> <p><strong>8. Intellectual Property</strong></p> <p>All content and materials on our app, including but not limited to text, graphics, logos, and images, are the property of [Your Food Delivery App] or its licensors and are protected by copyright and other intellectual property laws.</p> <p><strong>9. Limitation of Liability</strong></p> <p>In no event shall [Your Food Delivery App] be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with your use of our app, including but not limited to lost profits, loss of data, or business interruption.</p> <p><strong>10. Modification of Terms</strong></p> <p>We reserve the right to modify these Terms and Conditions at any time without prior notice. By continuing to use our app after any changes are made, you agree to be bound by the revised terms.</p> <p><strong>11. Governing Law</strong></p> <p>These Terms and Conditions shall be governed by and construed in accordance with the laws of [Your Jurisdiction], without regard to its conflict of law provisions.</p> <p><strong>12. Contact Us</strong></p> <p>If you have any questions or concerns about these Terms and Conditions, please contact us at rparth160@gmail.com.</p> <p>By using our app, you agree to these Terms and Conditions. Thank you for choosing FoodFly</p>";



