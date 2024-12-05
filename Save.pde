boolean[] saveSlots = {false, false, false};
int selectedSlot = -1;

void drawSaveMenu() {
  image(mainImage, 0, -30, 400, 500);
  textAlign(CENTER, CENTER);
  textSize(24);
  fill(0);
  text("SAVE MENU", width / 2, 60);

  // Draw save slots
  drawSaveSlot(100, 140, "Save 1", saveSlots[0]);
  drawSaveSlot(100, 200, "Save 2", saveSlots[1]);
  drawSaveSlot(100, 260, "Save 3", saveSlots[2]);

  // Draw back button
  drawBackButton(width / 2, 350);

  // If a save slot is selected, show confirmation box
  if (selectedSlot != -1) {
    drawConfirmationBox();
  }
}

void drawConfirmationBox() {
  // Confirmation box background
  fill(100); // Gray background
  rectMode(CENTER);
  rect(width / 2, height / 2, 200, 100, 10);

  // Confirmation box text
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(16);
  text("Delete Save " + (selectedSlot + 1) + "?", width / 2, height / 2 - 20);

  // Draw "YES" button
  fill(0, 255, 0); // Green button
  rect(width / 2 - 50, height / 2 + 20, 80, 30, 5);
  fill(255);
  text("YES", width / 2 - 50, height / 2 + 20);

  // Draw "NO" button
  fill(255, 0, 0); // Red button
  rect(width / 2 + 50, height / 2 + 20, 80, 30, 5);
  fill(255);
  text("NO", width / 2 + 50, height / 2 + 20);
}

void drawSaveSlot(float x, float y, String label, boolean isSaved) {
  fill(200);
  rectMode(CORNER);
  rect(x, y, 200, 40, 10);

  fill(0);
  textAlign(LEFT, CENTER);
  text(label + (isSaved ? " (Saved)" : ""), x + 10, y + 20);

  if (trashcanImage != null) {
    image(trashcanImage, x + 160, y + 5, 30, 30); // Adjust trashcan icon size and position
  }
}

void toggleSave(int slot) {
  if (!saveSlots[slot]) {
    saveSlots[slot] = true; // Mark the slot as saved
    println("Slot " + (slot + 1) + " saved!");
  } else {
 println("Slot " + (slot + 1) + " is already saved!");
  }
}

void handleSaveInput(float mouseX, float mouseY) {
  if (selectedSlot == -1) {
    // Check for save slot clicks
    if (mouseY > 140 && mouseY < 180) {
      toggleSave(0);
    } else if (mouseY > 200 && mouseY < 240) {
      toggleSave(1);
    } else if (mouseY > 260 && mouseY < 300) {
      toggleSave(2);
    }

    // Check for trashcan clicks
    if (mouseY > 140 && mouseY < 170 && mouseX > 260 && mouseX < 290) {
      selectedSlot = 0; // Select the first save slot
    } else if (mouseY > 200 && mouseY < 230 && mouseX > 260 && mouseX < 290) {
      selectedSlot = 1; // Select the second save slot
    } else if (mouseY > 260 && mouseY < 290 && mouseX > 260 && mouseX < 290) {
      selectedSlot = 2; // Select the third save slot
    }

    // Back button
    if (mouseX > width / 2 - 50 && mouseX < width / 2 + 50 && mouseY > 330 && mouseY < 370) {
      state = "menu"; // Return to main menu
    }
  } else {
    // Handle confirmation box button clicks
    if (mouseY > height / 2 + 10 && mouseY < height / 2 + 40) {
      if (mouseX > width / 2 - 90 && mouseX < width / 2 - 10) {
        // Clicked "YES" button
        saveSlots[selectedSlot] = false; // Delete save
        println("Save " + (selectedSlot + 1) + " deleted.");
        selectedSlot = -1; // Close confirmation box
      } else if (mouseX > width / 2 + 10 && mouseX < width / 2 + 90) {
        // Clicked "NO" button
        println("Cancelled deletion for Save " + (selectedSlot + 1));
        selectedSlot = -1; // Close confirmation box
      }
    }
  }
}

void deleteSave(int slot) {
  if (saveSlots[slot]) {
    saveSlots[slot] = false; // Delete save
    println("Save " + (slot + 1) + " deleted.");
  } else {
    println("No save found in slot " + (slot + 1));
  }
}
