import processing.video.*;

public class VideoElement extends UIElement {
  private Movie movie;
  public boolean isPlaying;
  protected boolean hover = false;
  protected boolean show = false;

  public VideoElement( int xx, int yy, int w, int h, PApplet p, String fileName) {
    super(xx, yy, w, h);
    println("Vidoe Element attempt load file: " + fileName);
    movie = new Movie(p, fileName);
    println("Vidoe Element loaded" + movie.toString());

    isPlaying = false;
    show = true;
    //movie.loop();
  }

  void draw() {
    // Called every time a new frame is available to read
    if (movie.available()) {
      movie.read();
    }
    // Show the video if show is active
    if (show) {
      pushStyle();
      imageMode(CENTER);
      if (!isPlaying) {
        // Darken the video when its not playing
        tint(128);
      }
      image(movie, x, y, elementWidth, elementHeight);
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
