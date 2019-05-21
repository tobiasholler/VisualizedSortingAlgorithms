String currentSortName = "";
SortableArray arr = new SortableArray();

void setup() {
  size(600, 600);
  frameRate(60);
  noSmooth();
  colorMode(HSB, 1000);
  thread("ani");
}

void ani() {
  while (true) {
    delay(1000);
    shuffle();
    delay(1000);
    shellSort();
    delay(1000);
    shuffle();
    delay(1000);
    selectionSort();
    delay(1000);
    shuffle();
    delay(1000);
    quickSort();
    delay(1000);
    shuffle();
    delay(1000);
    bubbleSort();
  }
}

void shuffle() {
  currentSortName = "shuffling...";
  for (int i = 0; i < 1000; i++) {
    int j = (int) Math.floor(Math.random()*arr.getLength());
    int k = (int) Math.floor(Math.random()*arr.getLength());
    arr.swi(j, k);
    //if (i%6 == 0) delay(1);
  }
  currentSortName = "";
}

void bubbleSort() {
  currentSortName = "Bubble Sort";
  boolean isSorted;
  int temp;
  do {
    isSorted = true;
    for (int i = 0; i < arr.getLength()-1; i++) {
      if (arr.get(i) > arr.get(i+1)) {
        arr.swi(i, i+1);
        isSorted = false;
      }
    }
  } while (!isSorted);
  currentSortName = "";
}

void selectionSort() {
  currentSortName = "Selection Sort";
  int minIndex = 0;
  for (int i = 0; i < arr.getLength(); i++) {
    minIndex = -1;
    for (int j = i; j < arr.getLength(); j++) {
      if (minIndex < 0 || arr.get(j) <= arr.get(minIndex)) minIndex = j;
    }
    arr.swi(i, minIndex);
  }
  currentSortName = "";
}

void quickSort() {
  currentSortName = "Quick Sort";
  quickSortPart(0, arr.getLength()-1);
  currentSortName = "";
}

void quickSortPart(int leftWall, int rightWall) { //<>//
  if (leftWall < 0 || rightWall > arr.getLength()-1 || rightWall - leftWall < 1) return;
  if (rightWall - leftWall == 2) {
    if (arr.get(leftWall) > arr.get(rightWall)) {
      arr.swi(leftWall, rightWall);
    }
    return;
  }
  //System.out.println("quickSortPart " + leftWall + " " + rightWall);
  int pivotPos = rightWall;
  int leftMarkerPos = leftWall;
  int rightMarkerPos = rightWall-1;
  while (leftMarkerPos <= rightMarkerPos) {
    while (leftMarkerPos <= rightWall && arr.get(leftMarkerPos) < arr.get(pivotPos)) leftMarkerPos++;
    while (rightMarkerPos >= leftWall && arr.get(rightMarkerPos) > arr.get(pivotPos)) rightMarkerPos--;
    if (leftMarkerPos <= rightMarkerPos) {
      arr.swi(leftMarkerPos, rightMarkerPos);
    } else {
      arr.swi(leftMarkerPos, pivotPos);
      quickSortPart(leftWall, leftMarkerPos-1);
      quickSortPart(leftMarkerPos+1, rightWall);
    }
  }
}

void shellSort() { 
  currentSortName = "Shell Sort";
  int n = arr.getLength(); 
  
  // Start with a big gap, then reduce the gap 
  for (int gap = n/2; gap > 0; gap /= 2) { 
     // Do a gapped insertion sort for this gap size. 
     // The first gap elements a[0..gap-1] are already 
     // in gapped order keep adding one more element 
     // until the entire array is gap sorted 
     for (int i = gap; i < n; i += 1) { 
        // add a[i] to the elements that have been gap 
        // sorted save a[i] in temp and make a hole at 
        // position i 
        int temp = arr.get(i);
        
        // shift earlier gap-sorted elements up until 
        // the correct location for a[i] is found 
        int j; 
        for (j = i; j >= gap && arr.get(j - gap) > temp; j -= gap) 
           arr.set(j, arr.get(j - gap)); 
  
        // put temp (the original a[i]) in its correct 
        // location 
        arr.set(j, temp);

   } 
  } 
  currentSortName = "";
} 

void draw() {
  background(0);
  double piece = TWO_PI/arr.getLength();
  for (int i = arr.getLength()-1; i >= 0; i--) {
    fill(((float)arr.get(i))/arr.getLength()*1000, 1000, 1000);
    arc(((float) width)/2, ((float) height)/2, (float) width, (float) height, (float) piece*i, (float) piece*(i+1));
  }
  fill(0, 0, 1000);
  textSize(16);
  text(currentSortName, 10, 30);
}
