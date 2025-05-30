printf "\n#### BEGIN CONFIG : Build Automation\n\n"

dnf install -y -q msmtp

printf "Creating msmtp control files\n"

cd $SUDO_USER_HOME
curl $GITDIR/scripts/.msmtprc | sed "s#aliases #aliases ${SUDO_USER_HOME}/#" > .msmtprc

chown -R ${SUDO_USER}: .msmtprc
chmod 600 .msmtprc


printf "Creating automation control files\n"

mkdir $SUDO_USER_HOME/automation
cd $SUDO_USER_HOME/automation

printf "mailnotify=DEST1\nmailother=\n" > build-email-aliases

curl -O "$GITDIR/scripts/{build-if-changed.sh,build.sh,cron-build.sh,setup.sh}"
chown -R $SUDO_USER: $SUDO_USER_HOME/automation
chmod u+x $SUDO_USER_HOME/automation/*.sh

mkdir $SUDO_USER_HOME/.locks $SUDO_USER_HOME/repos $SUDO_USER_HOME/logs
chown $SUDO_USER: $SUDO_USER_HOME/.locks $SUDO_USER_HOME/repos $SUDO_USER_HOME/logs

printf "\n#### END CONFIG : Build Automation\n\n"
