def call(String imgName, String imgVersion){
    sh "docker build -t ${imgName}:${imgVersion} ."
}
