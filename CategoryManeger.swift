//
//  CategoryManeger.swift
//  drawer
//
//  Created by amir lahav on 10.7.2018.
//  Copyright © 2018 LA Computers. All rights reserved.
//

import Foundation
import UIKit


enum PlaceTypeCategory:String{
    
    case none
    case accounting
    case airport
    case amusement_park
    case aquarium
    case art_gallery
    case atm
    case bakery
    case bank
    case bar
    case beauty_salon
    case bicycle_store
    case book_store
    case bowling_alley
    case bus_station
    case cafe
    case campground
    case car_dealer
    case car_rental
    case car_repair
    case car_wash
    case casino
    case cemetery
    case church
    case city_hall
    case clothing_store
    case convenience_store
    case courthouse
    case dentist
    case department_store
    case doctor
    case electrician
    case electronics_store
    case embassy
    case fire_station
    case florist
    case funeral_home
    case furniture_store
    case gas_station
    case gym
    case hair_care
    case hardware_store
    case hindu_temple
    case home_goods_store
    case hospital
    case insurance_agency
    case jewelry_store
    case laundry
    case lawyer
    case library
    case liquor_store
    case local_government_office
    case locksmith
    case lodging
    case meal_delivery
    case meal_takeaway
    case mosque
    case movie_rental
    case movie_theater
    case moving_company
    case museum
    case night_club
    case painter
    case park
    case parking
    case pet_store
    case pharmacy
    case physiotherapist
    case plumber
    case police
    case post_office
    case real_estate_agency
    case restaurant
    case roofing_contractor
    case rv_park
    case school
    case shoe_store
    case shopping_mall
    case spa
    case stadium
    case storage
    case store
    case subway_station
    case supermarket
    case synagogue
    case taxi_stand
    case train_station
    case transit_station
    case travel_agency
    case veterinary_care
    case zoo
    case food
    case shopping
    case travel
    case fun
    case money
    case historySearch
    
    /////////
    // defualt master categories
    
    static var defualtCategories:[PlaceTypeCategory] {
        return [.food, .shopping, .fun, .money]
    }
    
    
    /////////
    // master categories
    
    func getCategory(for category:PlaceTypeCategory) -> [PlaceTypeCategory]
    {
        switch category {
        case .food:
            return [.restaurant,.cafe]
        case .shopping:
            return [.shopping_mall]
        case .travel:
            return [.atm]
        case .fun:
            return [.night_club , .bar]
        case .money:
            return [.bank, .atm]
        default:
            return [category]
        }
    }
    
    
    ////////////
    
    // convert categories to array of string for api manager
    
    func mapToCategory() -> [String] {
        
        let categories = getCategory(for: self)
        
        let types = categories.map { (category) in return category.rawValue}
        
        return types
    }
    
