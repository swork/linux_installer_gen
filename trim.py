#! /usr/bin/env python

import gzip, re, sys, os, os.path, textwrap

# Make installed-base.txt from initial imaging of a VM - it's the set of
# packages to trim the full CD to (like there's much value to that)
# dpkg-query --show|cut -f1|cut -d: -f1 > installed-base.txt
try:
    ib = open(os.path.expanduser("~/installed-base.txt"))
except IOError:
    print textwrap.dedent("""
    Missing file ~/installed-base.txt, can't continue.
    This file lists the packages that need to be on the installation CD
    (besides the debian-installer packages) in order for the CD image to be
    complete stand-alone. We use it to trim off a few hundred megabytes from
    the standard install CD. Make it from a just-completed preseeded Fester
    VM image like this:
    
    # dpkg-query --show|cut -f1|cut -d: -f1 > installed-base.txt

    Then transfer the file to ~ and run me again.
    """)
    raise
    
installed_pkgs = set(
    map(
        lambda x: x.rstrip(),
        ib.readlines()))

di_re = re.compile(r'^Package: ([^_]+).*$')
di_pkgs = set()
di_fn = "~/cd/dists/raring/main/debian-installer/binary-i386/Packages.gz"
for line in gzip.open(os.path.expanduser(di_fn)).readlines():
    mo = di_re.match(line)
    if mo:
        di_pkgs.add(mo.groups(1)[0].rstrip())

for entry in os.walk(os.path.expanduser("~/cd/pool")):
    for filename in entry[2]:
        pkgname = filename.split('_')[0]
        if not (pkgname in di_pkgs or pkgname in installed_pkgs):
            os.unlink(os.path.join(entry[0], filename))




