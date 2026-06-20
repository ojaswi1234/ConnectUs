import 'dart:io';
import 'package:ConnectUs/graphql/__generated__/operations.req.gql.dart';
import 'package:ConnectUs/services/ferry_client.dart';
import 'package:ConnectUs/utils/app_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AIPage extends ConsumerStatefulWidget {
  const AIPage({super.key});

  @override
  ConsumerState<AIPage> createState() => _AIPageState();
}

class _AIPageState extends ConsumerState<AIPage> {
  final TextEditingController _textController = TextEditingController();
  String _response = '';
  bool _isLoading = false;

  static const Color primaryColor = AppTheme.accentDark;
  static const Color accentColor = AppTheme.accent;
  static const double borderRadius = 16.0;

  bool get isMobile => !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  /// Sends the prompt to the GraphQL backend, which proxies it to Groq.
  /// The API key lives only on the server — never in the app binary.
  Future<void> _generateResponse(String prompt) async {
    setState(() {
      _isLoading = true;
      _response = '';
    });
    try {
      final client = ref.read(clientProvider);
      final req = GAskAssistantReq((b) => b..vars.prompt = prompt);
      await for (final response in client.request(req)) {
        if (response.data != null) {
          setState(() => _response = response.data!.askAssistant);
          break;
        }
        if (response.hasErrors) {
          setState(() => _response = 'Server error. Please try again.');
          break;
        }
      }
    } catch (e) {
      setState(() => _response = 'Connection error. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _handleSend() {
    if (_textController.text.isNotEmpty && !_isLoading) {
      final prompt = _textController.text;
      _textController.clear();
      setState(() {});
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
          'Connectify',
          style: TextStyle(
            fontFamily: 'EduNSWACTCursive',
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
              onPressed: () => Scaffold.of(context).openDrawer(),
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
              decoration: const BoxDecoration(color: accentColor),
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
              title: const Text('Home',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () => Navigator.pushNamed(context, '/home'),
            ),
            ListTile(
              leading:
                  const Icon(Icons.info_outline_rounded, color: primaryColor),
              title: const Text('About AI',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () => Navigator.pop(context),
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
                  border: Border.all(color: Colors.black12.withAlpha(25)),
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
                hintText: 'Ask Connectify',
                hintStyle: TextStyle(color: Colors.black54.withAlpha(153)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide:
                      const BorderSide(color: accentColor, width: 2.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Colors.black12.withAlpha(25),
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
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _handleSend(),
            ),
          ],
        ),
      ),
    );
  }
}
