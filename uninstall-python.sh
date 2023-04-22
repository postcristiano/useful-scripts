#!/bin/bash
#
# to use, below
# sudo bash uninstall_python.sh <python-no-version-to-remove>

loc='/usr/local/'
py_version="$1"
rm -rf \
 $HOME/.local/lib/Python${py_version} \
 ${loc}bin/python${py_version} \
 ${loc}bin/python${py_version}-config \
 ${loc}bin/pip${py_version} \
 ${loc}bin/include/python${py_version} \
 ${loc}lib/libpython${py_version}.a \
 ${loc}lib/python${py_version} \
 ${loc}lib/pkgconfig/python-${py_version}.pc \
 ${loc}lib/libpython${py_version}m.a \
 ${loc}bin/python${py_version}m \
 ${loc}bin/2to3-${py_version} \
 ${loc}bin/python${py_version}m-config \
 ${loc}bin/idle${py_version} \
 ${loc}bin/pydoc${py_version} \
 ${loc}bin/pyvenv-${py_version} \
 ${loc}share/man/man1/python${py_version}.1 \
 ${loc}include/python${py_version}m \
 ${loc}bin/easy_install-${py_version}
 
