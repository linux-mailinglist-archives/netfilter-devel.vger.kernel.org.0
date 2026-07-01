Return-Path: <netfilter-devel+bounces-13580-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yKnnGh6IRWptBgsAu9opvQ
	(envelope-from <netfilter-devel+bounces-13580-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 23:35:26 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBDD6F1DDB
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 23:35:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ssi.bg header.s=ssi header.b=qJI8VJIf;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13580-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13580-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=ssi.bg;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3D733007F76
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2026 21:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045593A1A2D;
	Wed,  1 Jul 2026 21:30:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FD34DB52;
	Wed,  1 Jul 2026 21:30:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782941436; cv=none; b=WXE7RAzM6pK/J386sOUcYHGoYazYstmjJGsHq+V3RIsmH23jlVjpGyppspwlCrpVQCCrPrTPD31JCfZPbNV2WYlwoW8hMNvdPy009/kvcyGX+4qo0pqET9g8+oPD/FfpNWFLkAe6+vTvmutLCLeDpN1B3Hy51vVZNHXaqEObGXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782941436; c=relaxed/simple;
	bh=emgr7AcR9zV7A175hPGP6xoxZ5obxf/8siL2BKffT+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkXI9wb5Sd1zMz12zMO/fDc2r6gq/BccJU1mmLpX3KzAv/q2o59EI7AE1PtX2+NWbr2yAVH59/pcMlGH3wFCzOIpqbMZ/IAU2K4ZmFhYvQNLcOYs41wTpbYWno9fw7iKlz8cLx/WAqcurkJBgzLatU+1pCfStmbiknt5XHf2n0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=qJI8VJIf; arc=none smtp.client-ip=193.238.174.39
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id BD47A229E0;
	Thu, 02 Jul 2026 00:30:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-transfer-encoding:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=QjFSLsG1AZ7sN6KlEAZKRXgxPbH7yg3ncYMzzihX0KA=; b=qJI8VJIfqimh
	hgumf/J9oEWCkIMht+3d/cNfk+W2c25csW7ej7VuLC1Iud10+Xp9AB4dL3E3o3m+
	//LomvawPMGGwtUpj5LRhmqGaiK0XwsOXdicJksGVNap84TV6b/vNJ6XzSkRCkWN
	S2BsnKegaozSuAYceA2oB5thzkG7n1G0X9wh+ir0OYyZB0U0SoHyRedO6Wc64L1p
	RmJKMPIepW4S7yia5Qxv+M+tYYTbeafeSuBgl/2jX/hL1Gj9Kb+ziv20JUk3Otcv
	ZLB1ACu0sk1ma7KcH2E9vXyGiLY6HnjS2BHmevWw/DM/bcTxwFbarej3TP6xkHLD
	LKWnO47rYgONzq17hffaSxERWnx12H51kwDuiFse30FovXBa1S78VAeTP1isbEdv
	/TbHrnX26XrJ953awl+Xd/lm584frnc/OUdgM1EmgyESNnnMZc9h28eT8MvmrU+h
	Olm/fur1t64Rfq5yWSTfE4AC8tN7Z6WcibE2TGy4JzcopIGseEJTm8C1qkDyD0XA
	cFbas0RLBhyQ2vSuPu4pXwwGJXWn1Gd/KPCPxq7d19CpYQASiQeKAg3Ng/uDIQtW
	IWiFKUuB05fE0kLhUoqiMj6Z0faumteQcDdCQcwSk4Kw7zl/ZVMArg7YkV/gfREr
	2EACs8pmGymQsm+q6uJx3vj529X6nfE=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Thu, 02 Jul 2026 00:30:30 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 147B4608C2;
	Thu,  2 Jul 2026 00:30:32 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 661LQCJT003661;
	Thu, 2 Jul 2026 00:26:12 +0300
Received: (from root@localhost)
	by ja.home.ssi.bg (8.18.2/8.18.2/Submit) id 661LQ7vC003657;
	Thu, 2 Jul 2026 00:26:07 +0300
From: Julian Anastasov <ja@ssi.bg>
To: tt roxy <roxy520tt@gmail.com>
Cc: Ren Wei <n05ec@lzu.edu.cn>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yuantan098@gmail.com,
        yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn
Subject: [PATCH RFC nf v2 1/2] ipvs: do not propagate one_packet flag to hashed conns
Date: Thu,  2 Jul 2026 00:25:19 +0300
Message-ID: <20260701212520.3634-1-ja@ssi.bg>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-13580-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:roxy520tt@gmail.com,m:n05ec@lzu.edu.cn,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[ssi.bg:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ssi.bg:dkim,ssi.bg:email,ssi.bg:mid,ssi.bg:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CBDD6F1DDB

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---

 This patch is just to help the testing of both patches. You will
 replace it with your own patch that should allow the second
 patch to be applied. Let me know if you see any problems.

 net/netfilter/ipvs/ip_vs_conn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index cb36641f8d1c..c916eedd69c1 100644
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



