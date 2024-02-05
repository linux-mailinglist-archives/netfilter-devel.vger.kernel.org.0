Return-Path: <netfilter-devel+bounces-883-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E1F84A6ED
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Feb 2024 22:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45EB21F298D9
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Feb 2024 21:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D434EB33;
	Mon,  5 Feb 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="LBp2c3VH"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD64EB38
	for <netfilter-devel@vger.kernel.org>; Mon,  5 Feb 2024 19:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161313; cv=none; b=n72oWBtQWuBT7uy9Lc3Lu4BIgPRynWjAVSAlr8ScSDb3VgU86SAWH87b9Gk+eZX0IgkcafJRl5LyvMJkQdeAPW49fjxgdXhmDrBwCGcUBuROnx7ENsT5ftiTPLbGBv4eRMON5cPlensBHb6RQcjnktDw0sachV+krUfAHxNdcow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161313; c=relaxed/simple;
	bh=vkvgGRo1pSFs/GOYpJ8ezRcamKPDuI51v3yzsw9Qwac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btayK5+rGYKlZq28uRSzlg6gnvMBjY7WPNVFXoYjW0G6Ywb7qk+qS//PDxdpVvvGIGLQU6OpVrW8n8n/zJuhNKc7dfRPGOtioFHddUPkJL54pFd6F3zdKygwnduScFPUZsrDQaOOwVXM+1ZHDPAzXbKKilQz3YN9QVIjzfI/qqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=LBp2c3VH; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5114b2b3b73so1957311e87.0
        for <netfilter-devel@vger.kernel.org>; Mon, 05 Feb 2024 11:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1707161309; x=1707766109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uM9bfvnNjJ5wIVcYSWt719eXiAyrV1V8o/Z3/l9SYpM=;
        b=LBp2c3VHHL1YK4Oxc5b705aSeKaiBIwyfHjyd7F+EThOeMgN0+VBBvQsvkvmQX07K5
         HiPkUjCKmXHNRZA3kViwaLIqASCMKlpExnEohVqXF0P6xQ784L6ntCHd/VjvnbHVo2s2
         WftY9A1Y75hp6upOLq4OBLAYNNvUmUxky5fRQLhuAR3EyTYEMDw6CZAH+5kEL9/sfEdg
         gOBcCPdClxhjEcF8hHNtg4duIyPIrSBegcj0uhkJfqXInsRE4QSPoauMhq1MCfKUOVGU
         D1xrzhet5hm/AkgUc69BsNbjCnnH8v98u7WdxxclIdP5N1EFD0XHV3MinHbnJcT5a1hr
         EOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707161309; x=1707766109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uM9bfvnNjJ5wIVcYSWt719eXiAyrV1V8o/Z3/l9SYpM=;
        b=hlWP4w53JeDdYNkz0aKoJR1QlqeYclMJ3uvgl7yg2y06t8MSVDRaOklI7J4yrZFocs
         +0Jmpze6qh61jAWtqePLw3S2OgOuTxpYxBLLNBT7BP0tyy76X+ZlyuHNKFscucj2eJ1U
         QRaPrmOAw4o6RBWqvIQE/C5+RC267imSSAV2/euQpVsA1E6gh6fV8/QrglEoSfvbwtaD
         fzD2zkdqaqG5MwKP5ZudKhHHPe7++S58F0aH5afNhOdBZKaD5ySbuxfB7j9bjKcnegLV
         SDz6Z9SoPa7iMsTUjvnZXP516laGWi0zxjzkIgAw+9K15Nc6jyXEkDOGqkGT0XeTGx6T
         1P3Q==
X-Gm-Message-State: AOJu0Yy7cxEQjog32Girq7rpm0WGJAdzuc8kyMPo4Qs2jVfLCJfOLDl2
	6bXrgwCDHqKX6ng+EwTpRQYfAWDAQgx/++BXa3iS9XMr2H2RCHKYfEPfhXMrTQM=
