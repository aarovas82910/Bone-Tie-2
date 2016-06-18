/*
The MIT License (MIT)

Copyright (c) 2015 AhmetKeskin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
import AVKit

class LocalNotificationHelper: NSObject {
    
    let LOCAL_NOTIFICATION_CATEGORY : String = "LocalNotificationCategory"
    
    // MARK: - Shared Instance
    
    class func sharedInstance() -> LocalNotificationHelper {
        struct Singleton {
            static var sharedInstance = LocalNotificationHelper()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: - Schedule Notification
    
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, CalendarUnit: NSCalendarUnit) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        notification.soundName = "Dog Bark.mp3"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, soundName: String, CalendarUnit: NSCalendarUnit) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        notification.soundName = soundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, theDog: dog, CalendarUnit: NSCalendarUnit) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        if let sound = theDog.sound {
            notification.soundName = String(sound)
        } else {
            notification.soundName = UILocalNotificationDefaultSoundName
        }
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, dates: [NSDate]) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        notification.soundName = "Dog Bark.mp3"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, soundName: String, dates: [NSDate]) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        notification.soundName = soundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, theDog: dog, dates: [NSDate]) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        if let sound = theDog.sound {
            notification.soundName = String(sound)
        } else {
            notification.soundName = UILocalNotificationDefaultSoundName
        }
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        for reminderDate in dates {
            let FutureDate = NSDate(timeIntervalSinceNow: reminderDate.timeIntervalSinceNow)
            let FutureNotification = notificationWithTitle(key, title: title, message: message, date: FutureDate, userInfo: userInfo, soundName: nil, hasAction: true)
            FutureNotification.category = LOCAL_NOTIFICATION_CATEGORY
            if let sound = theDog.sound {
                FutureNotification.soundName = String(sound)
            } else {
                FutureNotification.soundName = UILocalNotificationDefaultSoundName
            }
            UIApplication.sharedApplication().scheduleLocalNotification(FutureNotification)
        }
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, Weekdays: [String]) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        notification.soundName = "Dog Bark.mp3"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, soundName: String, Weekdays: [String]) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        notification.soundName = soundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, theDog: dog, Weekdays: [String]) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        if let sound = theDog.sound {
            notification.soundName = String(sound)
        } else {
            notification.soundName = UILocalNotificationDefaultSoundName
        }
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        notification.soundName = "Dog Bark.mp3"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, soundName: String) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        notification.soundName = soundName
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, userInfo: [NSObject: AnyObject]?, theDog: dog) {
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: userInfo, soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        if let sound = theDog.sound {
            notification.soundName = String(sound)
        } else {
            notification.soundName = UILocalNotificationDefaultSoundName
        }
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    func scheduleNotificationWithKey(key: String, title: String, message: String, date: NSDate, userInfo: [NSObject: AnyObject]?){
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: ["key": key], soundName: nil, hasAction: true)
        notification.category = LOCAL_NOTIFICATION_CATEGORY
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func scheduleNotificationWithKey(key: String, title: String, message: String, seconds: Double, soundName: String, userInfo: [NSObject: AnyObject]?){
        let date = NSDate(timeIntervalSinceNow: NSTimeInterval(seconds))
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: ["key": key], soundName: soundName, hasAction: true)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func scheduleNotificationWithKey(key: String, title: String, message: String, date: NSDate, soundName: String, userInfo: [NSObject: AnyObject]?){
        let notification = notificationWithTitle(key, title: title, message: message, date: date, userInfo: ["key": key], soundName: soundName, hasAction: true)
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    // MARK: - Present Notification
    
    func presentNotificationWithKey(key: String, title: String, message: String, soundName: String, userInfo: [NSObject: AnyObject]?) {
        let notification = notificationWithTitle(key, title: title, message: message, date: nil, userInfo: ["key": key], soundName: nil, hasAction: true)
        UIApplication.sharedApplication().presentLocalNotificationNow(notification)
    }
    
    // MARK: - Create Notification
    
    func notificationWithTitle(key : String, title: String, message: String, date: NSDate?, userInfo: [NSObject: AnyObject]?, soundName: String?, hasAction: Bool) -> UILocalNotification {
        
        var dct : Dictionary<String,AnyObject> = userInfo as! Dictionary<String,AnyObject>
        dct["key"] = NSString(string: key) as String
        
        let notification = UILocalNotification()
        notification.alertAction = title
        notification.alertBody = message
        notification.userInfo = dct
        notification.soundName = soundName ?? UILocalNotificationDefaultSoundName
        notification.fireDate = date
        notification.hasAction = hasAction
        return notification
    }
    
    func getNotificationWithKey(key : String) -> UILocalNotification {
        
        var notif : UILocalNotification?
        
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! where notification.userInfo!["key"] as! String == key{
            notif = notification
            break
        }
        
        return notif!
    }
    
    func cancelNotification(key : String){
        
        for notification in UIApplication.sharedApplication().scheduledLocalNotifications! where notification.userInfo!["key"] as! String == key{
            UIApplication.sharedApplication().cancelLocalNotification(notification)
            break
        }
    }
    
    func getAllNotifications() -> [UILocalNotification]? {
        return UIApplication.sharedApplication().scheduledLocalNotifications
    }
    
    func cancelAllNotifications() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func registerUserNotificationWithActionButtons(actions actions : [UIUserNotificationAction]){
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = LOCAL_NOTIFICATION_CATEGORY
        
        category.setActions(actions, forContext: UIUserNotificationActionContext.Default)
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: NSSet(object: category) as? Set<UIUserNotificationCategory>)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    func registerUserNotification(){
        
        let settings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
    func createUserNotificationActionButton(identifier identifier : String, title : String) -> UIUserNotificationAction{
        
        let actionButton = UIMutableUserNotificationAction()
        actionButton.identifier = identifier
        actionButton.title = title
        actionButton.activationMode = UIUserNotificationActivationMode.Background
        actionButton.authenticationRequired = true
        actionButton.destructive = false
        
        return actionButton
    }
    
}