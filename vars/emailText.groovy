def call(String txtSub, String txtResult){
    emailext (
                    to: 'devopstest483@gmail.com',
                    subject: "Jenkins Build ${txtSub}",
                    body: "Build ${txtResult}."
                )
}
