void drawBackButton(float x, float y) {
  fill(200, 50, 50); // Set button color
  rectMode(CENTER);
  rect(x, y, 100, 40, 10); // Draw button rectangle

  fill(255); // Set text color
  textAlign(CENTER, CENTER);
  text("BACK", x, y); // Draw button label
}
