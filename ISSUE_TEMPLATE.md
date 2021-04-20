Make sure you have provided the following information:

 - [x] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [x] completed README.md file with the necessary information
 - [x] shim.efi to be signed
 - [x] public portion of your certificate(s) embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [-] binaries, for which hashes are added do vendor_db ( if you use vendor_db and have hashes allow-listed )
 - [-] any extra patches to shim via your own git tree or as files
 - [-] any extra patches to grub via your own git tree or as files
 - [x] build logs
 - [x] a Dockerfile to reproduce the build of the provided shim EFI binaries


###### What organization or people are asking to have this signed:
`VMware, https://www.vmware.com/`

###### What product or service is this for:
`Photon OS, https://vmware.github.io/photon/`

###### Please create your shim binaries starting with the 15.4 shim release tar file:
###### https://github.com/rhboot/shim/releases/download/15.4/shim-15.4.tar.bz2
###### This matches https://github.com/rhboot/shim/releases/tag/15.4 and contains
###### the appropriate gnu-efi source.
###### Please confirm this as the origin your shim.
We use the shim 15.4 release tarball.
Here is the review repo: [YustasSwamp/shim-review@vmware-shim-x86_64-20210419](https://github.com/YustasSwamp/shim-review/tree/vmware-shim-x86_64-20210419), which includes `README.md`, `shimx64.efi`, `photon_sb2020.der`, and the `build.log`.

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
Photon OS is a Linux distribution being used by VMware customers in a clouds
(vSphere, AWS, Azure, GCE) and on a bare metal. We use shim->grub2->Linux chain for
Secure Boot support. It does need to be signed in order to boot the Photon OS
on any device using UEFI CA certificate for Secure Boot.

###### How do you manage and protect the keys used in your SHIM?
It’s stored in HSMs which are operating in FIPS 140-2 Level 2 approved mode, only accessible by certain members of the build infrastructure team.  They’re located in physically secur
e areas of our datacenters.

###### Do you use EV certificates as embedded certificates in the SHIM?
`No`

###### If you use new vendor_db functionality, are any hashes allow-listed, and if yes: for what binaries ?
We don't use vendor_db in this build.

###### Is kernel upstream commit 75b0cea7bf307f362057cc778efe89af4c615354 present in your kernel, if you boot chain includes a Linux kernel ?
`Yes`

###### if SHIM is loading GRUB2 bootloader, are CVEs CVE-2020-14372,
###### CVE-2020-25632, CVE-2020-25647, CVE-2020-27749, CVE-2020-27779,
###### CVE-2021-20225, CVE-2021-20233, CVE-2020-10713, CVE-2020-14308,
###### CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705,
###### ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
###### and if you are shipping the shim_lock module CVE-2021-3418
###### fixed ?
`Yes`, these are all fixed.

###### "Please specifically confirm that you add a vendor specific SBAT entry for SBAT header in each binary that supports SBAT metadata
###### ( grub2, fwupd, fwupdate, shim + all child shim binaries )" to shim review doc ?
###### Please provide exact SBAT entries for all SBAT binaries you are booting or planning to boot directly through shim
On shim, we have:
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
shim,1,UEFI shim,shim,1,https://github.com/rhboot/shim
shim.photon,1,VMware Photon OS,shim,15.4-1.ph4,https://github.com/vmware/photon/tree/4.0/SPECS/shim-signed/
```

On grub2, we have:
```
sbat,1,SBAT Version,sbat,1,https://github.com/rhboot/shim/blob/main/SBAT.md
grub,1,Free Software Foundation,grub,2.06~rc1,https//www.gnu.org/software/grub/
grub.photon,1,VMware Photon OS,grub2,2.06~rc1-1.ph4,https://github.com/vmware/photon/tree/4.0/SPECS/grub2/
```

##### Were your old SHIM hashes provided to Microsoft ?
`Yes`

##### Did you change your certificate strategy, so that affected by CVE-2020-14372, CVE-2020-25632, CVE-2020-25647, CVE-2020-27749,
##### CVE-2020-27779, CVE-2021-20225, CVE-2021-20233, CVE-2020-10713,
##### CVE-2020-14308, CVE-2020-14309, CVE-2020-14310, CVE-2020-14311, CVE-2020-15705 ( July 2020 grub2 CVE list + March 2021 grub2 CVE list )
##### grub2 bootloaders can not be verified ?
We continue to use new photon_sb2020 certificate issued after boothole. Previous (and only one) shim-15 binary which embedded it was revoked. MS will update DBX on 04/22/2021.
Previously signed vulnerable grub2 image (without .sbat) is not allowed to boot by current shim.

##### What exact implementation of Secureboot in grub2 ( if this is your bootloader ) you have ?
##### * Upstream grub2 shim_lock verifier or * Downstream RHEL/Fedora/Debian/Canonical like implementation ?
We use upstream grub2 (2.06~rc1) shim_lock verifier.

###### What is the origin and full version number of your bootloader (GRUB or other)?
`Upstream grub2 2.06~rc1`

###### If your SHIM launches any other components, please provide further details on what is launched
`No`, only grub2

###### If your GRUB2 launches any other binaries that are not Linux kernel in SecureBoot mode,
###### please provide further details on what is launched and how it enforces Secureboot lockdown
`No`, only Linux

###### If you are re-using a previously used (CA) certificate, you
###### will need to add the hashes of the previous GRUB2 binaries
###### exposed to the CVEs to vendor_dbx in shim in order to prevent
###### GRUB2 from being able to chainload those older GRUB2 binaries. If
###### you are changing to a new (CA) certificate, this does not
###### apply. Please describe your strategy.
We use previous post-boothole certificate. shim-15 without SBAT support was revoked (DBXed). Previous grub2 image sighed with this key does not have .sbat and got rejected by this shim.

###### How do the launched components prevent execution of unauthenticated code?
Everything validates signatures using shim's protocol.

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
`No`

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
We use linux-4.19.y and linux-5.10.y kernels, which are all patched for the kernel `boothole` CVEs and lockdown support.

###### What changes were made since your SHIM was last signed?
Only upstream changes.

###### What is the SHA256 hash of your final SHIM binary?
```
[~/shim-review]$ sha256sum shimx64.efi
99ff0f437801fbd46d2b7cdba640fd4bee10128fcd065b68199541b9b8a33fc9  shimx64.efi
```
