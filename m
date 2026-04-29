Return-Path: <netfilter-devel+bounces-12292-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECxtBnoS8mningEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12292-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 16:15:22 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D78F4495783
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 16:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61C133012879
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943853FE355;
	Wed, 29 Apr 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="PSvvmYuS"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7CE3FE64E;
	Wed, 29 Apr 2026 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472082; cv=none; b=onXwYWJM28q0R9fcdFmxdoPSfjSLk6M0imbHzUPbdppXAKHK3tB/3jF1ejoaGvQM8Kx8llguVfMe4INljmCTdSFJifCyu0OIfTelqte+h/7KOzMq1uX6yQBXazOc06QNk7RnfklDotMOoLS/X2TFGNGTLhvMEILlpwJOTBHsmBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472082; c=relaxed/simple;
	bh=VTwq0UWthz0QpJzYDrKRtfiupj+O/yP9vV5eAzWzF8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6WhJezkvigNh4duaGJxDf7/THI7zvQLdUg4VWGb8bS5gKG0eIbzBfBDZHFqZN11f7qXpsaoS+uSOZ/9yzCsEwSZOgmXVQND30VB53FTxryt5IWtquv83nBAvHcu7w0DVn36jo/dKof/ObIwT8ONnZKixn1NkVUFI6cU2cjHKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=PSvvmYuS; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 99B4821CD8;
	Wed, 29 Apr 2026 17:14:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-transfer-encoding:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=eDhsBF6QpJzkCaUZXdy+0cspQLn0pC7/3H/qKuY5fz4=; b=PSvvmYuSvdTr
	HNr+cKaP6pvpzzeI0d/kSAXglBtD1sKNCi77sPYC0IMjwHToh15m/0DRwRuJb8Dp
	CMfjgx+XcleAqvoGT9U06lLvroikTFQGenS2Al74Zt0RDRS3FzxcZgnx8vjCqW4Z
	3dU2sQjvVJ+cO0Vu6KUAqAvS48P+RyDRSj7g6tV10nFDZhcuqgf9wStr9QxRTtp7
	MVxN+9+Q1iO97jh02AOlkXtiLqlUYWMeIJsWLprLAQLVq4mG5GCVr7jVfk6RFgGU
	dZuO3egiAH6xrmywpJRCQCF55LVZCtIO+zGg4f6fnDXKnpTiF3ycSLsflPMPdgTf
	IWTGDuxGPrGNEvMd/gL5KQuc+5SUdawov2AKNSHeEgzOACB+I1y78nO6IY8HwH7e
	8vw0GalrElHJzpaH/qJjOemG9zfWSEh8eys2vFONJ2ip4o4+uesTL0Hkq076ikem
	pm5kg8gUkoQZWRPe83bycZ4Q3ae6bYM6M3IQ556T7HuJLp2sK/H5Sp7x46SFDdsx
	YylqXKy6iH+4CGLuuqFq9Uh9X3Bp01SPYOFZAw1J0iBvbgRHwJfgb1uamEdXba9h
	IUu6zvZ50nv+E+AEv5gH1yV0Ii2gdpG81CDzb2Xm2c7mQF+PFirxwymRiyY4E/+6
	n6TLvM7d2UQt9VXwGbw7EKGCkayGJPc=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Wed, 29 Apr 2026 17:14:11 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id B26776088F;
	Wed, 29 Apr 2026 17:14:10 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.18.1) with ESMTP id 63TEBMjq085110;
	Wed, 29 Apr 2026 17:11:22 +0300
Received: (from root@localhost)
	by ja.home.ssi.bg (8.18.1/8.18.1/Submit) id 63TEBMjv085109;
	Wed, 29 Apr 2026 17:11:22 +0300
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        Waiman Long <longman@redhat.com>, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCHv2 nf 7/8] ipvs: Guard access of HK_TYPE_KTHREAD cpumask with RCU
Date: Wed, 29 Apr 2026 17:10:54 +0300
Message-ID: <20260429141055.85052-8-ja@ssi.bg>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429141055.85052-1-ja@ssi.bg>
References: <20260429141055.85052-1-ja@ssi.bg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D78F4495783
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-12292-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ssi.bg:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]

From: Waiman Long <longman@redhat.com>

