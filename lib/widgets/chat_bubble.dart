import 'dart:async';

class ChatbotService {
  static Future<String> fetchBotResponse(String userMessage) async {
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    // Normalize input: Convert to lowercase, remove extra spaces, and strip punctuation
    String normalizedMessage =
    userMessage.toLowerCase().trim().replaceAll(RegExp(r'[^\w\s]'), '');

    // Debugging: Print user input to console
    print("User asked: $normalizedMessage");

    // E-Waste Recycling Q&A Responses
    Map<String, String> responses = {
      // General Questions
      "what is ewaste":
      "E-waste (electronic waste) includes discarded electronic devices such as smartphones, laptops, TVs, and batteries that are no longer in use.",
      "why is recycling ewaste important":
      "E-waste contains harmful chemicals that can pollute the environment. Recycling helps recover valuable materials like gold, silver, and copper.",
      "what happens if ewaste is not disposed of properly":
      "Improper disposal can lead to toxic chemicals like lead and mercury contaminating soil and water, harming human health and wildlife.",

      // Accepted & Not Accepted Items
      "what electronic items can i recycle":
      "You can recycle phones, laptops, chargers, batteries, TVs, printers, and more.",
      "can i recycle broken electronics":
      "Yes! Even broken electronics contain valuable materials that can be recovered and reused.",
      "are light bulbs and batteries considered ewaste":
      "Yes, certain types of light bulbs and batteries (like lithium-ion batteries) are e-waste and should be recycled properly.",
      "can i recycle old cds dvds and vhs tapes":
      "Yes, but they need to be taken to special recycling centers.",

      // E-Waste Collection & Process
      "where can i drop off my ewaste":
      "You can drop off e-waste at certified recycling centers, electronic stores, or special e-waste collection events.",
      "how does the recycling process work":
      "E-waste is collected, sorted, dismantled, and valuable materials are recovered. Hazardous substances are safely disposed of.",
      "can i schedule an ewaste pickup":
      "Some recycling centers or city services offer pickup for large electronics like refrigerators or TVs.",
      "what should i do before recycling my phone or laptop":
      "Always back up your data and perform a factory reset to erase personal information.",

      // Reward System & Incentives
      "do i get rewards for recycling ewaste":
      "Yes! With the E-Recyclus app, you earn points for recycling items, which can be redeemed for discounts or rewards.",
      "how many points do i get for recycling a phone":
      "It depends on the phone's condition. Working phones may earn more points than broken ones.",
      "can i donate working electronics instead of recycling them":
      "Yes! Donating old electronics helps extend their life and benefits those in need.",

      // Environmental Impact & Awareness
      "how does ewaste harm the environment":
      "E-waste releases toxic chemicals like mercury, lead, and cadmium, polluting the air, soil, and water.",
      "how does recycling ewaste help the planet":
      "It reduces pollution, saves energy, and conserves raw materials like gold and aluminum.",
      "what materials can be recovered from ewaste":
      "Metals like gold, silver, copper, aluminum, and rare earth elements can be extracted and reused.",
      "how can i encourage others to recycle ewaste":
      "Spread awareness, use recycling apps like E-Recyclus, and participate in local e-waste collection programs.",

      // Small Talk & Common Phrases
      "hello": "Hi there! How can I assist you?",
      "hi": "Hello! How can I help you with e-waste recycling?",
      "bye": "Goodbye! Have a great day!",
      "thank you": "You're welcome! Keep recycling and saving the environment!",
    };

    // Debugging: Check if the message exists in the response map
    if (responses.containsKey(normalizedMessage)) {
      print("Bot found a response: ${responses[normalizedMessage]!}");
      return responses[normalizedMessage]!;
    } else {
      print("Bot did not find a match for: $normalizedMessage");
      return "I'm not sure how to respond to that. Try asking about e-waste recycling, such as 'What is e-waste?'";
    }
  }
}