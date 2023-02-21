
import Foundation

enum AppLanguage: String {
    case uz
    case uz_kr
    case ru
}

enum UserDefaultsKeys: String {
    case localization
    case phoneNumber
    case isConfirmed
    case isVpn
    case firstTimeAuth
    case point
}

extension UserDefaults {
    func getLocalization() -> String {
        return string(forKey: UserDefaultsKeys.localization.rawValue) ?? AppLanguage.uz.rawValue
    }

    func saveLocalization(lang: String) {
        set(lang, forKey: UserDefaultsKeys.localization.rawValue)
    }
    
    func saveIsVpn(isVpn: Bool) {
        set(isVpn, forKey: UserDefaultsKeys.isVpn.rawValue)
    }
    
    func isVpn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isVpn.rawValue)
    }
    
    func savePhoneNumber(phoneNumber: String) {
        set(phoneNumber, forKey: UserDefaultsKeys.phoneNumber.rawValue)
    }
    
    func getPhoneNumber() -> String? {
        return string(forKey: UserDefaultsKeys.phoneNumber.rawValue)
    }
    
    func removePhoneNumber() {
        removeObject(forKey: UserDefaultsKeys.phoneNumber.rawValue)
    }
    
    func saveIsConfirmed(isConfirmed: Int) {
        set(isConfirmed, forKey: UserDefaultsKeys.isConfirmed.rawValue)
    }
    
    func getIsConfirmed() -> Bool {
        return integer(forKey: UserDefaultsKeys.isConfirmed.rawValue) == 1
    }
    
    func removeIsConfirmed() {
        removeObject(forKey: UserDefaultsKeys.isConfirmed.rawValue)
    }
    
    func saveFirstTimeAuth() {
        set(true, forKey: UserDefaultsKeys.firstTimeAuth.rawValue)
    }
    
    func isFirstTimeAuth() -> Bool {
        return !bool(forKey: UserDefaultsKeys.firstTimeAuth.rawValue)
    }
}

extension UserDefaults {
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}

enum YandexLocalization: String {
    case uz = "uz_UZ"
    case uz_kr = "uz-Cyrl"
    case ru = "ru_RU"
}

extension UserDefaults {
    func getLocalizationYandex() -> String {
        switch getLocalization() {
        case AppLanguage.uz.rawValue:
            return YandexLocalization.uz.rawValue
        case AppLanguage.uz_kr.rawValue:
            return YandexLocalization.uz_kr.rawValue
        case AppLanguage.ru.rawValue:
            return YandexLocalization.ru.rawValue
        default:
            return YandexLocalization.uz.rawValue
        }
    }
}
