class LayerManager {
  ArrayList<Layer> layers;

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
    for (Layer layer : this.layers) layer.selected = true;
  }

  void deselectAll() {
    for (Layer layer : this.layers) layer.selected = false;
  }

  void deleteSelectedLayers() {
    ArrayList<Integer> markedForDeletion = new ArrayList<Integer>();

    for (int i = 0; i < this.layers.size(); i++)
      if (this.layers.get(i).selected)
        markedForDeletion.add(i);

    for (int i : markedForDeletion)
      this.layers.remove(i);
  }

  int getFirstVisibleUnlockedLayer() {
    for (Layer layer : this.layers)
      if (!layer.hidden && !layer.locked) return this.layers.indexOf(layer);
    return -1;
  }

  boolean selectedLayerPresent() {
    for (Layer layer : this.layers)
      if (layer.selected) return true;
    return false;
  }
}
