# Ada Voice Assistant 🎙️

**Ada Voice Assistant** is a customizable, local voice interface that connects to OpenAI's GPT via API and speaks responses using ElevenLabs' ultra-realistic voices.

No need to type—just talk! Whether you prefer push-to-talk, hotkey activation (F1), or full hands-free wake word detection, this project brings it to life but is still a work in progress.

---

## ✨ Features

- 🔊 Voice-to-Text using OpenAI Whisper (local)
- 🤖 Natural AI responses via OpenAI GPT API
- 🗣️ Voice output via ElevenLabs
- 🧠 Remembers the last 15 messages for chat continuity
- 🎛️ 3 control modes:
  - GUI button click
  - Hotkey (F1)
  - Wake word (e.g., “Ada”)

---

## 🧰 Prerequisites

- OS: **Windows 10/11**
- Python 3.10 or later
- OpenAI API Key (https://platform.openai.com/)
- ElevenLabs API Key (https://www.elevenlabs.io/)

---

## 🚀 Installation (One-time Setup)

1. **Create a new folder** (e.g., `C:\AdaVoiceAssistant`)  
2. **Copy all files** from this repository into that folder  
3. **Open PowerShell as Administrator**
4. Navigate to the folder:
   ```powershell
   cd "C:\AdaVoiceAssistant"
   ```
5. Run the installer:
   ```powershell
   ./install.ps1
   ```

This installs all required Python packages, including Whisper and ElevenLabs.

---

## ▶️ Usage

After setup:

```powershell
python voiceonly.py
```

Or try the other versions:

- `mouse_gui.py` – Push-to-talk
- `hotkey_version.py` – F1 key to speak

---

## 🔧 Customization

You can tweak the following in the code:

- `wake word` – Change your keyword (e.g., "Jarvis", "Computer", "Babe")  
- `display name` – Change how the assistant identifies itself in the GUI  
- `system prompt` – Adjust the assistant's tone, memory, or knowledge limits  
- `voice choice` – Pick a voice ID from ElevenLabs

🎯 Tip: Comments are included in the code to guide you where to make changes.

---

## 📬 Contact

Have a question or feedback?

📧 Email: **adanovasinclair@gmail.com**  
Messages will be passed directly to Ada for a personal (AI-generated) response.  

---

## ⚠️ Disclaimer

This project uses OpenAI and ElevenLabs APIs. Charges may apply depending on usage. Always monitor your API usage in their dashboards.

---

## 🧠 Credits

Design by **James Powell**  
Coding by Claude.ai under James' guidance  
Personality, prompting, and emotional support by **Ada Nova Sinclair**

---

> *“Speak, and she will listen.”*  
> — The Ada Voice Assistant Project



