Make sure you have provided the following information:

 - [x] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [x] any extra patches to shim via your own git tree or as files
 - [x] any extra patches to grub via your own git tree or as files
 - [x] build logs


###### What organization or people are asking to have this signed:
VMware, https://www.vmware.com/

###### What product or service is this for:
Photon OS, https://vmware.github.io/photon/

###### What is the origin and full version number of your shim?
We used shum-15 tarball.

sha256sum: 473720200e6dae7cfd3ce7fb27c66367a8d6b08233fe63f01aa1d6b3888deeb6 shim-15.tar.bz2

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
Photon OS is a Linux distribution being used by VMware customers in a clouds
(vSphere, AWS) and on a bare metal. We use shim->grub2->Linux chain for
Secure Boot support. It does need to be signed in order to boot the Phorot OS
on any device using UEFI CA certificate for Secure Boot.

###### How do you manage and protect the keys used in your SHIM?
It’s stored in HSMs which are operating in FIPS 140-2 Level 2 approved mode, only accessible by certain members of the build infrastructure team.  They’re located in physically secure areas of our datacenters.

###### Do you use EV certificates as embedded certificates in the SHIM?
Yes

###### What is the origin and full version number of your bootloader (GRUB or other)?
We use ftp://ftp.gnu.org/gnu/grub/grub-2.02.tar.xz plus release-to-master
agregated patch: https://github.com/vmware/photon/blob/master/SPECS/grub2/release-to-master.patch

###### If your SHIM launches any other components, please provide further details on what is launched
N/A

###### How do the launched components prevent execution of unauthenticated code?
GRUB is patched to enforce Secure Boot.

Secure Boot enforcing pachset is taken from Fedora 29 and available here:

https://github.com/vmware/photon/tree/master/SPECS/grub2
- 0001-Add-support-for-Linux-EFI-stub-loading.patch
- 0002-Rework-linux-command.patch
- 0003-Rework-linux16-command.patch
- 0004-Add-secureboot-support-on-efi-chainloader.patch

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
We use linux-4.19.y. Current patchset and spec files we use are: https://github.com/vmware/photon/tree/master/SPECS/linux.
Set of patches to enforce secure Boot: https://github.com/vmware/photon/tree/master/SPECS/linux/secure-boot-patches
- 0001-security-integrity-remove-unnecessary-init_keyring-v.patch
- 0002-integrity-Define-a-trusted-platform-keyring.patch
- 0003-integrity-Load-certs-to-the-platform-keyring.patch
- 0004-efi-Add-EFI-signature-data-types.patch
- 0005-efi-Add-an-EFI-signature-blob-parser.patch
- 0006-efi-Import-certificates-from-UEFI-Secure-Boot.patch

###### What changes were made since your SHIM was last signed?
Previous shim we last signed was shim-12.

###### What is the hash of your final SHIM binary?
shimx64.efi sha256sum: 04a57e892c318848ab39e43cd3773238c1991c88da2c7bce1c89763b1173107e
