float volume = 0.5;

void drawOptionsMenu() {
  image(mainImage, 0, -30, 400, 500);
  textAlign(CENTER, CENTER);
  textSize(24);
  fill(255);
  text("OPTIONS MENU", width / 2, 60);

  // Draw volume slider
  drawVolumeControl();

  // Draw back button
  drawBackButton(width / 2, 300);
}

void drawVolumeControl() {
  textSize(16);
  fill(255);
  text("Adjust Volume", width / 2, 140);

  fill(200);
  rectMode(CENTER);
  rect(width / 2, 180, 200, 10); // Slider background

  float sliderX = map(volume, 0.0, 1.0, width / 2 - 100, width / 2 + 100);
  fill(255, 100, 100);
  ellipse(sliderX, 180, 20, 20); // Slider knob

  fill(255);
  textSize(14);
  text("Volume: " + nf(volume, 1, 2), width / 2, 210);
}

void handleOptionsInput(float mouseX, float mouseY) {
  if (isInsideButton(mouseX, mouseY, width / 2, 300, 100, 40)) {
    state = "menu"; // Return to main menu
    println("Back button clicked!");
  } else if (mouseX > width / 2 - 100 && mouseX < width / 2 + 100 && mouseY > 170 && mouseY < 190) {
    volume = constrain(map(mouseX, width / 2 - 100, width / 2 + 100, 0, 1), 0, 1);
    println("Volume adjusted: " + volume);
  }
}
