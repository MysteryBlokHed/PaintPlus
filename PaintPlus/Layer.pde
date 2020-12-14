class Layer {
  PGraphics pg;
  String label;
  boolean selected;
  boolean hidden;
  boolean locked;

  Layer(PGraphics pg, String label, boolean selected) {
    this.pg = pg;
    this.label = label;
    this.selected = selected;
    this.hidden = false;
    this.locked = false;
  }
}
