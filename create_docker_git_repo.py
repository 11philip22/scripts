from github import Github
from jenkins import Jenkins

git_access_token = ""
jenkins_server_url  = "
jenkins_username = ""
jenkins_password = ""

git_repo_name = "docker-test_test"
docker_repo_name = git_repo_name.replace("_", "-").replace("docker-", "")
jenkins_job_name = "docker-build-{0}".format(git_repo_name.replace("docker-", ""))


def create_jenkins_job_xml(github_repo_url):
    return """ \
    <?xml version='1.0' encoding='UTF-8'?>
    <flow-definition plugin="workflow-job@2.3">
    <description></description>
    <keepDependencies>false</keepDependencies>
    <properties/>
    <definition class="org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition" plugin="workflow-cps@2.9">
        <scm class="hudson.plugins.git.GitSCM" plugin="git@2.5.2">
        <configVersion>2</configVersion>
        <userRemoteConfigs>
            <hudson.plugins.git.UserRemoteConfig>
            <url>{0}</url>
            </hudson.plugins.git.UserRemoteConfig>
        </userRemoteConfigs>
        <branches>
            <hudson.plugins.git.BranchSpec>
            <name>*/master</name>
            </hudson.plugins.git.BranchSpec>
        </branches>
        <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
        <submoduleCfg class="list"/>
        <extensions/>
        </scm>
        <scriptPath>Jenkinsfile</scriptPath>
    </definition>
    <triggers/>
    </flow-definition> \
    """.format(github_repo_url)


def create_github_repo(repo_name, access_token):
    g = Github(access_token)
    authenticated_user = g.get_user()
    repo = authenticated_user.create_repo(repo_name, private=False)
    return repo.clone_url


def create_jenkins_job(name, github_clone_url, jenkins_url, user, passwd):
    job_xml = create_jenkins_job_xml(github_clone_url)
    jenkins_server = Jenkins(jenkins_url, username=user, password=passwd)
    jenkins_server.create_job(name, job_xml)


if __name__ == "__main__":
    clone_url = create_github_repo(git_repo_name, git_access_token)
    create_jenkins_job(jenkins_job_name, clone_url, jenkins_server_url, jenkins_username, jenkins_password)