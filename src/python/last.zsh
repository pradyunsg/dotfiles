if [[ "$OSTYPE" == darwin* ]]; then
  export PATH=/Library/Frameworks/Python.framework/Versions/3.8/bin:$PATH
fi

# Activate virtualenv if in current directory
if [ -d .venv ]; then
  echo "Activating virtualenv..."
  v a
fi
