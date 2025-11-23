import 'dart:io';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';

class AIPage extends StatefulWidget {
  const AIPage({super.key});

  @override
  State<AIPage> createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> {
  final TextEditingController _textController = TextEditingController();
  String _response = '';
  bool _isLoading = false;

  // Get API key from environment
  String? _apiKey = dotenv.env['GROQ_API_KEY'];

  static const Color primaryColor = AppTheme.accentDark;
  static const Color accentColor = AppTheme.accent;
  static const double borderRadius = 16.0;

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  Future<void> _generateResponse(String prompt) async {
    // Check if API key exists and is valid
    if (_apiKey == null || _apiKey!.isEmpty || _apiKey == "YOUR_GROQ_API_KEY") {
      setState(() {
        _response = "Error: Please add your Groq API Key to the .env file.\n\n"
            "Steps:\n"
            "1. Create a .env file in your project root\n"
            "2. Add: GROQ_API_KEY=your_actual_key_here\n"
            "3. Get your key from https://console.groq.com/keys";
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _response = '';
    });

    try {
      final chat = ChatOpenAI(
        apiKey: _apiKey!,
        baseUrl: 'https://api.groq.com/openai/v1',
        defaultOptions: const ChatOpenAIOptions(
          model: 'llama-3.3-70b-versatile', // Updated to a valid Groq model
          temperature: 0.7,
        ),
      );

      final promptTemplate = PromptTemplate.fromTemplate(
        'You are a chatty chatbot and a part of ConnectUs App, your name is Connectify. '
        'Chat casually as much as possible and also help user in their queries. '
        'The user has asked: {question}'
      );

      final chain = promptTemplate.pipe(chat).pipe(const StringOutputParser());
      final stream = chain.stream({'question': prompt});

      await for (final chunk in stream) {
        setState(() {
          _response += chunk;
        });
      }
    } catch (e) {
      setState(() {
        _response = 'Too bad !!! \n Server Error';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleSend() {
    if (_textController.text.isNotEmpty && !_isLoading) {
      final prompt = _textController.text;
      _textController.clear(); // Clear input after sending
      _generateResponse(prompt);
    }
  }

  Widget _buildResponseArea() {
    if (_isLoading && _response.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: accentColor),
      );
    } else if (_response.isNotEmpty) {
      return SingleChildScrollView(
        child: SelectableText(
          _response,
          style: const TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
      );
    } else {
      return Opacity(
        opacity: 0.5,
        child: Image.asset(
          'assets/images/bee.png',
          fit: BoxFit.contain,
        ),
      );
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
              leading: const Icon(Icons.info_outline_rounded, color: primaryColor),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
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
                        : _handleSend,
                  ),
                ),
                prefixIcon: const Icon(Icons.mic, color: primaryColor),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 20.0,
                ),
              ),
              onSubmitted: (_) => _handleSend(),
            ),
          ],
        ),
      ),
    );
  }
}