import java.util.Arrays;

public class ProfAlt 
{
  public String profileName;
  public int UID;
  String profileHeight;
  public float profileWeight;
  JSONObject json;
  protected boolean isLoggedIn;
  
  public ProfAlt()
  {
    this.UID = 0;
    this.profileName = "Joe Yoga";
    this.profileHeight = "5'4";
    this.profileWeight = 182.5;
    this.isLoggedIn = false;
  }
  public ProfAlt(String name, String pHeight, float pWeight, int uid, boolean logged_in)
  {
    this.UID = uid;
    this.profileName = name;
    this.profileHeight = pHeight;
    this.profileWeight = pWeight;     
    this.isLoggedIn = logged_in;
  }
}

public class ProfManager {
  private final String PROFILES_JSON_FILE = "profiles.json";
  private ArrayList<ProfAlt> profiles;
  public JSONObject json;
  
  public ProfManager() {
    //profiles = new ArrayList<Profile>();
    this.json = loadJSONObject(PROFILES_JSON_FILE);
  }
  
  public void loadProfiles() {
    profiles = new ArrayList<ProfAlt>();
    //String lines[] = loadStrings(PROFILES_JSON_FILE);
    for (int i = 0; i < this.json.size(); i++) {
        
        JSONObject user = this.json; 
    
        int uid = user.getInt("uid");
        String name = user.getString("name");
        String uHeight = user.getString("height");
        float uWeight = user.getFloat("weight");
        boolean logged_in = user.getBoolean("logged_in");
    
        println(uid + ", " + name + ", " + uHeight + ", " + uWeight + ", " + logged_in);
      }
  }
  
  public ProfAlt getUserProfile(int id)
  {        
    JSONObject user = this.json;
    int uid = user.getInt("uid");
    String name = user.getString("name");
    String uHeight = user.getString("height");
    float uWeight = user.getFloat("weight");
    boolean logged_in = user.getBoolean("logged_in");
    return new ProfAlt(name, uHeight, uWeight, uid, logged_in); 
  }
  public void createNewProfile(String name, String pHeight, float pWeight, int id, boolean log_in)
  {
    JSONObject user = this.json;
    user.setInt("uid", id);
    user.setString("name", name);
    user.setString("height", pHeight);
    user.setFloat("weight", pWeight);
    user.setBoolean("logged_in", log_in);
    saveJSONObject(user, "profiles.json");
  }
}
