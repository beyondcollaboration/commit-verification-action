#!/bin/sh -l

# Lets print out the latest commit to see what were working with
git log -1
echo
# Now lets check to see if the latest commit was signed
# Here is some documentation on the --pretty=format:"%G?" command
# https://git-scm.com/docs/git-log#_pretty_formats
# TLDR: the %G? argument will tell us the signature status of the commit
MESSAGE=$(git log -1 --pretty=format:"%G?")
case $MESSAGE in
    N)
        # In this case the commit was not signed so we want the pipeline to fail
        # exit 1 will cause the pipeline to fail
        echo -n "The commit was not signed, failing job..."
        exit 1
        ;;
    U | B | X | Y | R | E)
        # In this case the commit was signed, but has not been verified by BeyondIdentity yet
        # In this example we will let the pipeline continue, but eventually we will replace this
        # echo statement with an API call to Beyond Identity Cloud
        echo -n "The commit was signed, but with unknown validity"
        ;;
esac
