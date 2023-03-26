//
//  ContentView.swift
//  converter
//
//  Created by Matteo Lovrić on 26.03.2023..
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountFocused: Bool
    @State var inputValue = 0.0
    @State var selectedInputScale = "C"
    @State var selectedOutputScale = "F"
    var tempScale = ["C": UnitTemperature.celsius, "F": UnitTemperature.fahrenheit, "K": UnitTemperature.kelvin]
    var tempScaleArr = ["C", "F", "K"]

    func conversion() -> Double {
        let input = Measurement(value: inputValue, unit: tempScale[selectedInputScale] ?? UnitTemperature.celsius)
        let outputValue = input.converted(to: tempScale[selectedOutputScale] ?? UnitTemperature.fahrenheit).value

        return outputValue
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("From: ")
                    Picker("Unit", selection: $selectedInputScale) {
                        ForEach(tempScaleArr, id: \.self) { unit in
                            unit == "K" ? Text("\(unit)") : Text("º\(unit)")
                        }
                    }.pickerStyle(.segmented)
                    TextField("Input", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountFocused)
                }

                Section {
                    Text("To: ")
                    Picker("Unit", selection: $selectedOutputScale) {
                        ForEach(tempScaleArr, id: \.self) { unit in
                            unit == "K" ? Text("\(unit)") : Text("º\(unit)")
                        }
                    }.pickerStyle(.segmented)
                    Text(conversion(), format: .number)
                }
            }
            .navigationTitle("Temperature Converter").font(.subheadline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                        amountFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
