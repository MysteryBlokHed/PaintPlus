import java.util.Collections;

// Painting finals
final float SCROLL_MULTIPLIER = 3f;

// Layers
LayerManager layers = new LayerManager(new ArrayList<Layer>());

// Mouse variables
boolean lmouseDown = false;
boolean mmouseDown = false;
boolean rmouseDown = false;

int xOnMouseDown = 0;
int yOnMouseDown = 0;

// Key-specific variables
boolean shiftDown = false;

// Painting variables
boolean painting = false;
float brushSize = 20f;

// Brush colour
color c = color(255, 0, 0);

void setup() {
  size(1000, 500);

  // Create default layers
  Layer background = new Layer(createGraphics(640, 480), "Background", false);
  Layer circle = new Layer(createGraphics(640, 480), "Foreground", false);

  // Set up background layer
  background.pg.beginDraw();
  background.pg.background(255);
  background.pg.endDraw();

  // Set up circle layer
  circle.pg.beginDraw();
  circle.pg.noStroke();
  circle.pg.fill(255, 0, 0);
  circle.pg.ellipse(150, 150, 150, 150);
  circle.pg.endDraw();

  layers.layers.add(background);
  layers.layers.add(0, circle);
}

void draw() {
  // Clear screen
  background(200);

  textSize(32);

  // Palette label
  fill(0);
  text("Palette", 32, 32);

  // Layers label
  text("Layers", 865, 32);

  textSize(16);

  // Palette
  noStroke();
  // Red
  fill(#FF0000);
  ellipse(35, 75, 50, 50);
  // Blue
  fill(#0000FF);
  ellipse(90, 75, 50, 50);
  // Yellow
  fill(#FFFF00);
  ellipse(145, 75, 50, 50);
  // Green
  fill(#00FF00);
  ellipse(35, 130, 50, 50);
  // Brown
  fill(#663300);
  ellipse(90, 130, 50, 50);
  // Orange
  fill(#FF9900);
  ellipse(145, 130, 50, 50);
  // Dark green
  fill(#006600);
  ellipse(35, 185, 50, 50);

  // Current colour
  fill(0);
  text("Current Colour:", 32, height-50);
  // White rectangle under colour to properly show opacity
  fill(255);
  rect(32, height-45, 120, 25);
  fill(c);
  rect(32, height-45, 120, 25);

  fill(0); // `fill(0)` right before `noFill()` for text
  noFill();
  stroke(0);

  // Draw layers alongside a small preview in layers menu
  for(int i = 0; i < layers.layers.size(); i++) {
    // Blue highlight if layer is selected
    if(layers.layers.get(i).selected) {
      noStroke();
      fill(105, 189, 210);
      rect(830, 50 + i * 60, 200, 60);
      fill(0);
      noFill();
      stroke(0);
    }

    // Layer preview
    image(layers.layers.get(i).pg, 830, 50 + i * 60, 80, 60);

    // Layer label
    textSize(12);
    text(layers.layers.get(i).label, 920, 80 + i * 60);

    // Label for hidden layers
    if(layers.layers.get(i).hidden)
      text("Hid.", 920, 100 + i * 60);

    // Label for locked layers
    if(layers.layers.get(i).locked)
      text("Lock.", 950, 100 + i * 60);

    // Border around layer
    rect(830, 50 + i * 60, 80, 60);
  }

  // Draw each layer to canvas
  Collections.reverse(layers.layers);
  for(Layer layer : layers.layers)
    if(!layer.hidden) image(layer.pg, 180, 10);

  Collections.reverse(layers.layers);

  // Canvas outline in center of screen
  noFill();
  rect(180, 10, 640, 480);

  // Painting
  if(painting) {
    // Select first layer if none is selected
    if(!layers.selectedLayerPresent()) {
      int layer = layers.getFirstVisibleUnlockedLayer();
      if(layer >= 0) layers.selectLayer(layers.getFirstVisibleUnlockedLayer());
    }

    // Paint on selected layer
    for(Layer layer : layers.layers)
      if(layer.selected && !layer.hidden && !layer.locked) {
        layer.pg.beginDraw();
        // Change stroke based on which key is pressed
        // Default stroke colour
        if(lmouseDown) layer.pg.stroke(c);
        // Erase mode
        else if(rmouseDown) {
          layer.pg.stroke(0, 0, 0, 0);
          layer.pg.blendMode(REPLACE);
        }
        layer.pg.strokeWeight(brushSize);
        layer.pg.line(mouseX - 180, mouseY - 10, pmouseX - 180, pmouseY - 10);
        layer.pg.endDraw();
        break;
      }
  }

  noFill();
  stroke(0);
  ellipse(mouseX, mouseY, brushSize, brushSize);
}

void mousePressed() {
  // Update mouse variables
  if(mouseButton == LEFT) lmouseDown = true;
  if(mouseButton == RIGHT) rmouseDown = true;
  if(mouseButton == CENTER) mmouseDown = true;
  xOnMouseDown = mouseX;
  yOnMouseDown = mouseY;

  // Check if mouse started on canvas
  if(mouseX >= 180 && mouseX <= 820 && mouseY >= 10 && mouseY <= height - 10)
    painting = true;
}

void mouseReleased() {
  if(mouseButton == LEFT) lmouseDown = false;
  if(mouseButton == RIGHT) rmouseDown = false;
  if(mouseButton == CENTER) mmouseDown = false;
  if(painting) painting = false;

  // Check if the mouse was pressed & released in the layers panel
  // (excluding the layers label)
  if(xOnMouseDown > 820 && mouseX > 820 && yOnMouseDown > 40 && mouseY > 40) {
    // Get the index of the layer the mouse was pressed on
    int pIndex;
    pIndex = floor((yOnMouseDown - 50) / 60);

    // Get the index of the layer the mouse was released on
    int index;
    index = floor((mouseY - 50) / 60);

    if(mouseButton == LEFT) {
      // If the mouse was pressed & released on the same layer, select that layer
      if(index == pIndex && index < layers.layers.size()) {
          layers.deselectAll();
          layers.selectLayer(index);

      // If the mouse was pressed on a non-existant layer
      } else if(index >= layers.layers.size()) {
        layers.deselectAll();
      }
    } else if(mouseButton == CENTER) {
        // Hide layer if shift + middle mouse was pressed, lock it if only middle mouse was
        if(index < layers.layers.size()) {
          Layer targetLayer = layers.layers.get(index);
          if(shiftDown)
            targetLayer.hidden = !targetLayer.hidden;
          else
            targetLayer.locked = !targetLayer.locked;
        }
    }
  }

  // Check if the left mouse was pressed in the palette
  if(mouseX < 180 && mouseY >= 50) {
    color newC = get(mouseX, mouseY);
    // Make sure that the new colour isn't the background gray
    if(newC != color(200)) c = newC;
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  // Change brush size on scroll
  brushSize -= e * SCROLL_MULTIPLIER;

  // Stop brush size from going below 1
  if(brushSize < 1) brushSize = 1;
}

void keyPressed() {
  if(keyCode == SHIFT) shiftDown = true;
}

void keyReleased() {
  if(keyCode == SHIFT) shiftDown = false;
}
