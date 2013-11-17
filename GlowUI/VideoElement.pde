import processing.video.*;

public class VideoElement extends UIElement {
  private Movie movie;
  public boolean isPlaying;
  protected boolean hover = false;

  public VideoElement( int xx, int yy, int w, int h, PApplet p, String fileName) {
    super(xx, yy, w, h);
    movie = new Movie(p, fileName);
    isPlaying = false;
    //movie.loop();
  }

  void draw() {
    // Called every time a new frame is available to read
    if (movie.available()) {
      movie.read();
    }
    image(movie, x, y, elementWidth, elementHeight);
    
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
  
  public void jump(float where) {
    movie.jump(where);
  }


  public void play() {
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
  
  public boolean isDone() {
    return (movie.duration() <= movie.time());
  }
  
}