The ip_vs_ctl.c file and the associated ip_vs.h file are the only places
in the kernel where HK_TYPE_KTHREAD cpumask is being retrieved and used.
Now that HK_TYPE_KTHREAD/HK_TYPE_DOMAIN cpumask can be changed at run
time. We need to use RCU to guard access to this cpumask to avoid a
potential UAF problem as the returned cpumask may be freed before it
is being used.

We can replace HK_TYPE_KTHREAD by HK_TYPE_DOMAIN as they are aliases
of each other, but keeping the HK_TYPE_KTHREAD name can highlight the
fact that it is the kthread initiated by ipvs that is being controlled.

Fixes: 03ff73510169 ("cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 include/net/ip_vs.h            | 20 ++++++++++++++++----
 net/netfilter/ipvs/ip_vs_ctl.c | 13 ++++++++-----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index d28ad8a0541f..02762ce73a0c 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -1412,7 +1412,7 @@ static inline int sysctl_run_estimation(struct netns_ipvs *ipvs)
 	return ipvs->sysctl_run_estimation;
 }
 
-static inline const struct cpumask *sysctl_est_cpulist(struct netns_ipvs *ipvs)
+static inline const struct cpumask *__sysctl_est_cpulist(struct netns_ipvs *ipvs)
 {
 	if (ipvs->est_cpulist_valid)
 		return ipvs->sysctl_est_cpulist;
@@ -1530,7 +1530,7 @@ static inline int sysctl_run_estimation(struct netns_ipvs *ipvs)
 	return 1;
 }
 
-static inline const struct cpumask *sysctl_est_cpulist(struct netns_ipvs *ipvs)
+static inline const struct cpumask *__sysctl_est_cpulist(struct netns_ipvs *ipvs)
 {
 	return housekeeping_cpumask(HK_TYPE_KTHREAD);
 }
@@ -1565,6 +1565,18 @@ static inline int sysctl_svc_lfactor(struct netns_ipvs *ipvs)
 	return READ_ONCE(ipvs->sysctl_svc_lfactor);
 }
 
+static inline bool sysctl_est_cpulist_empty(struct netns_ipvs *ipvs)
+{
+	guard(rcu)();
+	return cpumask_empty(__sysctl_est_cpulist(ipvs));
+}
+
+static inline unsigned int sysctl_est_cpulist_weight(struct netns_ipvs *ipvs)
+{
+	guard(rcu)();
+	return cpumask_weight(__sysctl_est_cpulist(ipvs));
+}
+
 /* IPVS core functions
  * (from ip_vs_core.c)
  */
@@ -1904,7 +1916,7 @@ static inline void ip_vs_est_stopped_recalc(struct netns_ipvs *ipvs)
 	/* Stop tasks while cpulist is empty or if disabled with flag */
 	ipvs->est_stopped = !sysctl_run_estimation(ipvs) ||
 			    (ipvs->est_cpulist_valid &&
-			     cpumask_empty(sysctl_est_cpulist(ipvs)));
+			     sysctl_est_cpulist_empty(ipvs));
 #endif
 }
 
@@ -1920,7 +1932,7 @@ static inline bool ip_vs_est_stopped(struct netns_ipvs *ipvs)
 static inline int ip_vs_est_max_threads(struct netns_ipvs *ipvs)
 {
 	unsigned int limit = IPVS_EST_CPU_KTHREADS *
-			     cpumask_weight(sysctl_est_cpulist(ipvs));
+			     sysctl_est_cpulist_weight(ipvs);
 
 	return max(1U, limit);
 }
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 5c9f8e0e238f..c7c7f6a7a9f6 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -2394,11 +2394,14 @@ static int ipvs_proc_est_cpumask_get(const struct ctl_table *table,
 
 	mutex_lock(&ipvs->est_mutex);
 
-	if (ipvs->est_cpulist_valid)
-		mask = *valp;
-	else
-		mask = (struct cpumask *)housekeeping_cpumask(HK_TYPE_KTHREAD);
-	ret = scnprintf(buffer, size, "%*pbl\n", cpumask_pr_args(mask));
+	/* HK_TYPE_KTHREAD cpumask needs RCU protection */
+	scoped_guard(rcu) {
+		if (ipvs->est_cpulist_valid)
+			mask = *valp;
+		else
+			mask = (struct cpumask *)housekeeping_cpumask(HK_TYPE_KTHREAD);
+		ret = scnprintf(buffer, size, "%*pbl\n", cpumask_pr_args(mask));
+	}
 
 	mutex_unlock(&ipvs->est_mutex);
 
-- 
2.53.0



