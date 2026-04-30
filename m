Return-Path: <netfilter-devel+bounces-12324-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEwXONkJ82l0wwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12324-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 09:50:49 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFA49EE39
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 09:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 337103008226
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 07:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97933FA5E6;
	Thu, 30 Apr 2026 07:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="oWIIzpra"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341135836B;
	Thu, 30 Apr 2026 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535284; cv=none; b=RV3dK1M5ySviE7853+Os/CRXiy9Hfg5Utj2yEqhaziiufU3n9CbJPbdH2YUK5bgKhck1/a631kfVhY1b6ZsrXu9pCk45rxnstviHbeFuRqX0hc4bPbM68iFBt3bUdJmLwGUmIrfZFCnHVvz/uTyYYr04FlH8FBb53tlyt1jbEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535284; c=relaxed/simple;
	bh=dTo9HHruW8QVv/6+G5t8xN35S3zWzyhJt4phdhyCqTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZPOOGmhcCocYqUydV3Bpwf7MOa7L/Wvbd1dwLhwExy77RVuwDsxO2v5qhh6FOB2HmYRETcuJ31WRbhnr/Eba10Z+Ef3oh1FM5qNFL1FEPPljMFnbvInLvsdZir6WYz4FFaslEk70GE1U4esNzQcRgT9hNzKguJRUWGr0FxmHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=oWIIzpra; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 31A3A22930;
	Thu, 30 Apr 2026 10:47:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-transfer-encoding:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=+5l6HjIa6pEN1i6IQbOcoo3u2ww0YtZrxpJ29skJSz0=; b=oWIIzprak8go
	09LmI5ewAZXaG/X9IwBWluzPXz5nLnuHGq6JB5YnipnnVa8tfiBM+oCRgJe6zpgG
	EKca977K4ufN+XsiHPYQ+8RRwXTuiBtcoLVwzQYip3TC5wIZuYAJ0bW9/FSckduT
	gGC08zcppk70s4gbGe0URevMZsdEFSqAeyFwKdyUudxmwGSxY3k0neYq5FH0Hi1l
	RkUAazTBOLp9tAf2n/a+eRGwxOcyHtTWOJ731vcHszpOlrHpkoKpltMG3pgx+7vz
	h5F4g3334qmtu8OIH9/KnpfaZC/sOwBAu0w7oqlilOCJyyP3XrVjs+rHJTjcWOeS
	culQffY3+0zAoGsl7edip5+vPF4eu8059o5sNUSs3lKoece0NY1S6CFmK7jC/Ktk
	o9cpQzNG1EQEqA+NxLvcifTmkVkKw8DMcujr6Iq9JBPGKirpnx4JHnyDa8fSUxAk
	53klIjANQR37aGoNh+rP13OzppAGhbWm3H8EuX8Qzf40XbI1DTQeB2HMzyEm30k3
	Nwv+D/o4S/GsPSWsC3gNAamR5u0SkYMyOhFACFfIKy5D/ZAV1PkjmKbY2jMXn6g+
	O66miYrSkSvBCnCACGpUvoeZc9+cToQyGqZHAWTByO6bMXYIYKi2jvEzcQtsIVFw
	Q2yFtoXNuhjQBmpckoKXkxspPPmkxVQ=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Thu, 30 Apr 2026 10:47:53 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id EECF562B23;
	Thu, 30 Apr 2026 10:47:52 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.18.1) with ESMTP id 63U7iwgu027465;
	Thu, 30 Apr 2026 10:44:58 +0300
Received: (from root@localhost)
	by ja.home.ssi.bg (8.18.1/8.18.1/Submit) id 63U7iwCP027464;
	Thu, 30 Apr 2026 10:44:58 +0300
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Waiman Long <longman@redhat.com>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCHv3 nf 4/8] ipvs: do not leak dest after get from dest trash
Date: Thu, 30 Apr 2026 10:44:16 +0300
Message-ID: <20260430074420.26697-5-ja@ssi.bg>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260430074420.26697-1-ja@ssi.bg>
References: <20260430074420.26697-1-ja@ssi.bg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 46BFA49EE39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12324-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ssi.bg:email,ssi.bg:dkim,ssi.bg:mid,sashiko.dev:url];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ssi.bg:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[8]