    var color:UIColor {
        switch self {
        case .food, .cafe:
            return ARMOrange
        case .shopping:
            return ARMYellow
        case .fun, .bar, .night_club,.restaurant:
            return ARMPink
        case .travel:
            return ARMBlue
        case .money:
            return ARMDrakBlue
        default:
            return ARMRed
        }
    }
    
    
    var description: String {
        switch self {
        case .none:                                 return  ""
        case .accounting:                           return  "Accounting"
        case .airport:                              return  "Airport"
        case .amusement_park:                       return  "Amusement Park"
        case .aquarium:                             return  "Aquarium"
        case .art_gallery:                          return  "Art Gallery"
        case .atm:                                  return  "Atm"
        case .bakery:                               return  "Bakery"
        case .bank:                                 return  "Bank"
        case .bar:                                  return  "Bar"
        case .beauty_salon:                         return  "Beauty Salon"
        case .bicycle_store:                        return  "Bicycle Store"
        case .book_store:                           return  "Book Store"
        case .bowling_alley:                        return  "Bowling Alley"
        case .bus_station:                          return  "Bus Station"
        case .cafe:                                 return  "Cafe"
        case .campground:                           return  "Campground"
        case .car_dealer:                           return  "Car Dealer"
        case .car_rental:                           return  "Car Rental"
        case .car_repair:                           return  "Car Repair"
        case .car_wash:                             return  "Car Wash"
        case .casino:                               return  "Casino"
        case .cemetery:                             return  "Cemetery"
        case .church:                               return  "Church"
        case .city_hall:                            return  "City Hall"
        case .clothing_store:                       return  "Clothing Store"
        case .convenience_store:                    return  "Convenience Store"
        case .courthouse:                           return  "Courthouse"
        case .dentist:                              return  "Dentist"
        case .department_store:                     return  "Department Store"
        case .doctor:                               return  "Doctor"
        case .electrician:                          return  "Electrician"
        case .electronics_store:                    return  "Electronics Shop"
        case .embassy:                              return  "Embassy"
        case .fire_station:                         return  "Fire Station"
        case .florist:                              return  "Florist"
        case .funeral_home:                         return  "Funeral Home"
        case .furniture_store:                      return  "Furniture Store"
        case .gas_station:                          return  "Gas Station"
        case .gym:                                  return  "Gym"
        case .hair_care:                            return  "Hair Care"
        case .hardware_store:                       return  "Hardware Store"
        case .hindu_temple:                         return  "Hindu Temple"
        case .home_goods_store:                     return  "Home Goods Store"
        case .hospital:                             return  "Hospital"
        case .insurance_agency:                     return  "Insurance Agency"
        case .jewelry_store:                        return  "Jewelry Store"
        case .laundry:                              return  "Laundry"
        case .lawyer:                               return  "Lawyer"
        case .library:                              return  "Library"
        case .liquor_store:                         return  "Liquor Store"
        case .local_government_office:              return  "Local Government Office"
        case .locksmith:                            return  "Locksmith"
        case .lodging:                              return  "Hotel"
        case .meal_delivery:                        return  "Meal Delivery"
        case .meal_takeaway:                        return  "Meal Takeaway"
        case .mosque:                               return  "Mosque"
        case .movie_rental:                         return  "Movie Rental"
        case .movie_theater:                        return  "Movie Theater"
        case .moving_company:                       return  "Moving Company"
        case .museum:                               return  "Museum"
        case .night_club:                           return  "Night Club"
        case .painter:                              return  "Painter"
        case .park:                                 return  "Park"
        case .parking:                              return  "Parking"
        case .pet_store:                            return  "Pet Store"
        case .pharmacy:                             return  "Pharmacy"
        case .physiotherapist:                      return  "Physiotherapist"
        case .plumber:                              return  "Plumber"
        case .police:                               return  "Police"
        case .post_office:                          return  "Post Office"
        case .real_estate_agency:                   return  "Real Estate Agency"
        case .restaurant:                           return  "Restaurant"
        case .roofing_contractor:                   return  "Roofing Contractor"
        case .rv_park:                              return  "Rv Park"
        case .school:                               return  "School"
        case .shoe_store:                           return  "Shoe Store"
        case .shopping_mall:                        return  "Shopping Mall"
        case .spa:                                  return  "Spa"
        case .stadium:                              return  "Stadium"
        case .storage:                              return  "Storage"
        case .store:                                return  "Store"
        case .subway_station:                       return  "Subway Station"
        case .supermarket:                          return  "Supermarket"
        case .synagogue:                            return  "Synagogue"
        case .taxi_stand:                           return  "Taxi Stand"
        case .train_station:                        return  "Train Station"
        case .transit_station:                      return  "Transit Station"
        case .travel_agency:                        return  "Travel Agency"
        case .veterinary_care:                      return  "Veterinary Care"
        case .zoo:                                  return  "Zoo"
            
            
            
            /////////////
        // Master Category
        case .food:                                 return "Food & Drinks"
        case .shopping:                             return "Shopping"
        case .travel:                               return "Travel"
        case .fun:                                  return "Fun"
        case .money:                                return "Bank & ATM"
            
        case .historySearch:
            return ""
        }
    }
    static let allValues:[PlaceTypeCategory] =    [
        ///// master categories
        .food,
        .fun,
        .shopping,
        .travel,
        .money,
        
        .atm,
        .bakery,
        .bank,
        .bar,
        
        .beauty_salon,
        .bicycle_store,
        .book_store,
        .bowling_alley,
        .bus_station,
        .cafe,
        .campground,
        .car_dealer,
        .car_rental,
        .car_repair,
        .car_wash,
        .casino,
        .cemetery,
        .church,
        .city_hall,
        .clothing_store,
        .convenience_store,
        .courthouse,
        .dentist,
        .department_store,
        .doctor,
        .electrician,
        .electronics_store,
        .embassy,
        .fire_station,
        .florist,
        .funeral_home,
        .furniture_store,
        .gas_station,
        .gym,
        .hair_care,
        .hardware_store,
        .hindu_temple,
        .home_goods_store,
        .hospital,
        .insurance_agency,
        .jewelry_store,
        .laundry,
        .lawyer,
        .library,
        .liquor_store,
        .local_government_office,
        .locksmith,
        .lodging,
        .meal_delivery,
        .meal_takeaway,
        .mosque,
        .movie_rental,
        .movie_theater,
        .moving_company,
        .museum,
        .night_club,
        .painter,
        .park,
        .parking,
        .pet_store,
        .pharmacy,
        .physiotherapist,
        .plumber,
        .police,
        .post_office,
        .real_estate_agency,
        .restaurant,
        .roofing_contractor,
        .rv_park,
        .school,
        .shoe_store,
        .shopping_mall,
        .spa,
        .stadium,
        .storage,
        .store,
        .subway_station,
        .supermarket,
        .synagogue,
        .taxi_stand,
        .train_station,
        .transit_station,
        .travel_agency,
        .veterinary_care,
        .accounting,
        .airport,
        .amusement_park,
        .aquarium,
        .art_gallery,
        .zoo]
    
