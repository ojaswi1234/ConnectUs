#!/bin/bash

# Exit on any error
set -e

# 1. Clone the Flutter SDK if it doesn't exist
if [ ! -d "flutter" ]; then
  git clone https://github.com/flutter/flutter.git -b stable
fi

# 2. Add flutter to the path
export PATH="$PATH:`pwd`/flutter/bin"

# 3. Enable web support
flutter config --enable-web

# 4. Create the .env file dynamically in the root directory
# This ensures the compiler finds the asset defined in pubspec.yaml
touch .env

# 5. Inject variables from Vercel's environment settings into the .env file


# New: Inject the Groq API Key
if [ -n "$GROQ_API_KEY" ]; then
  echo "GROQ_API_KEY=$GROQ_API_KEY" >> .env
fi

# 6. Build the project for web
flutter build web --release