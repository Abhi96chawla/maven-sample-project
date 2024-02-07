// freestyle_job.groovy
freeStyleJob('MyFreestyleJob') {
    description('This is a freestyle job created with Job DSL')
    logRotator {
        numToKeep(10)
        daysToKeep(10)
    }
    steps {
        shell('echo "Hello from Jenkins!"')
    }
}