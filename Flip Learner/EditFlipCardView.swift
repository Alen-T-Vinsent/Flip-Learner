//
//  EditFlipCardView.swift
//  Flip Learner
//
//  Created by Apple  on 05/06/23.
//

import SwiftUI

struct EditFlipCardView: View {
    
    //MARK: to fetch flicards from Local db
    @FetchRequest(sortDescriptors: []) var flipcards: FetchedResults<CardEntity>
    
    //MARK: for environment
    @Environment(\.managedObjectContext) var moc
    
    @EnvironmentObject var flashCardVm:FlashCardViewModel
    
    //MARK: State for delete alert
    @State var showDeleteAlert:Bool = false
    
    var body: some View {
        List{
            ForEach(flipcards){ eachFlipcard in
                NavigationLink(destination: {
                    UpdateFlipCardView(flipCard: eachFlipcard, questionTxtField: eachFlipcard.questionAttribute ?? "UNKNOWN", answerTxtField: eachFlipcard.answerAttribute ?? "UNKNOWN", hintTxtField: eachFlipcard.hintAttribute ?? "UNKONWN")
                }, label: {
                    HStack{
                        VStack(alignment:.leading){
                            Text(eachFlipcard.questionAttribute ?? "UNKNOWN")
                                .font(.title2)
                            Text(eachFlipcard.answerAttribute ?? "UNKNOWN")
                                .font(.callout)
                            Text(eachFlipcard.hintAttribute ?? "UNKNOWN")
                            .font(.callout)}
                        
                        Spacer()
                        
                        
                    }
                })
                .frame(maxWidth: .infinity)
                .overlay(alignment:.topTrailing){
                    
                    
                   
                    
                }
                .alert("Are you sure you want to delete ? ", isPresented: $showDeleteAlert){
                    Button("No", role: .cancel) {}
                    Button("Yes", role: .destructive) {
                        moc.delete(eachFlipcard)
                        try? moc.save()
                        flashCardVm.flashCardModelsArray = []
                        for each in flipcards{
                            flashCardVm.flashCardModelsArray.append(each)
                        }
                    }
                    
                }
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Edit Flipcard")
    }
    
    
    func delete(at offsets: IndexSet) {
        flashCardVm.flashCardModelsArray.remove(atOffsets: offsets)
        
        // Loop through the offsets in reverse order to handle the correct indices
            offsets.sorted(by: >).forEach { index in
                // Get the card entity at the given index
                let card = flipcards[index]
                
                // Delete the card entity from the managed object context
                moc.delete(card)
            }
            
            // Save the changes to the managed object context
            do {
                try moc.save()
            } catch {
                // Handle the error gracefully
                print("Failed to delete cards: \(error)")
            }
        }
}

struct EditFlipCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditFlipCardView()
    }
}
