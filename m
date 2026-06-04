Return-Path: <netfilter-devel+bounces-13062-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d7lwKV7PIWrwOQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13062-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 21:17:50 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E953642D5C
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 21:17:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13062-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13062-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 570953018755
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jun 2026 19:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523030566F;
	Thu,  4 Jun 2026 19:17:47 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A013C3EA66
	for <netfilter-devel@vger.kernel.org>; Thu,  4 Jun 2026 19:17:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600667; cv=none; b=oH3HUq+3TgJHG0hxYcb8NNJlmV6XQwUpjnjCChrwSXZoSgQy4z0Jd+XWmjaI5YoMgrAUZp0tDYUC5WeBPi+RAK6IkpclZcnCHIB/m5J/0aBOT9YnGfhoOJQu/mA1s+v82Qb89kKCyDT53z2O9GqDX42bTadbB4euda28boDfTHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600667; c=relaxed/simple;
	bh=pugH9HMpPNbkawsKgIOGZRStLhijJaUyGx4fUYNRon4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QN7B1VeXKNuaLOPL5TruW8oxfzLE4cuZsr20As+tFBoU/pUvb2lHvK94xXxs+VBTvrfeMp5VtT8TmMX2D62yp6x/gM88WVTM7PbpD0JFhYq19nfO0YY5m05km03rt1qwFPsA0TmUgD3IadSRdebTYW4x5/4LJTpCUGE9+ZufKjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 5BABA60551; Thu, 04 Jun 2026 21:17:43 +0200 (CEST)
Date: Thu, 4 Jun 2026 21:17:42 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Possible device resouce leak in nf_offload infra
Message-ID: <aiHPPts-fb3oG9Sx@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13062-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E953642D5C

Hi Pablo

net/netfilter/nf_dup_netdev.c :

 70 int nft_fwd_dup_netdev_offload(struct nft_offload_ctx *ctx,
 71                                struct nft_flow_rule *flow,
 72                                enum flow_action_id id, int oif)
 73 {
 74         struct flow_action_entry *entry;
 75         struct net_device *dev;
 76
 77         /* nft_flow_rule_destroy() releases the reference on this device. */

This comment is no longer true.

 78         dev = dev_get_by_index(ctx->net, oif);
 79         if (!dev)
 80                 return -EOPNOTSUPP;
 81
 82         entry = nft_flow_action_entry_next(ctx, flow);
 83         if (!entry)
 84                 return -E2BIG;

... because nft_flow_rule_destroy() cannot drop the device
ref when we return here, as dev is not assigned to entry
yet (and we got no entry).

AFAICS its safe to just swap this and have
lines 77/78 moved after line 82.

nft_fwd_dup_netdev_offload() could also use some debug
check to make sure this doesn't get called for actions
other than FLOW_ACTION_REDIRECT/FLOW_ACTION_MIRRED as
those are the only ones where nft_flow_rule_destroy() takes
action.

(or accessors and comments that say that accesses to the
 hidden union are illegal).

Is the analysis correct?  I can make a patch.

