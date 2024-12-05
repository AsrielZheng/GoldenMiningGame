class Mineral {
  PVector position;
  int type; // 0: gold, 1: stone, 2: bomb, 3: diamond

  Mineral(float x, float y, int type) {
    position = new PVector(x, y);
    // 20% chance to turn stone into diamond
    if (type == 1 && random(1) < 0.2) {
      this.type = 3; // Diamond type
    } else {
      this.type = type;
    }
  }

  int getScore() {
    int baseScore = 0; // Default value

    if (type == 0) baseScore = 20; // Gold
    else if (type == 1) baseScore = 5; // Stone
    else if (type == 2) baseScore = ignoreBombs ? 0 : -10; // Bomb
    else if (type == 3) baseScore = 50; // Diamond

    if (valueBooster) {
      baseScore *= random(1.1, 1.2); // Increase value by 10%-20%
    }

    return doubleMoney ? baseScore * 2 : baseScore; // Double money bonus
  }

  void interact() {
    // If it's a stone and energy saver is active
    if (type == 1 && energySaver) {
      score += 20; // Refund $20 after grabbing stone
    }
  }

  void display() {
    // Display diamond
    if (type == 3) {
      image(stoneImage, position.x - 10, position.y - 10, 30, 30);
    }    
    // Display gold
    if (type == 0) {
      if (goldImage != null) {
        image(goldImage, position.x - 10, position.y - 10, 30, 30);
      }
    } 
    // Display stone
    else if (type == 1) {
      if (stoneImage != null) {
        image(stoneImage, position.x - 10, position.y - 10, 30, 30);
      }
    } 
    // Display bomb
    else if (type == 2) {
      if (bombImage != null) {
        image(bombImage, position.x - 10, position.y - 10, 30, 30);
      }
    }
  }
}