ArrayList<Mineral> minerals;  // List to store minerals
Player player;  // Player object
int score = 0;  // Initial score
int timeLeft = 175;  // Initial time left
boolean gameOver = false;  // Is the game over
int level = 1;  // Initial level
boolean specialLevel = false;  // Is it a special level
String state = "menu";  // Game state: menu, game, special, shop, save, options
int scoreTarget = 75;  // Initial score target for each level
boolean isInShop = false;  // Is the player in the shop

// Shop item related variables
boolean hookUpgraded = false;  // Is the hook upgraded
boolean ignoreBombs = false;  // Should bombs be ignored
boolean doubleMoney = false;  // Is the money doubled

boolean nextHookUpgraded = false;  // Is the next hook upgrade available
boolean valueBooster = false;  // Is the value booster available
boolean luckyCoin = false;  // Is the lucky coin available
boolean energySaver = false;  // Is the energy saver available
boolean diamondMagnet = false;  // Is the diamond magnet available
boolean nextIgnoreBombs = false;  // Is the next ignore bombs upgrade available
boolean nextDoubleMoney = false;  // Is the next double money upgrade available

// Function to check if the mouse is inside a button
boolean isInsideButton(float mouseX, float mouseY, float x, float y, float w, float h) {
  return mouseX > x - w / 2 && mouseX < x + w / 2 && mouseY > y - h / 2 && mouseY < y + h / 2;
}

// Images
PImage cartImage, hookImage, goldImage, stoneImage, bombImage, skyImage, scoreImage, goalImage, shopImage, groundImage, trashcanImage, logoImage, mainImage;

void setup() {
  size(400, 400);  // Set canvas size
  // Load images
  cartImage = loadImage("Cart.png");  // Cart image
  hookImage = loadImage("Hook.png");  // Hook image
  goldImage = loadImage("Golden.png");  // Gold image
  stoneImage = loadImage("Stone.png");  // Stone image
  bombImage = loadImage("boom.png");  // Bomb image
  skyImage = loadImage("Sky.jpg");  // Sky image
  groundImage = loadImage("Ground.jpg");  // Ground image
  scoreImage = loadImage("Score.png");  // Score image
  goalImage = loadImage("Goal.png");  // Goal image
  shopImage = loadImage("Shop.png");  // Shop image
  trashcanImage = loadImage("trashcan.png");  // Trashcan image
  logoImage = loadImage("LOGO.png");  // Logo image
  mainImage = loadImage("Main.jpg");  // Main image
  
  player = new Player(width / 2, 50);  // Initialize player
  minerals = new ArrayList<Mineral>();  // Initialize minerals list
  startNextLevel();  // Start the first level
  frameRate(30);  // Set frame rate
}

void draw() {
  // Draw based on the current state
  if (state.equals("menu")) {
    drawMenu();
  } else if (state.equals("game")) {
    drawGame();
  } else if (state.equals("shop")) {
    drawShop();
  } else if (state.equals("save")) {
    drawSaveMenu();
  } else if (state.equals("options")) {
    drawOptionsMenu();
  }
}

void mousePressed() {
 if (state.equals("menu")) {
  // Handle mouse press in menu state
  if (isInsideButton(mouseX, mouseY, width / 2, 160, 200, 40)) {
    state = "game"; // Switch to game state
    startNextLevel();
  }
  // Check if "SAVE" button is clicked
  else if (isInsideButton(mouseX, mouseY, width / 2, 220, 200, 40)) {
    state = "save"; // Switch to save state
  }
  // Check if "OPTIONS" button is clicked
  else if (isInsideButton(mouseX, mouseY, width / 2, 280, 200, 40)) {
    state = "options"; // Switch to options state
  }
} else if (state.equals("shop")) {
  handleShopMouseInput(mouseX, mouseY); // Handle mouse input in shop state
} else if (state.equals("save")) {
  handleSaveInput(mouseX, mouseY); // Handle mouse input in save state
} else if (state.equals("options")) {
  handleOptionsInput(mouseX, mouseY); // Handle mouse input in options state
}
}

void drawButton(float x, float y, String label) {
  fill(200); // Button background color
  rectMode(CENTER);
  rect(x, y, 200, 40, 10); // Draw button rectangle

  fill(0); // Button text color
  textAlign(CENTER, CENTER);
  textSize(16);
  text(label, x, y); // Draw button label
}

