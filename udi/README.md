

export S2I_DELETE_SOURCE=false
export S2I_DESTINATION_DIR=/projects/
# export WILDFLY_S2I_OUTPUT_DIR=/s2i-output
export CUSTOM_INSTALL_DIRECTORIES=extensions

GIT_REPO=/opt/eap
git -C $GIT_REPO init
git config --global --add safe.directory $GIT_REPO
git config --global user.name "kitchensink"
git config --global user.email "kitchensink@example.com"
git -C $GIT_REPO add * .galleon/ .installation/ .well-known/
git -C $GIT_REPO commit -a -m "reset point"


git clone https://github.com/atarazana/kitchensink /projects/src
/usr/local/s2i/assemble

# To reset
git -C $GIT_REPO reset --hard && git -C $GIT_REPO clean -fd && rm /deployments/ROOT.war


git -C $GIT_REPO reset --hard && git -C $GIT_REPO clean -fd && /usr/local/s2i/assemble
usr/local/s2i/run
