import jenkins.model.Jenkins
import hudson.security.HudsonPrivateSecurityRealm
import hudson.security.FullControlOnceLoggedInAuthorizationStrategy

// Create the admin user from env variables on first start
def jenkins = Jenkins.get()
def user = System.getenv('JENKINS_ADMIN_ID') ?: 'kim_vladislav'
def pass = System.getenv('JENKINS_ADMIN_PASSWORD')
if (!(jenkins.securityRealm instanceof HudsonPrivateSecurityRealm) && pass) {
    def realm = new HudsonPrivateSecurityRealm(false)
    realm.createAccount(user, pass)
    jenkins.securityRealm = realm
    def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
    strategy.allowAnonymousRead = false
    jenkins.authorizationStrategy = strategy
    jenkins.save()
}
