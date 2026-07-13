Return-Path: <netfilter-devel+bounces-13921-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A/heOU4UVWr4jgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13921-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 18:37:34 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A5F74DA96
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 18:37:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=oF5vypA7;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13921-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13921-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 529A4301F497
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 16:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7697243803C;
	Mon, 13 Jul 2026 16:37:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C7140B363;
	Mon, 13 Jul 2026 16:37:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960650; cv=none; b=Ma72iCyeHVVZNLRz3KJzdxoBB4HljsJyQkGgXUnbb77fRT3BuF5qhzm+FWtblW3pEVcUMt1GQmzSZGllYuORSEm0iZy1+l76ODX3Qf1P6OdpFWqjQALufeejjQZ6NpCVEZFbN0oIaqHsMy61DYUYWLuydVuEBUccw9LSfsOdeFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960650; c=relaxed/simple;
	bh=6scaW2J2qf21cIApCJxfkJtUQpHKzhlP+xFnw+curr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGbO4WVRGuRSiasOZBiWA8QhkCCMBEjLQfsKPaEiKKlFIFk3Hi/3jMjTXOzG9MGDAmoBxqI5kq41V5MSc7y4xFWYil5B+RN7bcV+7kmUigDuoI2dTX51GOGma2/r15secwynq6Yb0jyUsdjC6eayP271zC331SgJBHyb7qtxRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=oF5vypA7; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 6B68B6019B;
	Mon, 13 Jul 2026 18:37:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783960646;
	bh=GJa8nPlZCR7ehCdSDWBoMCL6m7AlOgFGh+udXkLrOEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oF5vypA7EpKwY1+pDvfGVnK0KhsjSSov7QN5TQRAt2Cu7dpagNChnvMOL45ev6Wv0
	 ZRIWH4s78wZZxy0OMeww2wSAuSeKSZ3PiVRZReyaqvWabWhV/mr+lMAek2h7DeLnyS
	 Epu505H9YxAYmKDRCWmHS2AoCg0Hy5NSa94BDJMfwf+u5UD6yNk5vf2JMbYACxSxUh
	 HtGqXzAiIOudtx4HkwgM2nkWBHjdSQh19mtUvUiO6Y089UcMDrrTSPzLOgjWe9a1hx
	 IF9M6OIF+hQSmNj3Scwv1rYAn+Lxg9koisb9xzh2vIbCsJy2BgdqxOakMxBZJW/Ph5
	 84m1NOF1I3Low==
Date: Mon, 13 Jul 2026 18:37:23 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH v12 nf-next 3/7] netfilter: nf_flow_table_offload: Add
 nf_flow_rule_bridge()
Message-ID: <alUUQ368a0bmCnoi@chamomile>
References: <20260707091045.967678-1-ericwouds@gmail.com>
 <20260707091045.967678-4-ericwouds@gmail.com>
 <ak4dAXHDmTDRr7-b@chamomile>
 <81c3bf65-b19b-4f80-aa8e-c0c4b3f5d6a7@gmail.com>
 <alC64Vg_xihR-huW@chamomile>
 <12451f0d-7e5b-4697-a734-8200944b204f@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12451f0d-7e5b-4697-a734-8200944b204f@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ericwouds@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:razor@blackwall.org,m:idosch@nvidia.com,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:bridge@lists.linux.dev,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,strlen.de,nwl.cc,blackwall.org,nvidia.com,gmail.com,uwaterloo.ca,vger.kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13921-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:dkim,ozlabs.org:url,chamomile:mid,bridge_fastpath.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50A5F74DA96

Hi,

On Fri, Jul 10, 2026 at 05:16:44PM +0200, Eric Woudstra wrote:
> 
> 
> On 7/10/26 11:26 AM, Pablo Neira Ayuso wrote:
> > Hi Eric,
> > 
> > On Wed, Jul 08, 2026 at 08:36:11PM +0200, Eric Woudstra wrote:
> >> On 7/8/26 11:48 AM, Pablo Neira Ayuso wrote:
> >>> On Tue, Jul 07, 2026 at 11:10:41AM +0200, Eric Woudstra wrote:
> >>>> Add nf_flow_rule_bridge().
> >>>>
> >>>> It only calls the common rule and adds the redirect.
> >>>
> >>> I decided to use the new _unsupp() function, so we don't pretend
> >>> bridge hw offload is already supported. We will need a driver before
> >>> we can add this, this stub does not provide much. I guess your goal
> >>> was just to avoid a crash here.
> >>
> >> No, I am already using hw_offload between bridged interfaces
> >> on the mt7986 succesfully for almost 2 years.
> >> It works dsa-port to direct interface (lan1 to eth1 on Bananapi R3) and
> >> between direct interfaces (eth0 to eth1 on Bananapi-R3-mini)
> > 
> > Do you utilize the existing mt7986 driver in-tree without changes to
> > achive this hardware offload? Or you have still have out-of-tree
> > patches that need to be merged to achive this?
> 
> I do not change anything about the mediatek drivers to achieve hardware
> offload. No patch needed to fix hardware offload.

Good. I would suggest you follow up to replace my _unsupp() function
with the .action function once the initial flowtable bridge support
gets merged upstream, explaining what drivers you have tested, it
would be nice for the record.

But hold on a bit until initial steps are made to upstream the initial
infrastructure, please.

> However I do have a small fix for the offloading towards the mediatek
> wifi interface. This is a fix for the software fastpath already.
> Also with hardware offload to wifi interface, once the software fastpath
> is setup correctly (needs this patch), then the hardware offload functions
> correctly without any further patch. See patch:
> 
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260317101525.358016-1-ericwouds@gmail.com/
> 
> It is not reviewed yet.

I'm reading the commit description, info.indev = NULL is not returned
anymore, a rebase, review and re-post once initial bridge supports
gets added would be good.

This is to build a fast path between the bridge ports and wifi through
the SoC.

> >> It can also be tested with my bridge_fastpath.sh selftest script.
> >> This script uses veth-device pairs to test the software fastpath.
> >> It can also use 2 real interfaces interconnected in a loop of copper,
> >> when chosen with commandline arguments. Then it tests software- and
> >> hardware-fastpath. It also tests many different scenarios.
> >>
> >> So this is why I've added it, as it is already functional. If a software
> >> fastpath is setup correctly, the hardware fastpath is also functional.
> > 
> > Thanks for explaining.
> > 
> > I am targetting at a minimal subset of the flowtable bridge support at
> > this stage. There is a need to make progress with the
> > nf_conntrack_bridge counterpart before the flowtable bridge can get
> > more features (namely, bridge vlan filtering support).
> 
> I did send a newer version of my patch-set for nf_conntrack_bridge,
> last version also adding support to defrag/refrag. See:
> 
> https://patchwork.ozlabs.org/project/netfilter-devel/cover/20260512103347.102746-1-ericwouds@gmail.com/

I'm taking a look to the nf_conntrack_bridge side.

> I've added testcases for defrag/refrag to the bridge_fastpath.sh selftest
> script (v5), so I know it is functional.
> 
> For proper vlan filtering support, I do also believe you will need to
> introduce DEV_PATH_BR_VLAN_KEEP_HW, or do something similar. See:
> 
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260317101722.358640-1-ericwouds@gmail.com/

OK, this will be useful once bridge vlan filtering gets supported.

The existing proposal that extends the bridge fill_forward_path relies
uniquely on one single bridge port to decide whether keep, untag or
tag? Should this look for the pvid at the ingress bridge port (tag or
keep vlan), then look at the egress bridge port (for untagging).

