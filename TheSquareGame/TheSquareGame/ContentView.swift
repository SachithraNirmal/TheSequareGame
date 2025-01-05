import SwiftUI
import SpriteKit

struct GameView: View {
    var scene: SKScene
    
    init() {
        // Initialize the scene and set it up
        let scene = GameScene(size: CGSize(width: 375, height: 667)) // iPhone screen size (adjustable)
        scene.scaleMode = .aspectFill
        self.scene = scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .edgesIgnoringSafeArea(.all)
    }
}
import SpriteKit

class GameScene: SKScene {
    
    var squares: [SKSpriteNode] = []  // Array to store squares
    let gridSize: CGFloat = 3          // 3x3 grid

    override func didMove(to view: SKView) {
        backgroundColor = .white
        createSquares()
    }
    
    // Function to create 9 squares in a 3x3 grid
    func createSquares() {
        let squareSize: CGFloat = 80  // Size of each square
        let padding: CGFloat = 10      // Padding between squares
        
        let startX = (frame.width - (squareSize * gridSize + padding * (gridSize - 1))) / 2
        let startY = (frame.height - (squareSize * gridSize + padding * (gridSize - 1))) / 2
        
        for row in 0..<Int(gridSize) {
            for col in 0..<Int(gridSize) {
                let xPos = startX + CGFloat(col) * (squareSize + padding)
                let yPos = startY + CGFloat(row) * (squareSize + padding)
                
                let square = SKSpriteNode(color: .blue, size: CGSize(width: squareSize, height: squareSize))
                square.position = CGPoint(x: xPos, y: yPos)
                square.name = "square\(row)_\(col)"  // Name each square for identification
                addChild(square)
                
                squares.append(square)
            }
        }
    }
    
    // Function to move squares based on touch interaction
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        // Check if any of the squares is being touched
        for square in squares {
            if square.contains(touchLocation) {
                // Move the touched square to the touch location
                square.position = touchLocation
            }
        }
    }
    
    // Function to reset the position of all squares
    func resetSquares() {
        let squareSize: CGFloat = 100
        let padding: CGFloat = 20
        let startX = (frame.width - (squareSize * gridSize + padding * (gridSize - 1))) / 2
        let startY = (frame.height - (squareSize * gridSize + padding * (gridSize - 1))) / 2
        
        for (index, square) in squares.enumerated() {
            let row = index / Int(gridSize)
            let col = index % Int(gridSize)
            
            let xPos = startX + CGFloat(col) * (squareSize + padding)
            let yPos = startY + CGFloat(row) * (squareSize + padding)
            
            square.position = CGPoint(x: xPos, y: yPos)
        }
    }
}

struct ContentView: View {
    var body: some View {
        GameView() // Shows the game scene
            .onAppear {
                // Additional setup can be done here if needed
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 16") // Preview on iPhone 16 (adjust for other devices)
    }
}


