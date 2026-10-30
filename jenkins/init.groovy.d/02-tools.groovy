import jenkins.model.Jenkins
import hudson.model.JDK

// Register the JDK 21 bundled in the image as tool "jdk21"
def desc = Jenkins.get().getDescriptorByType(JDK.DescriptorImpl)
if (!desc.installations.find { it.name == 'jdk21' }) {
    desc.setInstallations((desc.installations as List) + new JDK('jdk21', '/opt/java/openjdk') as JDK[])
    desc.save()
}
