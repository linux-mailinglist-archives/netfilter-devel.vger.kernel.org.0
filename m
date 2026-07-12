Return-Path: <netfilter-devel+bounces-13873-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QtU8Iq7nU2pZgAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13873-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 21:14:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0D4745B44
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 21:14:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=frGnAVog;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13873-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13873-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57ECD300A102
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Jul 2026 19:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707DD370D69;
	Sun, 12 Jul 2026 19:13:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFD7372670
	for <netfilter-devel@vger.kernel.org>; Sun, 12 Jul 2026 19:13:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783883635; cv=none; b=eYdnm8XLHsDNncqRcJICe8K3EFyv0USLDdQAbaORMyIK3B7Et2OqTSFSKVAmqFX/AWZKONram1kORjqf5KqVqS8zcRt1LYhtPP0Q0bXdfL0odZcFJPGOoHcYRxTvEM1Pl3QA8spbFRN3Xja2kE1cVuf3j5nyinbhgSGyADVohjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783883635; c=relaxed/simple;
	bh=Mye7jNOzA9wHfBaf8QBtzzmG5iue/CNYZ06WWcD8TvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeDYZlKgqBf/v0SsBZUzImhIljIY3TRYz/tHAXOJILQxOGucBdSiYP4ILqRrvHTnaGDBtOlyy66NORFwmoSh7wOyBkgRrUw38qtBIjavAktfvmU/zkDSe7Mdgm4n8LhPsmJVaAxuJ93S5SUar4QTAx3knQruvG7K8G1w0nd17tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=frGnAVog; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id EAAAB60193;
	Sun, 12 Jul 2026 21:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783883629;
	bh=NH3mUtbQZzfheLe/G+uK5Zc+aAtr8VIQ0Z3UZ3lCfw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frGnAVogDr4xrAqS0nySx3ASYB+YCrEtFBje1LrcbtQrYY6e1nE2o2f/CoZH3EH5a
	 XcRJhK6RoNMri/pJ3d5NSD36AECoqzcr08BJkDY/bDdxqyG0USbhW2lZ15/dXilzZG
	 yfteogDRnPuEwhaIC3l/UDuKEpYoGmKVo6yEJnO/0LwlGiND8QsrRsV+aAWH3YGdSK
	 f42X6U4xzhfJ5rZ+M70a948F6OMfG7m2QjfRoawRfbBU9ZAiBapB6ccfiiy97360XB
	 hZscf5xhDs/xR2mO75moXzY2Vng/5wWwUnicnZ9Uu5Q2k5C/A4tFSVW6anT+YuNxxj
	 azhdOJirye4eA==
Date: Sun, 12 Jul 2026 21:13:46 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: netfilter-devel@vger.kernel.org, razor@blackwall.org, fw@strlen.de
Subject: Re: [PATCH nf-next,v2 3/3] netfilter: flowtable: initial bridge
 support
Message-ID: <alPnatkWtPmXrusu@chamomile>
References: <20260710100729.1383580-1-pablo@netfilter.org>
 <20260710100729.1383580-4-pablo@netfilter.org>
 <9b423fa5-88cb-4197-9849-91e40901dd5b@gmail.com>
 <f332d077-bd3b-454f-a14d-73f7701e0644@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f332d077-bd3b-454f-a14d-73f7701e0644@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ericwouds@gmail.com,m:netfilter-devel@vger.kernel.org,m:razor@blackwall.org,m:fw@strlen.de,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13873-lists,netfilter-devel=lfdr.de];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:dkim,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC0D4745B44

On Sun, Jul 12, 2026 at 03:46:02PM +0200, Eric Woudstra wrote:
> On 7/12/26 11:27 AM, Eric Woudstra wrote:
> > On 7/10/26 12:07 PM, Pablo Neira Ayuso wrote:
[...]
> After fixing the problems in the patch-set mentioned earlier, when the sotware
> fastpath is setup correctly:

How are you testing this, my series is passing tests with netns and
veths with:

- plain bridge ports.
- VLAN devices used in the ports.

> Setting up a hardware offloaded flow, because the hardware supports it,
> this crashes:
>
> [  283.380108] Unable to handle kernel execute from non-executable memory at virtual address 0000000000000000
> [  283.389925] Mem abort info:
> [  283.393178]   ESR = 0x0000000086000004
> [  283.396940]   EC = 0x21: IABT (current EL), IL = 32 bits
> [  283.402299]   SET = 0, FnV = 0
> [  283.405358]   EA = 0, S1PTW = 0
> [  283.408498]   FSC = 0x04: level 0 translation fault
> [  283.413473] user pgtable: 4k pages, 48-bit VAs, pgdp=00000000419d9000
> [  283.419918] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
> [  283.426766] Internal error: Oops: 0000000086000004 [#1]  SMP
> [  283.432432] Modules linked in: nft_flow_offload nf_flow_table_inet nf_flow_table nft_masq nft_chain_nat nf_nat nf_conntrack_bridge nft_ct nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_tables cdc_mbim cdc_wdm cdc_ncm r8153_ecm cdc_ether usbnet r8152 mii mt7915e mt76_connac_lib mt76 mac80211 cfg80211 rfkill libarc4
> [  283.460181] CPU: 1 UID: 0 PID: 2420 Comm: kworker/u16:6 Not tainted 7.2.0-rc1-bpirnn #12 PREEMPT 
> [  283.469040] Hardware name: Bananapi BPI-R3 (DT)
> [  283.473558] Workqueue: nf_ft_offload_add flow_offload_work_handler [nf_flow_table]
> [  283.481128] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [  283.488084] pc : 0x0
> [  283.490269] lr : nf_flow_offload_rule_alloc+0x45c/0x4b0 [nf_flow_table]
> [  283.496875] sp : ffff8000830b3c90
> [  283.500176] x29: ffff8000830b3c90 x28: ffff00000afc06b8 x27: ffff000007a8a180
> [  283.507298] x26: ffff000006704000 x25: ffff000006704000 x24: ffff0000029598c8
> [  283.514420] x23: ffff00000af7ac50 x22: 0000000000000000 x21: ffff000006704000
> [  283.521541] x20: ffff000002959850 x19: ffff000002959800 x18: 0000000000000000
> [  283.528662] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> [  283.535785] x14: 0000000000000000 x13: 0000000000000008 x12: 0101010101010101
> [  283.542914] x11: 7f7f7f7f7f7f7f7f x10: fefefefefefeff63 x9 : 0000000000000000
> [  283.550038] x8 : ffff000001f25000 x7 : 0000000000000000 x6 : 000000000000003f
> [  283.557159] x5 : 00000000ffffffff x4 : 0000000000000000 x3 : ffff000002959800
> [  283.564280] x2 : 0000000000000000 x1 : ffff000006704000 x0 : ffff000007a8a180
> [  283.571405] Call trace:
> [  283.573841]  0x0 (P)
> [  283.576022]  flow_offload_work_handler+0x60/0x358 [nf_flow_table]
> [  283.582111]  process_scheduled_works+0x210/0x30c
> [  283.586731]  worker_thread+0x140/0x1d4
> [  283.590478]  kthread+0xf8/0x108
> [  283.593617]  ret_from_fork+0x10/0x20
> 
> Adding .action = nf_flow_rule_bridge, with the function as it is in my latest
> patch named "netfilter: nf_flow_table_offload: Add nf_flow_rule_bridge()",
> it does not crash and the hardware offloaded path functions like a charm.

I still have to reintroduce the _unsupp chunk which it is not included
in the version.

