Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99EA2E271A
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Dec 2020 14:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgLXNIK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Dec 2020 08:08:10 -0500
Received: from correo.us.es ([193.147.175.20]:43340 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbgLXNIJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Dec 2020 08:08:09 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 31791ADCE1
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Dec 2020 14:06:57 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 09C46DA72F
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Dec 2020 14:06:57 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id F3836DA730; Thu, 24 Dec 2020 14:06:56 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 83DF2DA72F
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Dec 2020 14:06:53 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 24 Dec 2020 14:06:53 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 6770A426CC84
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Dec 2020 14:06:53 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack-tools] conntrackd: add ip netns test script
Date:   Thu, 24 Dec 2020 14:07:13 +0100
Message-Id: <20201224130713.17517-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds a script that creates a ip netns testbed. The network
topology looks like this:

          veth0---veth0
 host     nsr1     ns2
 veth0----veth0
 ns1      veth2
            |
          veth0
          nsr2

* ns1 and ns2 are clients to generate traffic
* nsr1 and nsr2 run conntrackd to synchronize states
* nsr1 is the primary gateway
  - veth2 is used to synchronize states
* nsr2 is the backup gateway
  - veth0 is used to synchronize states

To set up the testbed:

	% sudo ./conntrackd-netns-test.sh start

To test your testbed works, from ns2:

	% sudo ip netns exec ns2 nc -l -p 8080

From ns1:

	% sudo ip netns exec ns1 nc -vvv 10.0.1.2 8080

From nsr1:

	% sudo ip netns exec nsr1 conntrackd -s -C conntrackd-nsr1.conf
	cache internal:
	current active connections:                1
	[...]
	cache external:
	current active connections:                0

From nsr2:

	% sudo ip netns exec nsr1 conntrackd -s -C conntrackd-nsr2.conf
	cache internal:
	current active connections:                0
	[...]
	cache external:
	current active connections:                1

To stop it:

	% sudo ./conntrackd-netns-test.sh stop

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 .../conntrackd/netns/conntrackd-netns-test.sh |  85 ++++
 tests/conntrackd/netns/conntrackd-nsr1.conf   | 413 ++++++++++++++++++
 tests/conntrackd/netns/conntrackd-nsr2.conf   | 413 ++++++++++++++++++
 tests/conntrackd/netns/ruleset-nsr1.nft       |   6 +
 4 files changed, 917 insertions(+)
 create mode 100755 tests/conntrackd/netns/conntrackd-netns-test.sh
 create mode 100644 tests/conntrackd/netns/conntrackd-nsr1.conf
 create mode 100644 tests/conntrackd/netns/conntrackd-nsr2.conf
 create mode 100644 tests/conntrackd/netns/ruleset-nsr1.nft

