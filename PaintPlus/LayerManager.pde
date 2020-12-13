class LayerManager {
  public ArrayList<Layer> layers;

  LayerManager(ArrayList<Layer> layers) {
    this.layers = layers;
  }

  void selectLayer(int index) {
    this.layers.get(index).selected = true;
  }

  void deselectLayer(int index) {
    this.layers.get(index).selected = false;
  }

  void selectAll() {
    for(Layer layer : this.layers) layer.selected = true;
  }

  void deselectAll() {
    for(Layer layer : this.layers) layer.selected = false;
  }
}
