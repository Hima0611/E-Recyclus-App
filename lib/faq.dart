import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(EWasteFAQApp());
}

class EWasteFAQApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(), // Apply Google Fonts globally
      ),
      home: FAQScreen(),
    );
  }
}

class FAQScreen extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      "question": "E-Recyclus: About Us",
      "answer":
      "E-Recyclus is a smart and intuitive e-waste recycling app designed to make electronic waste disposal efficient, rewarding, and environmentally friendly. With an integrated AI-powered chatbot, users can get instant guidance on how to recycle their old devices responsibly.\n\n"
          "✅ Smart Chatbot Assistance – Get instant recycling tips and guidance.\n"
          "✅ Streaks & Rewards – Earn points for consistent recycling efforts and redeem exciting rewards.\n"
          "✅ Scratch Card System – Unlock surprise bonuses for your contributions.\n"
          "✅ Eco-Friendly Impact Tracker – See how much e-waste you've diverted from landfills.\n"
          "✅ Nearby E-Waste Collection Centers – Locate authorized recycling facilities with ease.\n\n"
          "E-Recyclus is not just an app—it’s a movement towards a cleaner and greener future. Join us in making e-waste recycling effortless and rewarding! 🌱♻"
    },
    {
      "question": "Meet the Visionaries Behind E-Recyclus",
      "answer":
      "E-Recyclus is the brainchild of three passionate innovators—Himanshi, Ishika, and Vipan —who share a common vision: to revolutionize e-waste recycling through technology and awareness.\n\n"
          "🔹 Himanshi – A sustainability advocate, ensuring that E-Recyclus aligns with eco-friendly practices and impactful solutions.\n"
          "🔹 Ishika – A tech enthusiast with a keen eye for innovation, leading the app's development and user experience.\n"
          "🔹 Vipan – A strategic thinker, driving the app’s vision, outreach, and reward-based engagement model.\n\n"
          "Together, they are on a mission to make e-waste recycling accessible, rewarding, and impactful for a greener tomorrow. Join them in shaping a sustainable future with E-Recyclus! 🌱♻"
    },
    {
      "question": "Impact on Earth with E-Recyclus",
      "answer":
      "🌍 E-Recyclus: Transforming E-Waste, Protecting Our Planet ♻\n\n"
          "E-waste is one of the fastest-growing environmental challenges, polluting our land, water, and air with toxic materials. With E-Recyclus, we are changing the way people dispose of their old electronics—making recycling easy, rewarding, and impactful.\n\n"
          "✅ Reduces Landfill Waste – Keeps harmful e-waste out of landfills, preventing soil and water contamination.\n"
          "✅ Lowers Carbon Footprint – Supports responsible recycling, reducing the need for raw material extraction and energy-intensive production.\n"
          "✅ Promotes Circular Economy – Encourages reuse and proper disposal, extending the life cycle of electronics.\n"
          "✅ Empowers a Greener Future – Rewards eco-conscious actions, inspiring more people to recycle responsibly.\n\n"
          "With every device recycled, we take a step closer to a cleaner, healthier planet. Join us in making a real impact—one gadget at a time! 🌱♻"
    },
    {
      "question": "What is e-waste?",
      "answer":
      "“E-waste refers to discarded electronic devices such as computers, mobile phones, and appliances that are no longer in use.”"
    },
    {
      "question": "Why is e-waste recycling important?",
      "answer":
      "“Recycling e-waste reduces pollution, saves resources, and prevents hazardous materials from harming the environment.”"
    },
    {
      "question": "How can I dispose of my old electronics?",
      "answer":
      "“You can drop them at authorized e-waste collection centers, donate, or use e-waste recycling services.”"
    },
    {
      "question": "Are there any rewards for recycling e-waste?",
      "answer":
      "“Yes! Some programs offer discounts, coupons, or cash incentives for properly recycling old electronics.”"
    },
    {
      "question": "What materials can be recovered from e-waste?",
      "answer":
      "“E-waste contains valuable materials like gold, silver, copper, and plastics that can be reused in new products.”"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Waste FAQs"),
        backgroundColor: Colors.green[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[200]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                color: Colors.white,
                shadowColor: Colors.green[300],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.question_answer, color: Colors.green[700]),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              faqs[index]["question"]!,
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.format_quote, color: Colors.green[500]),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                faqs[index]["answer"]!,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}