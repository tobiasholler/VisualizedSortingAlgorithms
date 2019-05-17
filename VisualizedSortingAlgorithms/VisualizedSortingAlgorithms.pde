int[] arr = new int[1000];
String currentSortName = "";

void setup() {
  size(600, 600);
  frameRate(60);
  noSmooth();
  colorMode(HSB, 1000);
  for (int i = 0; i < arr.length; i++) {
    arr[i] = i;
  }
  thread("ani");
}

void ani() {
  while (true) {
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
  for (int i = 0; i < 3000; i++) {
    int j = (int) Math.floor(Math.random()*arr.length);
    int k = (int) Math.floor(Math.random()*arr.length);
    int temp = arr[j];
    arr[j] = arr[k];
    arr[k] = temp;
    if (i%6 == 0) delay(1);
  }
  currentSortName = "";
}

void sw(int i, int j) {
  if (i == j) return;
  int t = arr[i];
  arr[i] = arr[j];
  arr[j] = t;
}

void bubbleSort() {
  currentSortName = "Bubble Sort";
  boolean isSorted;
  int temp;
  do {
    isSorted = true;
    for (int i = 0; i < arr.length-1; i++) {
      if (arr[i] > arr[i+1]) {
        temp = arr[i+1];
        arr[i+1] = arr[i];
        arr[i] = temp;
        isSorted = false;
      }
    }
    delay(5);
  } while (!isSorted);
  currentSortName = "";
}

void selectionSort() {
  currentSortName = "Selection Sort";
  int minIndex = 0;
  for (int i = 0; i < arr.length; i++) {
    minIndex = -1;
    for (int j = i; j < arr.length; j++) {
      if (minIndex < 0 || arr[j] <= arr[minIndex]) minIndex = j;
    }
    delay(3);
    sw(i, minIndex);
  }
  currentSortName = "";
}

void quickSort() {
  currentSortName = "Quick Sort";
  quickSortPart(0, arr.length-1);
  currentSortName = "";
}

void quickSortPart(int leftWall, int rightWall) { //<>//
  if (leftWall < 0 || rightWall > arr.length-1 || rightWall - leftWall < 1) return;
  if (rightWall - leftWall == 2) {
    if (arr[leftWall] > arr[rightWall]) {
      int temp = arr[leftWall];
      arr[leftWall] = arr[rightWall];
      arr[rightWall] = temp;
    }
    return;
  }
  //System.out.println("quickSortPart " + leftWall + " " + rightWall);
  int pivotPos = rightWall;
  int leftMarkerPos = leftWall;
  int rightMarkerPos = rightWall-1;
  while (leftMarkerPos <= rightMarkerPos) {
    while (arr[leftMarkerPos] < arr[pivotPos] && leftMarkerPos <= rightWall) leftMarkerPos++;
    while (arr[rightMarkerPos] > arr[pivotPos] && rightMarkerPos >= leftWall) rightMarkerPos--;
    if (leftMarkerPos <= rightMarkerPos) {
      int temp = arr[leftMarkerPos];
      arr[leftMarkerPos] = arr[rightMarkerPos];
      arr[rightMarkerPos] = temp;
    } else {
      int temp = arr[leftMarkerPos];
      arr[leftMarkerPos] = arr[pivotPos];
      arr[pivotPos] = temp;
      quickSortPart(leftWall, leftMarkerPos-1);
      quickSortPart(leftMarkerPos+1, rightWall);
    }
    delay(1);
  }
}

void draw() {
  background(0);
  double piece = TWO_PI/arr.length;
  for (int i = arr.length-1; i >= 0; i--) {
    fill(((float)arr[i])/arr.length*1000, 1000, 1000);
    arc(((float) width)/2, ((float) height)/2, (float) width, (float) height, (float) piece*i, (float) piece*(i+1));
  }
  fill(0, 0, 1000);
  textSize(16);
  text(currentSortName, 10, 30);
}
