#!/bin/bash

declare pkg_name=darkdevel
declare pkg_base=$(dirname "$0")
declare pkg_version=$(git tag | sort | tail -n 1)
declare pkg_file="${pkg_name}-${pkg_version#v}.zip"
declare prefix=${1:-'.vim'}

function format {
  git archive --format=tar --prefix=$prefix/ $pkg_version | tar xf -
}

function cleanup {
  pushd $prefix
  local ignoreds=(.gitignore $0 *.png README.*)
  for file in ${ignoreds[@]}; do
    rm -v $file
  done
  popd
}

function compress {
  zip -r $pkg_file $prefix
  rm -rf $prefix
}

echo "** Formating package ...";              format
echo "** Removing temporary files ...";       cleanup
echo "** Compressing package $pkg_file ...";  compress
echo "** Done!"
exit 0
