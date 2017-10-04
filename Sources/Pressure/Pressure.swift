//
//  PressureType.swift
//  PressurePackageDescription
//
//  Created by Michael Housh on 10/2/17.
//
// NOTES:  There are some rounding errors on certain conversions.
//         However calculations are still accurate in most cases.

import Foundation

struct Pressure {
    
    let value: Double
    let type: PressureType
    
    init(_ value: Double, type: PressureType = .psi) {
        self.value = value
        self.type = type
    }
}

// MARK: Equatable
extension Pressure {
    // Pressures are considered equal if their value and type
    // are matching.
    static func ==(lhs: Pressure, rhs: Pressure) -> Bool {
        return lhs.value == rhs.value && lhs.type == rhs.type
    }
}

// MARK: CustomStringConvertible
extension Pressure: CustomStringConvertible {
    // return the value with the pressure symbol
    var description: String {
        return "\(value) \(type.symbol)"
    }
}

// MARK: PressureConvertible
extension Pressure: PressureConvertible {
    
    private func convertToAtmosphere() -> Double {
        switch type {
        case .psi:
            return value * 0.068045957064302
        case .pascals:
            return value * 9.8692316931427e-6
            //return value * 0.00014503773800722
        case .inchesWaterColumn:
            return value * 0.00245832
            //return value * 0.036127291827354
        case .bar:
            return value * 0.98692316931427
        case .torr:
            return value * 0.0013157893594089
        default: // we're already atmosphere pressure
            return value
        }
    }
    
    func convert(to pressureType: PressureType) -> Pressure {
        let value: Double
        
        switch pressureType {
        case .atmosphere:
            value = convertToAtmosphere()
        case .psi:
            value = convertToAtmosphere() / 0.068045957064302
        case .pascals:
            value = convertToAtmosphere() / 9.8692316931427e-6
        case .inchesWaterColumn:
             value = convertToAtmosphere() / 0.00245832
            //value = convertToAtmosphere() / 0.036127291827354
        case .torr:
            value = convertToAtmosphere() / 0.0013157893594089
        case .bar:
            value = convertToAtmosphere() / 0.98692316931427
        }
        
        // we should possibly throw an error if the
        // value is 0.0
        return Pressure(value, type: pressureType)
    }
}

// MARK: Pressure for altitude
extension Pressure {
    
    // There are some inaccuricies due to rounding and conversions between
    // different measurements to come up with the value for the pressure
    // however it is pretty close.
    
    static func forAltitude(altitude: Length, type pressureType: PressureType = .psi) -> Pressure {
        let meters = altitude.convert(to: .meters).value
        let value = 101325 * pow((1 - 2.25577e-5 * meters), 5.525588)
        let pressure = Pressure(value, type: .pascals)
        return pressure.convert(to: pressureType)
    }
    
    // convenience to get pressure for altitude at `feet` as `psi`
    //
    // The input (Double) is always used as `feet`.
    //
    // Example get the pressure for altitude in psi at 1000 feet:
    //      Pressure.forAltitude(1000.0)
    //      Pressure.forAltitude(1000.0, .pascals)  // 1000 feet in pascals (Pa)
    static func forAltitude(_ altitude: Double, _ pressureType: PressureType = .psi) -> Pressure {
        let length = Length(altitude, type: .feet)
        return Pressure.forAltitude(altitude: length, type: pressureType)
    }
}
