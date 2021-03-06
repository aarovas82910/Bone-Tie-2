//
//  Setings.swift
//  Bone Tie 3
//
//  Created by Alex Arovas on 3/24/16.
//  Copyright © 2016 Alex Arovas. All rights reserved.
//

import UIKit
import CloudKit

class Setings: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dogs: dog?
    let container = CKContainer.defaultContainer()
    var publicDatabase: CKDatabase?
    var privateDatabase: CKDatabase?
    var currentRecord: CKRecord?
    var photoURL: NSURL?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var FoundButton: UIButton!
    @IBOutlet weak var LostButton: UIButton!
    var doggies = [dog]()
    
    override func viewDidLoad() {
        publicDatabase = container.publicCloudDatabase
        privateDatabase = container.privateCloudDatabase
        if let savedDogs = loadDogs() {
            doggies += savedDogs
        }

        tableView.delegate = self
        tableView.dataSource = self
        if lost == "Yes" {
            FoundButton.hidden = false
            LostButton.hidden = true
        }
        else {
            FoundButton.hidden = true
            LostButton.hidden = false
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfSections: Int) -> Int{
        return 0 }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Device", forIndexPath: indexPath) as! SettingsTableViewCell
        return cell
    }
    @IBAction func DeletingDog(sender: AnyObject) {
        confirmDelete(dogs!.name)
    }
    func confirmDelete(Dog: String) {
        let alert = UIAlertController(title: "Delete Dog", message: "Are you sure you want to permanently delete \(Dog)?", preferredStyle: .ActionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: handleDeleteDog)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelDeleteDog)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRectMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0, 1.0, 1.0)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    // ...
    
    func handleDeleteDog(alertAction: UIAlertAction!) -> Void {
            let doggied = dogs
            let dogID = CKRecordID(recordName: doggied!.name)
            let newRecord = CKRecord(recordType: "Dogs", recordID: dogID)
            if let url = photoURL {
                let imageAsset = CKAsset(fileURL: url)
                newRecord.setObject(imageAsset, forKey: "Photo")
            }
            newRecord.setObject(doggied!.name, forKey: "Name")
            if let myLostDog = MyLostDogs.indexOf(doggied!) {
                privateDatabase?.deleteRecordWithID(CKRecordID(recordName: doggied!.name + doggied!.trackerNumber) , completionHandler: { (Record, Error) in
                    if Error == nil {
                        MyLostDogs.removeAtIndex(myLostDog)
                        repeat {
                            self.publicDatabase?.deleteRecordWithID(newRecord.recordID, completionHandler: ({
                            returnRecord, error in
                                if let err = error {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        print(err.localizedDescription)
                                        self.notifyUser("Error Deleting From Public Database", message: "Trying Again")
                                    }
                                } else {
                                    dispatch_async(dispatch_get_main_queue()) {
                                        self.notifyUser("Success!", message: "Record Deleted successfully.")
                                        print("Record Deleted")
                                    }
                                    self.currentRecord = newRecord
                                    if let savedDogs = self.loadDogs() {
                                        self.doggies += savedDogs
                                    }
                                }
                            }))
                        } while Error != nil

                    } else {
                        return
                    }
                })
            }
            /*
            // Note that indexPath is wrapped in an array:  [indexPath]
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            deleteDogIndexPath = nil
            */
            saveDogs()
            self.performSegueWithIdentifier("Deleted", sender: self)
        
        
        }
    
    
    func cancelDeleteDog(alertAction: UIAlertAction!) {
    }
func notifyUser(title: String, message: String) -> Void
{
    let alert = UIAlertController(title: title,
        message: message,
        preferredStyle: UIAlertControllerStyle.Alert)
    
    let cancelAction = UIAlertAction(title: "OK",
        style: .Cancel, handler: nil)
    
    alert.addAction(cancelAction)
    self.presentViewController(alert, animated: true,
        completion: nil)
}
func saveImageToFile(image: UIImage) -> NSURL
{
    let dirPaths = NSSearchPathForDirectoriesInDomains(
        .DocumentDirectory, .UserDomainMask, true)
    
    let docsDir: AnyObject = dirPaths[0]
    
    let filePath =
    docsDir.stringByAppendingPathComponent("img")
    
    UIImageJPEGRepresentation(image, 0.5)!.writeToFile(filePath,
        atomically: true)
    
    return NSURL.fileURLWithPath(filePath)
}
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Dogs" {
            let DestViewController = segue.destinationViewController as! UINavigationController
            let targetController = DestViewController.topViewController as! EditDogViewController
            let video = dogs
            targetController.dogs = video
        }

    }
