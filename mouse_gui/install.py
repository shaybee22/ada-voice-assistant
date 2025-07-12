import subprocess
import sys
import os

def install_requirements():
    print("Installing Python dependencies...")
    subprocess.check_call([sys.executable, "-m", "pip", "install", "--upgrade", "pip"])
    subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])

def create_app_directory():
    print("Creating ada_mouse_only directory...")
    if not os.path.exists("ada_mouse_only"):
        os.makedirs("ada_mouse_only")

    print("Moving files to ada_mouse_only directory...")
    for file in os.listdir():
        if file.endswith(".py") or file.endswith(".txt"):
            if file != "install.py":
                os.rename(file, os.path.join("ada_mouse_only", file))

def main():
    install_requirements()
    create_app_directory()
    print("\n✅ Installation complete!")
    print("➡️  To start the app, navigate into the 'ada_mouse_only' folder and run your Python script:")
    print("   cd ada_mouse_only")
    print("   python mouse_gui.py")

if __name__ == "__main__":
    main()
