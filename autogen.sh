#! /bin/sh

########################################################################
## Utility functions
########################################################################

warn() {
    echo "===> WARNING: $@"
}

error() {
    echo "===> ERROR:   $@"
}

echo_n() {
    # "echo -n" isn't portable, must portably implement with printf
    printf "%s" "$*"
}

########################################################################
## Building maint/version
########################################################################

echo_n "Generating a helper maint/version... "
if autom4te -l M4sugar maint/version.base.m4 > maint/version ; then
    echo "done"
else
    echo "error"
    error "unable to correctly generate maint/version shell helper"
fi

########################################################################
## Building the README
########################################################################

echo_n "Updating README.md... "
. ./maint/Version
if [ -f README.vin ] ; then
    sed -e "s/%VERSION%/${ZM_VERSION}/g" README.vin > README.md
    echo "done"
else
    echo "error"
    error "README.vin file not present, unable to update the README.md version number (perhaps we are running in a release tarball source tree?)"
fi

autoreconf -vif
