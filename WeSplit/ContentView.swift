import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = "" //text fieldは文字列のみ使用可
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
        Form {
            Section {
                TextField("Amount", text: $checkAmount)
                .keyboardType(.decimalPad)
                
                Picker("Number of people", selection: $numberOfPeople) {
                    ForEach(2 ..< 100) {
                        Text("\($0) people")
                    }
                }
            }
            
            Section (header: Text("How much tip do you want to leave?")){
                
                Picker("Tip percentage", selection: $tipPercentage) {
                    ForEach(0 ..< tipPercentages.count) {
                        Text("\(self.tipPercentages[$0])%")
//                        percentage in
//                        Text("\(self.tipPercentages[percentage])%") //同じ意味
                    }
                }.pickerStyle(SegmentedPickerStyle()) //選択肢少ないときはこっちが見栄えいい
            }
            
          Section {
               Text("$\(totalPerPerson, specifier: "%.2f")")
            }
            
            
        }.navigationBarTitle("WeSplit")
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
