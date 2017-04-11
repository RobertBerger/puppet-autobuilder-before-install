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
            revision => 'f9b4e02730a5e712ee9085e2480f9a3b8b00f56d',
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
            revision => 'jethro-training-v4.4.x',
            user => 'genius'
   }

# bb: d458b310b43d4f69afbd16362f55cf2bf5afcb24 is needed for Python 2 support
# see: https://github.com/kergoth/bb/issues/28 - Jethro
# Morty is Python 3, so we can use mater I guess

   vcsrepo { "/home/genius/test/bb":
            ensure => present,
            provider => git,
            source => 'https://github.com/kergoth/bb.git',
#            revision => 'd458b310b43d4f69afbd16362f55cf2bf5afcb24',
            user => 'genius'
   }

   include patch

    patch::file { '/home/genius/test/yocto-autobuilder/bin/worker-init':
             diff_source => '/home/genius/test/autobuilder-patches/before-install/0001-genius-genius-part1.patch',
             owner => 'genius',
             group => 'genius',
    }

    patch::file { '/home/genius/test/yocto-autobuilder/yocto-autobuilder-setup':
             diff_source => '/home/genius/test/autobuilder-patches/before-install/0002-genius-genius-part2.patch',
             owner => 'genius',
             group => 'genius',
    }

    patch::file { '/home/genius/test/yocto-autobuilder/yocto-controller/controller.cfg.example':
             diff_source => '/home/genius/test/autobuilder-patches/before-install/0003-allow-only-one-build-at-the-time.patch',
             owner => 'genius',
             group => 'genius',
    }


    patch::file { '/home/genius/test/yocto-autobuilder/lib/python2.7/site-packages/autobuilder/buildsteps/PublishArtifacts.py':
             diff_source => '/home/genius/test/autobuilder-patches/before-install/0004-deal-only-with-built-toolchains-cp-also-md5-and-mani.patch',
             owner => 'genius',
             group => 'genius',
    }

   patch::file { '/home/genius/test/yocto-autobuilder/config/autobuilder.conf.example':
          diff_source => '/home/genius/test/autobuilder-patches/before-install/0005-generalize-num-of-CPUs.patch',
          owner => 'genius' ,
          group => 'genius' ,
   }

#   patch::file { '/home/genius/test/yocto-autobuilder/yocto-controller/controller.cfg.example':
#           diff_source => '/home/genius/test/autobuilder-patches/before-install/0001-allow-only-1-build-at-a-time.patch',
#           owner => 'genius',
#           group => 'genius',
#   }

 #  patch::file { '/home/genius/test/yocto-autobuilder/lib/python2.7/site-packages/autobuilder/buildsteps/MakeImageMD5s.py':
#         diff_source => '/home/genius/test/autobuilder-patches/before-install/0002-md5sums-for-now.patch',
#   }

#   patch::file { '/home/genius/test/yocto-autobuilder/yocto-autobuilder-setup':
#          diff_source => '/home/genius/test/autobuilder-patches/before-install/0003-genius-genius.patch',
#          owner => 'genius',
#          group => 'genius',
#   }

#   patch::file { '/home/genius/test/yocto-autobuilder/config/autobuilder.conf.example':
#          diff_source => '/home/genius/test/autobuilder-patches/before-install/0004-generalize-num-of-CPUs.patch',
#          owner => 'genius' ,
#          group => 'genius' ,
#   }

}
