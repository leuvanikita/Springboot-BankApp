def call(String sonarQubeAPI, String  projectName, String projectKey){
   withSonarQubeEnv("${sonarQubeAPI}") {
         sh "mvn clean install"
         sh "$SONAR_HOME/bin/sonar-scanner -Dsonar.projectName=${projectName} -Dsonar.projectKey=${projectKey} -Dsonar.java.binaries=target/classes -X"
   }
}
