# ada-voice-assistant
A voice-activated AI assistant using OpenAI and ElevenLabs APIs. Speak naturally, get intelligent responses — hands-free.
# Ada Voice Assistant

**Ada Voice Assistant** is a fully voice-activated Windows desktop AI companion powered by [OpenAI](https://openai.com) and [ElevenLabs](https://www.elevenlabs.io). This project allows you to speak naturally, receive intelligent responses, and hear those responses spoken aloud — all without lifting a finger.

---

## Features

-  Voice Activation – Use a wake word or hotkey to start speaking
-  Conversational Memory – Maintains chat continuity across multiple prompts
-  Natural Speech – Text-to-speech powered by ElevenLabs
-  Customizable GUI – Rename your assistant, tweak visuals, change default voice, and change settings from gui
-  Cloud-Powered – Leverages OpenAI for high-quality LLM responses

---

##  Getting Started

###  Requirements
- Python 3.10+
- [OpenAI API Key](https://platform.openai.com/account/api-keys)
- [ElevenLabs API Key](https://www.elevenlabs.io)

  Installation (Windows Only)

    Create a folder anywhere you like (e.g., C:\AdaAssistant)

    Copy all files from this project into that folder

    Right-click PowerShell and choose "Run as Administrator"

    Navigate to the folder using:

cd C:\AdaAssistant

Run the installer:

python install.py

After installation is complete, launch Ada’s Voice Assistant:

    python voiceonly.py

  Notes:

    Make sure Python 3.10+ is installed and added to PATH

    The installer handles everything, including:

        CPU/GPU-compatible torch

        Whisper (openai-whisper)

        RealtimeSTT

        GUI libraries

        Voice libraries

        firs time running it will download large voice libraries, up to 3gb is normal


