//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<cloud_firestore/FLTFirebaseFirestorePlugin.h>)
#import <cloud_firestore/FLTFirebaseFirestorePlugin.h>
#else
@import cloud_firestore;
#endif

#if __has_include(<file_picker/FilePickerPlugin.h>)
#import <file_picker/FilePickerPlugin.h>
#else
@import file_picker;
#endif

#if __has_include(<firebase_auth/FLTFirebaseAuthPlugin.h>)
#import <firebase_auth/FLTFirebaseAuthPlugin.h>
#else
@import firebase_auth;
#endif

#if __has_include(<firebase_core/FLTFirebaseCorePlugin.h>)
#import <firebase_core/FLTFirebaseCorePlugin.h>
#else
@import firebase_core;
#endif

#if __has_include(<firebase_database/FLTFirebaseDatabasePlugin.h>)
#import <firebase_database/FLTFirebaseDatabasePlugin.h>
#else
@import firebase_database;
#endif

#if __has_include(<firebase_storage/FLTFirebaseStoragePlugin.h>)
#import <firebase_storage/FLTFirebaseStoragePlugin.h>
#else
@import firebase_storage;
#endif

#if __has_include(<flutter_logs/FlutterLogsPlugin.h>)
#import <flutter_logs/FlutterLogsPlugin.h>
#else
@import flutter_logs;
#endif

#if __has_include(<geolocator_apple/GeolocatorPlugin.h>)
#import <geolocator_apple/GeolocatorPlugin.h>
#else
@import geolocator_apple;
#endif

#if __has_include(<google_maps_flutter_ios/FLTGoogleMapsPlugin.h>)
#import <google_maps_flutter_ios/FLTGoogleMapsPlugin.h>
#else
@import google_maps_flutter_ios;
#endif

#if __has_include(<image_picker_ios/FLTImagePickerPlugin.h>)
#import <image_picker_ios/FLTImagePickerPlugin.h>
#else
@import image_picker_ios;
#endif

#if __has_include(<native_device_orientation/NativeDeviceOrientationPlugin.h>)
#import <native_device_orientation/NativeDeviceOrientationPlugin.h>
#else
@import native_device_orientation;
#endif

#if __has_include(<package_info_plus/FPPPackageInfoPlusPlugin.h>)
#import <package_info_plus/FPPPackageInfoPlusPlugin.h>
#else
@import package_info_plus;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<permission_handler_apple/PermissionHandlerPlugin.h>)
#import <permission_handler_apple/PermissionHandlerPlugin.h>
#else
@import permission_handler_apple;
#endif

#if __has_include(<printing/PrintingPlugin.h>)
#import <printing/PrintingPlugin.h>
#else
@import printing;
#endif

#if __has_include(<sqflite/SqflitePlugin.h>)
#import <sqflite/SqflitePlugin.h>
#else
@import sqflite;
#endif

#if __has_include(<url_launcher_ios/URLLauncherPlugin.h>)
#import <url_launcher_ios/URLLauncherPlugin.h>
#else
@import url_launcher_ios;
#endif

#if __has_include(<wakelock_plus/WakelockPlusPlugin.h>)
#import <wakelock_plus/WakelockPlusPlugin.h>
#else
@import wakelock_plus;
#endif

#if __has_include(<zego_callkit/ZegoCallkitPlugin.h>)
#import <zego_callkit/ZegoCallkitPlugin.h>
#else
@import zego_callkit;
#endif

#if __has_include(<zego_express_engine/ZegoExpressEnginePlugin.h>)
#import <zego_express_engine/ZegoExpressEnginePlugin.h>
#else
@import zego_express_engine;
#endif

#if __has_include(<zego_uikit/ZegoUikitPlugin.h>)
#import <zego_uikit/ZegoUikitPlugin.h>
#else
@import zego_uikit;
#endif

#if __has_include(<zego_zpns/ZegoZpnsPlugin.h>)
#import <zego_zpns/ZegoZpnsPlugin.h>
#else
@import zego_zpns;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTFirebaseFirestorePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseFirestorePlugin"]];
  [FilePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FilePickerPlugin"]];
  [FLTFirebaseAuthPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAuthPlugin"]];
  [FLTFirebaseCorePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseCorePlugin"]];
  [FLTFirebaseDatabasePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseDatabasePlugin"]];
  [FLTFirebaseStoragePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseStoragePlugin"]];
  [FlutterLogsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterLogsPlugin"]];
  [GeolocatorPlugin registerWithRegistrar:[registry registrarForPlugin:@"GeolocatorPlugin"]];
  [FLTGoogleMapsPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTGoogleMapsPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [NativeDeviceOrientationPlugin registerWithRegistrar:[registry registrarForPlugin:@"NativeDeviceOrientationPlugin"]];
  [FPPPackageInfoPlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"FPPPackageInfoPlusPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [PrintingPlugin registerWithRegistrar:[registry registrarForPlugin:@"PrintingPlugin"]];
  [SqflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"SqflitePlugin"]];
  [URLLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"URLLauncherPlugin"]];
  [WakelockPlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"WakelockPlusPlugin"]];
  [ZegoCallkitPlugin registerWithRegistrar:[registry registrarForPlugin:@"ZegoCallkitPlugin"]];
  [ZegoExpressEnginePlugin registerWithRegistrar:[registry registrarForPlugin:@"ZegoExpressEnginePlugin"]];
  [ZegoUikitPlugin registerWithRegistrar:[registry registrarForPlugin:@"ZegoUikitPlugin"]];
  [ZegoZpnsPlugin registerWithRegistrar:[registry registrarForPlugin:@"ZegoZpnsPlugin"]];
}

@end
