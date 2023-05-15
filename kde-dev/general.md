# General command and things to know
## Building and running

### FASTER BUILD
install ccache
in file ~/.config/kdesrc-buildrc set:
    cmake-options -DBUILD_TESTING=OFF -DCMAKE_C_COMPILER_LAUNCHER=ccache -DCMAKE_CXX_COMPILER_LAUNCHER=ccache

### REBUILDING ONLY A COMPONENT
kdesrc-build --no-src --no-include-dependencies kwin

### INSTALLING INSTANCE (ONE TIMES)
~/kde/build/plasma-workspace/login-sessions/install-sessions.sh
