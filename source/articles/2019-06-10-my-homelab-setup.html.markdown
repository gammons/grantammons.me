---

title: my-homelab-setup
date: 2019-06-10 10:22 UTC
tags: homelab

---

I run a computer that has a lot of VMs on it.  It's my test bed for messing around with servers.

# The hardware

It's a NUC8I7BEH (https://www.amazon.com/Intel-NUC-Mainstream-Kit-NUC8i7BEH/dp/B07GX69JQP?th=1) with 32GB of ram.  The CPU is a i7-8559U with 4 cores / 8 threads.  This spec is plenty enough for practically anything I could throw at it.

NUCs are great because they are small (about the same size as a Mac mini), consume little power (28W TDP), and are practically silent, even under load.


# Host system

The entire VM setup is based upon [qemu](2), which is an open-source machine emulator that performs hardware virtualization.  It has near-native performance for the guest VMs, with the correct configuration.

The host OS is a bare-bones Arch linux with nothing other than the base config and qemu installed.

# Guest VMs

**Bitwarden**
I have a guest machine set up for [Bitwarden][3].  

**Unifi**
Unifi is the web-based controller for my home network.

**PiHole**
Pihole is essential nowadays.  

**Syncthing**
Syncthing is a replacement for Dropbox.

**Algo VPN**
I set up a VPN service.  This is so I can access my personal email and bitwarden passwords on my phone.  It also has the side benefit of blocking ads while I'm on a mobile network.

**Postfix**
I run my own incoming mail server for grant.dev.


### Future VMs

I plan running another VM specifically for testing / running a Kubernetes set up to host [Ultralist][4], a simple task management service I wrote.

# How it works


[2]: https://www.qemu.org/
[3]: https://bitwarden.com/
[4]: https://ultralist.io

