@objc(RMTSession)
class RMTSession: _RMTSession {

    func saveMyRatings() {
        let allCategoryRatings = self.ratingCategories
        let count = allCategoryRatings.count
        if count > 0 {
            for index in 0...count - 1 {
                let ratingCategory = allCategoryRatings.objectAtIndex(index) as? RMTRatingCategory
                if ratingCategory != nil {
                    ratingCategory?.saveMyRating()
                }
            }
        }
    }

}
