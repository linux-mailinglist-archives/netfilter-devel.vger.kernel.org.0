Return-Path: <netfilter-devel+bounces-13681-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PyvzBqTDTGpfpQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13681-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 11:15:16 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 901F7719985
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 11:15:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gv0cI1Zh;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13681-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13681-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3BE9B3026735
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Jul 2026 09:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A58F392C2C;
	Tue,  7 Jul 2026 09:11:22 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350A738F93B
	for <netfilter-devel@vger.kernel.org>; Tue,  7 Jul 2026 09:11:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783415481; cv=none; b=I7dvA6wuaN0iz5LWSzQ7kdD1NvYhh4m/SbZWsf/Nkzr1YKGcYJcitMgTtsZ4jEQMlT1If1te+8M/csOcQd1/YE5b0o5lxE1IRSinH+vk1CObVDDXl5/o+wOb1KIA/Jy1JYz4YIFJKILrGY970fa3Z0We4WROcdxIUF7nZn3kFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783415481; c=relaxed/simple;
	bh=s02OZU6yGbhZS+80+Db+cUZOuelG+2HfZ5D9w07AOX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TkYbOOVfknqc38zxajev51a3ZIfIHlxY6AXN66t1UGni4u1qC31XZbpc/B5w5FhoXr0nh1ZFWHZwYLikQ8Sa2U7joViut1da3OYGdlm8kOZlY1EjtCKYcCPO5ESqfXWFgsStc4+dMACl5jzpPSY1MqCUJ9WPoToGLd9Qo4ZtyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv0cI1Zh; arc=none smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso3489665a12.0
        for <netfilter-devel@vger.kernel.org>; Tue, 07 Jul 2026 02:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783415478; x=1784020278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GTNzg7neY6XAYNOZrTHnOAN/xy3esmxWmnvFgBYG4BI=;
        b=gv0cI1ZhHSXLjcraaGWZhxpVjQe3uMuXq9CsnSDV0yX+aK7Cl2PvmNdT1FtOKxKjWM
         wOn923K8QV+eV5pZ7gGAcTe3XgdKPvM1ZZJGBxG2JhSv6AkZ3C/ClVOsQXhT+7LQ46/4
         TUibiltV3KOz2bZ/IuC5asm/5JC/V5ohNV4VX/rexjj/7dLiCqizBLamh7R0uBA2GXjk
         zFsZ7Qk8PX4lHqriXfbfVPvE24xe+WmnQEyRDe8yIQMS1F2LGqeMUya9wZZxjsxoXCmt
         VugT7T9QdPp5sSHzhRi/DHXZOKDpT6bWaVE4RaKHZ4U7KgRlNmlHdyH2vd3i2iXwoUNE
         XtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783415478; x=1784020278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GTNzg7neY6XAYNOZrTHnOAN/xy3esmxWmnvFgBYG4BI=;
        b=pymPvvgtVCSri+b7jcXWm9TQb2jmTPO8K6QPGKizotot8cQxJeOMOYvNI7bYmQfDtc
         to3jo3NfHpgK7YW5/DDYYyny9AL1fm5F5+uKkVBSQU+7qsvkwAOaGzl5hmS/Azf0TsDz
         17VsEJ8uTfzD2Gbp+EXn4ZjEbkPckPhPxxdFff3JydlB9X7RPpE/HL8HcdO+0aMTENMx
         jnPzOrBQ/fKODhoWGM+ZyzEpzVejJGVdqjI+lBg/6trUh8RLw4A+FOwsyprNHGZPXjwy
         g35vcly4+BZA9wMlO0gCT2A/98oWvqQgvc2v7k4tO716Q5S5OLb4kGt/tfsap+UPKoY0
         q4Mw==
X-Forwarded-Encrypted: i=1; AHgh+Rrhne2+UsVAABA/FOZyGHbwYElRd0s79/p539ZqAWR/lh0xhmHEt5vvlL8s9miyaVAI0GrQJEuQUfiK8p+9HFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsZkVn5OD3eq+jMgC89AvJjII+T1W7sMQIIz1KT7E36YtHPId+
	JiYCrogYC6IGqxy4VTqi3qjK6IowVyTPRYGTdXyXKnxnfjCGMFCBbRzH
