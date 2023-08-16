Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E395A77D7F9
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Aug 2023 03:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbjHPB6P (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Aug 2023 21:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241172AbjHPB5t (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:57:49 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028F26B9;
        Tue, 15 Aug 2023 18:57:31 -0700 (PDT)
Received: from mg.bb.i.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id 9003F121B4;
        Wed, 16 Aug 2023 04:57:30 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 76672121B3;
        Wed, 16 Aug 2023 04:57:30 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
        by ink.ssi.bg (Postfix) with ESMTPSA id ED9D23C07D4;
        Wed, 16 Aug 2023 04:57:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ssi.bg; s=ink;
        t=1692151029; bh=U7L3zoqhCwu5M8Fib74tMlUPBqHxZrA8d3dSyNTiFkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Cgb4JShpjNd4J2SLuQZanaSrwmpip6Ag84mIBUl/4AcQPeK+qQ6UJ7tOri6ycD9l7
         zQTy+OZtf6lzo8sUHJtAe4e74aioNzh+qehQx8BBnjeTpa7CRsxDlHvzUtyq95pAth
         Ge9Qvf2TUlCP3+17D5BMsOgrKIRmplKfXDHe527c=
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.17.1) with ESMTP id 37FHWGh2168632;
        Tue, 15 Aug 2023 20:32:16 +0300
Received: (from root@localhost)
        by ja.home.ssi.bg (8.17.1/8.17.1/Submit) id 37FHWGev168630;
        Tue, 15 Aug 2023 20:32:16 +0300
From:   Julian Anastasov <ja@ssi.bg>
To:     Simon Horman <horms@verge.net.au>
Cc:     lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        netdev@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: [PATCH RFC net-next 06/14] ipvs: use more counters to avoid service lookups
Date:   Tue, 15 Aug 2023 20:30:23 +0300
Message-ID: <20230815173031.168344-7-ja@ssi.bg>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815173031.168344-1-ja@ssi.bg>
References: <20230815173031.168344-1-ja@ssi.bg>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When new connection is created we can lookup for services multiple
times to support fallback options. We already have some counters
to skip specific lookups because it costs CPU cycles for hash
calculation, etc.

Add more counters for fwmark/non-fwmark services (fwm_services and
nonfwm_services) and make all counters per address family.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
---
 include/net/ip_vs.h             | 24 ++++++---
 net/netfilter/ipvs/ip_vs_core.c |  2 +-
 net/netfilter/ipvs/ip_vs_ctl.c  | 86 +++++++++++++++++++--------------
 3 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index b0a9f67a5c33..6b9b32257e10 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -271,6 +271,18 @@ static inline const char *ip_vs_dbg_addr(int af, char *buf, size_t buf_len,
 			pr_err(msg, ##__VA_ARGS__);			\
 	} while (0)
 
+/* For arrays per family */
+enum {
+	IP_VS_AF_INET,
+	IP_VS_AF_INET6,
+	IP_VS_AF_MAX
+};
+
+static inline int ip_vs_af_index(int af)
+{
+	return af == AF_INET6 ? IP_VS_AF_INET6 : IP_VS_AF_INET;
+}
+
 /* The port number of FTP service (in network order). */
 #define FTPPORT  cpu_to_be16(21)
 #define FTPDATA  cpu_to_be16(20)
@@ -940,17 +952,17 @@ struct netns_ipvs {
 	/* ip_vs_ctl */
 	struct ip_vs_stats_rcu	*tot_stats;      /* Statistics & est. */
 
-	int			num_services;    /* no of virtual services */
-	int			num_services6;   /* IPv6 virtual services */
-
 	/* Trash for destinations */
 	struct list_head	dest_trash;
 	spinlock_t		dest_trash_lock;
 	struct timer_list	dest_trash_timer; /* expiration timer */
 	/* Service counters */
-	atomic_t		ftpsvc_counter;
-	atomic_t		nullsvc_counter;
-	atomic_t		conn_out_counter;
+	atomic_t		num_services[IP_VS_AF_MAX];   /* Services */
+	atomic_t		fwm_services[IP_VS_AF_MAX];   /* Services */
+	atomic_t		nonfwm_services[IP_VS_AF_MAX];/* Services */
+	atomic_t		ftpsvc_counter[IP_VS_AF_MAX]; /* FTPPORT */
+	atomic_t		nullsvc_counter[IP_VS_AF_MAX];/* Zero port */
+	atomic_t		conn_out_counter[IP_VS_AF_MAX];/* out conn */
 
 #ifdef CONFIG_SYSCTL
 	/* delayed work for expiring no dest connections */
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index cb83ca506c5c..b56bef234ed4 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1404,7 +1404,7 @@ ip_vs_out_hook(void *priv, struct sk_buff *skb, const struct nf_hook_state *stat
 		return handle_response(af, skb, pd, cp, &iph, hooknum);
 
 	/* Check for real-server-started requests */
-	if (atomic_read(&ipvs->conn_out_counter)) {
+	if (atomic_read(&ipvs->conn_out_counter[ip_vs_af_index(af)])) {
 		/* Currently only for UDP:
 		 * connection oriented protocols typically use
 		 * ephemeral ports for outgoing connections, so
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 475521af5530..e44dfb97566a 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -437,35 +437,42 @@ struct ip_vs_service *
 ip_vs_service_find(struct netns_ipvs *ipvs, int af, __u32 fwmark, __u16 protocol,
 		   const union nf_inet_addr *vaddr, __be16 vport)
 {
-	struct ip_vs_service *svc;
+	struct ip_vs_service *svc = NULL;
+	int af_id = ip_vs_af_index(af);
 
 	/*
 	 *	Check the table hashed by fwmark first
 	 */
-	if (fwmark) {
+	if (fwmark && atomic_read(&ipvs->fwm_services[af_id])) {
 		svc = __ip_vs_svc_fwm_find(ipvs, af, fwmark);
 		if (svc)
 			goto out;
 	}
 
+	if (!atomic_read(&ipvs->nonfwm_services[af_id]))
+		goto out;
+
 	/*
 	 *	Check the table hashed by <protocol,addr,port>
 	 *	for "full" addressed entries
 	 */
 	svc = __ip_vs_service_find(ipvs, af, protocol, vaddr, vport);
+	if (svc)
+		goto out;
 
-	if (!svc && protocol == IPPROTO_TCP &&
-	    atomic_read(&ipvs->ftpsvc_counter) &&
+	if (protocol == IPPROTO_TCP &&
+	    atomic_read(&ipvs->ftpsvc_counter[af_id]) &&
 	    (vport == FTPDATA || !inet_port_requires_bind_service(ipvs->net, ntohs(vport)))) {
 		/*
 		 * Check if ftp service entry exists, the packet
 		 * might belong to FTP data connections.
 		 */
 		svc = __ip_vs_service_find(ipvs, af, protocol, vaddr, FTPPORT);
+		if (svc)
+			goto out;
 	}
 
-	if (svc == NULL
-	    && atomic_read(&ipvs->nullsvc_counter)) {
+	if (atomic_read(&ipvs->nullsvc_counter[af_id])) {
 		/*
 		 * Check if the catch-all port (port zero) exists
 		 */
@@ -1352,6 +1359,7 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 {
 	int ret = 0;
 	struct ip_vs_scheduler *sched = NULL;
+	int af_id = ip_vs_af_index(u->af);
 	struct ip_vs_pe *pe = NULL;
 	struct ip_vs_service *svc = NULL;
 	int ret_hooks = -1;
@@ -1396,8 +1404,7 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 	}
 #endif
 
-	if ((u->af == AF_INET && !ipvs->num_services) ||
-	    (u->af == AF_INET6 && !ipvs->num_services6)) {
+	if (!atomic_read(&ipvs->num_services[af_id])) {
 		ret = ip_vs_register_hooks(ipvs, u->af);
 		if (ret < 0)
 			goto out_err;
@@ -1448,17 +1455,17 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 
 	/* Update the virtual service counters */
 	if (svc->port == FTPPORT)
-		atomic_inc(&ipvs->ftpsvc_counter);
-	else if (svc->port == 0)
-		atomic_inc(&ipvs->nullsvc_counter);
+		atomic_inc(&ipvs->ftpsvc_counter[af_id]);
+	else if (!svc->port && !svc->fwmark)
+		atomic_inc(&ipvs->nullsvc_counter[af_id]);
 	if (svc->pe && svc->pe->conn_out)
-		atomic_inc(&ipvs->conn_out_counter);
+		atomic_inc(&ipvs->conn_out_counter[af_id]);
 
-	/* Count only IPv4 services for old get/setsockopt interface */
-	if (svc->af == AF_INET)
-		ipvs->num_services++;
-	else if (svc->af == AF_INET6)
-		ipvs->num_services6++;
+	if (svc->fwmark)
+		atomic_inc(&ipvs->fwm_services[af_id]);
+	else
+		atomic_inc(&ipvs->nonfwm_services[af_id]);
+	atomic_inc(&ipvs->num_services[af_id]);
 
 	/* Hash the service into the service table */
 	ip_vs_svc_hash(svc);
@@ -1503,6 +1510,8 @@ ip_vs_edit_service(struct ip_vs_service *svc, struct ip_vs_service_user_kern *u)
 	struct ip_vs_pe *pe = NULL, *old_pe = NULL;
 	int ret = 0;
 	bool new_pe_conn_out, old_pe_conn_out;
+	struct netns_ipvs *ipvs = svc->ipvs;
+	int af_id = ip_vs_af_index(svc->af);
 
 	/*
 	 * Lookup the scheduler, by 'u->sched_name'
@@ -1571,9 +1580,9 @@ ip_vs_edit_service(struct ip_vs_service *svc, struct ip_vs_service_user_kern *u)
 		new_pe_conn_out = (pe && pe->conn_out) ? true : false;
 		old_pe_conn_out = (old_pe && old_pe->conn_out) ? true : false;
 		if (new_pe_conn_out && !old_pe_conn_out)
-			atomic_inc(&svc->ipvs->conn_out_counter);
+			atomic_inc(&ipvs->conn_out_counter[af_id]);
 		if (old_pe_conn_out && !new_pe_conn_out)
-			atomic_dec(&svc->ipvs->conn_out_counter);
+			atomic_dec(&ipvs->conn_out_counter[af_id]);
 	}
 
 out:
@@ -1593,16 +1602,15 @@ static void __ip_vs_del_service(struct ip_vs_service *svc, bool cleanup)
 	struct ip_vs_scheduler *old_sched;
 	struct ip_vs_pe *old_pe;
 	struct netns_ipvs *ipvs = svc->ipvs;
+	int af_id = ip_vs_af_index(svc->af);
 
-	if (svc->af == AF_INET) {
-		ipvs->num_services--;
-		if (!ipvs->num_services)
-			ip_vs_unregister_hooks(ipvs, svc->af);
-	} else if (svc->af == AF_INET6) {
-		ipvs->num_services6--;
-		if (!ipvs->num_services6)
-			ip_vs_unregister_hooks(ipvs, svc->af);
-	}
+	atomic_dec(&ipvs->num_services[af_id]);
+	if (!atomic_read(&ipvs->num_services[af_id]))
+		ip_vs_unregister_hooks(ipvs, svc->af);
+	if (svc->fwmark)
+		atomic_dec(&ipvs->fwm_services[af_id]);
+	else
+		atomic_dec(&ipvs->nonfwm_services[af_id]);
 
 	ip_vs_stop_estimator(svc->ipvs, &svc->stats);
 
@@ -1614,7 +1622,7 @@ static void __ip_vs_del_service(struct ip_vs_service *svc, bool cleanup)
 	/* Unbind persistence engine, keep svc->pe */
 	old_pe = rcu_dereference_protected(svc->pe, 1);
 	if (old_pe && old_pe->conn_out)
-		atomic_dec(&ipvs->conn_out_counter);
+		atomic_dec(&ipvs->conn_out_counter[af_id]);
 	ip_vs_pe_put(old_pe);
 
 	/*
@@ -1629,9 +1637,9 @@ static void __ip_vs_del_service(struct ip_vs_service *svc, bool cleanup)
 	 *    Update the virtual service counters
 	 */
 	if (svc->port == FTPPORT)
-		atomic_dec(&ipvs->ftpsvc_counter);
-	else if (svc->port == 0)
-		atomic_dec(&ipvs->nullsvc_counter);
+		atomic_dec(&ipvs->ftpsvc_counter[af_id]);
+	else if (!svc->port && !svc->fwmark)
+		atomic_dec(&ipvs->nullsvc_counter[af_id]);
 
 	/*
 	 *    Free the service if nobody refers to it
@@ -2958,7 +2966,8 @@ do_ip_vs_get_ctl(struct sock *sk, int cmd, void __user *user, int *len)
 		struct ip_vs_getinfo info;
 		info.version = IP_VS_VERSION_CODE;
 		info.size = ip_vs_conn_tab_size;
-		info.num_services = ipvs->num_services;
+		info.num_services =
+			atomic_read(&ipvs->num_services[IP_VS_AF_INET]);
 		if (copy_to_user(user, &info, sizeof(info)) != 0)
 			ret = -EFAULT;
 	}
@@ -4293,9 +4302,14 @@ int __net_init ip_vs_control_net_init(struct netns_ipvs *ipvs)
 	INIT_LIST_HEAD(&ipvs->dest_trash);
 	spin_lock_init(&ipvs->dest_trash_lock);
 	timer_setup(&ipvs->dest_trash_timer, ip_vs_dest_trash_expire, 0);
-	atomic_set(&ipvs->ftpsvc_counter, 0);
-	atomic_set(&ipvs->nullsvc_counter, 0);
-	atomic_set(&ipvs->conn_out_counter, 0);
+	for (idx = 0; idx < IP_VS_AF_MAX; idx++) {
+		atomic_set(&ipvs->num_services[idx], 0);
+		atomic_set(&ipvs->fwm_services[idx], 0);
+		atomic_set(&ipvs->nonfwm_services[idx], 0);
+		atomic_set(&ipvs->ftpsvc_counter[idx], 0);
+		atomic_set(&ipvs->nullsvc_counter[idx], 0);
+		atomic_set(&ipvs->conn_out_counter[idx], 0);
+	}
 
 	INIT_DELAYED_WORK(&ipvs->est_reload_work, est_reload_work_handler);
 
-- 
2.41.0


