//
//  Dog.swift
//  Bone Tie2
//
//  Created by Alex Arovas on 12/6/15.
//  Copyright © 2015 Alex Arovas. All rights reserved.
//

import UIKit
class dog: NSObject, NSCoding {
    var name: String
    var photo: UIImage?
    var date: NSDate
    var trackerNumber: String
    var breed: String
    var city: String
    var color: String
    var sound: NSURL?
    static let doccumentDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
    static let archiveURL = doccumentDirectory?.URLByAppendingPathComponent("Dogs")
    static let archivedURL = doccumentDirectory?.URLByAppendingPathComponent("Lost")
    
    // MARK: Initialization
    struct propertyKey {
        static let nameKey = "Name"
        static let photoKey = "Photo"
        static let dateKey = "Date"
        static let breedKey = "Breed"
        static let trackerNumberKey = "trackerNumber"
        static let cityKey = "city"
        static let colorKey = "color"
        static let soundKey = "sound"
    }
    
    init?(name: String, photo: UIImage?, date: NSDate, breed: String, trackerNumber: String, city: String, color: String, sound: NSURL?) {
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.date = date
        self.breed = breed
        self.trackerNumber = trackerNumber
        self.city = city
        self.color = color
        self.sound = sound
    }
    // Initialization should fail if there is no name or if the rating is negative.
    // return nil
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: propertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: propertyKey.photoKey)
        aCoder.encodeObject(breed, forKey: propertyKey.breedKey)
        aCoder.encodeObject(date, forKey: propertyKey.dateKey)
        aCoder.encodeObject(trackerNumber, forKey: propertyKey.trackerNumberKey)
        aCoder.encodeObject(city, forKey: propertyKey.cityKey)
        aCoder.encodeObject(date, forKey: propertyKey.dateKey)
        aCoder.encodeObject(color, forKey:  propertyKey.colorKey)
        aCoder.encodeObject(sound, forKey:  propertyKey.soundKey) // RAM to Hardrive
    }
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(propertyKey.nameKey) as! String // Hardrive to RAM
        let photo = aDecoder.decodeObjectForKey(propertyKey.photoKey) as? UIImage
        let date = aDecoder.decodeObjectForKey(propertyKey.dateKey) as! NSDate
        let breed = aDecoder.decodeObjectForKey(propertyKey.breedKey) as! String
        let trackerNumber = aDecoder.decodeObjectForKey(propertyKey.trackerNumberKey) as! String
        let city = aDecoder.decodeObjectForKey(propertyKey.cityKey) as! String
        let color = aDecoder.decodeObjectForKey(propertyKey.colorKey) as! String
        let sound = aDecoder.decodeObjectForKey(propertyKey.soundKey) as! NSURL? //If nil it is the default sound
        self.init(name: name, photo: photo, date: date, breed: breed, trackerNumber: trackerNumber, city: city, color: color, sound: sound)
    }
}
