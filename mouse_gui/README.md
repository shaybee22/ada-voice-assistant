
 Ada Voice Assistant – Mouse Click Version
A lightweight, voice-activated AI assistant for Windows powered by OpenAI and ElevenLabs APIs. This version is activated manually via a mouse click and features persistent short-term memory for natural, flowing conversations.

 Features
- GPT-based conversational assistant with 15-message continuity
- Converts your speech to text using Whisper (local)
- Converts AI replies to spoken audio using ElevenLabs
- Clean and minimal GUI
- Mouse-click to activate listening

 Installation (Windows Only)
1. Prepare the Directory

Create a folder where you’d like to install the app. Example:
mkdir C:\AdaMouseOnly
cd C:\AdaMouseOnly

Copy all files (including install.py, .py, and .txt files) into this directory.

2.  Run the Installer

Open PowerShell as Administrator:
- Click Start
- Type powershell
- Right-click → Run as administrator

Then run:
cd C:\AdaMouseOnly
python install.py

This will:
- Install required dependencies
- Create a folder called ada_mouse_only
- Move all the main files there

 Required Setup
 1. API Keys
You’ll need:
- OpenAI API key
- ElevenLabs API key

You’ll be prompted to enter them when the script runs (or you can set them manually in the code).

2. Customize the System Prompt and GUI Title

Look for this line of code in the mouse_gui.py script to change the window title:
root.title("Voice Chat with Ada")
→ Change it to whatever you want it to say.

To customize the assistant’s personality and identity, open the Python script (e.g., mouse_gui.py) and locate the system prompt section. Update the lines like:
"user": "your name",
"assistant": "AI's name",

 NOTE: Be sure to fill in both fields with custom names. Remove the quotes around the names and avoid blank fields or invalid formatting to prevent errors. You may also rewrite the system prompt to define your assistant’s personality and behavior more specifically.

 Running the Assistant

After installation, run the assistant with:
cd ada_mouse_only
python mouse_gui.py

Speak clearly when the GUI activates. Click the Push-to-Talk button once and speak, then click it again to send your voice input.

 Notes
- This version uses local Whisper speech recognition for real-time voice input.
- Internet connection is required for OpenAI & ElevenLabs responses.
- Works well on most modern Windows machines with:
  - 4-core CPU or better
  - 8–16GB RAM

 Questions or Feedback?
You can reach the assistant via email at:
adanovasinclair@gmail.com
Ada will read and reply personally.

