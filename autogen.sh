#! /bin/sh
AC_VERSION=

AUTOMAKE=${AUTOMAKE:-automake}
AM_INSTALLED_VERSION=$($AUTOMAKE --version | sed -e '2,$ d' -e 's/.* \([0-9]*\.[0-9]*\).*/\1/')

if [ "$AM_INSTALLED_VERSION" != "1.10" \
    -a "$AM_INSTALLED_VERSION" != "1.11" ];then
	echo
	echo "You must have automake > 1.10 or 1.11 installed to compile lxde-common."
	echo "Install the appropriate package for your distribution,"
	echo "or get the source tarball at http://ftp.gnu.org/gnu/automake/"
	exit 1
fi

set -x

if [ "x${ACLOCAL_DIR}" != "x" ]; then
  ACLOCAL_ARG=-I ${ACLOCAL_DIR}
fi

${ACLOCAL:-aclocal$AM_VERSION} ${ACLOCAL_ARG}
$AUTOMAKE --add-missing --copy --include-deps
${AUTOCONF:-autoconf$AC_VERSION}

# mkinstalldirs was not correctly installed in some cases.
cp -f /usr/share/${AUTOMAKE}-*/mkinstalldirs .

rm -rf autom4te.cache
