Return-Path: <netfilter-devel+bounces-12552-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFSPCAkOA2pI0AEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12552-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2026 13:24:57 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1449D51F4D2
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2026 13:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CF0A30008BB
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2026 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55ABC4A3408;
	Tue, 12 May 2026 11:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="ZhYWOplb"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993F4B8DE3
	for <netfilter-devel@vger.kernel.org>; Tue, 12 May 2026 11:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778585077; cv=none; b=dipMZvO6CNdlFF8M9xNbFiiiLnmIrmQf95itbw0TTv7qlvx9Z7fWysR/FK7AnacxvPGcw2zcAPw7urEqvy9fCf/bpzKkiqEP9scfHWh0Ydg4E5Tb1XJ7CucGzs8ez9/Y11VLpB5y7KA3TwqnX3fvRMHDT+Qf7P9qB0aUw7hwaFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778585077; c=relaxed/simple;
	bh=X6BxXFUJTG/Guu3mg8QwUMqmvoAhYOukNnL4G8ngDZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bk19LNxdnruYKH2PI7MInsfqjDkyWkRflVMEBnQAxwyXi626sNedFHMQ5n5o4zKzL3dNGddyDMjNRpPY+RwIE82m3cpGrXflDGkdmhF5PirosR+jQBEuABcN2WUHiF29n6F7TmhNIfDG+cUkbWffaR+/GgHQKa9dk4XlnR8Qns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=ZhYWOplb; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 2A94E6017D;
	Tue, 12 May 2026 13:24:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778585072;
	bh=snBmz6x1s42yTaEa2xGEdM3KSY3iDTf3kEI2BFUHYTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZhYWOplbENIQZfWwO2GOQ7AOivanmO3VXT8NmEjoCji0qpfxA+4vZw25AEYyv6Rbw
	 Y//oi4m7oYyxE32dEi4IyHhvnndg1VO0A4nshi5nFiElTj+WdxphFU2BWcv6x5C/ts
	 xYXfPn5NBR2G5pOZafmgCvNBfGhYGPP6qvpfnhbcxOxvs2c+H4RwjfKn3gyrl7oo2l
	 7D81QC34injeABZO/QVW9bFZju4ooYu3xzgC/B4qKpJVaVRrW6xVU+GZSYQ3nPTmO4
	 swBwMrIOj3Khe2kYeydBCWJ+V7TpaZ+8QvOA4l3AvzyzHf+nkkhTm9Azt8cMK/6mdB
	 dXjYqkCWr6p/w==
Date: Tue, 12 May 2026 13:24:29 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de, phil@nwl.cc,
	stephane.ml.bryant@gmail.com, yuantan098@gmail.com,
	yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
	royenheart@gmail.com
Subject: Re: [PATCH nf 1/1] netfilter: nf_queue: hold bridge skb->dev while
 queued
Message-ID: <agMN7WfUC7Xmc2cj@chamomile>
References: <cover.1778493188.git.royenheart@gmail.com>
 <ca7ee343bbcb44905e1f5b853df2f3a5b7d40548.1778493188.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lUc2ecu79LRwF7Ye"
Content-Disposition: inline
In-Reply-To: <ca7ee343bbcb44905e1f5b853df2f3a5b7d40548.1778493188.git.royenheart@gmail.com>
X-Rspamd-Queue-Id: 1449D51F4D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-diff];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12552-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,nwl.cc,gmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:dkim]
X-Rspamd-Action: no action


--lUc2ecu79LRwF7Ye
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, May 12, 2026 at 03:57:25PM +0800, Ren Wei wrote:
> From: Haoze Xie <royenheart@gmail.com>
> 
> br_pass_frame_up() rewrites skb->dev from the ingress port to the bridge
> master before queueing bridge LOCAL_IN packets. NFQUEUE only holds
> references on state.in/out and bridge physdevs, so a queued bridge
> packet can retain a freed bridge master in skb->dev until reinjection.
> 
> When the verdict is reinjected later, br_netif_receive_skb() re-enters
> the receive path with skb->dev still pointing at the freed bridge master,
> triggering a use-after-free.
> 
> Store skb->dev in the queue entry for bridge builds, hold a reference on
> it for the queue lifetime, and use the saved device when dropping queued
> packets during NETDEV_DOWN handling.

Next attempt: Maybe hold reference on skb->dev...

--lUc2ecu79LRwF7Ye
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="fix.patch"

diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index a6c81c04b3a5..26a4db5e17d4 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -66,6 +66,7 @@ static void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
 	if (state->sk)
 		nf_queue_sock_put(state->sk);
 
+	dev_put(entry->skb->dev);
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	dev_put(entry->physin);
 	dev_put(entry->physout);
@@ -104,6 +105,7 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 
 	dev_hold(state->in);
 	dev_hold(state->out);
+	dev_hold(entry->skb->dev);
 
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	dev_hold(entry->physin);

--lUc2ecu79LRwF7Ye--

