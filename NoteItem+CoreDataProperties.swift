//
//  NoteItem+CoreDataProperties.swift
//  Notes
//
//  Created by Laurentiu-Andrei Postole on 08.05.2022.
//
//

import Foundation
import CoreData


extension NoteItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NoteItem> {
        return NSFetchRequest<NoteItem>(entityName: "NoteItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?

}

extension NoteItem : Identifiable {

}
