pipeline {
    agent none
    stages {
        stage('DoingLinux') {
            agent {
                label "master"
            }
            steps {
                script {
                    REMOTE_COMMAND_CALL = sh(
                        script: 'ssh -T -i  /var/lib/jenkins/myssh/id_rsa ertan@10.0.2.4 /home/ertan/bScript.sh > /jnkstmp/bScriptLog',
                        returnStdout: true)
                    echo "${REMOTE_COMMAND_CALL}"

                }
            }
        }
        stage('DoingWin') {
            agent {
                label "centos7"
            }
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'winCred', usernameVariable: 'a', passwordVariable: 'b')]) {
                        REMOTE_WIN_CALL = sh(
                            script: 'pwsh -f remoting.ps1 -u $winUser -p $winPass -m "10.0.2.7"',
                            returnStdout: true)
                        echo "REMOTE_WIN_CALL is ${REMOTE_WIN_CALL}"

                        LOG_FILE_CONTENT = sh(
                            script: 'pwsh -f readLogFile.ps1 -u $winUser -p $winPass -m "10.0.2.7" > /jnkstemp/contentLog',
                            returnStdout: true)
                        echo "${LOG_FILE_CONTENT}"
                    }
                }

            }
        }
        stage('UpdateVM') {
            when {
                expression {
                    REMOTE_WIN_CALL.contains("True")
                }
            }
            agent {
                label "centos7"
            }
            steps {
                script {
                    UPDATE_VMWARE = sh(
                        script: 'pwsh -c "Invoke-Command -ScriptBlock {Import-Module -Name /jenkins/workspace/sil_test/UpdateVmware.ps1;Update-VmwareBackupInfo -strVcenter tata -strUserName user -strPass pass}" | tail -n +15',
                        returnStdout: true)
                    echo "${UPDATE_VMWARE}"
                }
            }
        }
    }
    environment {
        UPDATE_VMWARE = 'MY_NULL'
        REMOTE_WIN_CALL = 'MY_NULL'
        LOG_FILE_CONTENT = 'MY_NULL'
        REMOTE_COMMAND_CALL = 'MY_NULL'
    }
}
