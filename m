Return-Path: <netfilter-devel+bounces-12815-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI2OFq2MFGozOQcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12815-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 19:53:49 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC1C5CD780
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 19:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 016833013724
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 17:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C2B2D9787;
	Mon, 25 May 2026 17:53:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622078462
	for <netfilter-devel@vger.kernel.org>; Mon, 25 May 2026 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731626; cv=none; b=nHC5jtfyHNsFsjcT6NOKP4v/UNse6WQ18vDVIq1M5oFkUr0GTuXfiSVQfltOdgpCtvm5mf3i16gsjTTYAGiFlB7gxcO382q8CUqBWZ/2oTw7WpOqrfjUDPbhWi4TxRGWA7cf1XG87E1RDQ8wWYlB+m5EhBl3W5SjBKP5y2CsVeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731626; c=relaxed/simple;
	bh=eGZGnF1/vH/i8T6SXiT16xpmMF9oB/vu5Ss2uA3zkIk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HoF+Dt4HbPHy489eAEg34B10r91w2+5qjBuS5vsoFtvVyT0kMjbgLoCEcg/E+WOmvfchwPjlkXNJeUsYzadFSmGtjDXUJ1uiuYFQQky9g8+XSh4Ukk8YDyCBidBYe50jlA3anPyQrxSzoJwucGEBGUMjBl9qBJOolU9M41dC4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 9677260595; Mon, 25 May 2026 19:53:35 +0200 (CEST)
Date: Mon, 25 May 2026 19:53:35 +0200
From: Florian Westphal <fw@strlen.de>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netfilter-devel@vger.kernel.org
Subject: Followup needed for netfilter: nft_fib_ipv6: walk fib6_siblings
 under RCU?
Message-ID: <ahSMn9GB65ztRN2e@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12815-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: DFC1C5CD780
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Sashiko claims we need this change:

diff --git a/net/ipv6/netfilter/nft_fib_ipv6.c b/net/ipv6/netfilter/nft_fib_ipv6.c
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -191,6 +191,9 @@ static bool nft_fib6_info_nh_uses_dev(struct fib6_info *rt,
 
                if (nft_fib6_info_nh_dev_match(nh_dev, dev))
                        return true;
+
+               if (!READ_ONCE(rt->fib6_nsiblings))
+                       return false;
        }
 
        return false;


Could ypu please check and send a followup if its correct?
AFAICS the nodes can be relinked to a *different* list and
then this turns into busyloop without the extra test.

https://sashiko.dev/#/patchset/20260520023411.391233-1-jiayuan.chen%40linux.dev

Thank you.

