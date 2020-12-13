import java.util.Collections;

// Layers
LayerManager layers = new LayerManager(new ArrayList<Layer>());

// Mouse variables
boolean mouseDown;
int xOnMouseDown;
int yOnMouseDown;

void setup() {
  size(1000, 500);

  // Create default layers
  Layer background = new Layer(createGraphics(640, 480), "Background", false);
  Layer circle = new Layer(createGraphics(640, 480), "Circle", false);

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
  noFill();

  // Draw layers alongside a small preview in layers menu
  for(int i = 0; i < layers.layers.size(); i++) {
    // Blue highlight if layer is selected
    if(layers.layers.get(i).selected) {
      noStroke();
      fill(105, 189, 210);
      rect(830, 50 + i * 60, 200, 60);
      fill(0);
      noFill();
      stroke(1);
    }

    // Layer preview
    image(layers.layers.get(i).pg, 830, 50 + i * 60, 80, 60);

    // Layer label
    textSize(12);
    text(layers.layers.get(i).label, 920, 80 + i * 60);

    // Border around layer
    rect(830, 50 + i * 60, 80, 60);
  }

  // Draw each layer to canvas
  Collections.reverse(layers.layers);
  for(Layer layer : layers.layers) {
    image(layer.pg, 180, 10);
  }

  Collections.reverse(layers.layers);

  // Canvas outline in center of screen
  noFill();
  rect(180, 10, 640, 480);
}

void mousePressed() {
  // Update mouse variables
  if(mouseButton == LEFT) mouseDown = true;
  xOnMouseDown = mouseX;
  yOnMouseDown = mouseY;
}

void mouseReleased() {
  if(mouseButton == LEFT) mouseDown = false;

  // Check if the mouse was pressed & released in the layers panel
  // (excluding the layers label)
  if(xOnMouseDown > 820 && mouseX > 820 && yOnMouseDown > 40 && mouseY > 40) {
    // Get the index of the layer the mouse was pressed on
    int pIndex;
    pIndex = floor((yOnMouseDown - 50) / 60);

    // Get the index of the layer the mouse was released on
    int index;
    index = floor((mouseY - 50) / 60);

    // If the mouse was pressed & released on the same layer, select that layer
    if(index == pIndex && index < layers.layers.size()) {
        layers.deselectAll();
        layers.selectLayer(index);
      }
  }
}
