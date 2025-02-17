import SwiftUI

struct GridView: View {
    let colors: [Color] = [.red, .blue, .green, .orange, .brown, .purple, .cyan, .indigo]
    private var row: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    @State private var buttonColors: [Color] = []
    @State private var lastClickedButtonIndex: Int? = nil
    @State private var clickedColor: Color? = nil
    
    @State private var score: Int = 0
    @State private var highScore: Int = 0
    @State private var highScorePlayer: String = ""  // New state for player's name
    @State private var showRestartButton: Bool = false
    @State private var showingNamePrompt: Bool = false  // New state to show name prompt
    
    init() {
        _buttonColors = State(initialValue: generateButtonColors())
    }
    
    func generateButtonColors() -> [Color] {
        var uniqueColors = Set<Color>()
        var colorsArray: [Color] = []
        
        let repeatedColor = colors.randomElement() ?? .black
        uniqueColors.insert(repeatedColor)
        
        while uniqueColors.count < 8 {
            if let randomColor = colors.randomElement(), !uniqueColors.contains(randomColor) {
                uniqueColors.insert(randomColor)
            }
        }
        
        colorsArray = Array(uniqueColors) + [repeatedColor]
        colorsArray.shuffle()
        
        return colorsArray
    }
    
    func restartGame() {
        score = 0
        lastClickedButtonIndex = nil
        clickedColor = nil
        buttonColors = generateButtonColors()
        showRestartButton = false
        showingNamePrompt = false  // Reset the name prompt
    }
    
    func checkHighScore() {
        if score > highScore {
            highScore = score
            showingNamePrompt = true // Show name prompt when breaking high score
        }
    }
    
    var body: some View {
        VStack {
            // Display score and high score
            HStack {
                Text("Score: \(score)")
                    .font(.title)
                    .padding()
                Spacer()
                Text("High Score: \(highScore) by \(highScorePlayer)")
                    .font(.title)
                    .padding()
            }
            
            LazyVGrid(columns: row, spacing: 10) {
                ForEach((0..<9), id: \.self) { index in
                    let color = buttonColors[index]
                    
                    Button(action: {
                        if let lastClickedIndex = lastClickedButtonIndex, lastClickedIndex == index {
                            // Prevent action if the same button is clicked
                            return
                        }
                        
                        if let clickedColor = clickedColor {
                            if clickedColor == color {
                                // Correct match, increase the score
                                score += 1
                                
                                // Reset the grid and clicked state
                                buttonColors = generateButtonColors()
                                lastClickedButtonIndex = nil
                                self.clickedColor = nil
                            } else {
                                // Mismatch, check and update high score, then reset score
                                checkHighScore()
                                
                                score = 0
                                showRestartButton = true
                                // Update the clicked button and color
                                self.clickedColor = color
                                self.lastClickedButtonIndex = index
                            }
                        } else {
                            // No color was clicked, update the clicked button and color
                            self.clickedColor = color
                            self.lastClickedButtonIndex = index
                        }
                        
                        print("Button Index: \(index), Color: \(color), Color Index: \(colors.firstIndex(of: color) ?? -1)")
                    }) {
                        Rectangle()
                            .fill(color)
                            .frame(width: 100, height: 100, alignment: .center)
                            .cornerRadius(15)
                            .padding()
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(showRestartButton)
                }
                
                if showRestartButton {
                    Button(action: {
                        restartGame()
                    }) {
                        Text("Restart")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
            }
            
            // Show prompt for entering name if the high score was broken
            if showingNamePrompt {
                VStack {
                    Text("New High Score! Enter your name:")
                        .font(.title2)
                        .padding()
                    
                    TextField("Enter your name", text: $highScorePlayer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .frame(maxWidth: 300)
                    
                    Button(action: {
                        // When the player enters a name, update the high score player and restart the game
                        if !highScorePlayer.isEmpty {
                            showingNamePrompt = false
                        }
                    }) {
                        Text("Save Name")
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 20)
                }
            }
        }
        .padding()
    }
}

#Preview {
    GridView()
}
