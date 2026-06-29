Return-Path: <netfilter-devel+bounces-13512-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EuVKMBiHQmq/9AkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13512-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 16:54:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6ED6DC546
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 16:54:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=gDuNkA3v;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13512-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13512-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83899305D80C
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ADE42315F;
	Mon, 29 Jun 2026 14:39:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A14218AE
	for <netfilter-devel@vger.kernel.org>; Mon, 29 Jun 2026 14:39:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743991; cv=none; b=JWYtJ8cJroTabsP9ItCc1eh9qGZjCExnS9kjA1ZT/7uf7tVkNtWtdvzNX8XViH9sJMKpQH44zgXmpqWV00BmtUSEgTBRLGnrqR+5Qso6eO83i+VSIbvAAI2g/ZZcwHsr8BeZLhYfr9FKWrs05bzkTX5fYDkF6dkfzR/6uSzSiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743991; c=relaxed/simple;
	bh=8iOOPC3tvSXN1gPOZAZ46resUuJl2e54i8kyl3SPXZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6thlnrztTQqksbhtHlIzu3o4s2Ilu6YfIOpocG9PZmQ1VghS73kPz6idsQ2pys8kxxrkHxmOrl0cUhlfX2bc40o+9GbGj3HlMkXgoVPKuoq1WHItkcTWF0U6ewePoCnEJ99+8WIE+n2jDsuQJBjhrQthYcHVfVgiPnA5zg1xKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=gDuNkA3v; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 5F0DA60588;
	Mon, 29 Jun 2026 16:39:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782743980;
	bh=4I0gLooVVwTSguRVVxXvfJgqhQfWSKNT/UxtAA8zLGI=;
	h=From:To:Cc:Subject:Date:From;
	b=gDuNkA3vN3zXZfDgi0ioU1866/rSBQTNKuFaqG6q8VdXPk080i1Iiu5Eq2QyeEYZ3
	 sF9np8Lvmm03l2SWkmOwM4zR3MNRjjC//wxmazJVmbjQImSaZqeHbvc1A/JRvkeS5q
	 CP6jPxk6WDrLRtiRx2b0AMAHc0d6G01blo6e1zgLtxCJLPKSG/mwRJVRetof1kLi7+
	 VsGn6gSutsgNVSU1ybrOKFU2eRIlOwGgvCzq8BFpftQeoIBTEdgy8uQOR/Yyffhw4I
	 DLpazcLwosM/MjtQuKQYanmH48Js+DOc1VB2v9R+3grB36RFCZv/s6sAkkyX6TlFQ6
	 qdChlHV2dsVFA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: chzhengyang2023@lzu.edu.cn,
	lorenzo@kernel.org
Subject: [PATCH nf 0/3] flowtable fixes for ipip tunnels
Date: Mon, 29 Jun 2026 16:39:33 +0200
Message-ID: <20260629143936.61239-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13512-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:chzhengyang2023@lzu.edu.cn,m:lorenzo@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:dkim,netfilter.org:mid,netfilter.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B6ED6DC546

Hi,

The following patchset contains fixes for the flowtable ipip support:

Patch #1 updates nf_flow_tunnel_ip{6}ip{6}_push() to use the dst_entry
         in this direction to calculate headroom and set iph->frag_off.
	 Apparently, nft_flow_tunnel_update_route() sets the right
	 dst_entry in this direction, but datapath uses the other direction.

Patch #2 adds a function to bail out early on any attempt to hardware
	 offload a flow entry which is not supported. Currently, ->num_tun
	 has no drivers supporting this.

Patch #3 makes dst_entry available for all xmit modes which is required
	 to reach the dst_entry when pushing the ipip header (see related
	 patch #1). Based on patch from Rein Wein.

This series is passing nft_flowtable.sh selftest here, including Ren Wei's
patch:

  [nf,v3,2/2] selftests: netfilter: add bridge tunnel flowtable regression
  https://patchwork.ozlabs.org/project/netfilter-devel/patch/5b8a9e87ff7b47401612bb0e0fc841d8bfdd333d.1782092221.git.chzhengyang2023@lzu.edu.cn/

which should be also be taken upstream.

Pablo Neira Ayuso (3):
  netfilter: flowtable: use dst in this direction when pushing IPIP header
  netfilter: flowtable: IPIP tunnel hardware offload is not yet support
  netfilter: flowtable: support IPIP tunnel with direct xmit

 include/net/netfilter/nf_flow_table.h |  4 ++--
 net/netfilter/nf_flow_table_core.c    | 15 +++++++++++----
 net/netfilter/nf_flow_table_ip.c      | 21 ++++++++++++---------
 net/netfilter/nf_flow_table_offload.c | 17 +++++++++++++++++
 4 files changed, 42 insertions(+), 15 deletions(-)

-- 
2.47.3