X-Google-Smtp-Source: AGHT+IGtNsCzgbhU7U/ubyiUXO0/4h3AjbKmSAxr3VReZ6e/awosLCDhPMapn4/j6qdpSw70rfhlSg==
X-Received: by 2002:a19:6753:0:b0:511:4a38:351e with SMTP id e19-20020a196753000000b005114a38351emr101251lfj.34.1707161309397;
        Mon, 05 Feb 2024 11:28:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXsAQtz5Pk/+R4pz2JZD65pSIrfPg0vPLZ6EKyQkFS/am1zueK/tYgKlQQdanEqbX8E+FnkX/9M6vMIzJiUkdNO+d1Jcp6BCTofP18/A0jZPbesj9jYQ80jGRtok1mtOcbzUB4nQTfElpugpGtGHrWEQ4TsNysMHojCQzpffQgnlio/peznpu+qMNQdkXiV/zFZnCiZV8fR3URWmRCf1F26Xg+bExkBFJNJkswr0ubUN1Tkj6/9
Received: from localhost ([2a09:bac5:4e26:15c3::22b:3a])
        by smtp.gmail.com with ESMTPSA id se1-20020a170906ce4100b00a3743142429sm173161ejb.39.2024.02.05.11.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:28:29 -0800 (PST)
From: Terin Stock <terin@cloudflare.com>
To: horms@verge.net.au,
	ja@ssi.bg
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: [PATCH] ipvs: generic netlink multicast event group
Date: Mon,  5 Feb 2024 19:28:28 +0000
Message-ID: <20240205192828.187494-1-terin@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IPVS subsystem allows for configuration from userspace programs
using the generic netlink interface. However, the program is currently
unable to react to changes in the configuration of services or
destinations made on the system without polling over all configuration
in IPVS.

Adds an "events" multicast group for the IPVS generic netlink family,
allowing for userspace programs to monitor changes made by any other
netlink client (or legacy tools using the IPVS socket options). As
service and destination statistics are separate from configuration,
those netlink attributes are excluded in events.

Signed-off-by: Terin Stock <terin@cloudflare.com>
---
 include/uapi/linux/ip_vs.h     |   2 +
 net/netfilter/ipvs/ip_vs_ctl.c | 107 +++++++++++++++++++++++++++++----
 2 files changed, 96 insertions(+), 13 deletions(-)

diff --git a/include/uapi/linux/ip_vs.h b/include/uapi/linux/ip_vs.h
index 1ed234e7f251..0aa119ebaf85 100644
--- a/include/uapi/linux/ip_vs.h
+++ b/include/uapi/linux/ip_vs.h
@@ -299,6 +299,8 @@ struct ip_vs_daemon_user {
 #define IPVS_GENL_NAME		"IPVS"
 #define IPVS_GENL_VERSION	0x1
 
+#define IPVS_GENL_MCAST_EVENT_NAME "events"
+
 struct ip_vs_flags {
 	__u32 flags;
 	__u32 mask;
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 143a341bbc0a..ced232361d02 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -64,6 +64,11 @@ int ip_vs_get_debug_level(void)
 
 
 /*  Protos */
+static struct genl_family ip_vs_genl_family;
+static int ip_vs_genl_fill_service(struct sk_buff *skb,
+				   struct ip_vs_service *svc, bool stats);
+static int ip_vs_genl_fill_dest(struct sk_buff *skb, struct ip_vs_dest *dest,
+				bool stats);
 static void __ip_vs_del_service(struct ip_vs_service *svc, bool cleanup);
 
 
@@ -960,6 +965,62 @@ void ip_vs_stats_free(struct ip_vs_stats *stats)
 	}
 }
 
+static int ip_vs_genl_service_event(u8 event, struct ip_vs_service *svc)
+{
+	struct sk_buff *msg;
+	void *hdr;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ip_vs_genl_family, 0, event);
+	if (!hdr)
+		goto free_msg;
+
+	if (ip_vs_genl_fill_service(msg, svc, false))
+		goto free_msg;
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&ip_vs_genl_family, msg, 0, 0, GFP_ATOMIC);
+
+	return 0;
+
+free_msg:
+	nlmsg_free(msg);
+	return -EMSGSIZE;
+}
+
+static int ip_vs_genl_dest_event(u8 event, struct ip_vs_service *svc,
+				 struct ip_vs_dest *dest)
+{
+	struct sk_buff *msg;
+	void *hdr;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_ATOMIC);
+	if (!msg)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(msg, 0, 0, &ip_vs_genl_family, 0, event);
+	if (!hdr)
+		goto free_msg;
+
+	if (ip_vs_genl_fill_service(msg, svc, false))
+		goto free_msg;
+
+	if (ip_vs_genl_fill_dest(msg, dest, false))
+		goto free_msg;
+
+	genlmsg_end(msg, hdr);
+	genlmsg_multicast(&ip_vs_genl_family, msg, 0, 0, GFP_ATOMIC);
+
+	return 0;
+
+free_msg:
+	nlmsg_free(msg);
+	return -EMSGSIZE;
+}
+
 /*
  *	Update a destination in the given service
  */
