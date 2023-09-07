//
//  AddNewFlipCardView.swift
//  Flip Learner
//
//  Created by Apple  on 05/06/23.
//


import SwiftUI
import CoreData

struct AddNewFlipCardView: View {
    @State var questionTxtField = ""
    @State var answerTxtField = ""
    @State var hintTxtField = ""
    
    
    //MARK: for environment
    @Environment(\.managedObjectContext) var moc
    
    //MARK:
    @FetchRequest(sortDescriptors: []) var flipcards: FetchedResults<CardEntity>
    
    //MARK: for environmentobject for
    @EnvironmentObject var flashCardVm:FlashCardViewModel
    
    //MARK: For presentation
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        Form {
            Section {
                TextField("Enter question", text: $questionTxtField)
                TextField("Enter Answer", text: $answerTxtField)
                TextField("Enter hint", text: $hintTxtField)
            }


            Section {
                Button {
                    print("save flipcard button tapped")
                    saveNewFlipcardWithCoreData()
                   
                } label: {
                    HStack{
                        Spacer()
                        Text("Save flip card")
                        Spacer()
                    }
                }
            }


        }

        .navigationBarTitle("Add new flipcard")
        .background(background.opacity(0.2))
        .scrollContentBackground(.hidden)

        
    }
    
    var background: some View {
        LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.6),.pink.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
    
    //MARK: Functions
    func saveNewFlipcardWithCoreData(){
        let flipcard = CardEntity(context: moc)
        flipcard.questionAttribute = questionTxtField
        flipcard.answerAttribute = answerTxtField
        flipcard.hintAttribute = hintTxtField
        
        
        flashCardVm.flashCardModelsArray.append(flipcard)
        
        do{
            try moc.save()
            flashCardVm.flashCardModelsArray = []
            for each in flipcards{
                flashCardVm.flashCardModelsArray.append(each)
            }
            
            questionTxtField = ""
            answerTxtField = ""
            hintTxtField = ""
            
            presentationMode.wrappedValue.dismiss()
        }catch{
            print(error.localizedDescription)
        }
        
       
        
    }
}

struct AddNewFlipCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewFlipCardView()
    }
}
