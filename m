Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A91B70A23
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jul 2019 21:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbfGVTxl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jul 2019 15:53:41 -0400
Received: from mail.us.es ([193.147.175.20]:56778 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732364AbfGVTx3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:53:29 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 272DE81401
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jul 2019 21:53:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 14CED1150CB
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jul 2019 21:53:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0A952DA708; Mon, 22 Jul 2019 21:53:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E30CCDA732;
        Mon, 22 Jul 2019 21:53:23 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 22 Jul 2019 21:53:23 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from us.es (unknown [31.4.183.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: 1984lsi)
        by entrada.int (Postfix) with ESMTPSA id 76F794265A31;
        Mon, 22 Jul 2019 21:53:23 +0200 (CEST)
Date:   Mon, 22 Jul 2019 21:53:21 +0200
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fwestpha@redhat.com>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nf PATCH v2 1/2] net: nf_tables: Make nft_meta expression more
 robust
Message-ID: <20190722195321.uf2r5lp46bvslvtd@salvia>
References: <20190719123921.1249-1-phil@nwl.cc>
 <20190719163521.oozthobj33ejswrx@salvia>
 <20190720151502.GD32501@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azqmpx3tcpihrwon"
Content-Disposition: inline
In-Reply-To: <20190720151502.GD32501@orbyte.nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


--azqmpx3tcpihrwon
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 20, 2019 at 05:15:02PM +0200, Phil Sutter wrote:
> Hi,
> 
> On Fri, Jul 19, 2019 at 06:35:21PM +0200, Pablo Neira Ayuso wrote:
> > On Fri, Jul 19, 2019 at 02:39:20PM +0200, Phil Sutter wrote:
> > > nft_meta_get_eval()'s tendency to bail out setting NFT_BREAK verdict in
> > > situations where required data is missing breaks inverted checks
> > > like e.g.:
> > > 
> > > | meta iifname != eth0 accept
> > > 
> > > This rule will never match if there is no input interface (or it is not
> > > known) which is not intuitive and, what's worse, breaks consistency of
> > > iptables-nft with iptables-legacy.
> > > 
> > > Fix this by falling back to placing a value in dreg which never matches
> > > (avoiding accidental matches):
> > > 
> > > {I,O}IF:
> > > 	Use invalid ifindex value zero.
> > > 
> > > {BRI_,}{I,O}IFNAME, {I,O}IFKIND:
> > > 	Use an empty string which is neither a valid interface name nor
> > > 	kind.
> > > 
> > > {I,O}IFTYPE:
> > > 	Use ARPHRD_VOID (0xFFFF).
> > 
> > What could it be done with?
> > 
> > NFT_META_BRI_IIFPVID
> > NFT_META_BRI_IIFPVPROTO
> > 
> > Those will still not work for
> > 
> >         meta ibrpvid != 40
> > 
> > if interface is not available.
> > 
> > For VPROTO probably it's possible. I don't have a solution for
> > IIFPVID.
> 
> VLAN IDs 0 and 4095 are reserved, we could use those. I refrained from
> changing bridge VLAN matches because of IIFPVPROTO, no idea if there's
> an illegal value we could use for that. If you have an idea, I'm all for
> it. :)

I think we can add something like:

        NFT_META_BRI_IIFVLAN

just to check for br_vlan_enabled(), from userspace we can check for
exists/missing as a boolean, so we don't have to worry on assuming an
unused value for things like this. This can be added in the next
release cycle.

Regarding IIFTYPE / OIFTYPE, if there is no in-trees interfaces using
"", I think we are fine, probably send a patch to propose to disallow
this to net.

These ones are missing:

        NFT_META_IIFGROUP
        NFT_META_OIFGROUP

For these two, the default group (0) should be fine since every
interface is falling under this category by default.

I can squash this small patch to this one and push it one.

Thanks.

--azqmpx3tcpihrwon
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="x.patch"

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index d8d04ec1face..e2c6857c0f68 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -177,14 +177,10 @@ void nft_meta_get_eval(const struct nft_expr *expr,
 		*dest = raw_smp_processor_id();
 		break;
 	case NFT_META_IIFGROUP:
-		if (in == NULL)
-			goto err;
-		*dest = in->group;
+		*dest = in ? in->group : 0;
 		break;
 	case NFT_META_OIFGROUP:
-		if (out == NULL)
-			goto err;
-		*dest = out->group;
+		*dest = out ? out->group : 0;
 		break;
 #ifdef CONFIG_CGROUP_NET_CLASSID
 	case NFT_META_CGROUP:

--azqmpx3tcpihrwon--
