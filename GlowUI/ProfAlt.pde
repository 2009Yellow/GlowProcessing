import java.util.Arrays;

public class ProfAlt 
{
  public String profileName;
  public int UID;
  public int profileHeight;
  public float profileWeight;
  JSONObject json;
  protected boolean isLoggedIn;
  
  public ProfAlt()
  {
    this.UID = 0;
    this.profileName = "Joe Yoga";
    this.profileHeight = 8;
    this.profileWeight = 182.5;
    this.isLoggedIn = false;
  }
  public ProfAlt(String name, int pHeight, float pWeight, int uid, boolean logged_in)
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
  public JSONArray json;
  
  public ProfManager() {
    //profiles = new ArrayList<Profile>();
    this.json = loadJSONArray(PROFILES_JSON_FILE);
  }
  
  public void loadProfiles() {
    profiles = new ArrayList<ProfAlt>();
    //String lines[] = loadStrings(PROFILES_JSON_FILE);
    for (int i = 0; i < this.json.size(); i++) {
        
        JSONObject user = this.json.getJSONObject(i); 
    
        int uid = user.getInt("uid");
        String name = user.getString("name");
        int uHeight = user.getInt("height");
        float uWeight = user.getFloat("weight");
        boolean logged_in = user.getBoolean("logged_in");
    
        println(uid + ", " + name + ", " + uHeight + ", " + uWeight + ", " + logged_in);
      }
  }
  
  public ProfAlt getUserProfile(int id)
  {        
    JSONObject user = this.json.getJSONObject(id);
    int uid = user.getInt("uid");
    String name = user.getString("name");
    int uHeight = user.getInt("height");
    float uWeight = user.getFloat("weight");
    boolean logged_in = user.getBoolean("logged_in");
    return new ProfAlt(name, uHeight, uWeight, uid, logged_in); 
  }
  public void createNewProfile(String name, int pHeight, float pWeight, int id, boolean log_in)
  {
    JSONObject user = this.json.getJSONObject(id);
    user.setInt("uid", id);
    user.setString("name", name);
    user.setInt("height", pHeight);
    user.setFloat("weight", pWeight);
    user.setBoolean("logged_in", log_in);
  }
}
