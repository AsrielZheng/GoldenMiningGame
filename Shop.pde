void drawShop() {
  background(50);
  image(shopImage, 0, 10, 400, 100);
  textAlign(CENTER, CENTER);
  textSize(16);
  fill(0); // Black text
  text("Level: " + level, 100, 98); 
  fill(255); // White text
  text(score, 290, 98);

  // Draw shop items
  drawShopItem(100, 150, "Hook Upgrade", 50);
  drawShopItem(200, 150, "Ignore Bombs", 80);
  drawShopItem(300, 150, "Extra Time", 40);
  drawShopItem(100, 200, "Double Money", 100);
  drawShopItem(200, 200, "Value Booster", 60);
  drawShopItem(300, 200, "Lucky Coin", 70);
  drawShopItem(100, 250, "Energy Saver", 50);
  drawShopItem(200, 250, "Diamond Magnet", 80);

  fill(255);
  text("Press ENTER to start the next level", width / 2, 300);
}

void drawShopItem(float x, float y, String name, int price) {
  fill(200);
  rectMode(CENTER);
  rect(x, y, 90, 40, 5);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(12);
  text(name + "\n$" + price, x, y);
}

void handleShopMouseInput(float mouseX, float mouseY) {
  if (mouseX > 60 && mouseX < 140 && mouseY > 120 && mouseY < 160) {
    purchaseItem("Hook Upgrade", 50);
  } else if (mouseX > 160 && mouseX < 240 && mouseY > 120 && mouseY < 160) {
    purchaseItem("Ignore Bombs", 80);
  } else if (mouseX > 260 && mouseX < 340 && mouseY > 120 && mouseY < 160) {
    purchaseItem("Extra Time", 40);
  } else if (mouseX > 60 && mouseX < 140 && mouseY > 220 && mouseY < 260) {
    purchaseItem("Double Money", 100);
  } else if (mouseX > 160 && mouseX < 240 && mouseY > 220 && mouseY < 260) {
    purchaseItem("Value Booster", 60);
  } else if (mouseX > 260 && mouseX < 340 && mouseY > 220 && mouseY < 260) {
    purchaseItem("Lucky Coin", 70);
  } else if (mouseX > 60 && mouseX < 140 && mouseY > 320 && mouseY < 360) {
    purchaseItem("Energy Saver", 50);
  } else if (mouseX > 160 && mouseX < 240 && mouseY > 320 && mouseY < 360) {
    purchaseItem("Diamond Magnet", 80);
  }
}

void handleShopKeyInput(char key) {
  if (key == ENTER) {
    state = "game";  // Switch to game state
    level++;         // Increase level
    isInShop = false; // Reset shop state
    startNextLevel(); // Start next level
  }
}

void purchaseItem(String itemName, int price) {
  if (score >= price) {
    score -= price; // Deduct price from score

    // Apply the purchased item effect
    if (itemName.equals("Hook Upgrade")) {
      nextHookUpgraded = true;
    } else if (itemName.equals("Ignore Bombs")) {
      nextIgnoreBombs = true;
    } else if (itemName.equals("Extra Time")) {
      timeLeft += 10;
    } else if (itemName.equals("Double Money")) {
      nextDoubleMoney = true;
    } else if (itemName.equals("Value Booster")) {
      valueBooster = true;
    } else if (itemName.equals("Lucky Coin")) {
      luckyCoin = true;
    } else if (itemName.equals("Energy Saver")) {
      energySaver = true;
    } else if (itemName.equals("Diamond Magnet")) {
      diamondMagnet = true;
    }
  } else {
    println("Not enough money to purchase " + itemName);
  }
}
