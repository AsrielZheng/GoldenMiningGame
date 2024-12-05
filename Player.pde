class Player {
  PVector position; // Position of the cart
  PVector hook;     // Position of the hook
  PVector hookSpeed; // Speed of the hook
  boolean hookMoving; // Is the hook moving
  boolean hookReturning; // Is the hook returning
  Mineral mineralCaught = null; // The mineral currently caught

  Player(float x, float y) {
    position = new PVector(x, y);
    hook = new PVector(x, y);
    hookSpeed = new PVector(0, 0);
    hookMoving = false;
    hookReturning = false;
  }

  void move(int direction) {
    position.x += direction * 5; // Update cart position
    hook.x += direction * 5;     // Update hook position
    position.x = constrain(position.x, 50, width - 50); // Constrain cart position
    hook.x = constrain(hook.x, 50, width - 50);         // Constrain hook position
  }

  void releaseHook() {
    if (!hookMoving && !hookReturning) {
      hookSpeed.set(0, hookUpgraded ? 8 : 5); // Set hook downward speed
      hookMoving = true;
    }
  }

  void update() {
    if (hookMoving) {
      hook.add(hookSpeed); // Update hook position

      // Check for collision with minerals
      for (int i = 0; i < minerals.size(); i++) {
        Mineral mineral = minerals.get(i);
        if (dist(hook.x, hook.y, mineral.position.x, mineral.position.y) < 15) {
          handleMineralCollision(mineral);
          return;
        }
      }

      // Check if the hook is out of bounds
      if (hook.y > height || hook.x < 0 || hook.x > width) {
        startReturnHook(); // Start returning if out of bounds
      }
    }

    if (hookReturning) {
      // Calculate return vector
      PVector returnDirection = PVector.sub(position, hook);
      returnDirection.normalize();
      returnDirection.mult(5); // Set return speed
      hook.add(returnDirection);

      // If a mineral is caught, move it with the hook
      if (mineralCaught != null) {
        mineralCaught.position.set(hook);
      }

      // Stop returning if the hook is near the cart
      if (dist(hook.x, hook.y, position.x, position.y) < 5) {
        resetHook();
      }
    }
  }

  void startReturnHook() {
    hookMoving = false;
    hookReturning = true; // Start returning state
  }

  void resetHook() {
    hook.set(position.x, position.y); // Reset hook position to the cart
    hookSpeed.set(0, 0);             // Reset hook speed
    hookMoving = false;              // Stop hook movement
    hookReturning = false;           // Stop hook returning
    mineralCaught = null;            // Clear the caught mineral
  }

  void handleMineralCollision(Mineral mineral) {
    hookSpeed.set(0, 0);
    hookMoving = false; // Stop downward movement
    hookReturning = true; // Start returning

    mineralCaught = mineral; // Record the caught mineral

    // Increase score
    score += mineral.getScore();
    minerals.remove(mineral); // Remove the mineral

    println("Collected mineral! Score: " + score);
  }

  void display() {
    // Draw the hook and connecting line
    stroke(0);
    line(position.x, position.y, hook.x, hook.y); // Draw hook and line

    // Draw the hook
    image(hookImage, hook.x - 10, hook.y - 10, 20, 20);

    // Draw the cart
    image(cartImage, position.x - 40, position.y - 20, 50, 40);
  }
}

