GITDIR="https://raw.githubusercontent.com/myramoki/builder-vm/main"
export GITDIR

SUDO_USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
export SUDO_USER_HOME

echo "
##
## Choose which setup you want to run:
##
##   S - Starter setup [only]
##   J - Java [only]
##   G - Github [only]
##
##   a - Automation [starter, java, github, automation]
##   A - Automation [only]
##
"

read -p "?? Select setup type: " respType

_basic() {
	printf "%s\n" $GITDIR/001-software.sh \
		$GITDIR/002-network.sh \
		$GITDIR/003-cifs.sh \
		$GITDIR/090-user.sh \
		$GITDIR/099-misc.sh
}

_java() {
	printf "%s\n" $GITDIR/101-java.sh
}

_github() {
	printf "%s\n" $GITDIR/201-github-ssh.sh
}

_automation() {
	printf "%s\n" $GITDIR/501-sftp.sh \
		$GITDIR/502-build-automation.sh
}

if [ -n "$respType" ]; then
	case $respType in
	S)	echo "# Processing Starter [only]"
		sh -c "$(curl $(_basic))"
		;;

	J)	echo "# Processing Java [only]"
		sh -c "$(curl $(_java))"
		;;

	G)	echo "# Processing Github setup [only]"
		sh -c "$(curl $(_github))"
		;;

	A)	echo "# Automation [only]"
		sh -c "$(curl $(_automation))"
		;;

	a)	echo "# Automation"
		sh -c "$(curl $(_basic) $(_java) $(_github) $(_automation))"
		;;
	esac
fi

if [ -e /tmp/dofinal ]; then
	sh -c "$(cat /tmp/dofinal)"
fi

if [ -e /tmp/doreboot ]; then
    read -t 5 -p "Press ENTER before reboot"
	reboot
fi
