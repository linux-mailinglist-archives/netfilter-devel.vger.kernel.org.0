Return-Path: <netfilter-devel+bounces-13553-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t618AhccRGpqogoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13553-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 21:42:15 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABFB6E79FE
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 21:42:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ssi.bg header.s=ssi header.b=4fRUP9OL;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13553-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13553-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ssi.bg;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFABB303331D
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 19:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B1C3D171B;
	Tue, 30 Jun 2026 19:42:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC0623EAAD;
	Tue, 30 Jun 2026 19:42:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782848530; cv=none; b=dwyNZeZlomfE/yhgRhUbex+JDbspR+jR/V14qNQmXWokgQQN6uF/NayxXr1NA5bbxh+HUaX8CXrMZxWL+ORPhzdfAszSdghr5uixefM+P4KzeVLpxmhFnFAgYfiB2pP7elgRH0wKburZdLlOle6qxND+WZu82PWzn7TgkCHUrvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782848530; c=relaxed/simple;
	bh=aNb61ZbTqlbPCMzEO19dNhnnKLlizlMPieAqbtIZzI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=per0DX2S6StA+KMpBF/BNkJck8TqiAfKh2m0Pnr2deek23m2YxjPEPVvKwrD8BABRe1qkKJBrwqPjsAldC7cHRnJ214uuS8TP33DyodPNrMkBYqbw+BMR9ShW3vPhwvbWpQTF0WmAGAdhBb00/F7RtyTAgU6g5Zd3dynQJXgyI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=4fRUP9OL; arc=none smtp.client-ip=193.238.174.39
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id B24592121A;
	Tue, 30 Jun 2026 22:42:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-transfer-encoding:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=HAcP9c7bTPE7QT6JOibiEYBFyOrHDBbHdX2Kqznh1zk=; b=4fRUP9OLGNj+
	qmAxmurRVVKGff5I6cWSh1cxWEXOrpovQgpFaveF82u4rBg6jVAqcnzpaQECctON
	aEPWh2WnTvT74+eW+twzS+iz75PzvCVrtZ1dBxdeSsXdEdPPIyWVzLztVe1UZ3AM
	N1ajMW7BNFbnOEYp5xzHWaMXasVTSUml8zV6mkW4RE5SR8bepms3cBfDUkNUq/1l
	Y1bzArEDcKGep0NjrWqfUNQgabe/z7yTRL1ms8j9QOsp+upsD3hhw4XcspD0p7P2
	v+wixMfYmQBxXhI4SN/3onZMtQp2inrJlpqqnMUtc65QRcXLEhA4uVIRNMSPNX4V
	3fpldKG7G/gFpkPNX/ZLf4I8D5G793mNeq0aaZ8Xl8AZEYO5rg6jvJGMKFHcjTAK
	L0eDEfwQHRzBfFmIxZGQc3nF68jMtPMSVj7i1Wi5FLVYEKSbKmr4mrvsvsUokQjH
	Rqlajfat+LspEZIBUzQ35K/YWds5CMsIabyFvRd1a+sEY0XgmDi6omqGmhXPGutJ
	kaPPUgUcZhQo39IrM7ZYSszKGLSpNJ86/tNqy+5LKVA/fV13n+6RNlNHlrGRfXWu
	QmFiNAW8Q0LrouVFLxRfm7QBJKwKIFvIXRI9l67j4LZuiavzBJulO+KXtns5BDnC
	1Ljb9u7+/4uh8bT6Tsox8/bhc2xKyzg=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Tue, 30 Jun 2026 22:42:04 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 0546361B49;
	Tue, 30 Jun 2026 22:42:06 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 65UJbxqh125374;
	Tue, 30 Jun 2026 22:37:59 +0300
Received: (from root@localhost)
	by ja.home.ssi.bg (8.18.2/8.18.2/Submit) id 65UJbuw2125372;
	Tue, 30 Jun 2026 22:37:56 +0300
From: Julian Anastasov <ja@ssi.bg>
To: tt roxy <roxy520tt@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yuantan098@gmail.com,
        yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn
Subject: [PATCH RFC nf 1/2] ipvs: do not propagate one_packet flag to hashed conns
Date: Tue, 30 Jun 2026 22:36:45 +0300
Message-ID: <20260630193647.125280-1-ja@ssi.bg>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <CALMqdkR704S2BG_QD_bgHTFp2+1QCi7n0T4zoZyTo8mDZevYSA@mail.gmail.com>
References: <CALMqdkR704S2BG_QD_bgHTFp2+1QCi7n0T4zoZyTo8mDZevYSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13553-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:roxy520tt@gmail.com,m:n05ec@lzu.edu.cn,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[ssi.bg:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ssi.bg:dkim,ssi.bg:email,ssi.bg:mid,ssi.bg:from_mime];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8ABFB6E79FE

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---

 This patch is just to help the testing of both patches. You will
 replace it with your own patch that should allow the second
 patch to be applied. Let me know if you see any problems.

 net/netfilter/ipvs/ip_vs_conn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index e76a73d183d5..805ca1fc3bc8 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -1014,6 +1014,9 @@ ip_vs_bind_dest(struct ip_vs_conn *cp, struct ip_vs_dest *dest)
 	flags = cp->flags;
 	/* Bind with the destination and its corresponding transmitter */
 	if (flags & IP_VS_CONN_F_SYNC) {
+		/* Synced conns are hashed, so they can not get this flag */
+		conn_flags &= ~IP_VS_CONN_F_ONE_PACKET;
+
 		/* if the connection is not template and is created
 		 * by sync, preserve the activity flag.
 		 */
-- 
2.54.0



