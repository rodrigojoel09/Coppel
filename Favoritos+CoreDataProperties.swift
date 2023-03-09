//
//  Favoritos+CoreDataProperties.swift
//  Nativekit
//
//  Created by Joel Ramirez on 09/03/23.
//
//

import Foundation
import CoreData


extension Favoritos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favoritos> {
        return NSFetchRequest<Favoritos>(entityName: "Favoritos")
    }


}

extension Favoritos : Identifiable {

}
