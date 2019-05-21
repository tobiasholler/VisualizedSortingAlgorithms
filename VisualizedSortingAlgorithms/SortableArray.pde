class SortableArray {
  
  int[] arr;
  int delayAmount = 2;
  boolean skipSleep = false;
  
  public SortableArray() {
    arr = new int[1000];
    for (int i = 0; i < arr.length; i++) {
      arr[i] = i;
    }
  }
  
  public int get(int i) {
    sleep(0.03);
    return arr[i];
  }
  
  public void set(int i, int v) {
    arr[i] = v;
    sleep(1);
  }
  
  public void swi(int i, int j) {
    if (i == j) return;
    int t = arr[i];
    arr[i] = arr[j];
    arr[j] = t;
    sleep(1);
  }
  
  public int getLength() {
    return arr.length;
  }
  
  private void sleep(float multiplyer) {
    if (skipSleep) return;
    if (Math.random()*delayAmount < multiplyer) delay(1);
  }
  
  private void setSkipSleep(boolean skipSleep) {
    this.skipSleep = skipSleep;
  }
  
  private void sleepNanos(int nanos) {
    long endTime = System.nanoTime() + nanos;
    while (System.nanoTime() < endTime) {}
  }
  
}