@@ -1043,10 +1104,12 @@ __ip_vs_update_dest(struct ip_vs_service *svc, struct ip_vs_dest *dest,
 		sched = rcu_dereference_protected(svc->scheduler, 1);
 		if (sched && sched->add_dest)
 			sched->add_dest(svc, dest);
+		ip_vs_genl_dest_event(IPVS_CMD_NEW_DEST, svc, dest);
 	} else {
 		sched = rcu_dereference_protected(svc->scheduler, 1);
 		if (sched && sched->upd_dest)
 			sched->upd_dest(svc, dest);
+		ip_vs_genl_dest_event(IPVS_CMD_SET_DEST, svc, dest);
 	}
 }
 
@@ -1316,6 +1379,7 @@ ip_vs_del_dest(struct ip_vs_service *svc, struct ip_vs_dest_user_kern *udest)
 		return -ENOENT;
 	}
 
+	ip_vs_genl_dest_event(IPVS_CMD_DEL_DEST, svc, dest);
 	/*
 	 *	Unlink dest from the service
 	 */
@@ -1480,6 +1544,8 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 	/* Hash the service into the service table */
 	ip_vs_svc_hash(svc);
 
+	ip_vs_genl_service_event(IPVS_CMD_NEW_SERVICE, svc);
+
 	*svc_p = svc;
 
 	if (!ipvs->enable) {
@@ -1593,6 +1659,8 @@ ip_vs_edit_service(struct ip_vs_service *svc, struct ip_vs_service_user_kern *u)
 			atomic_dec(&svc->ipvs->conn_out_counter);
 	}
 
+	ip_vs_genl_service_event(IPVS_CMD_SET_SERVICE, svc);
+
 out:
 	ip_vs_scheduler_put(old_sched);
 	ip_vs_pe_put(old_pe);
@@ -1667,6 +1735,8 @@ static void ip_vs_unlink_service(struct ip_vs_service *svc, bool cleanup)
 	ip_vs_unregister_conntrack(svc);
 	/* Hold svc to avoid double release from dest_trash */
 	atomic_inc(&svc->refcnt);
+
+	ip_vs_genl_service_event(IPVS_CMD_DEL_SERVICE, svc);
 	/*
 	 * Unhash it from the service table
 	 */
