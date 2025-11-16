import 'package:flutter/material.dart';

class AIPage extends StatefulWidget {
  const AIPage({super.key});

  @override
  State<AIPage> createState() => _AIPageState();
}

class _AIPageState extends State<AIPage> {
  // Define colors and constants for reuse and consistency
  static const Color primaryColor = Color.fromARGB(255, 245, 210, 105);
  static const Color accentColor = Color.fromARGB(255, 207, 168, 79);
  static const Color secondaryBackground = Color.fromARGB(255, 245, 229, 183);
  static const double borderRadius = 16.0;

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive elements if needed later
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        // AppBar Styling
        backgroundColor: Colors.transparent,
        elevation: 0, // Removes the shadow under the AppBar
        title: const Text(
          "Connectify",
          style: TextStyle(
            fontFamily: "EduNSWACTCursive",
            fontWeight: FontWeight.w900, // Make it bolder
            fontSize: 30, // Increase title size
            color: Colors.black87, // Better text color
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.view_sidebar_outlined, // Using a more modern menu icon
                color: Colors.black87,
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
      
      // ---------------------------------
      // Drawer Styling (Sidebar)
      // ---------------------------------
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
            // Custom Drawer Header for visual appeal
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
            
            // Drawer List Tile
            ListTile(
              leading: const Icon(Icons.home_rounded, color: primaryColor),
              title: const Text(
                "Home",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Example of another list item
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
      
      // ---------------------------------
      // Body Content
      // ---------------------------------
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            // AI Banner/Logo Container
            Container(
              height: size.height * 0.5, // Use screen height for better responsiveness
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: secondaryBackground,
                borderRadius: BorderRadius.circular(borderRadius),
                // Optional: Subtle shadow for depth
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), 
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.asset(
                  'assets/images/removebg.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // Input Text Field
            TextField(
              cursorColor: accentColor,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: "Hey There, I am B-127.....",
                hintStyle: TextStyle(color: Colors.black54.withOpacity(0.6)),
                filled: true,
                fillColor: Colors.white,
                
                // Border Styling
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Highly rounded corners
                  borderSide: BorderSide.none, // Remove default border line
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: accentColor, // Highlight color when focused
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
                
                // Add a send button icon inside the input field
                suffixIcon: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: accentColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 24),
                    onPressed: () {
                      // Logic to send message
                    },
                  ),
                ),
                
                // Add leading icon (optional)
                prefixIcon: const Icon(Icons.mic, color: primaryColor),
                contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}