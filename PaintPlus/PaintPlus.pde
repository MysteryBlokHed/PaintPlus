import java.util.Collections;

// Layers
ArrayList<Layer> layers = new ArrayList<Layer>();

void setup() {
  size(1000, 500);

  // Create default layers
  Layer background = new Layer(createGraphics(640, 480), "Background");
  Layer circle = new Layer(createGraphics(640, 480), "Circle");

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

  layers.add(background);
  layers.add(0, circle);
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

  rectMode(CORNER);
  textSize(16);
  noFill();

  // Draw layers alongside a small preview in layers menu
  for(int i = 0; i < layers.size(); i++) {
    // Layer preview
    image(layers.get(i).pg, 830, 50 + i * 65, 80, 60);
    // Layer label
    textSize(12);
    text(layers.get(i).label, 920, 80 + i * 65);
    // Border around layer
    rect(830, 50 + i * 65, 80, 60);
  }

  // Draw each layer to canvas
  Collections.reverse(layers);
  for(Layer layer : layers) {
    image(layer.pg, 180, 10);
  }

  Collections.reverse(layers);

  // Canvas outline in center of screen
  noFill();
  rectMode(CENTER);
  rect(width/2, height/2, 640, 480);
}