@@ -3313,7 +3383,7 @@ static int ip_vs_genl_fill_stats64(struct sk_buff *skb, int container_type,
 }
 
 static int ip_vs_genl_fill_service(struct sk_buff *skb,
-				   struct ip_vs_service *svc)
+				   struct ip_vs_service *svc, bool stats)
 {
 	struct ip_vs_scheduler *sched;
 	struct ip_vs_pe *pe;
@@ -3349,10 +3419,12 @@ static int ip_vs_genl_fill_service(struct sk_buff *skb,
 	    nla_put_be32(skb, IPVS_SVC_ATTR_NETMASK, svc->netmask))
 		goto nla_put_failure;
 	ip_vs_copy_stats(&kstats, &svc->stats);
-	if (ip_vs_genl_fill_stats(skb, IPVS_SVC_ATTR_STATS, &kstats))
-		goto nla_put_failure;
-	if (ip_vs_genl_fill_stats64(skb, IPVS_SVC_ATTR_STATS64, &kstats))
-		goto nla_put_failure;
+	if (stats) {
+		if (ip_vs_genl_fill_stats(skb, IPVS_SVC_ATTR_STATS, &kstats))
+			goto nla_put_failure;
+		if (ip_vs_genl_fill_stats64(skb, IPVS_SVC_ATTR_STATS64, &kstats))
+			goto nla_put_failure;
+	}
 
 	nla_nest_end(skb, nl_service);
 
@@ -3375,7 +3447,7 @@ static int ip_vs_genl_dump_service(struct sk_buff *skb,
 	if (!hdr)
 		return -EMSGSIZE;
 
-	if (ip_vs_genl_fill_service(skb, svc) < 0)
+	if (ip_vs_genl_fill_service(skb, svc, true) < 0)
 		goto nla_put_failure;
 
 	genlmsg_end(skb, hdr);
@@ -3528,7 +3600,8 @@ static struct ip_vs_service *ip_vs_genl_find_service(struct netns_ipvs *ipvs,
 	return ret ? ERR_PTR(ret) : svc;
 }
 
-static int ip_vs_genl_fill_dest(struct sk_buff *skb, struct ip_vs_dest *dest)
+static int ip_vs_genl_fill_dest(struct sk_buff *skb, struct ip_vs_dest *dest,
+				bool stats)
 {
 	struct nlattr *nl_dest;
 	struct ip_vs_kstats kstats;
@@ -3561,10 +3634,12 @@ static int ip_vs_genl_fill_dest(struct sk_buff *skb, struct ip_vs_dest *dest)
 	    nla_put_u16(skb, IPVS_DEST_ATTR_ADDR_FAMILY, dest->af))
 		goto nla_put_failure;
 	ip_vs_copy_stats(&kstats, &dest->stats);
-	if (ip_vs_genl_fill_stats(skb, IPVS_DEST_ATTR_STATS, &kstats))
-		goto nla_put_failure;
-	if (ip_vs_genl_fill_stats64(skb, IPVS_DEST_ATTR_STATS64, &kstats))
-		goto nla_put_failure;
+	if (stats) {
+		if (ip_vs_genl_fill_stats(skb, IPVS_DEST_ATTR_STATS, &kstats))
+			goto nla_put_failure;
+		if (ip_vs_genl_fill_stats64(skb, IPVS_DEST_ATTR_STATS64, &kstats))
+			goto nla_put_failure;
+	}
 
 	nla_nest_end(skb, nl_dest);
 
@@ -3586,7 +3661,7 @@ static int ip_vs_genl_dump_dest(struct sk_buff *skb, struct ip_vs_dest *dest,
 	if (!hdr)
 		return -EMSGSIZE;
 
-	if (ip_vs_genl_fill_dest(skb, dest) < 0)
+	if (ip_vs_genl_fill_dest(skb, dest, true) < 0)
 		goto nla_put_failure;
 
 	genlmsg_end(skb, hdr);
@@ -4078,7 +4153,7 @@ static int ip_vs_genl_get_cmd(struct sk_buff *skb, struct genl_info *info)
 			ret = PTR_ERR(svc);
 			goto out_err;
 		} else if (svc) {
-			ret = ip_vs_genl_fill_service(msg, svc);
+			ret = ip_vs_genl_fill_service(msg, svc, true);
 			if (ret)
 				goto nla_put_failure;
 		} else {
@@ -4235,6 +4310,10 @@ static const struct genl_small_ops ip_vs_genl_ops[] = {
 	},
 };
 
+static const struct genl_multicast_group ip_vs_genl_mcgrps[] = {
+	{ .name = IPVS_GENL_MCAST_EVENT_NAME },
+};
+
 static struct genl_family ip_vs_genl_family __ro_after_init = {
 	.hdrsize	= 0,
 	.name		= IPVS_GENL_NAME,
@@ -4246,6 +4325,8 @@ static struct genl_family ip_vs_genl_family __ro_after_init = {
 	.small_ops	= ip_vs_genl_ops,
 	.n_small_ops	= ARRAY_SIZE(ip_vs_genl_ops),
 	.resv_start_op	= IPVS_CMD_FLUSH + 1,
+	.mcgrps = ip_vs_genl_mcgrps,
+	.n_mcgrps = ARRAY_SIZE(ip_vs_genl_mcgrps),
 };
 
 static int __init ip_vs_genl_register(void)
-- 
2.43.0


