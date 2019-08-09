-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
VMware, https://www.vmware.com/

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Photon OS, https://vmware.github.io/photon/

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
Photon OS is a Linux distribution being used by VMware customers in a clouds
(vSphere, AWS) and on a bare metal. We use shim->grub2->Linux chain for
Secure Boot support. It does need to be signed in order to boot the Phorot OS
on any device using UEFI CA certificate for Secure Boot.

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Monty Ijzerman
- Position: Staff Program Manager, Security Response
- Email address: mijzerman@vmware.com
- PGP: http://pgp.mit.edu/pks/lookup?op=vindex&search=0xC61F6A1D

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Edward Hawkins
- Position: Senior Security Program Manager
- Email address: ehawkins@vmware.com
- PGP: http://pgp.mit.edu/pks/lookup?op=vindex&search=0x405F7C6D

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/releases/tag/15

Tarball sha256sum: 473720200e6dae7cfd3ce7fb27c66367a8d6b08233fe63f01aa1d6b3888deeb6 shim-15.tar.bz2

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/tree/51413d1deb0df0debdf1d208723131ff0e36d3a3

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
There are no patches being applied.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
Install Ubuntu server 16.04 from http://releases.ubuntu.com/16.04.2/ubuntu-16.04.2-server-amd64.img
- sudo apt-get install build-essential gnu-efi
- wget https://vmware.bintray.com/photon_shim_review/shim-15/build-shim.sh
- wget https://vmware.bintray.com/photon_shim_review/shim-15/vmware_esx40.cer
- ./build-shim.sh

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
shim build log: https://vmware.bintray.com/photon_shim_review/shim-15/build-shim.log

-------------------------------------------------------------------------------
Add any additional information you think we may need to validate this shim
-------------------------------------------------------------------------------
