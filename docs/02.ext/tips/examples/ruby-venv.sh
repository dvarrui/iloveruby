echo "==> ruby-venv active"

export GEM_HOME=$PWD/.gems
echo "GEM_HOME=$GEM_HOME"

gem install colorize

export GEM_PATH=$GEM_HOME
echo "GEM_PATH=$GEM_PATH"

echo $LOAD_PATH