void keyPressed() {
  if (state.equals("shop")) {
    handleShopKeyInput(key); // Handle key input in shop state
  }
  if (state.equals("game")) {
    if (key == 'a' || key == 'A') {
      player.move(-1); // Move player left
    } else if (key == 'd' || key == 'D') {
      player.move(1); // Move player right
    } else if (key == ' ') {
      player.releaseHook(); // Release hook
    }
  }
}

void drawMenu() {
  image(mainImage, 0, -30, 400, 500); // Draw main image
  textAlign(CENTER, CENTER);
  image(logoImage, 55, 10, 300, 120); // Draw logo image

  drawButton(width / 2, 160, "PLAY"); // Draw PLAY button
  drawButton(width / 2, 220, "SAVE"); // Draw SAVE button
  drawButton(width / 2, 280, "OPTIONS"); // Draw OPTIONS button
}

void drawGame() {
  background(200); // Set background color

  // Draw sky section
  image(skyImage, 0, 0, width, 85);

  // Draw underground background
  image(groundImage, 0, 85, width, 400);
  image(scoreImage, 5, 10, 100, 30);  // Adjust position and size
  image(goalImage, 4, 40, 100, 30);

  // Display game information
  textSize(16);
  fill(255);
  text(score, 70, 25);
  text(scoreTarget, 70, 53);
  
  fill(0);
  text("Time Left: " + timeLeft, width - 100, 20);
  text("Level: " + level, width / 2, 20);

  // Countdown timer
  if (frameCount % 30 == 0 && timeLeft > 0) {
    timeLeft--;
  }

  if (timeLeft <= 0) {
    gameOver = true;
  }

  // Check if target score is reached and enter shop
  if (score >= scoreTarget && !isInShop) {
    state = "shop";
    isInShop = true;
  }

  // Update and draw player and minerals
  player.update();
  player.display();
for (Mineral mineral : minerals) {
    mineral.display();
  }

  if (gameOver) {
    displayGameOver();
  }
}

void displayGameOver() {
  background(50);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(32);
  text("Game Over", width / 2, height / 2);
  textSize(16);
  text("Press ENTER to return to menu", width / 2, height / 2 + 30);

  if (keyPressed && key == ENTER) {
    resetGame();
  }
}

void resetGame() {
  // Reset game variables
  score = 0;
  timeLeft = 175;
  gameOver = false;
  level = 1;
  specialLevel = false;
  state = "menu";
  scoreTarget = 75;
  isInShop = false;

  // Reset shop item related variables
  hookUpgraded = false;
  ignoreBombs = false;
  doubleMoney = false;
  nextHookUpgraded = false;
  valueBooster = false;
  luckyCoin = false;
  energySaver = false;
  diamondMagnet = false;
  nextIgnoreBombs = false;
  nextDoubleMoney = false;

  // Clear minerals and reset player
  minerals.clear();
  player.resetHook();
}

void startNextLevel() {
  // Apply upgrades for the next level
  hookUpgraded = nextHookUpgraded;
  ignoreBombs = nextIgnoreBombs;
  doubleMoney = nextDoubleMoney;

  // Reset next level upgrades
  nextHookUpgraded = false;
  nextIgnoreBombs = false;
  nextDoubleMoney = false;
  valueBooster = false;
  luckyCoin = false;
  energySaver = false;
  diamondMagnet = false;

  // Set new score target and time left for the level
  scoreTarget = 15 + (level * 2) * 50;
  timeLeft = max(40, 180 - level * 5);
  minerals.clear();  // Clear existing minerals

  // Determine the number of minerals for the new level
  int numMinerals = 10 + level * 5;

  // Generate minerals at random positions
  for (int i = 0; i < numMinerals; i++) {
    float x = random(50, width - 50);
    float y = random(150, height - 50);

    int type;
    if (level % 3 == 0) {
      type = int(random(0, 4)); // Increase chance of diamonds
    } else {
      type = int(random(0, 3)); // Gold, stone, bomb
    }
    minerals.add(new Mineral(x, y, type));
  }
  player.resetHook();  // Reset the player's hook
}