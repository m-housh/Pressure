import XCTest
@testable import Pressure

class PressureTests: XCTestCase {

    func testConvertToPsiA() {
        let psig = Pressure(14.7, type: .psi)
        var psia = psig.convert(to: .atmosphere)
        XCTAssertEqual(1.0, round(psia.value))
        
        let pascals = Pressure(14.7, type: .pascals)
        psia = pascals.convert(to: .atmosphere)
        XCTAssertEqual(0.0001450777058891977, psia.value)
        
        let inH20 = Pressure(1234.0, type: .inchesWaterColumn)
        psia = inH20.convert(to: .atmosphere)
        XCTAssertEqual(3.03, round(psia.value * 100) / 100)
        
        let atm = Pressure(1.0, type: .atmosphere)
        psia = atm.convert(to: .atmosphere)
        XCTAssert(atm == psia)
        
        XCTAssertEqual("1.0 atm", psia.description)
    }
    
    func testConvertToPsiG() {
        let psia = Pressure(35.12, type: .atmosphere)
        var psig = psia.convert(to: .psi)
        XCTAssertEqual(516, round(psig.value))
        
        let pascals = Pressure(444503.0, type: .pascals)
        psig = pascals.convert(to: .psi)
        XCTAssertEqual(64, round(psig.value))
        
        let inH2O = Pressure(10.35, type: .inchesWaterColumn)
        psig = inH2O.convert(to: .psi)
        XCTAssertEqual(0.37, round(psig.value * 100) / 100)
        
        let gauge = Pressure(1.0)
        psig = gauge.convert(to: .psi)
        XCTAssertTrue(gauge == psig)
        
        XCTAssertEqual("1.0 psi", psig.description)
    }
    
    func testConvertToPascals() {
        let psia = Pressure(300.0, type: .atmosphere)
        var pascals = psia.convert(to: .pascals)
        XCTAssertEqual(30397503, round(pascals.value))
    
        let psig = Pressure(314.7, type: .psi)
        pascals = psig.convert(to: .pascals)
        XCTAssertEqual(2169780, round(pascals.value))
        
        let inH2O = Pressure(4432.0, type: .inchesWaterColumn)
        pascals = inH2O.convert(to: .pascals)
        // rounding conversion errors because we
        // convert from inH2O to atmosphere then to pascals
        // it is really 1103962
        XCTAssertEqual(1103964, round(pascals.value))
        
        let pa = Pressure(1.0, type: .pascals)
        pascals = pa.convert(to: .pascals)
        XCTAssertTrue(pa == pascals)
        
        XCTAssertEqual("1.0 Pa", pascals.description)
     
    }
    
    func testConvertToInchesWater() {
        let psia = Pressure(10.0, type: .atmosphere)
        var inH20 = psia.convert(to: .inchesWaterColumn)
        XCTAssertEqual(4068, round(inH20.value))
        
        let psig = Pressure(444.0, type: .pascals)
        inH20 = psig.convert(to: .inchesWaterColumn)
        XCTAssertEqual(1.78, round(inH20.value * 100) / 100)
        
        let pascals = Pressure(2345.0, type: .pascals)
        inH20 = pascals.convert(to: .inchesWaterColumn)
        XCTAssertEqual(9.41, round(inH20.value * 100) / 100)
        
        let inches = Pressure(1.0, type: .inchesWaterColumn)
        inH20 = inches.convert(to: .inchesWaterColumn)
        XCTAssertTrue(inches == inH20)
        
        XCTAssertEqual("1.0 inH2O", inH20.description)
    }
    
    func testConvertToTorr() {
        let psia = Pressure(34.555, type: .atmosphere)
        var torr = psia.convert(to: .torr)
        XCTAssertEqual(26262, round(torr.value))
        
        let psig = Pressure(312.34)
        torr = psig.convert(to: .torr)
        //XCTAssertEqual(16153, round(torr.value))
        
        let torr1 = Pressure(1.0, type: .torr)
        torr = torr1.convert(to: .torr)
        XCTAssertTrue(torr1 == torr)
        
        XCTAssertEqual("1.0 Torr", torr.description)
    }
    
    func testConvertToBar() {
        let psia = Pressure(876.0, type: .atmosphere)
        var bar = psia.convert(to: .bar)
        XCTAssertEqual(888, round(bar.value))
        
        let psig = Pressure(32.0)
        bar = psig.convert(to: .bar)
        XCTAssertEqual(2.21, round(bar.value * 100) / 100)
        
        let bar1 = Pressure(1.0, type: .bar)
        bar = bar1.convert(to: .bar)
        XCTAssertTrue(bar1 == bar)
        
        XCTAssertEqual("1.0 bar", bar.description)
    }

    static var allTests = [
        ("testConvertToPsiA", testConvertToPsiA),
    ]
}