diff --git a/tests/conntrackd/netns/conntrackd-netns-test.sh b/tests/conntrackd/netns/conntrackd-netns-test.sh
new file mode 100755
index 000000000000..a0885c6437e5
--- /dev/null
+++ b/tests/conntrackd/netns/conntrackd-netns-test.sh
@@ -0,0 +1,85 @@
+#!/bin/bash
+
+#
+# testbed network topology
+#
+#          veth0---veth0
+# host     nsr1     ns2
+# veth0----veth0
+# ns1      veth2
+#            |
+#          veth0
+#          nsr2
+#
+# ns1 and ns2 are clients to generate traffic
+# nsr1 and nsr2 run conntrackd to synchronize states
+# nsr1 is the primary gateway
+# - veth2 is used to synchronize states
+# nsr2 is the backup gateway
+# - veth0 is used to synchronize states
+#
+
+if [ $UID -ne 0 ]
+then
+	echo "You must be root to run this test script"
+	exit 0
+fi
+
+start () {
+	ip netns add ns1
+	ip netns add ns2
+	ip netns add nsr1
+	ip netns add nsr2
+
+	ip link add veth0 netns ns1 type veth peer name veth1 netns nsr1
+	ip link add veth0 netns nsr1 type veth peer name veth0 netns ns2
+	ip link add veth2 netns nsr1 type veth peer name veth0 netns nsr2
+
+	ip -net ns1 addr add 192.168.10.2/24 dev veth0
+	ip -net ns1 link set up dev veth0
+	ip -net ns1 ro add 10.0.1.0/24 via 192.168.10.1 dev veth0
+
+	ip -net nsr1 addr add 10.0.1.1/24 dev veth0
+	ip -net nsr1 addr add 192.168.10.1/24 dev veth1
+	ip -net nsr1 link set up dev veth0
+	ip -net nsr1 link set up dev veth1
+	ip -net nsr1 route add default via 192.168.10.2
+	ip netns exec nsr1 sysctl net.ipv4.ip_forward=1
+
+	ip -net nsr1 addr add 192.168.100.2/24 dev veth2
+	ip -net nsr1 link set up dev veth2
+	ip -net nsr2 addr add 192.168.100.3/24 dev veth0
+	ip -net nsr2 link set up dev veth0
+
+	ip -net ns2 addr add 10.0.1.2/24 dev veth0
+	ip -net ns2 link set up dev veth0
+	ip -net ns2 route add default via 10.0.1.1
+
+	echo 1 > /proc/sys/net/netfilter/nf_log_all_netns
+
+	ip netns exec nsr1 nft -f ruleset-nsr1.nft
+	ip netns exec nsr1 conntrackd -C conntrackd-nsr1.conf -d
+	ip netns exec nsr2 conntrackd -C conntrackd-nsr2.conf -d
+}
+
+stop () {
+	ip netns del ns1
+	ip netns del ns2
+	ip netns del nsr1
+	ip netns del nsr2
+	killall -15 conntrackd
+}
+
+case $1 in
+start)
+	start
+	;;
+stop)
+	stop
+	;;
+*)
+	echo "$0 [start|stop]"
+	;;
+esac
+
+exit 0
diff --git a/tests/conntrackd/netns/conntrackd-nsr1.conf b/tests/conntrackd/netns/conntrackd-nsr1.conf
new file mode 100644
index 000000000000..864f8270e9d7
--- /dev/null
+++ b/tests/conntrackd/netns/conntrackd-nsr1.conf
@@ -0,0 +1,413 @@
+#
+# Synchronizer settings
+#
+Sync {
+	Mode FTFW {
+		#
+		# Size of the resend queue (in objects). This is the maximum
+		# number of objects that can be stored waiting to be confirmed
+		# via acknoledgment. If you keep this value low, the daemon
+		# will have less chances to recover state-changes under message
+		# omission. On the other hand, if you keep this value high,
+		# the daemon will consume more memory to store dead objects.
+		# Default is 131072 objects.
+		#
+		# ResendQueueSize 131072
+
+		#
+		# This parameter allows you to set an initial fixed timeout
+		# for the committed entries when this node goes from backup
+		# to primary. This mechanism provides a way to purge entries
+		# that were not recovered appropriately after the specified
+		# fixed timeout. If you set a low value, TCP entries in
+		# Established states with no traffic may hang. For example,
+		# an SSH connection without KeepAlive enabled. If not set,
+		# the daemon uses an approximate timeout value calculation
+		# mechanism. By default, this option is not set.
+		#
+		# CommitTimeout 180
+
+		#
+		# If the firewall replica goes from primary to backup,
+		# the conntrackd -t command is invoked in the script.
+		# This command schedules a flush of the table in N seconds.
+		# This is useful to purge the connection tracking table of
+		# zombie entries and avoid clashes with old entries if you
+		# trigger several consecutive hand-overs. Default is 60 seconds.
+		#
+		# PurgeTimeout 60
+
+		# Set the acknowledgement window size. If you decrease this
+		# value, the number of acknowlegdments increases. More
+		# acknowledgments means more overhead as conntrackd has to
+		# handle more control messages. On the other hand, if you
+		# increase this value, the resend queue gets more populated.
+		# This results in more overhead in the queue releasing.
+		# The following value is based on some practical experiments
+		# measuring the cycles spent by the acknowledgment handling
+		# with oprofile. If not set, default window size is 300.
+		#
+		# ACKWindowSize 300
+
+		#
+		# This clause allows you to disable the external cache. Thus,
+		# the state entries are directly injected into the kernel
+		# conntrack table. As a result, you save memory in user-space
+		# but you consume slots in the kernel conntrack table for
+		# backup state entries. Moreover, disabling the external cache
+		# means more CPU consumption. You need a Linux kernel
+		# >= 2.6.29 to use this feature. By default, this clause is
+		# set off. If you are installing conntrackd for first time,
+		# please read the user manual and I encourage you to consider
+		# using the fail-over scripts instead of enabling this option!
+		#
+		# DisableExternalCache Off
+	}
+
+	#
+	# Multicast IP and interface where messages are
+	# broadcasted (dedicated link). IMPORTANT: Make sure
+	# that iptables accepts traffic for destination
+	# 225.0.0.50, eg:
+	#
+	#	iptables -I INPUT -d 225.0.0.50 -j ACCEPT
+	#	iptables -I OUTPUT -d 225.0.0.50 -j ACCEPT
+	#
+	Multicast {
+		#
+		# Multicast address: The address that you use as destination
+		# in the synchronization messages. You do not have to add
+		# this IP to any of your existing interfaces. If any doubt,
+		# do not modify this value.
+		#
+		IPv4_address 225.0.0.50
+
+		#
+		# The multicast group that identifies the cluster. If any
+		# doubt, do not modify this value.
+		#
+		Group 3780
+
+		#
+		# IP address of the interface that you are going to use to
+		# send the synchronization messages. Remember that you must
+		# use a dedicated link for the synchronization messages.
+		#
+		IPv4_interface 192.168.100.2
+
+		#
+		# The name of the interface that you are going to use to
+		# send the synchronization messages.
+		#
+		Interface veth2
+
+		# The multicast sender uses a buffer to enqueue the packets
+		# that are going to be transmitted. The default size of this
+		# socket buffer is available at /proc/sys/net/core/wmem_default.
+		# This value determines the chances to have an overrun in the
+		# sender queue. The overrun results packet loss, thus, losing
+		# state information that would have to be retransmitted. If you
+		# notice some packet loss, you may want to increase the size
+		# of the sender buffer. The default size is usually around
+		# ~100 KBytes which is fairly small for busy firewalls.
+		#
+		SndSocketBuffer 1249280
+
+		# The multicast receiver uses a buffer to enqueue the packets
+		# that the socket is pending to handle. The default size of this
+		# socket buffer is available at /proc/sys/net/core/rmem_default.
+		# This value determines the chances to have an overrun in the
+		# receiver queue. The overrun results packet loss, thus, losing
+		# state information that would have to be retransmitted. If you
+		# notice some packet loss, you may want to increase the size of
+		# the receiver buffer. The default size is usually around
+		# ~100 KBytes which is fairly small for busy firewalls.
+		#
+		RcvSocketBuffer 1249280
+
+		#
+		# Enable/Disable message checksumming. This is a good
+		# property to achieve fault-tolerance. In case of doubt, do
+		# not modify this value.
+		#
+		Checksum on
+	}
+	#
+	# You can specify more than one dedicated link. Thus, if one dedicated
+	# link fails, conntrackd can fail-over to another. Note that adding
+	# more than one dedicated link does not mean that state-updates will
+	# be sent to all of them. There is only one active dedicated link at
+	# a given moment. The `Default' keyword indicates that this interface
+	# will be selected as the initial dedicated link. You can have
+	# up to 4 redundant dedicated links. Note: Use different multicast
+	# groups for every redundant link.
+	#
+	# Multicast Default {
+	#	IPv4_address 225.0.0.51
+	#	Group 3781
+	#	IPv4_interface 192.168.100.101
+	#	Interface eth3
+	#	# SndSocketBuffer 1249280
+	#	# RcvSocketBuffer 1249280
+	#	Checksum on
+	# }
+
+	#
+	# You can use Unicast UDP instead of Multicast to propagate events.
+	# Note that you cannot use unicast UDP and Multicast at the same
+	# time, you can only select one.
+	#
+	# UDP {
+		#
+		# UDP address that this firewall uses to listen to events.
+		#
+		# IPv4_address 192.168.2.100
+		#
+		# or you may want to use an IPv6 address:
+		#
+		# IPv6_address fe80::215:58ff:fe28:5a27
+
+		#
+		# Destination UDP address that receives events, ie. the other
+		# firewall's dedicated link address.
+		#
+		# IPv4_Destination_Address 192.168.2.101
+		#
+		# or you may want to use an IPv6 address:
+		#
+		# IPv6_Destination_Address fe80::2d0:59ff:fe2a:775c
+
+		#
+		# UDP port used
+		#
+		# Port 3780
+
+		#
+		# The name of the interface that you are going to use to
+		# send the synchronization messages.
+		#
+		# Interface eth2
+
+		#
+		# The sender socket buffer size
+		#
+		# SndSocketBuffer 1249280
+
+		#
+		# The receiver socket buffer size
+		#
+		# RcvSocketBuffer 1249280
+
+		#
+		# Enable/Disable message checksumming.
+		#
+		# Checksum on
+	# }
+
+	#
+	# Other unsorted options that are related to the synchronization.
+	#
+	# Options {
+		#
+		# TCP state-entries have window tracking disabled by default,
+		# you can enable it with this option. As said, default is off.
+		# This feature requires a Linux kernel >= 2.6.36.
+		#
+		# TCPWindowTracking Off
+
+		# Set this option on if you want to enable the synchronization
+		# of expectations. You have to specify the list of helpers that
+		# you want to enable. Default is off. This feature requires
+		# a Linux kernel >= 3.5.
+		#
+		# ExpectationSync {
+		#	ftp
+		#	ras
+		#	q.931
+		#	h.245
+		#	sip
+		# }
+		#
+		# You can use this alternatively:
+		#
+		# ExpectationSync On
+		#
+		# If you want to synchronize expectations of all helpers.
+	# }
+}
+
+#
+# General settings
+#
+General {
+	#
+	# Enable systemd support. If conntrackd is compiled with the proper
+	# configuration, you can use a systemd service unit of Type=notify
+	# and use conntrackd with systemd watchdog as well.
+	# Default is: on if built with --enable-systemd, off otherwhise
+	#
+	#Systemd on
+
+	#
+	# Number of buckets in the cache hashtable. The bigger it is,
+	# the closer it gets to O(1) at the cost of consuming more memory.
+	# Read some documents about tuning hashtables for further reference.
+	#
+	HashSize 32768
+
+	#
+	# Maximum number of conntracks, it should be double of:
+	# $ cat /proc/sys/net/netfilter/nf_conntrack_max
+	# since the daemon may keep some dead entries cached for possible
+	# retransmission during state synchronization.
+	#
+	HashLimit 131072
+
+	#
+	# Logfile: on (/var/log/conntrackd.log), off, or a filename
+	# Default: off
+	#
+	LogFile on
+
+	#
+	# Syslog: on, off or a facility name (daemon (default) or local0..7)
+	# Default: off
+	#
+	#Syslog on
+
+	#
+	# Lockfile
+	#
+	LockFile /var/lock/conntrack-nsr1.lock
+
+	#
+	# Unix socket configuration
+	#
+	UNIX {
+		Path /var/run/conntrackd-nsr1.ctl
+	}
+
+	#
+	# Netlink event socket buffer size. If you do not specify this clause,
+	# the default buffer size value in /proc/sys/net/core/rmem_default is
+	# used. This default value is usually around 100 Kbytes which is
+	# fairly small for busy firewalls. This leads to event message dropping
+	# and high CPU consumption. This example configuration file sets the
+	# size to 2 MBytes to avoid this sort of problems.
+	#
+	NetlinkBufferSize 2097152
+
+	#
+	# The daemon doubles the size of the netlink event socket buffer size
+	# if it detects netlink event message dropping. This clause sets the
+	# maximum buffer size growth that can be reached. This example file
+	# sets the size to 8 MBytes.
+	#
+	NetlinkBufferSizeMaxGrowth 8388608
+
+	#
+	# If the daemon detects that Netlink is dropping state-change events,
+	# it automatically schedules a resynchronization against the Kernel
+	# after 30 seconds (default value). Resynchronizations are expensive
+	# in terms of CPU consumption since the daemon has to get the full
+	# kernel state-table and purge state-entries that do not exist anymore.
+	# Be careful of setting a very small value here. You have the following
+	# choices: On (enabled, use default 30 seconds value), Off (disabled)
+	# or Value (in seconds, to set a specific amount of time). If not
+	# specified, the daemon assumes that this option is enabled.
+	#
+	# NetlinkOverrunResync On
+
+	#
+	# If you want reliable event reporting over Netlink, set on this
+	# option. If you set on this clause, it is a good idea to set off
+	# NetlinkOverrunResync. This option is off by default and you need
+	# a Linux kernel >= 2.6.31.
+	#
+	# NetlinkEventsReliable Off
+
+	#
+	# By default, the daemon receives state updates following an
+	# event-driven model. You can modify this behaviour by switching to
+	# polling mode with the PollSecs clause. This clause tells conntrackd
+	# to dump the states in the kernel every N seconds. With regards to
+	# synchronization mode, the polling mode can only guarantee that
+	# long-lifetime states are recovered. The main advantage of this method
+	# is the reduction in the state replication at the cost of reducing the
+	# chances of recovering connections.
+	#
+	# PollSecs 15
+
+	#
+	# The daemon prioritizes the handling of state-change events coming
+	# from the core. With this clause, you can set the maximum number of
+	# state-change events (those coming from kernel-space) that the daemon
+	# will handle after which it will handle other events coming from the
+	# network or userspace. A low value improves interactivity (in terms of
+	# real-time behaviour) at the cost of extra CPU consumption.
+	# Default (if not set) is 100.
+	#
+	# EventIterationLimit 100
+
+	#
+	# Event filtering: This clause allows you to filter certain traffic,
+	# There are currently three filter-sets: Protocol, Address and
+	# State. The filter is attached to an action that can be: Accept or
+	# Ignore. Thus, you can define the event filtering policy of the
+	# filter-sets in positive or negative logic depending on your needs.
+	# You can select if conntrackd filters the event messages from
+	# user-space or kernel-space. The kernel-space event filtering
+	# saves some CPU cycles by avoiding the copy of the event message
+	# from kernel-space to user-space. The kernel-space event filtering
+	# is prefered, however, you require a Linux kernel >= 2.6.29 to
+	# filter from kernel-space. If you want to select kernel-space
+	# event filtering, use the keyword 'Kernelspace' instead of
+	# 'Userspace'.
+	#
+	Filter From Userspace {
+		#
+		# Accept only certain protocols: You may want to replicate
+		# the state of flows depending on their layer 4 protocol.
+		#
+		Protocol Accept {
+			TCP
+			SCTP
+			DCCP
+			# UDP
+			# ICMP # This requires a Linux kernel >= 2.6.31
+			# IPv6-ICMP # This requires a Linux kernel >= 2.6.31
+		}
+
+		#
+		# Ignore traffic for a certain set of IP's: Usually all the
+		# IP assigned to the firewall since local traffic must be
+		# ignored, only forwarded connections are worth to replicate.
+		# Note that these values depends on the local IPs that are
+		# assigned to the firewall.
+		#
+		Address Ignore {
+			IPv4_address 127.0.0.1 # loopback
+			IPv4_address 192.168.10.1
+			IPv4_address 10.0.10.1
+			IPv4_address 192.168.100.2 # dedicated link ip
+			#
+			# You can also specify networks in format IP/cidr.
+			# IPv4_address 192.168.0.0/24
+			#
+			# You can also specify an IPv6 address
+			# IPv6_address ::1
+		}
+
+		#
+		# Uncomment this line below if you want to filter by flow state.
+		# This option introduces a trade-off in the replication: it
+		# reduces CPU consumption at the cost of having lazy backup
+		# firewall replicas. The existing TCP states are: SYN_SENT,
+		# SYN_RECV, ESTABLISHED, FIN_WAIT, CLOSE_WAIT, LAST_ACK,
+		# TIME_WAIT, CLOSED, LISTEN.
+		#
+		# State Accept {
+		#	ESTABLISHED CLOSED TIME_WAIT CLOSE_WAIT for TCP
+		# }
+	}
+}
diff --git a/tests/conntrackd/netns/conntrackd-nsr2.conf b/tests/conntrackd/netns/conntrackd-nsr2.conf
new file mode 100644
index 000000000000..319eb6816cfd
--- /dev/null
+++ b/tests/conntrackd/netns/conntrackd-nsr2.conf
@@ -0,0 +1,413 @@
+#
+# Synchronizer settings
+#
+Sync {
+	Mode FTFW {
+		#
+		# Size of the resend queue (in objects). This is the maximum
+		# number of objects that can be stored waiting to be confirmed
+		# via acknoledgment. If you keep this value low, the daemon
+		# will have less chances to recover state-changes under message
+		# omission. On the other hand, if you keep this value high,
+		# the daemon will consume more memory to store dead objects.
+		# Default is 131072 objects.
+		#
+		# ResendQueueSize 131072
+
+		#
+		# This parameter allows you to set an initial fixed timeout
+		# for the committed entries when this node goes from backup
+		# to primary. This mechanism provides a way to purge entries
+		# that were not recovered appropriately after the specified
+		# fixed timeout. If you set a low value, TCP entries in
+		# Established states with no traffic may hang. For example,
+		# an SSH connection without KeepAlive enabled. If not set,
+		# the daemon uses an approximate timeout value calculation
+		# mechanism. By default, this option is not set.
+		#
+		# CommitTimeout 180
+
+		#
+		# If the firewall replica goes from primary to backup,
+		# the conntrackd -t command is invoked in the script.
+		# This command schedules a flush of the table in N seconds.
+		# This is useful to purge the connection tracking table of
+		# zombie entries and avoid clashes with old entries if you
+		# trigger several consecutive hand-overs. Default is 60 seconds.
+		#
+		# PurgeTimeout 60
+
+		# Set the acknowledgement window size. If you decrease this
+		# value, the number of acknowlegdments increases. More
+		# acknowledgments means more overhead as conntrackd has to
+		# handle more control messages. On the other hand, if you
+		# increase this value, the resend queue gets more populated.
+		# This results in more overhead in the queue releasing.
+		# The following value is based on some practical experiments
+		# measuring the cycles spent by the acknowledgment handling
+		# with oprofile. If not set, default window size is 300.
+		#
+		# ACKWindowSize 300
+
+		#
+		# This clause allows you to disable the external cache. Thus,
+		# the state entries are directly injected into the kernel
+		# conntrack table. As a result, you save memory in user-space
+		# but you consume slots in the kernel conntrack table for
+		# backup state entries. Moreover, disabling the external cache
+		# means more CPU consumption. You need a Linux kernel
+		# >= 2.6.29 to use this feature. By default, this clause is
+		# set off. If you are installing conntrackd for first time,
+		# please read the user manual and I encourage you to consider
+		# using the fail-over scripts instead of enabling this option!
+		#
+		# DisableExternalCache Off
+	}
+
+	#
+	# Multicast IP and interface where messages are
+	# broadcasted (dedicated link). IMPORTANT: Make sure
+	# that iptables accepts traffic for destination
+	# 225.0.0.50, eg:
+	#
+	#	iptables -I INPUT -d 225.0.0.50 -j ACCEPT
+	#	iptables -I OUTPUT -d 225.0.0.50 -j ACCEPT
+	#
+	Multicast {
+		#
+		# Multicast address: The address that you use as destination
+		# in the synchronization messages. You do not have to add
+		# this IP to any of your existing interfaces. If any doubt,
+		# do not modify this value.
+		#
+		IPv4_address 225.0.0.50
+
+		#
+		# The multicast group that identifies the cluster. If any
+		# doubt, do not modify this value.
+		#
+		Group 3780
+
+		#
+		# IP address of the interface that you are going to use to
+		# send the synchronization messages. Remember that you must
+		# use a dedicated link for the synchronization messages.
+		#
+		IPv4_interface 192.168.100.3
+
+		#
+		# The name of the interface that you are going to use to
+		# send the synchronization messages.
+		#
+		Interface veth0
+
+		# The multicast sender uses a buffer to enqueue the packets
+		# that are going to be transmitted. The default size of this
+		# socket buffer is available at /proc/sys/net/core/wmem_default.
+		# This value determines the chances to have an overrun in the
+		# sender queue. The overrun results packet loss, thus, losing
+		# state information that would have to be retransmitted. If you
+		# notice some packet loss, you may want to increase the size
+		# of the sender buffer. The default size is usually around
+		# ~100 KBytes which is fairly small for busy firewalls.
+		#
+		SndSocketBuffer 1249280
+
+		# The multicast receiver uses a buffer to enqueue the packets
+		# that the socket is pending to handle. The default size of this
+		# socket buffer is available at /proc/sys/net/core/rmem_default.
+		# This value determines the chances to have an overrun in the
+		# receiver queue. The overrun results packet loss, thus, losing
+		# state information that would have to be retransmitted. If you
+		# notice some packet loss, you may want to increase the size of
+		# the receiver buffer. The default size is usually around
+		# ~100 KBytes which is fairly small for busy firewalls.
+		#
+		RcvSocketBuffer 1249280
+
+		#
+		# Enable/Disable message checksumming. This is a good
+		# property to achieve fault-tolerance. In case of doubt, do
+		# not modify this value.
+		#
+		Checksum on
+	}
+	#
+	# You can specify more than one dedicated link. Thus, if one dedicated
+	# link fails, conntrackd can fail-over to another. Note that adding
+	# more than one dedicated link does not mean that state-updates will
+	# be sent to all of them. There is only one active dedicated link at
+	# a given moment. The `Default' keyword indicates that this interface
+	# will be selected as the initial dedicated link. You can have
+	# up to 4 redundant dedicated links. Note: Use different multicast
+	# groups for every redundant link.
+	#
+	# Multicast Default {
+	#	IPv4_address 225.0.0.51
+	#	Group 3781
+	#	IPv4_interface 192.168.100.101
+	#	Interface eth3
+	#	# SndSocketBuffer 1249280
+	#	# RcvSocketBuffer 1249280
+	#	Checksum on
+	# }
+
+	#
+	# You can use Unicast UDP instead of Multicast to propagate events.
+	# Note that you cannot use unicast UDP and Multicast at the same
+	# time, you can only select one.
+	#
+	# UDP {
+		#
+		# UDP address that this firewall uses to listen to events.
+		#
+		# IPv4_address 192.168.2.100
+		#
+		# or you may want to use an IPv6 address:
+		#
+		# IPv6_address fe80::215:58ff:fe28:5a27
+
+		#
+		# Destination UDP address that receives events, ie. the other
+		# firewall's dedicated link address.
+		#
+		# IPv4_Destination_Address 192.168.2.101
+		#
+		# or you may want to use an IPv6 address:
+		#
+		# IPv6_Destination_Address fe80::2d0:59ff:fe2a:775c
+
+		#
+		# UDP port used
+		#
+		# Port 3780
+
+		#
+		# The name of the interface that you are going to use to
+		# send the synchronization messages.
+		#
+		# Interface eth2
+
+		#
+		# The sender socket buffer size
+		#
+		# SndSocketBuffer 1249280
+
+		#
+		# The receiver socket buffer size
+		#
+		# RcvSocketBuffer 1249280
+
+		#
+		# Enable/Disable message checksumming.
+		#
+		# Checksum on
+	# }
+
+	#
+	# Other unsorted options that are related to the synchronization.
+	#
+	# Options {
+		#
+		# TCP state-entries have window tracking disabled by default,
+		# you can enable it with this option. As said, default is off.
+		# This feature requires a Linux kernel >= 2.6.36.
+		#
+		# TCPWindowTracking Off
+
+		# Set this option on if you want to enable the synchronization
+		# of expectations. You have to specify the list of helpers that
+		# you want to enable. Default is off. This feature requires
+		# a Linux kernel >= 3.5.
+		#
+		# ExpectationSync {
+		#	ftp
+		#	ras
+		#	q.931
+		#	h.245
+		#	sip
+		# }
+		#
+		# You can use this alternatively:
+		#
+		# ExpectationSync On
+		#
+		# If you want to synchronize expectations of all helpers.
+	# }
+}
+
+#
+# General settings
+#
+General {
+	#
+	# Enable systemd support. If conntrackd is compiled with the proper
+	# configuration, you can use a systemd service unit of Type=notify
+	# and use conntrackd with systemd watchdog as well.
+	# Default is: on if built with --enable-systemd, off otherwhise
+	#
+	#Systemd on
+
+	#
+	# Number of buckets in the cache hashtable. The bigger it is,
+	# the closer it gets to O(1) at the cost of consuming more memory.
+	# Read some documents about tuning hashtables for further reference.
+	#
+	HashSize 32768
+
+	#
+	# Maximum number of conntracks, it should be double of:
+	# $ cat /proc/sys/net/netfilter/nf_conntrack_max
+	# since the daemon may keep some dead entries cached for possible
+	# retransmission during state synchronization.
+	#
+	HashLimit 131072
+
+	#
+	# Logfile: on (/var/log/conntrackd.log), off, or a filename
+	# Default: off
+	#
+	LogFile on
+
+	#
+	# Syslog: on, off or a facility name (daemon (default) or local0..7)
+	# Default: off
+	#
+	#Syslog on
+
+	#
+	# Lockfile
+	#
+	LockFile /var/lock/conntrack-nsr2.lock
+
+	#
+	# Unix socket configuration
+	#
+	UNIX {
+		Path /var/run/conntrackd-nsr2.ctl
+	}
+
+	#
+	# Netlink event socket buffer size. If you do not specify this clause,
+	# the default buffer size value in /proc/sys/net/core/rmem_default is
+	# used. This default value is usually around 100 Kbytes which is
+	# fairly small for busy firewalls. This leads to event message dropping
+	# and high CPU consumption. This example configuration file sets the
+	# size to 2 MBytes to avoid this sort of problems.
+	#
+	NetlinkBufferSize 2097152
+
+	#
+	# The daemon doubles the size of the netlink event socket buffer size
+	# if it detects netlink event message dropping. This clause sets the
+	# maximum buffer size growth that can be reached. This example file
+	# sets the size to 8 MBytes.
+	#
+	NetlinkBufferSizeMaxGrowth 8388608
+
+	#
+	# If the daemon detects that Netlink is dropping state-change events,
+	# it automatically schedules a resynchronization against the Kernel
+	# after 30 seconds (default value). Resynchronizations are expensive
+	# in terms of CPU consumption since the daemon has to get the full
+	# kernel state-table and purge state-entries that do not exist anymore.
+	# Be careful of setting a very small value here. You have the following
+	# choices: On (enabled, use default 30 seconds value), Off (disabled)
+	# or Value (in seconds, to set a specific amount of time). If not
+	# specified, the daemon assumes that this option is enabled.
+	#
+	# NetlinkOverrunResync On
+
+	#
+	# If you want reliable event reporting over Netlink, set on this
+	# option. If you set on this clause, it is a good idea to set off
+	# NetlinkOverrunResync. This option is off by default and you need
+	# a Linux kernel >= 2.6.31.
+	#
+	# NetlinkEventsReliable Off
+
+	#
+	# By default, the daemon receives state updates following an
+	# event-driven model. You can modify this behaviour by switching to
+	# polling mode with the PollSecs clause. This clause tells conntrackd
+	# to dump the states in the kernel every N seconds. With regards to
+	# synchronization mode, the polling mode can only guarantee that
+	# long-lifetime states are recovered. The main advantage of this method
+	# is the reduction in the state replication at the cost of reducing the
+	# chances of recovering connections.
+	#
+	# PollSecs 15
+
+	#
+	# The daemon prioritizes the handling of state-change events coming
+	# from the core. With this clause, you can set the maximum number of
+	# state-change events (those coming from kernel-space) that the daemon
+	# will handle after which it will handle other events coming from the
+	# network or userspace. A low value improves interactivity (in terms of
+	# real-time behaviour) at the cost of extra CPU consumption.
+	# Default (if not set) is 100.
+	#
+	# EventIterationLimit 100
+
+	#
+	# Event filtering: This clause allows you to filter certain traffic,
+	# There are currently three filter-sets: Protocol, Address and
+	# State. The filter is attached to an action that can be: Accept or
+	# Ignore. Thus, you can define the event filtering policy of the
+	# filter-sets in positive or negative logic depending on your needs.
+	# You can select if conntrackd filters the event messages from
+	# user-space or kernel-space. The kernel-space event filtering
+	# saves some CPU cycles by avoiding the copy of the event message
+	# from kernel-space to user-space. The kernel-space event filtering
+	# is prefered, however, you require a Linux kernel >= 2.6.29 to
+	# filter from kernel-space. If you want to select kernel-space
+	# event filtering, use the keyword 'Kernelspace' instead of
+	# 'Userspace'.
+	#
+	Filter From Userspace {
+		#
+		# Accept only certain protocols: You may want to replicate
+		# the state of flows depending on their layer 4 protocol.
+		#
+		Protocol Accept {
+			TCP
+			SCTP
+			DCCP
+			# UDP
+			# ICMP # This requires a Linux kernel >= 2.6.31
+			# IPv6-ICMP # This requires a Linux kernel >= 2.6.31
+		}
+
+		#
+		# Ignore traffic for a certain set of IP's: Usually all the
+		# IP assigned to the firewall since local traffic must be
+		# ignored, only forwarded connections are worth to replicate.
+		# Note that these values depends on the local IPs that are
+		# assigned to the firewall.
+		#
+		Address Ignore {
+			IPv4_address 127.0.0.1 # loopback
+			IPv4_address 192.168.10.1
+			IPv4_address 10.0.10.1
+			IPv4_address 192.168.100.2 # dedicated link ip
+			#
+			# You can also specify networks in format IP/cidr.
+			# IPv4_address 192.168.0.0/24
+			#
+			# You can also specify an IPv6 address
+			# IPv6_address ::1
+		}
+
+		#
+		# Uncomment this line below if you want to filter by flow state.
+		# This option introduces a trade-off in the replication: it
+		# reduces CPU consumption at the cost of having lazy backup
+		# firewall replicas. The existing TCP states are: SYN_SENT,
+		# SYN_RECV, ESTABLISHED, FIN_WAIT, CLOSE_WAIT, LAST_ACK,
+		# TIME_WAIT, CLOSED, LISTEN.
+		#
+		# State Accept {
+		#	ESTABLISHED CLOSED TIME_WAIT CLOSE_WAIT for TCP
+		# }
+	}
+}
diff --git a/tests/conntrackd/netns/ruleset-nsr1.nft b/tests/conntrackd/netns/ruleset-nsr1.nft
new file mode 100644
index 000000000000..bd6f1b4df6dd
--- /dev/null
+++ b/tests/conntrackd/netns/ruleset-nsr1.nft
@@ -0,0 +1,6 @@
+table ip filter {
+	chain postrouting {
+		type nat hook postrouting priority srcnat; policy accept;
+		oif veth0 masquerade
+	}
+}
-- 
2.20.1

