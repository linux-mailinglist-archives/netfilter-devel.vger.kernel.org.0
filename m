Return-Path: <netfilter-devel+bounces-12807-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKDKGnBEFGqmLQcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12807-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 14:45:36 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9775CAA92
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79BB4301DCC2
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 May 2026 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38523383302;
	Mon, 25 May 2026 12:45:11 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDC3382F12
	for <netfilter-devel@vger.kernel.org>; Mon, 25 May 2026 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713111; cv=none; b=nexp7OPxh85YJnGx15zF1W564tVT6pb+itFWTVVXGqg24KHQW6oY8WiVIr41rQvXQtAslk7bHHc7sWQrQZkHv/l8DT23kxRuHJ9EJVyizDhr9Mj6JGpVzcMZyCdaBblEaUW7/9OGl7GEGKc4rBjHaO8ZNND1x/nMxKKsdXiukTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713111; c=relaxed/simple;
	bh=Ui7//IE7iXs+Qx+eIuOY4eoYvWwxTXBiQ6sGGCzqxCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sn0PbxD6x/pD8EN6WyzNMxT8J3bIUNa/6bpLwlqqonciCFRrMK1IfhQEIrwdafqLN3oTYMmmiT4Hd1GYn3KuxK4AxxqwsvdaAOypgpxv08e5Pu1omgy5RWi3f2qbvz1GYRmLqg1efRRdbZvlxxEQdqCZ308uPrzn5RI9VCDvgxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35259758C7;
	Mon, 25 May 2026 12:45:02 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1FC759C50;
	Mon, 25 May 2026 12:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4LhYLE1EFGq1SgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Mon, 25 May 2026 12:45:01 +0000
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	Fernando Fernandez Mancera <fmancera@suse.de>
Subject: [PATCH 4/4 nf v2] netfilter: synproxy: fix possible write to stale pointer
Date: Mon, 25 May 2026 14:44:50 +0200
Message-ID: <20260525124450.6043-5-fmancera@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525124450.6043-1-fmancera@suse.de>
References: <20260525124450.6043-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12807-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.965];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:mid,suse.de:email]
X-Rspamd-Queue-Id: ED9775CAA92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

skb_ensure_writable() is called to guarantee that the TCP options area
can be safely modified when adjusting the timestamp. As it expands or
linearize the skb head it might reallocate the data buffer.

This makes the th pointer passed by the caller stale. The following
writes to the TCP header might be done to a stale pointer.

Recalculating the th pointer after skb_ensure_writable() prevents this
issue from happening.

Fixes: 48b1de4c110a ("netfilter: add SYNPROXY core/target")
Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
---
 net/netfilter/nf_synproxy_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 5413133a42fa..84d36d4367a6 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -199,6 +199,7 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 
 	if (skb_ensure_writable(skb, optend))
 		return false;
+	th = (struct tcphdr *)(skb->data + protoff);
 
 	while (optoff < optend) {
 		unsigned char *op = skb->data + optoff;
-- 
2.53.0


