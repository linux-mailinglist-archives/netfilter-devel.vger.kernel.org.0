Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E288A4C1E
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Sep 2019 23:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbfIAVCL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Sep 2019 17:02:11 -0400
Received: from kadath.azazel.net ([81.187.231.250]:53684 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729106AbfIAVCL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Sep 2019 17:02:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=V8HKsNI81lfsNthou4GPDYqf5yyziLrMxmteLfuwjm0=; b=bYA5VGgFnm7awzjfa2JnjNl/9w
        nH73a7JkowZV5EcT6hRYa6q0HQrTVHz87L0+62Hbd4+RocSAS14TSdpFez9LA0QyplgnmmGLUshUX
        abxC2x0XGXVk4CtZvisOqcDi4HNfcpOc+kZg1IvmJop3aJNJSGtDnf3ATFCLQ3v8obnFF5g4Inv6b
        IOcDOb2Ts8njCxM1/ti8nLkQ9Z/pvnldM0s2vFKzMnjWW8e8XaNqOGLUonFAmLwt9Z3mdPBLpbMfC
        /htQWUvkiDwaM2g9sQ4rZTZgcRtpjtj4i4v5z6WJQIdj1ESnIClef6v947ek5EvzCYZMosPgRP6Yi
        0nHGht4w==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4Wos-0002Uf-DG; Sun, 01 Sep 2019 21:51:30 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 28/29] netfilter: add IP_SET_HASH config option.
Date:   Sun,  1 Sep 2019 21:51:24 +0100
Message-Id: <20190901205126.6935-29-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190901205126.6935-1-jeremy@azazel.net>
References: <20190901205126.6935-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a hidden tristate option which is selected by all the IP_SET_HASH_*
options.  It will be used to wrap ip_set_hash.h.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/ipset/Kconfig | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/net/netfilter/ipset/Kconfig b/net/netfilter/ipset/Kconfig
index 8a5498a86df0..56b95e859043 100644
--- a/net/netfilter/ipset/Kconfig
+++ b/net/netfilter/ipset/Kconfig
@@ -58,9 +58,13 @@ config IP_SET_BITMAP_PORT
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
+config IP_SET_HASH
+	tristate
+
 config IP_SET_HASH_IP
 	tristate "hash:ip set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:ip set type support, by which one
 	  can store arbitrary IPv4 or IPv6 addresses (or network addresses)
@@ -71,6 +75,7 @@ config IP_SET_HASH_IP
 config IP_SET_HASH_IPMARK
 	tristate "hash:ip,mark set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:ip,mark set type support, by which one
 	  can store IPv4/IPv6 address and mark pairs.
@@ -80,6 +85,7 @@ config IP_SET_HASH_IPMARK
 config IP_SET_HASH_IPPORT
 	tristate "hash:ip,port set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:ip,port set type support, by which one
 	  can store IPv4/IPv6 address and protocol/port pairs.
@@ -89,6 +95,7 @@ config IP_SET_HASH_IPPORT
 config IP_SET_HASH_IPPORTIP
 	tristate "hash:ip,port,ip set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:ip,port,ip set type support, by which
 	  one can store IPv4/IPv6 address, protocol/port, and IPv4/IPv6
@@ -99,6 +106,7 @@ config IP_SET_HASH_IPPORTIP
 config IP_SET_HASH_IPPORTNET
 	tristate "hash:ip,port,net set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:ip,port,net set type support, by which
 	  one can store IPv4/IPv6 address, protocol/port, and IPv4/IPv6
@@ -109,6 +117,7 @@ config IP_SET_HASH_IPPORTNET
 config IP_SET_HASH_IPMAC
 	tristate "hash:ip,mac set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:ip,mac set type support, by which
 	  one can store IPv4/IPv6 address and MAC (ethernet address) pairs in a set.
@@ -118,6 +127,7 @@ config IP_SET_HASH_IPMAC
 config IP_SET_HASH_MAC
 	tristate "hash:mac set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:mac set type support, by which
 	  one can store MAC (ethernet address) elements in a set.
@@ -127,6 +137,7 @@ config IP_SET_HASH_MAC
 config IP_SET_HASH_NETPORTNET
 	tristate "hash:net,port,net set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:net,port,net set type support, by which
 	  one can store two IPv4/IPv6 subnets, and a protocol/port in a set.
@@ -136,6 +147,7 @@ config IP_SET_HASH_NETPORTNET
 config IP_SET_HASH_NET
 	tristate "hash:net set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:net set type support, by which
 	  one can store IPv4/IPv6 network address/prefix elements in a set.
@@ -145,6 +157,7 @@ config IP_SET_HASH_NET
 config IP_SET_HASH_NETNET
 	tristate "hash:net,net set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:net,net  set type support, by which
 	  one can store IPv4/IPv6 network address/prefix pairs in a set.
@@ -154,6 +167,7 @@ config IP_SET_HASH_NETNET
 config IP_SET_HASH_NETPORT
 	tristate "hash:net,port set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:net,port set type support, by which
 	  one can store IPv4/IPv6 network address/prefix and
@@ -164,6 +178,7 @@ config IP_SET_HASH_NETPORT
 config IP_SET_HASH_NETIFACE
 	tristate "hash:net,iface set support"
 	depends on IP_SET
+	select IP_SET_HASH
 	help
 	  This option adds the hash:net,iface set type support, by which
 	  one can store IPv4/IPv6 network address/prefix and
-- 
2.23.0.rc1

