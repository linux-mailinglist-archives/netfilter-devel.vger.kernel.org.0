Return-Path: <netfilter-devel+bounces-13050-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xBF4K7EZIWqn/AAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13050-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 08:22:41 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BDE63D3C1
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 08:22:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=Daq+e+DR;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13050-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13050-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E648301C5BD
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jun 2026 06:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA5E3AE712;
	Thu,  4 Jun 2026 06:21:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F503D647F
	for <netfilter-devel@vger.kernel.org>; Thu,  4 Jun 2026 06:21:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554090; cv=none; b=DsZE7XZvnw2TBniLpDO6xeXX69WRNZEpCQO4jcq+RwQKMdrm+LIHN323VQaQx7I1NMHhoVn9/ux2JRuE9MOOvtDF2KU1/479JU02jwuK3Zane2Sl+PN986CJyyXGisnuG1lCKJL3aig8RWJPhhFyp5sOrqwJ27ASCrTeCli6My0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554090; c=relaxed/simple;
	bh=v76hdqRSoiSRUmVEgc2exyvHJ6K3C/VWunyOF2tMNIE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wad2j8NpJhlRlPXNosNQkY9YgeAbvGKjqMIVhNuNcKn3GlgsWzcuYd5uJVhv7kGkf4/tEHTys3toIizZ+Y4l5dlSmdyYefu6vnJg7pJ5NyLMAgw+P1zGCyqN0J2nEEtbmJWdkqc7e2Jpuw2bYBEMnjzphSkKPtz3WnYW/raPqP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Daq+e+DR; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id A131C6019C
	for <netfilter-devel@vger.kernel.org>; Thu,  4 Jun 2026 08:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780554087;
	bh=xzEOwOGItWGicAX1xTJiwsmUO/LEg149bq0llMolRIo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Daq+e+DRvjlsgePWNTHPlKlcsPgD5rJkfxsLIacMcPDCb2VCvXU+ijoWXAjZ5KHzx
	 tGO3OUmTjQi8G+t30WkooGMN99xEG8T1qDtZOTpruV9uHshc/uNNVzYcV7UwcSiF7n
	 SMfKlLOFsfr3SVfTGKh3n5+hUkiFgEPClJU4jOvLYvwD69B/t00R7wkJT1qqMrn9VE
	 ib7v/NNskUOYl9RhePGpYdde0iv4z0ccjLFuk8xLhzYv16KnEHIjTPf4s2R/c2knHi
	 jjqGeZK8OMvy6CQbOku8bvxYFzZcPLzal//r0qYq7TasBVS23N+nchbgn8UPbXGooW
	 p9TzuSvfh0JrA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v5 7/7] netfilter: ctnetlink: call helper->destroy() when unhelping conntrack
Date: Thu,  4 Jun 2026 08:21:14 +0200
Message-ID: <20260604062114.832273-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260604062114.832273-1-pablo@netfilter.org>
References: <20260604062114.832273-1-pablo@netfilter.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13050-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:mid,netfilter.org:dkim,netfilter.org:from_mime,netfilter.org:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04BDE63D3C1

The pptp helper maintains GRE mappings that need to be released in case
that the helper is unset. Wait for RCU grace period after unhelping the
conntrack to ensure that packet do not race to add new mapping.

Fixes: f09943fefe6b ("[NETFILTER]: nf_conntrack/nf_nat: add PPTP helper port")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v5: new in this series, after AI reviewer report.

 net/netfilter/nf_conntrack_netlink.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 958b3d6116f5..8d25bef43ac9 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1959,6 +1959,10 @@ static int ctnetlink_change_helper(struct nf_conn *ct,
 			/* we had a helper before ... */
 			nf_ct_remove_expectations(ct);
 			RCU_INIT_POINTER(help->helper, NULL);
+			if (helper->destroy) {
+				synchronize_rcu();
+				helper->destroy(ct);
+			}
 			if (refcount_dec_and_test(&helper->ct_refcnt))
 				kfree_rcu(helper, rcu);
 		}
-- 
2.47.3


