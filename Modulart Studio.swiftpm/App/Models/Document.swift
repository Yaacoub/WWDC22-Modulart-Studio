import SwiftUI

class Document: ObservableObject, Identifiable {
    
    
    
    //MARK: - Properties
    
    @Published var properties: Properties
    var name: String
    var thumbnailName: String { "Preset Thumbnails/\(name)" }
    
    static let current = Document.new(from: .cardioid)
    static let presets: [Document] = [
        .cardioid,
        .nephroid,
        .twentyOneModTwoHundred,
        .fiftyOneModOneHundred,
        .fiftyOneModTwoHundred,
        .sixtySixModTwoHundred,
        .ninetyEightModOneHundred,
        .ninetyNineModOneHundred,
        .ninetyNineModTwoHundred
    ]
    
    static private(set) var customPresets: [Document] = []
    
    
    
    //MARK: - Properties (Presets)
    
    static let cardioid = Document(name: "Cardioid", properties: Properties(
        angleStart: 270, colorStart: .red, colorEnd: .pink, dashSize: 0, dashes: 200, lineWidth: 1, multiplicationTable: 2, showNumbers: false)
    )
    static let nephroid = Document(name: "Nephroid", properties: Properties(
        angleStart: 270, colorStart: .pink, colorEnd: .purple, dashSize: 0, dashes: 200, lineWidth: 1, multiplicationTable: 3, showNumbers: false)
    )
    static let twentyOneModTwoHundred = Document(name: "21a mod 200", properties: Properties(
        angleStart: 0, colorStart: .purple, colorEnd: .indigo, dashSize: 0, dashes: 200, lineWidth: 1, multiplicationTable: 21, showNumbers: false)
    )
    static let fiftyOneModOneHundred = Document(name: "51a mod 100", properties: Properties(
        angleStart: 0, colorStart: .indigo, colorEnd: .blue, dashSize: 0, dashes: 100, lineWidth: 1, multiplicationTable: 51, showNumbers: false)
    )
    static let fiftyOneModTwoHundred = Document(name: "51a mod 200", properties: Properties(
        angleStart: 0, colorStart: .blue, colorEnd: .cyan, dashSize: 0, dashes: 200, lineWidth: 1, multiplicationTable: 51, showNumbers: false)
    )
    static let sixtySixModTwoHundred = Document(name: "66a mod 200", properties: Properties(
        angleStart: 0, colorStart: .cyan, colorEnd: .green, dashSize: 0, dashes: 200, lineWidth: 1, multiplicationTable: 66, showNumbers: false)
    )
    static let ninetyEightModOneHundred = Document(name: "98a mod 100", properties: Properties(
        angleStart: 0, colorStart: .green, colorEnd: .yellow, dashSize: 0, dashes: 100, lineWidth: 1, multiplicationTable: 98, showNumbers: false)
    )
    static let ninetyNineModOneHundred = Document(name: "99a mod 100", properties: Properties(
        angleStart: 0, colorStart: .yellow, colorEnd: .orange, dashSize: 0, dashes: 100, lineWidth: 1, multiplicationTable: 99, showNumbers: false)
    )
    static let ninetyNineModTwoHundred = Document(name: "99a mod 200", properties: Properties(
        angleStart: 0, colorStart: .orange, colorEnd: .red, dashSize: 0, dashes: 200, lineWidth: 1, multiplicationTable: 99, showNumbers: false)
    )
    
    
    
    //MARK: - Init
    
    private init(name: String, properties: Properties) {
        self.name = name
        self.properties = properties
    }
    
    
    
    //MARK: - Method
    
    static private func new(from document: Document) -> Document {
        return Document(name: document.name, properties: document.properties)
    }
    
}
