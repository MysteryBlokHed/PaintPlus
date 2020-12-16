class ContextMenu {
  ArrayList<ContextMenuElement> elements;
  PGraphics pg;

  ContextMenu(ArrayList<ContextMenuElement> elements) {
    this.elements = elements;
  }

  void renderContextMenu() {
    // Set PGraphics width to the width of the longest text
    int width = 0;
    textSize(24);
    for(ContextMenuElement element : elements)
      if(textWidth(element.displayText) > width)
        width = floor(textWidth(element.displayText)) + 10;

    this.pg = createGraphics(width, elements.size() * 40);

    this.pg.beginDraw();
    this.pg.fill(0);
    this.pg.textSize(24);

    this.pg.background(255);

    // Add each element to the menu
    int i = 0;
    for(ContextMenuElement element : elements) {
      this.pg.text(element.displayText, 5, 25 + i * 40);
      i++;
    }

    this.pg.endDraw();
  }
}
