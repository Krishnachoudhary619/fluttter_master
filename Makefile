format:
	dart format .

android-build-dev:
	fvm flutter build apk --flavor development --target lib/main.dart --dart-define=FLAVOR=development --release

android-build-prod:
	fvm flutter build apk --flavor production --target lib/main.dart --dart-define=FLAVOR=production --release

android-dev-bundle:
	fvm flutter build appbundle --release --flavor development --target lib/main.dart --dart-define=FLAVOR=development --release

build-runner:
	fvm flutter packages pub run build_runner build

generate-icon:
	flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons*

build-runner-delete:
	fvm flutter packages pub run build_runner build --delete-conflicting-outputs
	
build-runner-watch:
	fvm flutter packages pub run build_runner watch --delete-conflicting-outputs

ios-build-prod:
	fvm flutter build ios --flavor production --target lib/main.dart --dart-define=FLAVOR=production --release

ios-ipa-prod:
	fvm flutter build ipa --flavor production --target lib/main.dart --dart-define=FLAVOR=production --release

firebase-dev:
	flutterfire config --out=lib/firebase/firebase_options_dev.dart --ios-bundle-id=com.weq.flutter.master.dev --android-app-id=com.weq.flutter.master.dev
	
firebase-stag:
	flutterfire config --out=lib/firebase/firebase_options_stag.dart --ios-bundle-id=com.weq.flutter.master.stag --android-app-id=com.weq.flutter.master.stag
	
firebase-prod:
	flutterfire config --out=lib/firebase/firebase_options_prod.dart --ios-bundle-id=com.weq.flutter.master --android-app-id=com.weq.flutter.master