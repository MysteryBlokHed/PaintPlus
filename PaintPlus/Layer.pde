class Layer {
  public PGraphics pg;
  public String label;
  public boolean selected;
  public boolean hidden;
  public boolean locked;

  Layer(PGraphics pg, String label, boolean selected) {
    this.pg = pg;
    this.label = label;
    this.selected = selected;
    this.hidden = false;
    this.locked = true;
  }
}
