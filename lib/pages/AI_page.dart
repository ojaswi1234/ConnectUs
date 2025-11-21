import 'dart:io';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
// We use the OpenAI package because Groq's API is OpenAI-compatible
import 'package:langchain_openai/langchain_openai.dart';

class AIPage extends StatefulWidget {
  const AIPage({super.key});

  @override
  State<AIPage> createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> {
  // AI-related state variables
  final TextEditingController _textController = TextEditingController();
  String _response = '';
  bool _isLoading = false;

  // --- IMPORTANT: Store your API key securely! ---
  // Get your free key from https://console.groq.com/keys
  final String? _apiKey = dotenv.env['GROQ_API_KEY'];

  // UI Styling constants
  static const Color primaryColor = AppTheme.accentDark;
  static const Color accentColor = AppTheme.accent;
  static const double borderRadius = 16.0;
  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  // --- LangChain & Groq Integration ---
  Future<void> _generateResponse(String prompt) async {
    // FIXED: This now correctly checks for the placeholder string.
    if (_apiKey == "YOUR_GROQ_API_KEY") {
      setState(() {
        _response =
            "Error: Please add your Groq API Key to the _apiKey variable in lib/pages/AI_page.dart";
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Initialize the ChatOpenAI model, but point it to Groq's API
      final chat = ChatOpenAI(
        apiKey: _apiKey,
        baseUrl: 'https://api.groq.com/openai/v1', // The key change is here
        defaultOptions: const ChatOpenAIOptions(
          // One of the fast models available on Groq
          model: 'openai/gpt-oss-20b',
          temperature: 0.7,
        ),
      );

      // Create a prompt template
      final promptTemplate = PromptTemplate.fromTemplate(
          'You are a chatty chatbot and a part of ConnectUs App, your name is Connectify. Chat Casually as much posible and also help user in his queries. The user has asked: {question}');

      // Create a chain
      final chain = promptTemplate.pipe(chat).pipe(const StringOutputParser());

      // Invoke the chain with a stream for real-time updates
      final stream = chain.stream({'question': prompt});

      // Clear previous response and build new one from stream
      setState(() {
        _response = '';
      });

      await for (final chunk in stream) {
        setState(() {
          _response += chunk;
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      backgroundColor: AppTheme.background,
      // Your existing AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Connectify",
          style: TextStyle(
            fontFamily: "EduNSWACTCursive",
            fontWeight: FontWeight.w900,
            fontSize: isMobile ? 24 : 30,
            color: AppTheme.accentDark,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.view_sidebar_outlined,
                color: AppTheme.accent,
                size: 28,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),

      // Your existing Drawer
      drawer: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: accentColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.person_pin, size: 50, color: Colors.white),
                  const SizedBox(height: 8),
                  Text(
                    'User Menu',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home_rounded, color: primaryColor),
              title: const Text(
                "Home",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.info_outline_rounded, color: primaryColor),
              title: const Text(
                "About AI",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // --- Body with AI Integration ---
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            // --- AI Response Area ---
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(color: Colors.black12.withOpacity(0.1)),
                ),
                child: _buildResponseArea(),
              ),
            ),

            const SizedBox(height: 10),

            // --- Your styled Input Text Field ---
            TextField(
              controller: _textController,
              cursorColor: accentColor,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: "Ask Connectify",
                hintStyle: TextStyle(color: Colors.black54.withOpacity(0.6)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: accentColor,
                    width: 2.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors.black12.withOpacity(0.1),
                    width: 1.0,
                  ),
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 24),
                    onPressed: _isLoading || _textController.text.isEmpty
                        ? null
                        : () => _handleSend(),
                  ),
                ),
                prefixIcon: const Icon(Icons.mic, color: primaryColor),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 20.0),
              ),
              onSubmitted: (value) => _handleSend(),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to trigger response generation
  void _handleSend() {
    if (_textController.text.isNotEmpty && !_isLoading) {
      final prompt = _textController.text;
      _generateResponse(prompt);
    }
  }

  // Helper to build the content of the response area
  Widget _buildResponseArea() {
    if (_isLoading && _response.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: accentColor));
    } else if (_response.isNotEmpty) {
      return SingleChildScrollView(
        child: Text(
          _response,
          style: const TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
      );
    } else {
      // Show the bee image as a placeholder
      return Opacity(
        opacity: 0.5,
        child: Image.asset(
          'assets/images/bee.png',
          fit: BoxFit.contain,
        ),
      );
    }
  }
}
