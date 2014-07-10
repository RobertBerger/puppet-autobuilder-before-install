# Class: autobuilder_before_install
#
# This module manages autobuilder_before_install
#
# Parameters: none
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage: 
# puppet apply --modulepath=/modules -e "class { 'autobuilder_before_install': }"
#

class autobuilder_before_install (
  $ensure = present
) {

   vcsrepo { "/home/genius/test/yocto-autobuilder":
            ensure => present,
            provider => git,
            source => 'git://git.yoctoproject.org/yocto-autobuilder',
#           revision => '46485b117ffde2d2255ed3d66d671e2684385035',
            revision => 'b6f4f74a7475e7180a8e8d1d51b6a4dfb563706d',
            user => 'genius'
   }

   vcsrepo { "/home/genius/test/autobuilder-patches":
            ensure => present,
            provider => git,
            source => 'https://github.com/RobertBerger/autobuilder-patches.git',
            user => 'genius'
   }

   vcsrepo { "/home/genius/test/meta-mainline":
            ensure => present,
            provider => git,
            source => 'https://github.com/RobertBerger/meta-mainline.git',
            revision => 'daisy-training-v3.14.x',
            user => 'genius'
   }

   include patch

   patch::file { '/home/genius/test/yocto-autobuilder/yocto-master/master.cfg':
           diff_source => '/home/genius/test/autobuilder-patches/before-install/0001-allow-only-1-build-at-a-time.patch',
           owner => 'genius',
           group => 'genius',
   }

 #  patch::file { '/home/genius/test/yocto-autobuilder/lib/python2.7/site-packages/autobuilder/buildsteps/MakeImageMD5s.py':
#         diff_source => '/home/genius/test/autobuilder-patches/before-install/0002-md5sums-for-now.patch',
#   }

   patch::file { '/home/genius/test/yocto-autobuilder/yocto-autobuilder-setup':
          diff_source => '/home/genius/test/autobuilder-patches/before-install/0003-genius-genius.patch',
          owner => 'genius',
          group => 'genius',
   }
}
