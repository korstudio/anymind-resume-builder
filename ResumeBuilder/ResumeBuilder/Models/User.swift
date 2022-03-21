//
// Created by Methas Tariya on 21/3/22.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted var firstName: String = ""
    @Persisted var lastName: String = ""
    @Persisted var email: String = ""
}