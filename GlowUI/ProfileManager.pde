import java.util.Arrays;

static class ProfileHeight {
  public static int HEIGHT_50_TO_54 = 0;
  public static int HEIGHT_54_TO_58 = 1;
  public static int HEIGHT_58_TO_60 = 2;
  public static int HEIGHT_60_TO_64 = 3;
};


public class Profile {
  public String profileName = "Joe Yoga";
  public String profilePass = "Password";
  public int profileHeight = ProfileHeight.HEIGHT_54_TO_58;
  public float profileWeight = 182.5;
  
  public String serialize() {
    return profileName + "," + profileHeight + "," + profileWeight;
  }
}

public class ProfileManager {
  private final String PROFILES_FILE_NAME = "profiles.txt";
  private ArrayList<Profile> profiles;
  private int currentProfileIndex;
  //private Profile currentProfile;
  
  public ProfileManager() {
    //profiles = new ArrayList<Profile>();
    loadProfiles();
  }
  
  public void loadProfiles() {
    profiles = new ArrayList<Profile>();
    String lines[] = loadStrings(PROFILES_FILE_NAME);
    if (lines == null) {
      // There is no profile data, so create a new profile file.
      currentProfileIndex = -1;
      saveProfiles();
      return;
    }
    // Get the current profile index
    currentProfileIndex = Integer.parseInt(lines[0]);
    // Get the rest of the profile information
    lines = Arrays.copyOfRange(lines, 1, lines.length-1);
    println(lines.length);
    for (String line: lines) {
      profiles.add(parseLine(line));
    }
  }
  
  private Profile parseLine(String line) {
    Profile p = new Profile();
    String words[] = line.split(",");
    p.profileName = words[0];
    p.profileHeight = parseInt(words[1]);
    p.profileWeight = parseFloat(words[2]);
    return p;
  }
  
  public void saveProfiles() {
    ArrayList<String> lines = new ArrayList<String>();
    // Add the current profile index
    lines.add("" + currentProfileIndex + "\n");
    // Add each profile info
    for (Profile p: profiles) {
      lines.add(p.serialize());
    }
    saveStrings(PROFILES_FILE_NAME, lines.toArray(new String[lines.size()]));
  }
  
  public String[] listProfiles() {
    ArrayList<String> names = new ArrayList<String>();
    for (Profile p : profiles) {
      names.add(p.profileName);
    }
    return names.toArray(new String[names.size()]);
  }
  
  public Profile setCurrentProfile(int profileIndex) {
    currentProfileIndex = profileIndex;
    Profile p = profiles.get(profileIndex);
    //currentProfile = p;
    saveProfiles();
    return p;
  }
  
  public boolean loginCurrentProfile(int profileIndex, String pass) {
    Profile p = profiles.get(profileIndex);
    if ( pass == p.profilePass) {
      //currentProfile = p;
      currentProfileIndex = profileIndex;
      return true;
    } else {
      return false;
    }
  }
  
  public Profile createNewProfile() {
    Profile p = new Profile();
    currentProfileIndex = profiles.size();
    profiles.add(p);
    //currentProfile = p;
    saveProfiles();
    return p;
  }
  
  public int getNumProfiles() {
    return profiles.size();
  }
  
  public int getCurrentProfileIndex() {
    return currentProfileIndex;
  }
  
  public String getCurrentProfileName(){
    return profiles.get(currentProfileIndex).profileName;
  }
  
  public void setCurrentProfileName(String n) {
    profiles.get(currentProfileIndex).profileName = n;
  }
  
  public int getCurrentProfileHeight() {
    return profiles.get(currentProfileIndex).profileHeight;
  }
  
  public void setCurrentProfileHeight(int ph ) {
    profiles.get(currentProfileIndex).profileHeight = ph;
  }
  
  public float getCurrentProfileWeight() {
    return profiles.get(currentProfileIndex).profileWeight;
  }
  
  public void setCurrentProfileWeight(float w) {
    profiles.get(currentProfileIndex).profileWeight = w;
  }
}
