// SonarQube extension requires java to use the proxy server, which is set by the environment variable below (already in docker-compose.yaml)
// JAVA_TOOL_OPTIONS=-Djava.net.useSystemProxies=true

// Test java internet connection by running the following command:
// java check_internet.java


import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

public class check_internet {
   public static void main(String[] args) {
      try {
         URL url = new URL("http://www.google.com");
         URLConnection connection = url.openConnection();
         connection.connect();
         System.out.println("Internet is connected");
      } catch (MalformedURLException e) {
         System.out.println("Internet is not connected");
      } catch (IOException e) {
         System.out.println("Internet is not connected");
      }
   }
}
