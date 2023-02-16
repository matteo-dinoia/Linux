# Installing lnreader

## Installing requirement
### Installing NPM
install nvm by the [https://github.com/nvm-sh/nvm](github page)
restart bash
install npm 15 (by using nvm)
nvm use 15

### Java installation
download and install java 11
set JAVA_HOME to the install directory of java11

### Installing cmdline-tools android
downloading cmdline-tools at [https://developer.android.com/studio/](link)
extract them in <android_location>/sdk/cmdline-tools/latest
exporting ANDROID_SDK_ROOT to <android_location>/sdk

### Accepting licenses (needed for npm run android)
yes | <android_location>/sdk/cmdline-tools/latest/bin/sdkmanager --licenses

## Installing and running application
### Fork and clone
fork repository
git clone https://github.com/<your-account-name>/lnreader.git
cd lnreader

### Installing lnreader and running it
npm install --legacy-peer-deps
npm start
npm run android (on a new console, it will take a while)