Sashiko warns about leaked dest if ip_vs_start_estimator()
fails in ip_vs_add_dest(). Add ip_vs_trash_put_dest() to
put back the dest into dest trash.

Link: https://sashiko.dev/#/patchset/20260428175725.72050-1-ja%40ssi.bg
Fixes: 705dd3444081 ("ipvs: use kthreads for stats estimation")
Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 37 ++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index caec516856e9..d81077c2457a 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1102,6 +1102,24 @@ ip_vs_trash_get_dest(struct ip_vs_service *svc, int dest_af,
 	return dest;
 }
 
+/* Put destination in trash */
+static void ip_vs_trash_put_dest(struct netns_ipvs *ipvs,
+				 struct ip_vs_dest *dest, unsigned long istart,
+				 bool cleanup)
+{
+	spin_lock_bh(&ipvs->dest_trash_lock);
+	IP_VS_DBG_BUF(3, "Moving dest %s:%u into trash, dest->refcnt=%d\n",
+		      IP_VS_DBG_ADDR(dest->af, &dest->addr), ntohs(dest->port),
+		      refcount_read(&dest->refcnt));
+	if (list_empty(&ipvs->dest_trash) && !cleanup)
+		mod_timer(&ipvs->dest_trash_timer,
+			  jiffies + (IP_VS_DEST_TRASH_PERIOD >> 1));
+	/* dest lives in trash with reference */
+	list_add(&dest->t_list, &ipvs->dest_trash);
+	dest->idle_start = istart;
+	spin_unlock_bh(&ipvs->dest_trash_lock);
+}
+
 static void ip_vs_dest_rcu_free(struct rcu_head *head)
 {
 	struct ip_vs_dest *dest;
@@ -1461,9 +1479,12 @@ ip_vs_add_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 			      ntohs(dest->vport));
 
 		ret = ip_vs_start_estimator(svc->ipvs, &dest->stats);
+		/* On error put back dest into the trash */
 		if (ret < 0)
-			return ret;
-		__ip_vs_update_dest(svc, dest, udest, 1);
+			ip_vs_trash_put_dest(svc->ipvs, dest, dest->idle_start,
+					     false);
+		else
+			__ip_vs_update_dest(svc, dest, udest, 1);
 	} else {
 		/*
 		 * Allocate and initialize the dest structure
@@ -1533,17 +1554,7 @@ static void __ip_vs_del_dest(struct netns_ipvs *ipvs, struct ip_vs_dest *dest,
 	 */
 	ip_vs_rs_unhash(dest);
 
-	spin_lock_bh(&ipvs->dest_trash_lock);
-	IP_VS_DBG_BUF(3, "Moving dest %s:%u into trash, dest->refcnt=%d\n",
-		      IP_VS_DBG_ADDR(dest->af, &dest->addr), ntohs(dest->port),
-		      refcount_read(&dest->refcnt));
-	if (list_empty(&ipvs->dest_trash) && !cleanup)
-		mod_timer(&ipvs->dest_trash_timer,
-			  jiffies + (IP_VS_DEST_TRASH_PERIOD >> 1));
-	/* dest lives in trash with reference */
-	list_add(&dest->t_list, &ipvs->dest_trash);
-	dest->idle_start = 0;
-	spin_unlock_bh(&ipvs->dest_trash_lock);
+	ip_vs_trash_put_dest(ipvs, dest, 0, cleanup);
 
 	/* Queue up delayed work to expire all no destination connections.
 	 * No-op when CONFIG_SYSCTL is disabled.
-- 
2.53.0



