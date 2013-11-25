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
  private Profile currentProfile;
  
  public ProfileManager() {
    profiles = new ArrayList<Profile>();
    loadProfiles();
  }
  
  public void loadProfiles() {
    profiles = new ArrayList<Profile>();
    String lines[] = loadStrings(PROFILES_FILE_NAME);
    if (lines == null) {
      // There is no profile data, so just return. 
      return;
    }
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
    Profile p = profiles.get(profileIndex);
    currentProfile = p;
    return p;
  }
  
  public boolean loginCurrentProfile(int profileIndex, String pass) {
    Profile p = profiles.get(profileIndex);
    if ( pass == p.profilePass) {
      currentProfile = p;
      return true;
    } else {
      return false;
    }
  }
  
  public Profile createNewProfile() {
    Profile p = new Profile();
    profiles.add(p);
    currentProfile = p;
    return p;
  }
  
  public int getNumProfiles() {
    return profiles.size();
  }
  
  public void setCurrentProfileName(String n) {
    currentProfile.profileName = n;
  }
  
  public void setCurrentProfileHeight(int ph ) {
    currentProfile.profileHeight = ph;
  }
  
  public void setCurrentProfileWeight(float w) {
    currentProfile.profileWeight = w;
  }
}