    var icon:UIImage{
        switch self {
        case .food:
            return #imageLiteral(resourceName: "food_100")
        case .shopping:
            return #imageLiteral(resourceName: "shopping_100")
        case .fun:
            return UIImage(named: "drink main category")!
        case .money:
            return UIImage(named: "main category money")!
        default:
            return UIImage()
        }
    }
    
    var ARIcon:UIImage
    {
        switch self {
        case .restaurant:
            return #imageLiteral(resourceName: "Resturant AR")
        case .bar:
            return #imageLiteral(resourceName: "Bar AR")
        case .gas_station:
            return #imageLiteral(resourceName: "Gas staion AR")
        case .none:
            return #imageLiteral(resourceName: "Defualt AR")
        default:
            return #imageLiteral(resourceName: "Defualt AR")
        }
    }
    
    var searchIcon:UIImage
    {
        
        switch self {
        case .food:
            return #imageLiteral(resourceName: "Resturant search")
        case .bus_station:
            return #imageLiteral(resourceName: "bus station search")
        case .shopping:
            return #imageLiteral(resourceName: "shopping search")
        case .travel:
            return #imageLiteral(resourceName: "gas station search")
        case .restaurant:
            return #imageLiteral(resourceName: "Resturant search")
        case .cafe:
            return #imageLiteral(resourceName: "cafe search")
        case .bank:
            return #imageLiteral(resourceName: "bank search")
        case .atm:
            return #imageLiteral(resourceName: "ATM search")
        case .gas_station:
            return #imageLiteral(resourceName: "gas station search")
        case .shopping_mall:
            return #imageLiteral(resourceName: "shopping search")
        case .gym:
            return #imageLiteral(resourceName: "Gym search")
        case .supermarket:
            return #imageLiteral(resourceName: "supermarket search")
        case .bar, .night_club,.liquor_store:
            return #imageLiteral(resourceName: "bar search")
        case .clothing_store:
            return #imageLiteral(resourceName: "cloth store search")
        case .pharmacy:
            return #imageLiteral(resourceName: "Pharmacy search")
        case .bakery:
            return #imageLiteral(resourceName: "Bakery search")
        case .lodging:
            return #imageLiteral(resourceName: "Hotel search")
        default:
            return #imageLiteral(resourceName: "defualt search ")
        }
    }

    
    var categorySmallImage:UIImage?{
        switch self {
        case .bakery:
            return #imageLiteral(resourceName: "backery marker")
        case .restaurant:
            return #imageLiteral(resourceName: "Resturnat marker")
        case .cafe:
            return #imageLiteral(resourceName: "Cafe mareker")
        case .bus_station:
            return #imageLiteral(resourceName: "bus staion marker")
        case .clothing_store:
            return #imageLiteral(resourceName: "cloth store marker")
        case .bank:
            return #imageLiteral(resourceName: "bank marker")
        case .atm:
            return #imageLiteral(resourceName: "ATM marker")
        case .gas_station:
            return #imageLiteral(resourceName: "gas staion marker")
        case .shopping_mall:
            return #imageLiteral(resourceName: "shopping marker")
        case .lodging:
            return #imageLiteral(resourceName: "Hotel marker")
        case .gym:
            return #imageLiteral(resourceName: "Gym marker")
        case .bar, .night_club,.liquor_store:
            return #imageLiteral(resourceName: "bar mareker")
        case .supermarket, .convenience_store:
            return #imageLiteral(resourceName: "supermarket marker")
        case .pharmacy, .doctor, .veterinary_care:
            return #imageLiteral(resourceName: "pharmacy marker")
        default:
            return #imageLiteral(resourceName: "defualt marker")
        }

    }
    
    var categoryLargeImage:UIImage?{
        switch self {
        case .bakery:
            return #imageLiteral(resourceName: "Bakery marker focus")
        case .restaurant:
            return #imageLiteral(resourceName: "Resturnat marker focus")
        case .cafe:
            return #imageLiteral(resourceName: "Coffe marker focus")
        case .bus_station:
            return #imageLiteral(resourceName: "bus station marker focus")
        case .clothing_store:
            return #imageLiteral(resourceName: "cloth store marker focus")
        case .bank:
            return #imageLiteral(resourceName: "bank marker focus")
        case .atm:
            return #imageLiteral(resourceName: "ATM marker focus")
        case .gas_station:
            return #imageLiteral(resourceName: "gas station marker focus")
        case .shopping_mall:
            return #imageLiteral(resourceName: "Shopping marker focus")
        case .lodging:
            return #imageLiteral(resourceName: "Hotel marker focus")
        case .gym:
            return #imageLiteral(resourceName: "Gym marker focus")
        case .bar, .night_club,.liquor_store:
            return #imageLiteral(resourceName: "bar marker focus")
        case .supermarket, .convenience_store:
            return #imageLiteral(resourceName: "Supermarket marker focus")
        case .pharmacy, .doctor, .veterinary_care:
            return #imageLiteral(resourceName: "pharmacy marker focus")
        default:
            return #imageLiteral(resourceName: "defualt marker focus")
        }
    
    }
    
    
    
}
