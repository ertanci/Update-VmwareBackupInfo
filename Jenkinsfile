pipeline {
    agent none
    stages {
        stage('one') {
            agent {
                label "master"
            }
            steps {
                script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'clientCred', keyFileVariable: 'mykey', passphraseVariable: 'pp', usernameVariable: 'myuser')]) {
                       REMOTE_COMMAND_CALL = sh(
                        script: 'ssh -T -i  $mykey $myuser@10.0.2.4 /home/ertan/bScript.sh > /jnkstmp/bScriptLog',
                        returnStdout: true)
                        echo "${REMOTE_COMMAND_CALL}"
                    }
                }
            }
        }
        stage('two') {
            agent {
                label "centos7"
            }
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'winCred', usernameVariable: 'winUser', passwordVariable: 'winPass')]) {
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
        stage('three') {
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
                        script: 'pwsh -c "Invoke-Command -ScriptBlock {Import-Module -Name /jenkins/workspace/sil_test/UpdateVmware.ps1;Update-VmwareBackupInfo -strVcenter tata -strUserName user -strPassword pass}" | tail -n +1',
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
