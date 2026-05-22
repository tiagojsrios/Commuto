//
//  TripTravelFareProduct.swift
//  Commuto
//

enum TripTravelFareProduct: String, Codable {
    case geen = "GEEN"
    case ovchipkaartEnkeleReis = "OVCHIPKAART_ENKELE_REIS"
    case ovchipkaartRetour = "OVCHIPKAART_RETOUR"
    case dalVoordeel = "DAL_VOORDEEL"
    case altijdVoordeel = "ALTIJD_VOORDEEL"
    case dalVrij = "DAL_VRIJ"
    case weekendVrij = "WEEKEND_VRIJ"
    case altijdVrij = "ALTIJD_VRIJ"
    case businesscard = "BUSINESSCARD"
    case businesscardDal = "BUSINESSCARD_DAL"
    case studentWeek = "STUDENT_WEEK"
    case studentWeekend = "STUDENT_WEEKEND"
    case vdu = "VDU"
    case samenreiskorting = "SAMENREISKORTING"
    case trajectVrij = "TRAJECT_VRIJ"
}
