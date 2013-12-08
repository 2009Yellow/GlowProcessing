import processing.video.*;

public class VideoElement extends UIElement {
  private Movie movie;
  public boolean isPlaying;
  protected boolean hover = false;
  protected boolean show = false;
  private PApplet papplet;

  public VideoElement( int xx, int yy, int w, int h, PApplet p) { 
    super(xx - w/2, yy - h/2, w, h);
    isPlaying = false;
    show = true;
    papplet = p;
    movie = null;
    println("VidoeElement created! (YOU SHOULD ONLY SEE THIS ONCE)");
  }
  
  public void setVideo(String fileName) {
    if (movie != null) {
      stop();
      println("Video element removing from old view");
      view.remove(this);
    }
    println("Video Element attempt load file: " + fileName);
    movie = new Movie(papplet, fileName);
    println("Video Element loaded" + movie.toString());
    show = true;
  }

  void draw() {
    // Called every time a new frame is available to read
    if (movie.available()) {
      movie.read();
    }
    // Show the video if show is active
    if (show) {
      pushStyle();
      //imageMode(CENTER);
      imageMode(CORNER);
      if (!isPlaying) {
        // Darken the video when its not playing
        tint(128);
      }
      image(movie, x - elementWidth/2, y - elementHeight/2, elementWidth, elementHeight);
      popStyle();
    }
    // call action callback if movie is finished
    if (isDone()) {
      activateActionCallback();
    }
  }
  
 // called by manager
  public void mousePressed () {
  }
  
  public void mouseReleased() {
    if (isPlaying) {
      pause();
    } else {
      play();
    }
  }

  public boolean isInside ( float mx, float my ) {
    hover = Interactive.insideRect( x, y, elementWidth, elementHeight, mx, my );
    return hover;
  }
  
  public void setTime(float where) {
    movie.jump(where);
  }
  
  public float getTime() {
    return movie.time();
  }

  public void play() {
    // Show the movie if you try to play it. 
    if (!show) {
      setShow(true);
    }
    movie.play();
    isPlaying = true;
  }
  
  public void pause() {
    movie.pause();
    isPlaying = false;
  }
  
  public void restart() {
    movie.stop();
    movie.play();
    isPlaying = true;
  }
  
  public void stop() {
    movie.stop();
    isPlaying = false;
  }
  
  public void setShow(boolean s) {
    show = s;
    if ( s == true) {
    }
    // pause the video when its no longer being shown
    else if (s == false) {
      this.pause();
    }
  }
  
  public void destroy() {
    super.destroy();
    stop();
    movie = null;
  }
  
  public boolean isDone() {
    return (movie.duration() <= movie.time());
  }
  
}
