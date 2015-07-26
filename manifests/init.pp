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
#           revision => 'b6f4f74a7475e7180a8e8d1d51b6a4dfb563706d',
#           revision => '3d7aa93fc8ca9c3c38c58a66f7a03d9683b0c220',
#           revision => '92c7f27328dc444271a0949b858906612ffa40f3',
#           revision => '90053633470114703660bf6edf856dfe33710bd0',
#           revision => 'b7e7d2b8224f1261013cbd1e81cf166b63262d90',
#           revision => 'f31361e6d68c1c08274bb67fdc9d07e2f1645c2b',
            revision => '56ed1a21c6b78c1245ed8b84686e163c61eba71d',
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
            revision => 'fido-training-v4.1.x',
            user => 'genius'
   }

   include patch

   patch::file { '/home/genius/test/yocto-autobuilder/yocto-controller/controller.cfg.example':
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

   patch::file { '/home/genius/test/yocto-autobuilder/config/autobuilder.conf.example':
          diff_source => '/home/genius/test/autobuilder-patches/before-install/0004-generalize-num-of-CPUs.patch',
          owner => 'genius' ,
          group => 'genius' ,
   }

}
