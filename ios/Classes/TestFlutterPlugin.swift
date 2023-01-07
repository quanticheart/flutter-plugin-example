import Flutter
import UIKit

public class TestFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "test_flutter_plugin", binaryMessenger: registrar.messenger())
    let instance = TestFlutterPlugin()
     NSLog("****/ TestFlutterPlugin")
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.addApplicationDelegate(instance)
  }

   private var appUsageApi = AppUsageApi()

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
       switch (call.method) {
              case "getPlatformVersion":
                  result("iOS " + UIDevice.current.systemVersion)
              case "getBatteryLevel":
                  result(UIDevice.current.batteryLevel  * 100)
              case "getUsedApps":
                  result(appUsageApi.usedApps.map { $0.toJson() })
              case "setAppTimeLimit":
                  let arguments = call.arguments as! [String: Any]
                  let id = arguments["id"] as! String
                  let durationInMinutes = arguments["durationInMinutes"] as! Int
                  result(appUsageApi.setTimeLimit(id: id, durationInMinutes: durationInMinutes))
              default:
                  result(FlutterMethodNotImplemented)
          }
    }
  }

struct UsedApp {
    var id: String
    var name: String
    var minutesUsed: Int

    func toJson() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "minutesUsed": minutesUsed
        ]
    }
}

class AppUsageApi {
    var usedApps = [
        UsedApp(id: "com.reddit.app", name: "Reddit", minutesUsed: 75),
        UsedApp(id: "dev.hashnode.app", name: "Hashnode", minutesUsed: 37),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25),
        UsedApp(id: "link.timelog.app", name: "Timelog", minutesUsed: 25)
    ]

    func setTimeLimit(id: String, durationInMinutes: Int) -> String {
        return "Timer of \(durationInMinutes) minutes set for app ID \(id)"
    }
}

extension TestFlutterPlugin {
    public func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        NSLog("****/ didRegisterForRemoteNotificationsWithDeviceToken")
    }

    public func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        NSLog("****/ didReceiveRemoteNotification")
    }

    public func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) -> Bool {
        NSLog("****/ didReceiveRemoteNotification")
        UIDevice.current.isBatteryMonitoringEnabled = true
        return true
    }

    public func applicationDidBecomeActive(_ application: UIApplication) {
        debugPrint("applicationDidBecomeActive")
    }

    public func applicationWillTerminate(_ application: UIApplication) {
        debugPrint("applicationWillTerminate")
    }

    public func applicationWillResignActive(_ application: UIApplication) {
        debugPrint("applicationWillResignActive")
    }

    public func applicationDidEnterBackground(_ application: UIApplication) {
        debugPrint("applicationDidEnterBackground")
    }

    public func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
    }
}