@IBAction func unwindToDogList(sender: UIStoryboardSegue) {
    if let sourceViewControllered = sender.sourceViewController as? EditDogViewController, pupies = sourceViewControllered.dogs {
            let dogID = CKRecordID(recordName: pupies.name)
            photoURL = saveImageToFile(pupies.photo!)
            doggies[0] = pupies
            dogs = pupies
            self.navigationItem.title = dogs?.name
            publicDatabase?.fetchRecordWithID(dogID, completionHandler: { (record, error) in
                if error != nil {
                    print("Error fetching record: \(error!.localizedDescription)")
                } else {
                    // Now you have grabbed your existing record from iCloud
                    // Apply whatever changes you want
                    record!.setObject(pupies.name, forKey: "Name")
                    record!.setObject(pupies.breed, forKey: "category")
                    
                    if (pupies.photo == nil) {
                        self.notifyUser("No Photo", message: "Use the Photo option to choose a photo for the dog")
                        return
                    } else {
                        self.photoURL = self.saveImageToFile(pupies.photo!)
                    }
                    if let url = self.photoURL {
                        let imageAsset = CKAsset(fileURL: url)
                        record!.setObject(imageAsset, forKey: "Photo")
                    }
                    
                    // Save this record again
                    self.publicDatabase!.saveRecord(record!, completionHandler: { (savedRecord, saveError) in
                        if saveError != nil {
                            print("Error saving record: \(saveError!.localizedDescription)")
                        } else {
                            print("Successfully updated record!")
                        }
                    })
                }
            })
        // Update an existing meal.
        saveDogs()
        
    }
    saveDogs()
}
    @IBAction func Found(sender: AnyObject) {
        LostButton.hidden = false
        FoundButton.hidden = true
        lost = "No"
        let LostFound = Api().Found()
        NSTimer.scheduledTimerWithTimeInterval(3, target: Api(), selector: #selector(Api.Found), userInfo: nil, repeats: !LostFound)
        MyLostDogs.removeAtIndex(MyLostDogs.indexOf(dogs!)!)
        publicDatabase?.deleteRecordWithID(CKRecordID(recordName: dogs!.name + dogs!.breed + dogs!.city), completionHandler: ({returnRecord, error in
            if let err = error {
                dispatch_async(dispatch_get_main_queue()) {
                    //self.notifyUser("Save Error", message: err.localizedDescription)
                    print(err.localizedDescription)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    //self.notifyUser("Success!", message: "Record saved successfully.")
                    print("Record Saved")
                }
            }
        }))
    }
    @IBAction func LostMode(sender: AnyObject) {
        lost = "Yes"
        let LostModes = Api().LostMode()
        NSTimer.scheduledTimerWithTimeInterval(3, target: Api(), selector: #selector(Api.LostMode), userInfo: nil, repeats: !LostModes)
        NSTimer.scheduledTimerWithTimeInterval(3, target: Api(), selector: #selector(Api.retrieveWeatherForecast), userInfo: nil, repeats: lost == "Yes")
        MyLostDogs.append(dogs!)
        let dogID = CKRecordID(recordName: dogs!.name + dogs!.breed + dogs!.city)
        let newRecord = CKRecord(recordType: "Lost", recordID: dogID)
        let photo = saveImageToFile(dogs!.photo!)
        newRecord.setObject(CKAsset(fileURL: photo), forKey: "Photo")
        let lostDate = NSDateFormatter()
        lostDate.timeZone = NSTimeZone.systemTimeZone()
        newRecord.setObject(lostDate.dateFromString(lostDate.stringFromDate(NSDate())), forKey: "LostDate")
        let Latitude: CLLocationDegrees = latitude
        let Longitude: CLLocationDegrees = longitude
        newRecord.setObject(CLLocation(latitude: Latitude, longitude: Longitude), forKey: "Location")
        newRecord.setObject(dogs!.name, forKey: "Name")
        publicDatabase!.saveRecord(newRecord, completionHandler: ({returnRecord, error in
            if let err = error {
                dispatch_async(dispatch_get_main_queue()) {
                    self.notifyUser("Save Error", message: err.localizedDescription)
                    print(err.localizedDescription)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    self.notifyUser("Success!", message: "Record saved successfully.")
                    print("Record Saved")
                }
                print("suceess")
                self.currentRecord = newRecord
            }
        }))
        LostButton.hidden = true
        FoundButton.hidden = false
    }


    func saveDogs() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(doggies, toFile: dog.archiveURL!.path!)
        if !isSuccessfulSave {
            print("Failed to save dogs...")
        }
        
    }
    func loadDogs() -> [dog]? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(dog.archiveURL!.path!) as? [dog]
    }

}
