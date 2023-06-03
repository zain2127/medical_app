import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
        backgroundColor: Colors.black54,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. App Content',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'a. The App provides information related to doctors, medicines, hospitals, clinics, pharmacies, and health-related features, such as heart rate monitoring and exercise guidance for bicep and tricep exercises.',
            ),
            SizedBox(height: 8.0),
            Text(
              'b. The content provided in the App, including doctor information, medicine details, and exercise guidance, is for informational purposes only. It should not be considered as medical advice or a substitute for professional medical consultation. Always consult with a qualified healthcare professional for accurate diagnosis, treatment, or medical advice.',
            ),
            SizedBox(height: 16.0),
            Text(
              '2. User Responsibilities',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'a. You are solely responsible for the decisions and actions you take based on the information provided in the App. The App\'s content does not replace the need for professional medical advice or judgement.',
            ),
            Text(
              'b. If you experience any health-related issues or emergencies, seek immediate medical attention from a qualified healthcare professional or call emergency services.',
            ),
        SizedBox(height: 16.0),
        Text(
          '2. User Responsibilities',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'a. You are solely responsible for the decisions and actions you take based on the information provided in the App. The App\'s content does not replace the need for professional medical advice or judgement.',
        ),
        Text(
          'b. If you experience any health-related issues or emergencies, seek immediate medical attention from a qualified healthcare professional or call emergency services.',
        ),
        SizedBox(height: 16.0),
        Text(
          '3. Privacy and Data Security',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'a. The App may collect and store personal information in accordance with its Privacy Policy. By using the App, you consent to the collection, storage, and use of your personal information as described in the Privacy Policy.',
        ),
        Text(
          'b. The App implements reasonable security measures to protect the confidentiality and integrity of your data. However, no data transmission or storage method can guarantee 100% security. You understand and acknowledge that you provide information at your own risk.',
        ),
        SizedBox(height: 16.0),
        Text(
          '4. Intellectual Property',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'a. The App and its content, including but not limited to text, graphics, logos, images, and software, are protected by intellectual property rights and are the property of the App\'s owner or its licensors.',
        ),
        Text(
          'b. You may not modify, reproduce, distribute, transmit, display, or create derivative works of any portion of the App\'s content without prior written consent from the owner.',
        ),
        SizedBox(height: 16.0),
        Text(
          '5. Limitation of Liability',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'a. The App is provided on an "as-is" basis without any warranties, express or implied. The owner disclaims'
        ),
            Text(
              'b. In no event shall the owner be liable for any direct, indirect, incidental, special, or consequential damages arising out of or in connection with the use or inability to use the App, even if advised of the possibility of such damages.',
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Modifications',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'The owner reserves the right to modify or update this Agreement at any time without prior notice. It is your responsibility to review this Agreement periodically. Continued use of the App after any modifications constitutes your acceptance of the revised Agreement.',
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Governing Law and Jurisdiction',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'This Agreement shall be governed by and construed in accordance with the laws of [Country/Region]. Any legal actions or proceedings arising out of or in connection with this Agreement shall be exclusively brought in the courts located within [Country/Region].',
            ),
          ],
        ),
      ),
    );
  }
}
