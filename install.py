#!/usr/bin/env python3
"""
Ada Voice Assistant Installation Script
Automatically installs all required dependencies and checks system compatibility.
"""

import sys
import subprocess
import platform
import os

def run_command(command, description):
    """Run a command and handle errors gracefully"""
    print(f"\n🔄 {description}...")
    try:
        result = subprocess.run(command, shell=True, capture_output=True, text=True, timeout=300)
        if result.returncode == 0:
            print(f"✅ {description} completed successfully!")
            if result.stdout.strip():
                print(f"   Output: {result.stdout.strip()}")
            return True
        else:
            print(f"❌ {description} failed!")
            print(f"   Error: {result.stderr.strip()}")
            return False
    except subprocess.TimeoutExpired:
        print(f"⏰ {description} timed out (5 minutes)")
        return False
    except Exception as e:
        print(f"❌ {description} failed with exception: {e}")
        return False

def check_python_version():
    """Check if Python version is compatible"""
    print("🐍 Checking Python version...")
    version = sys.version_info
    if version.major == 3 and version.minor >= 8:
        print(f"✅ Python {version.major}.{version.minor}.{version.micro} is compatible!")
        return True
    else:
        print(f"❌ Python {version.major}.{version.minor}.{version.micro} is not supported!")
        print("   Ada requires Python 3.8 or higher.")
        return False

def check_system():
    """Check system compatibility"""
    print(f"\n💻 System Information:")
    print(f"   OS: {platform.system()} {platform.release()}")
    print(f"   Architecture: {platform.machine()}")
    print(f"   Python: {platform.python_version()}")
    
    # Check for Windows-specific audio support
    if platform.system() == "Windows":
        print("✅ Windows detected - audio support should work out of the box")
    elif platform.system() == "Darwin":
        print("✅ macOS detected - make sure your microphone permissions are enabled")
    else:
        print("⚠️  Linux detected - you may need to install additional audio packages")

def install_pytorch():
    """Install PyTorch with CUDA support if available"""
    print("\n🔥 Installing PyTorch...")
    
    # Try to detect CUDA
    try:
        import torch
        if torch.cuda.is_available():
            print("✅ PyTorch already installed with CUDA support!")
            return True
    except ImportError:
        pass
    
    # Install PyTorch (CPU version for compatibility)
    pytorch_cmd = "pip install torch torchaudio --index-url https://download.pytorch.org/whl/cpu"
    
    if run_command(pytorch_cmd, "Installing PyTorch (CPU version)"):
        # Check if installation worked
        try:
            import torch
            print(f"✅ PyTorch {torch.__version__} installed successfully!")
            if torch.cuda.is_available():
                print(f"🚀 CUDA {torch.version.cuda} is available for GPU acceleration!")
            else:
                print("💡 Running on CPU (GPU acceleration not available)")
            return True
        except ImportError:
            print("❌ PyTorch installation verification failed")
            return False
    return False

def install_requirements():
    """Install all requirements from requirements.txt"""
    if not os.path.exists("requirements.txt"):
        print("❌ requirements.txt not found!")
        print("   Make sure you're running this script from the Ada project directory.")
        return False
    
    return run_command("pip install -r requirements.txt", "Installing remaining requirements")

def check_api_keys():
    """Remind user about API keys"""
    print("\n🔑 API Keys Setup:")
    print("   You'll need to add your API keys to the ada_clean.py file:")
    print("   1. OpenAI API Key (for ChatGPT)")
    print("   2. ElevenLabs API Key (for voice synthesis)")
    print("   \n   Edit lines 130 and 134 in ada_clean.py")
    print("   Replace 'YOUR_OPENAI_API_KEY' and 'YOUR_ELEVENLABS_API_KEY'")

def test_imports():
    """Test that all required packages can be imported"""
    print("\n🧪 Testing package imports...")
    
    packages = [
        ("tkinter", "GUI framework"),
        ("torch", "PyTorch"),
        ("RealtimeSTT", "Speech recognition"),
        ("openai", "OpenAI API"),
        ("requests", "HTTP requests"),
        ("pygame", "Audio playback"),
        ("numpy", "Numerical computing")
    ]
    
    failed_imports = []
    
    for package, description in packages:
        try:
            __import__(package)
            print(f"✅ {package} ({description})")
        except ImportError as e:
            print(f"❌ {package} ({description}) - {e}")
            failed_imports.append(package)
    
    if failed_imports:
        print(f"\n❌ Failed to import: {', '.join(failed_imports)}")
        print("   Try running: pip install -r requirements.txt")
        return False
    else:
        print("\n🎉 All packages imported successfully!")
        return True

def main():
    """Main installation process"""
    print("🎤 Ada Voice Assistant Installation")
    print("=" * 50)
    
    # Check Python version
    if not check_python_version():
        sys.exit(1)
    
    # Check system
    check_system()
    
    # Upgrade pip first
    if not run_command("python -m pip install --upgrade pip", "Upgrading pip"):
        print("⚠️  Pip upgrade failed, continuing anyway...")
    
    # Install PyTorch first (it's the largest dependency)
    if not install_pytorch():
        print("❌ PyTorch installation failed. Trying to continue...")
    
    # Install other requirements
    if not install_requirements():
        print("❌ Requirements installation failed!")
        sys.exit(1)
    
    # Test imports
    if not test_imports():
        print("❌ Some packages failed to import!")
        sys.exit(1)
    
    # API keys reminder
    check_api_keys()
    
    print("\n🎉 Installation completed successfully!")
    print("\n🚀 Next steps:")
    print("   1. Add your API keys to ada_clean.py")
    print("   2. Run: python ada_clean.py")
    print("   3. Click 'Start Listening' and say 'Hey Ada'!")
    print("\n💡 Tip: Adjust the timing sliders for optimal performance")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\n\n⏹️  Installation cancelled by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Installation failed with error: {e}")
        sys.exit(1)
