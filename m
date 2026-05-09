Return-Path: <netfilter-devel+bounces-12518-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CztEAXw/mkMzwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12518-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 09 May 2026 10:27:49 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A98214FEAF2
	for <lists+netfilter-devel@lfdr.de>; Sat, 09 May 2026 10:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CE3D3029637
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 May 2026 08:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E1538B7D8;
	Sat,  9 May 2026 08:27:23 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D53288B1
	for <netfilter-devel@vger.kernel.org>; Sat,  9 May 2026 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778315243; cv=none; b=UzswdBjFKvqhTsjGOHCaBNAWrD+IOAGY9Vd5cQoEif/GTFKDlir7P6JblbhwLkliBt5LjOozk67QfSlZAGtcGvO18TkF/LP/Or3PYrATqSMYDx2HUDGG8YdW2VeBZ6agFJ3piSQ5ZhRPACDT/iRCuwDEAmVXjMUzs5PEyJ8oe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778315243; c=relaxed/simple;
	bh=qsrv1VmeA28HMIC8j2aIuY6th2+M94mbUe51ugwK9v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8LjeDvhWQW/uNRwB+rxIRJ3yYU9i5g7dX8BPrQ/+wIU45VOVfxXAbkb3e4q6oM3ySsrQbZ0rRPAGjwc+Fnhakiqacu+Eow/AOS9l5YKUYBGiUzki7c3v6/tDi93f8Qt/WSLDDnq3PnSd0JEk5uBU3e3KtRAW/m9K9OjyEDnFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id BC9AF605F3; Sat, 09 May 2026 10:27:15 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: nf_conntrack_helper: fix possible null deref during error log
Date: Sat,  9 May 2026 10:27:06 +0200
Message-ID: <20260509082710.10049-1-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A98214FEAF2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-12518-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.852];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Reported by sashiko: there is a small race window.

If a helper module is unloaded or a userspace-defined helper is
removed, nf_conntrack_helper_unregister() sets ->helper to NULL.

Handle this safely.  This needs a second patch to close related
race during nf_conntrack_helper_unregister().

Fixes: b20ab9cc63ca ("netfilter: nf_ct_helper: better logging for dropped packets")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_helper.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index b594cd244fe1..17e971bd4c74 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -321,8 +321,8 @@ __printf(3, 4)
 void nf_ct_helper_log(struct sk_buff *skb, const struct nf_conn *ct,
 		      const char *fmt, ...)
 {
+	const char *helper_name = "(null)";
 	const struct nf_conn_help *help;
-	const struct nf_conntrack_helper *helper;
 	struct va_format vaf;
 	va_list args;
 
@@ -331,14 +331,17 @@ void nf_ct_helper_log(struct sk_buff *skb, const struct nf_conn *ct,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	/* Called from the helper function, this call never fails */
 	help = nfct_help(ct);
+	if (help) {
+		const struct nf_conntrack_helper *helper;
 
-	/* rcu_read_lock()ed by nf_hook_thresh */
-	helper = rcu_dereference(help->helper);
+		helper = rcu_dereference(help->helper);
+		if (helper)
+			helper_name = helper->name;
+	}
 
 	nf_log_packet(nf_ct_net(ct), nf_ct_l3num(ct), 0, skb, NULL, NULL, NULL,
-		      "nf_ct_%s: dropping packet: %pV ", helper->name, &vaf);
+		      "helper %s dropping packet: %pV ", helper_name, &vaf);
 
 	va_end(args);
 }
-- 
2.54.0


