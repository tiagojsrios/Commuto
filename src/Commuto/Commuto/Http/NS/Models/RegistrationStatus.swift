//
//  RegistrationStatus.swift
//  Commuto
//

enum RegistrationStatus: String, Codable {
    case registrationPossible = "REGISTRATION_POSSIBLE"
    case notAvailable = "NOT_AVAILABLE"
    case dateInPast = "DATE_IN_PAST"
    case dateTooFarFuture = "DATE_TOO_FAR_FUTURE"
    case notNecessaryOtherOperator = "NOT_NECESSARY_OTHER_OPERATOR"
    case unknown = "UNKNOWN"
}