X-Gm-Gg: AfdE7cnYVWFKwQKrAWl2J42vidvlPHlZDL/SDDf6WBUN5n+4yIIqWYOSP83NOZZ1D6w
	4zm8xpA7+8R6qXqR88jkiFPkNnXKeFFD9nZqsnZmGAKlQfXqK6c21VF467AqZdVuq4nw4/f4dGC
	SYOnkCeYYB1P8geeduokCslzxkAPzdy9lRMnD+H1xe5nfqRTAfVx+kqDTMOxB79AZ0f3MdJagD1
	q8Xo6i3TEnUZiJzuKGoFi2UEeyXxgHNeZOZYo/PviFaqZRPduyjy7+WHccijReutFB8sLtYW8gq
	Grb2y45JwIsRSejEBu0beAs/HXBdo2y+hzCKx5AGDv7uRWpN55hxOmBMnIyH2M+yGdHryaD7L3j
	SmH+ivt3CV82CT1aReB+krH1JiN+TEI2zGl/6B6jch+UqrRmw3YDUReQlzoZICw8yuCmQ8qGYaV
	yrWqK2e9B/gG3FVYzzRuIhPcojESFgy84sshmGP2iynD0hPDqJpnZkPQJVHSrtl4NwX5oJ9Espk
	fB+quT1S5Wpr3O1tiZoWVb3fzKt7hljdeoHo5HZO8Mu
X-Received: by 2002:a05:6402:2483:b0:698:ae69:3992 with SMTP id 4fb4d7f45d1cf-69a85b9cd1emr2231989a12.16.1783415478241;
        Tue, 07 Jul 2026 02:11:18 -0700 (PDT)
Received: from eric (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19cd87d6sm5297152a12.6.2026.07.07.02.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 02:11:17 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>
Cc: netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v12 nf-next 3/7] netfilter: nf_flow_table_offload: Add nf_flow_rule_bridge()
Date: Tue,  7 Jul 2026 11:10:41 +0200
Message-ID: <20260707091045.967678-4-ericwouds@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707091045.967678-1-ericwouds@gmail.com>
References: <20260707091045.967678-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13681-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,netfilter.org,strlen.de,nwl.cc,blackwall.org,nvidia.com,gmail.com,uwaterloo.ca];
	FORGED_SENDER(0.00)[ericwouds@gmail.com,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:razor@blackwall.org,m:idosch@nvidia.com,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:bridge@lists.linux.dev,m:ericwouds@gmail.com,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,blackwall.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 901F7719985

Add nf_flow_rule_bridge().

It only calls the common rule and adds the redirect.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 include/net/netfilter/nf_flow_table.h |  3 +++
 net/netfilter/nf_flow_table_offload.c | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index 7b23b245a5a86..5c6e3b65ae85b 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -368,6 +368,9 @@ void nf_flow_table_offload_flush_cleanup(struct nf_flowtable *flowtable);
 int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 				struct net_device *dev,
 				enum flow_block_command cmd);
+int nf_flow_rule_bridge(struct net *net, struct flow_offload *flow,
+			enum flow_offload_tuple_dir dir,
+			struct nf_flow_rule *flow_rule);
 int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 			    enum flow_offload_tuple_dir dir,
 			    struct nf_flow_rule *flow_rule);
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 002ec15d988bd..5566ebda7b7d3 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -740,6 +740,19 @@ nf_flow_rule_route_common(struct net *net, const struct flow_offload *flow,
 	return 0;
 }
 
+int nf_flow_rule_bridge(struct net *net, struct flow_offload *flow,
+			enum flow_offload_tuple_dir dir,
+			struct nf_flow_rule *flow_rule)
+{
+	if (nf_flow_rule_route_common(net, flow, dir, flow_rule) < 0)
+		return -1;
+
+	flow_offload_redirect(net, flow, dir, flow_rule);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nf_flow_rule_bridge);
+
 int nf_flow_rule_route_ipv4(struct net *net, struct flow_offload *flow,
 			    enum flow_offload_tuple_dir dir,
 			    struct nf_flow_rule *flow_rule)
-- 
2.53.0


