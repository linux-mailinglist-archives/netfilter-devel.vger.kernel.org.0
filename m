Return-Path: <netfilter-devel+bounces-7781-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB3EAFC587
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jul 2025 10:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8121BC4071
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jul 2025 08:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0182929E0F0;
	Tue,  8 Jul 2025 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dSewunOP"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209432BDC1D
	for <netfilter-devel@vger.kernel.org>; Tue,  8 Jul 2025 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963073; cv=none; b=mIiT29p3eAHSJ/brxz0esXweMO8pBywhO0PpkDM9C7QyKZy1AF7Es6XVPQ+B+ALW4L+3dhUXhCaC5o363JCtPXIkz4O6H/HE1qtAA//OgugNzr2Kwp5vXctWK27eXc2hWK8pxkIrnilzsdbsYFGM9odcpg9NgRIH8c7MXqjlATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963073; c=relaxed/simple;
	bh=S/4ysQBNXSNRLbsTxzjmiKYVJK4WRI1JFEgfz8Ho5Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evwtlpvE2q3Py/LGJY/LieFA7UXJOKNE6J7plmTWSevysiPdhkgZ8oH3QHV8xlhQGJJRd+ZwzPRfFe2S0pzOuVD3fBW3IAmutDsZCqORMBvtABiMoIBO5HR+76kFya58v4ZlOJnz0LQF1ZP6NVSpjK/b4rQbw3ck23qAhN4do8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dSewunOP; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751963069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hMuwkXar/JP+QSBlJ36t2NR92ukOZdEZlTj2WN/ipWk=;
	b=dSewunOPNjJfgXkA/XqClycrlr1PjVDawPl5xDY28XKxCVzA8I/HrgRuQYSyVzdWsc1CDg
	QlDbm2o3lP8kQmxmGkaU1H2Hn2IXIzVsdAYnFOKxZnljYjBSio+AcgEDF86oJJ4/ASLo3o
	/DtbZ4ZoQLvqbHgbq5xj4npYHZt1LTk=
From: Tao Chen <chen.dylane@linux.dev>
To: daniel@iogearbox.net,
	razor@blackwall.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	horms@kernel.org,
	willemb@google.com,
	jakub@cloudflare.com,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	hawk@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v2 5/7] bpf: Remove attach_type in bpf_netns_link
Date: Tue,  8 Jul 2025 16:22:26 +0800
Message-ID: <20250708082228.824766-6-chen.dylane@linux.dev>
In-Reply-To: <20250708082228.824766-1-chen.dylane@linux.dev>
References: <20250708082228.824766-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use attach_type in bpf_link, and remove it in bpf_netns_link.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/net_namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index 63702c86275..6d27bd97c95 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -11,7 +11,6 @@
 
 struct bpf_netns_link {
 	struct bpf_link	link;
-	enum bpf_attach_type type;
 	enum netns_bpf_attach_type netns_type;
 
 	/* We don't hold a ref to net in order to auto-detach the link
@@ -216,7 +215,7 @@ static int bpf_netns_link_fill_info(const struct bpf_link *link,
 	mutex_unlock(&netns_bpf_mutex);
 
 	info->netns.netns_ino = inum;
-	info->netns.attach_type = net_link->type;
+	info->netns.attach_type = link->attach_type;
 	return 0;
 }
 
@@ -230,7 +229,7 @@ static void bpf_netns_link_show_fdinfo(const struct bpf_link *link,
 		   "netns_ino:\t%u\n"
 		   "attach_type:\t%u\n",
 		   info.netns.netns_ino,
-		   info.netns.attach_type);
+		   link->attach_type);
 }
 
 static const struct bpf_link_ops bpf_netns_link_ops = {
@@ -503,7 +502,6 @@ int netns_bpf_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	bpf_link_init(&net_link->link, BPF_LINK_TYPE_NETNS,
 		      &bpf_netns_link_ops, prog, type);
 	net_link->net = net;
-	net_link->type = type;
 	net_link->netns_type = netns_type;
 
 	err = bpf_link_prime(&net_link->link, &link_primer);
-- 
2.48.1


