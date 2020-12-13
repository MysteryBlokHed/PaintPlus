class Layer {
  public PGraphics pg;
  public String label;
  public boolean selected;

  Layer(PGraphics pg, String label, boolean selected) {
    this.pg = pg;
    this.label = label;
    this.selected = selected;
  }
}
