//
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
struct Result<Question: Hashable, Answer> {
    let answers:[Question: Answer]
    let score: Int
}
