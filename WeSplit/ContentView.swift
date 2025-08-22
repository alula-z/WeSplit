//
//  ContentView.swift
//  WeSplit
//
//  Created by Alula Zeruesenay on 8/22/25.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    var grandTotal: Double{
        let total:Double = totalPerPeron * Double(numberOfPeople + 2)
        return total
    }
    let tipPercentages = [10,15,20,25,0]
    var totalPerPeron: Double{
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationStack{
            Form{
                Section("Total Check Amount"){
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .focused($amountIsFocused)
                }
                Section("How much tip do you want to leave?"){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101, id:\.self){
                            Text($0,format:.percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section{
                    
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                        
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Total Amount"){
                    Text(grandTotal, format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                Section("Amount per person"){
                    Text(totalPerPeron, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
