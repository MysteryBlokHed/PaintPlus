class Layer {
  public PGraphics pg;
  public String label;
  public boolean selected;
  public boolean hidden;

  Layer(PGraphics pg, String label, boolean selected) {
    this.pg = pg;
    this.label = label;
    this.selected = selected;
    this.hidden = false;
  }
}
