####
When having this error during installation of updates

```bash
https://nvidia.github.io/nvidia-container-runtime/centos7/x86_64/repodata/repomd.xml: [Errno -1] repomd.xml signature could not be verified for nvidia-container-runtime
Trying other mirror.


 One of the configured repositories failed (nvidia-container-runtime),
 and yum doesn't have enough cached data to continue. At this point the only
 safe thing yum can do is fail. There are a few ways to work "fix" this:

     1. Contact the upstream for the repository and get them to fix the problem.

     2. Reconfigure the baseurl/etc. for the repository, to point to a working
        upstream. This is most often useful if you are using a newer
        distribution release than is supported by the repository (and the
        packages for the previous distribution release still work).

     3. Run the command with the repository temporarily disabled
            yum --disablerepo=nvidia-container-runtime ...

     4. Disable the repository permanently, so yum won't use it by default. Yum
        will then just ignore the repository until you permanently enable it
        again or use --enablerepo for temporary usage:

            yum-config-manager --disable nvidia-container-runtime
        or
            subscription-manager repos --disable=nvidia-container-runtime

     5. Configure the failing repository to be skipped, if it is unavailable.
        Note that yum will try to contact the repo. when it runs most commands,
        so will have to try and fail each time (and thus. yum will be be much
        slower). If it is a very temporary problem though, this is often a nice
        compromise:

            yum-config-manager --save --setopt=nvidia-container-runtime.skip_if_unavailable=true

failure: repodata/repomd.xml from nvidia-container-runtime: [Errno 256] No more mirrors to try.
https://nvidia.github.io/nvidia-container-runtime/centos7/x86_64/repodata/repomd.xml: [Errno -1] repomd.xml signature could not be
```


We need to import a new key and delete the old one:

```bash
sudo gpg --homedir /var/lib/yum/repos/x86_64/7/libnvidia-container/gpgdir --delete-key F796ECB0
sudo gpg --homedir /var/lib/yum/repos/x86_64/7/nvidia-container-runtime/gpgdir --delete-key F796ECB0
sudo gpg --homedir /var/lib/yum/repos/x86_64/7/nvidia-docker/gpgdir --delete-key F796ECB0
sudo yum update
```


Link to the issue: https://github.com/NVIDIA/nvidia-docker/issues/836

