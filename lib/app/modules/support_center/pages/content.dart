// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webuywesell/app/core/utils/thems/theme.dart';

class SupportSection extends StatefulWidget {
  const SupportSection({super.key});

  @override
  State<SupportSection> createState() => _SupportSectionState();
}

class _SupportSectionState extends State<SupportSection> {
  String selectedCategory = 'Other';
  String selectedSubOption = '';

  @override
  void initState() {
    fetchListArguements();
    super.initState();
  }

  fetchListArguements() {
    if (Get.arguments == null) {
      selectedCategory = '';
      print(selectedCategory);
      return;
    }
    String? phones = Get.arguments?['option'] as String?;
    if (phones == null) {
      selectedCategory = '';
      print(selectedCategory);
      return;
    }

    setState(() {
      selectedCategory = phones;
    });
    print(selectedCategory);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double getPadding(double width) {
        if (width >= 1200) {
          return 250.0; // Large screen
        } else if (width >= 800) {
          return 150.0; // Medium screen
        } else {
          return 20.0; // Small screen
        }
      }

      double padding = getPadding(constraints.maxWidth);
      return Column(
        children: [
          SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(color: Colors.white),
            height: 90,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: selectedCategory == ''
                              ? 'Others'
                              : categories[selectedCategory]?[0]['title'] ??
                                  'Others',
                          style: defaultTextStyle.copyWith(
                              fontSize: 22, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: Container(
              color: Colors.white,
              child: ListView.separated(
                separatorBuilder: (con, index) {
                  return Container(height: 2, color: Colors.grey.shade300);
                },
                shrinkWrap: true,
                itemCount: selectedCategory == ''
                    ? getCategories().length
                    : categories[selectedCategory]?.length ?? 0,
                itemBuilder: (context, index) {
                  final item = selectedCategory == ''
                      ? getCategories()[index]
                      : categories[selectedCategory]![index];
                  return selectedCategory == ''
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              selectedCategory = item;
                            });
                          },
                          child: Card(
                            elevation: 0,
                            margin: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.toString(),
                                  style: TextStyle(color: Colors.black),
                                ),
                                Icon(Icons.arrow_forward_ios)
                              ],
                            ),
                          ),
                        )
                      : InkWell(
                          child: Card(
                            elevation: 0,
                            margin: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['content']
                                      .toString()
                                      .replaceAll('*', ''),
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
        ],
      );
    });
  }
}

List getCategories() {
  return categories.keys.toList();
}

