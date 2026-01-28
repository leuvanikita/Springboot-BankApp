def call(String imgName, String imgVersion){
  withCredentials([
       usernamePassword(
          credentialsId: "dockerHub",
          usernameVariable: "dockerHubUser",
          passwordVariable: "dockerHubPass"
       )
   ]) {
       sh "docker login -u $dockerHubUser -p $dockerHubPass"
    
       sh "docker image tag ${imgName}:${imgVersion}  $dockerHubUser/${imgName}:${imgVersion}"
       sh "docker push $dockerHubUser/${imgName}:${imgVersion}"
    }
}
