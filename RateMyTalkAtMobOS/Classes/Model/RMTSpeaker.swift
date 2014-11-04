@objc(RMTSpeaker)
class RMTSpeaker: _RMTSpeaker {

    class func insertInContext(context: NSManagedObjectContext) -> RMTSpeaker {
        let speaker = RMTSpeaker(managedObjectContext: context)
        speaker.uuid = NSUUID().UUIDString
        speaker.createdAt = NSDate()
        speaker.updatedAt = NSDate()
        return speaker
    }

}