// Demo data structure
final Map<String, List<Map<String, String>>> categories = {
  'GDPR Policy': [
    {
      'title': 'GDPR Policy',
      'content': '''GDPR Policy Page

Last Updated: 17th Feb 2025

At Trade My Device, we are committed to protecting your privacy and ensuring that your personal data is handled in a safe and responsible manner. This GDPR Policy explains how we collect, use, store, and protect your personal data in accordance with the General Data Protection Regulation (GDPR). It outlines your rights and how you can exercise them.

1. Who We Are
Trade My Device is a company that provides a platform for users to trade in their old devices in exchange for payment or store credit. Our registered office is located at [Insert Company Address], and our contact email is [Insert Contact Email].

2. Personal Data We Collect
In order to provide our services, we may collect and process the following personal data:

- Contact Information: Name, email address, phone number, and mailing address.
- Device Information: Information about the device you are trading in, such as make, model, serial number, condition, and other relevant details.
- Payment Information: Financial details such as PayPal account information, bank details, or other payment methods for processing payments.
- Usage Data: Information about how you use our website, including IP address, browser type, and interactions with our site.

3. How We Use Your Personal Data
We collect and use your personal data for the following purposes:

- To Provide Services: To process your trade-in requests, evaluate your devices, issue payment, and communicate with you regarding your transaction.
- To Improve Our Services: To analyze user behavior on our website to improve functionality, enhance user experience, and fix any issues that may arise.
- To Communicate with You: To send transactional emails about your device trade-in, including confirmations, updates, and responses to any inquiries you may have.
- To Comply with Legal Obligations: We may use your personal data to comply with applicable laws, regulations, or legal processes.

4. Lawful Basis for Processing Personal Data
Under the GDPR, we rely on the following lawful bases to process your personal data:

- Consent: We collect and process your personal data with your explicit consent when you use our services, sign up for our newsletter, or agree to our terms.
- Contractual Necessity: We process your data to fulfill our contractual obligations with you when you trade in a device and complete a transaction.
- Legal Obligation: We may process your personal data when required to do so to comply with legal obligations (e.g., record-keeping or responding to legal requests).
- Legitimate Interests: We may process your personal data for purposes such as improving our services and ensuring website security, provided that these interests do not override your rights and freedoms.

5. How We Protect Your Personal Data
We take the protection of your personal data seriously and implement a variety of technical and organizational measures to safeguard it. These measures include:

- Encryption: We use encryption technologies (e.g., SSL) to protect your personal data during transmission.
- Access Control: We restrict access to personal data to authorized personnel only, and we use secure systems to store data.
- Regular Audits: We conduct regular security audits to ensure that our systems and processes are compliant with privacy standards.

6. Sharing Your Personal Data
We do not sell or rent your personal data to third parties. However, we may share your data with the following entities:

- Service Providers: We may share your data with trusted third-party vendors who assist us in running our business, such as payment processors, shipping partners, and analytics providers.
- Legal Compliance: We may disclose your data if required by law, legal process, or government request, or to protect our rights or the rights of others.

7. Your Data Protection Rights Under GDPR
As a data subject, you have the following rights under the GDPR:

- Right of Access: You have the right to request access to your personal data that we hold.
- Right to Rectification: You have the right to request corrections to any inaccurate or incomplete personal data we hold about you.
- Right to Erasure (Right to be Forgotten): You have the right to request that we delete your personal data, subject to certain conditions and exceptions.
- Right to Restrict Processing: You have the right to request that we restrict the processing of your personal data under certain circumstances.
- Right to Data Portability: You have the right to request that we provide your personal data in a structured, commonly used, and machine-readable format for transfer to another service provider.
- Right to Object: You have the right to object to the processing of your personal data, including for direct marketing purposes.
- Right to Withdraw Consent: If we rely on consent for processing your data, you have the right to withdraw that consent at any time.
- Right to Lodge a Complaint: If you believe that we have not handled your personal data in accordance with GDPR, you have the right to lodge a complaint with a supervisory authority.

8. Data Retention
We will only retain your personal data for as long as necessary to fulfill the purposes for which it was collected, including any legal or reporting obligations.

9. International Transfers of Data
If you are located in the European Economic Area (EEA), please note that some of our third-party service providers may be located outside the EEA. We will ensure that any international transfers of personal data are conducted in compliance with GDPR requirements.

10. Changes to This GDPR Policy
We may update this GDPR Policy from time to time to reflect changes in our practices, legal requirements, or other operational needs.

11. Contact Us
If you have any questions, concerns, or requests regarding this GDPR Policy or the handling of your personal data, please contact us at:

Trade My Device
Email: info@trademydevice.co.uk
  ''',
    },
  ],
  'Terms & Conditions': [
    {
      'title': 'Terms & Conditions',
      'content': '''Last Updated: 17th Feb 2025

Welcome to Trade My Device! By using our website and services, you agree to the following terms and conditions. Please read them carefully before proceeding.

1. **Acceptance of Terms**
By accessing or using Trade My Device’s services, including our website and any related services (collectively referred to as "the Service"), you agree to comply with these Terms and Conditions. If you do not agree with these terms, please do not use our services.

2. **Eligibility**
You must be at least 18 years old to use the Service. If you are under the age of 18, you may use the Service only with the consent of a parent or legal guardian. By using our service, you represent and warrant that you meet the age requirements and have the legal authority to enter into a binding agreement.

3. **Device Trade-In Process**
- **Eligibility of Devices:** You can trade in eligible devices such as smartphones, tablets, laptops, and other electronics. You must provide accurate details about the condition and specifications of the device you wish to trade in.
- **Device Evaluation:** Once we receive your device, it will be evaluated based on its condition. If there is a discrepancy between the condition you reported and what we find upon evaluation, we reserve the right to adjust the trade-in value accordingly.
- **Payment:** After we receive and evaluate your device, we will process your payment. Payment methods include PayPal, bank transfer, or store credit, depending on your selection. Payment will be made within a reasonable period, usually within 5-10 business days.
- **Device Shipping:** We provide a pre-paid shipping label for you to send your device to us. You are responsible for ensuring the device is securely packaged to prevent damage during shipment. We are not responsible for lost or damaged packages unless the shipping label was provided by us.

4. **Pricing & Quotes**
- **Instant Quotes:** The quote provided on our website is an estimate based on the information you provide about your device. The actual value of your device may vary once it is evaluated in person.
- **Adjustments:** If the condition of the device is not as described (e.g., damage, missing parts, or non-functional), we may revise the quote. You will have the option to accept the revised offer or request the return of the device.

5. **Shipping & Returns**
- **Shipping Costs:** We provide a prepaid shipping label for you to send your device to us. You are responsible for ensuring your device is adequately packaged to avoid shipping damage.
- **Device Returns:** If you are not satisfied with our offer after evaluation or if we are unable to accept your device, we will return the device to you at no additional cost.

6. **Ownership & Title**
- **Ownership Transfer:** By submitting your device to us, you represent that you are the rightful owner of the device and have the legal authority to transfer ownership. You also agree to remove all personal data and information from the device before sending it to us.
- **Data Removal:** Trade My Device is not responsible for any data remaining on the device. We recommend you back up your data and wipe all personal information from your device before sending it to us. We are not liable for any loss of data, photos, or information on the device.

7. **Privacy Policy**
Your use of the Service is also governed by our [Privacy Policy], which describes how we collect, use, and protect your personal information. Please review our Privacy Policy to understand our practices regarding your data.

8. **Prohibited Items**
You agree not to submit any of the following types of items:
- Stolen or illegally obtained devices
- Devices containing hazardous materials or items prohibited by law
- Devices that are counterfeit or replicas
- Devices with missing or altered serial numbers
If we determine that the device you submitted is prohibited or violates any laws, we may report it to the appropriate authorities, and you may be subject to legal action.

9. **Limitation of Liability**
To the fullest extent permitted by law, Trade My Device is not liable for any loss or damage arising from your use of our services, including but not limited to loss of data, device damage during shipping, or delays in processing payments. Our liability is limited to the amount of the trade-in value offered for the device.

10. **Indemnification**
You agree to indemnify and hold Trade My Device, its affiliates, employees, officers, and agents harmless from any claims, liabilities, damages, losses, or expenses (including legal fees) arising out of your use of the Service, your violation of these Terms, or your violation of any rights of any third party.

11. **Modifications to Terms**
We reserve the right to modify or update these Terms and Conditions at any time. Any changes will be posted on this page, and the revised terms will be effective as of the date of posting. Your continued use of the Service after such changes constitutes your acceptance of the updated Terms and Conditions.

12. **Termination**
We may suspend or terminate your access to the Service at any time, with or without cause, including if we believe you have violated these Terms. Upon termination, you must stop using the Service and return any devices that are in your possession if required.

13. **Governing Law**
These Terms and Conditions are governed by and construed in accordance with the laws of [your state/country], without regard to its conflict of law principles. Any disputes arising under these Terms shall be resolved exclusively in the courts located in [location].

14. **Dispute Resolution**
If a dispute arises between you and Trade My Device, we encourage you to contact us directly to resolve the issue. If the dispute cannot be resolved informally, it will be subject to arbitration or mediation in accordance with the applicable laws in your jurisdiction.

15. **Contact Us**
If you have any questions regarding these Terms and Conditions, please contact us at:

**Trade My Device**
Email: info@trademydevice.co.uk
  ''',
    },
  ],
  'Privacy Policy': [
    {
      'title': 'Privacy Policy',
      'content': "Last Updated: 17th Feb 2025\n\n"
          "At Trade My Device, we value and respect your privacy. This Privacy Policy explains how we collect, use, protect, and share your personal information when you use our website and services. By using our website or services, you agree to the collection and use of information as described in this policy.\n\n"
          "1. Information We Collect\n"
          "We collect personal information that you provide to us directly when using our services, including but not limited to:\n\n"
          "- Personal Identifiable Information (PII): This includes your name, email address, phone number, mailing address, and payment details.\n"
          "- Device Information: When you trade in a device, we may collect information about the device, such as its make, model, condition, and any additional details that you provide.\n"
          "- Payment Information: If you opt for payment via bank transfer, PayPal, or other methods, we may collect financial data necessary for processing payments.\n\n"
          "We also collect information automatically when you visit our website, including:\n\n"
          "- Log Data: This includes your IP address, browser type, device type, referring/exit pages, and timestamps of your interactions with our site.\n"
          "- Cookies: We use cookies and similar tracking technologies to enhance your experience on our website. Cookies help us analyze trends, track user movements around the site, and gather demographic information.\n\n"
          "2. How We Use Your Information\n"
          "We use the personal information we collect for the following purposes:\n\n"
          "- To process your device trade-ins: We use your contact and device information to provide you with a quote, process your device trade-in, and issue payment.\n"
          "- To communicate with you: We may use your contact details to send you important information related to your trade-in, such as updates on the status of your device or changes to our terms and conditions.\n"
          "- To improve our services: We use information about how you interact with our website and services to improve functionality, fix bugs, and enhance your overall experience.\n"
          "- To fulfill legal obligations: We may use your information to comply with applicable laws, regulations, or legal processes.\n\n"
          "3. How We Protect Your Information\n"
          "We are committed to ensuring that your information is secure. We implement a variety of security measures to maintain the safety of your personal information, including:\n\n"
          "- Encryption: Sensitive information (like payment details) is transmitted via Secure Socket Layer (SSL) technology and encrypted into our payment gateway provider's database.\n"
          "- Access Controls: Only authorized personnel have access to your personal data, and we restrict access based on necessity.\n"
          "- Data Storage: We store your personal data in secure environments and take steps to safeguard it against unauthorized access, alteration, or destruction.\n\n"
          "4. Sharing Your Information\n"
          "We do not sell, trade, or rent your personal information to third parties. However, we may share your information in the following circumstances:\n\n"
          "- Service Providers: We may share your information with third-party vendors, partners, or service providers who help us with our operations, such as payment processing, device evaluation, shipping, and website analytics.\n"
          "- Legal Requirements: We may disclose your information if required to do so by law, subpoena, or other legal processes, or in the good faith belief that such action is necessary to comply with legal obligations or protect our rights.\n"
          "- Business Transfers: In the event of a merger, acquisition, or sale of assets, your personal information may be transferred as part of the transaction. We will notify you of such a transfer and offer you the option to opt out if applicable.\n\n"
          "5. Cookies and Tracking Technologies\n"
          "We use cookies and other tracking technologies to improve your experience with our website. Cookies help us understand how visitors interact with our site and provide a better user experience.\n\n"
          "6. Third-Party Links\n"
          "Our website may contain links to third-party websites or services that are not operated by us. We are not responsible for the privacy practices or content of such third-party sites. We encourage you to review their privacy policies before providing any personal information.\n\n"
          "7. Your Rights and Choices\n"
          "Depending on your location and applicable laws, you may have the following rights regarding your personal information:\n\n"
          "- Access, Correction, Deletion, Opt-Out, and Data Portability. To exercise any of these rights, please contact us.\n\n"
          "8. Children’s Privacy\n"
          "Our services are not intended for individuals under the age of 13, and we do not knowingly collect personal information from children.\n\n"
          "9. Changes to This Privacy Policy\n"
          "We may update our Privacy Policy from time to time. When we make changes, we will update the 'Last Updated' date at the top of this page.\n\n"
          "10. Contact Us\n"
          "If you have any questions, concerns, or requests regarding this Privacy Policy, please contact us at:\n\n"
          "Trade My Device\nEmail: info@trademydevice.co.uk"
    }
  ],
  'Cookies Policy': [
    {
      'title': 'Cookies Policy',
      'content': '''
Cookies Policy

Last Updated: 17th Feb 2025

At Trade My Device, we respect your privacy and are committed to providing transparency about how we use cookies and other tracking technologies to enhance your experience while using our services. This Cookies Policy explains what cookies are, how we use them, and your rights regarding them.

1. What Are Cookies?

Cookies are small text files placed on your device (such as a computer, smartphone, or tablet) when you visit a website or use an app. These cookies allow us to recognize your device and collect information about your interactions with our website or app, enabling us to improve your user experience.

2. Types of Cookies We Use

We use both **first-party** and **third-party** cookies. Here's a breakdown of the different types of cookies we use:

- **Essential Cookies**: These cookies are necessary for the operation of our website or app and enable basic features like navigation, user authentication, and transaction processing. Without these cookies, the services you request cannot be provided.

- **Performance Cookies**: These cookies collect information about how users interact with our website or app. They help us improve the performance and functionality of our services by understanding how users engage with the content.

- **Functional Cookies**: These cookies allow us to remember your preferences, such as language settings or login credentials, to provide a personalized experience during subsequent visits.

- **Advertising and Targeting Cookies**: These cookies are used to deliver ads that are relevant to you and your interests. They help track your online activity and can limit the number of times you see an ad. They also help measure the effectiveness of ad campaigns.

- **Analytics Cookies**: These cookies collect anonymized data about website usage, such as the number of visitors and the pages they visit. We use analytics cookies to help us analyze trends, track user activity, and improve our services.

3. How We Use Cookies

We use cookies to improve your experience by:

- Personalizing content and ads based on your preferences.
- Analyzing how you interact with our website or app to enhance its performance.
- Enabling secure logins and maintaining your session on our platform.
- Providing you with relevant advertising and promotional content.
- Enhancing the functionality and usability of our website or app.

4. Third-Party Cookies

In some cases, we may allow third-party service providers (such as advertising networks, analytics services, or payment processors) to place cookies on our website or app. These third parties may collect information about your online activity across different websites and services. We do not control the use of these cookies, and their privacy practices are governed by the respective third parties’ privacy policies.

5. Managing Cookies

You have the right to control and manage cookies. You can disable or delete cookies through your browser settings. Most web browsers allow you to accept or reject cookies and delete cookies that have been placed on your device. However, please note that disabling cookies may affect your experience on our website or app and may prevent certain functionalities from working properly.


6. Your Consent

By continuing to use our website or app, you consent to our use of cookies as outlined in this policy. You can withdraw your consent or adjust your cookie preferences at any time by modifying your browser settings or using the options provided by our cookie consent banner (if applicable).

7. Changes to This Cookies Policy

We may update this Cookies Policy from time to time to reflect changes in our practices, legal requirements, or other operational needs. Any updates will be posted on this page with a revised "Last Updated" date. Please check this page regularly to stay informed about how we use cookies.

8. Contact Us

If you have any questions or concerns about our use of cookies or this policy, please contact us at:

Trade My Device
Email: info@trademydevice.co.uk
'''
    }
  ],
};
