package is.tagomor.woothee.os;

import java.util.Map;
import java.util.regex.Pattern;
import java.util.regex.Matcher;
import java.util.regex.MatchResult;

import is.tagomor.woothee.AgentCategory;
import is.tagomor.woothee.DataSet;
import is.tagomor.woothee.Classifier;

public class Windows extends AgentCategory {
  private static Pattern windowsVer = Pattern.compile("Windows ([ .a-zA-Z0-9]+)[;\\)]");

  public static boolean challenge(final String ua, final Map<String,String> result) {
    int pos = ua.indexOf("Windows");
    if (pos < 0) // not Windows
      return false;

    Map<String,String> data = DataSet.get("Win");

    Matcher win = windowsVer.matcher(ua);
    if (! win.find(pos)) {
      // windows, but version unknown
      updateCategory(result, data.get(DataSet.DATASET_KEY_CATEGORY));
      updateOs(result, data.get(DataSet.DATASET_KEY_NAME));
      return true;
    }

    String versionString = win.group(1);
    if (versionString.equals("NT 6.1"))
      data = DataSet.get("Win7");
    else if (versionString.equals("NT 6.0"))
      data = DataSet.get("WinVista");
    else if (versionString.equals("NT 5.1"))
      data = DataSet.get("WinXP");
    else if (versionString.equals("NT 5.0"))
      data = DataSet.get("Win2000");
    else if (versionString.startsWith("Phone OS"))
      data = DataSet.get("WinPhone");

    // else, windows, but version unknown

    updateCategory(result, data.get(DataSet.DATASET_KEY_CATEGORY));
    updateOs(result, data.get(DataSet.DATASET_KEY_NAME));
    return true;
  }
}