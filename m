Return-Path: <netfilter-devel+bounces-7810-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD44AFDDE7
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Jul 2025 05:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611205408E1
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Jul 2025 03:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7CB1EB5FE;
	Wed,  9 Jul 2025 03:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GZHxVMMn"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD271E5718;
	Wed,  9 Jul 2025 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752030572; cv=none; b=ZC/kwHOh5UOR4CVOwMMbdiszIqhU/q4f07e5tGs9movY3G3uzR+9PcsGgjDU/hbHzPq/VCk9C16kefz7Uh81Zsfk8P+OmvBgrO7guycVtcYOD9dMyekAcxO2RRB+xbCpVpzQwlYXUB3dswev6rJt/mKxD4E8q+Pmz9G83cudRy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752030572; c=relaxed/simple;
	bh=tcOr5S0+9/mR6t3UOyC0gu1T6E+4uGa/ZwOE4BwEsMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgK4qPTOZ/XyPHe3oCUP+y6C+bcPeCSrgwKELW6IpU9IQDyN0VyybH+ACe2EMJqj4KFwCat6hKUMC092OW/2COETmBBukpTA87QpxSO8fgiZan3II8sg9ylFMLgPjAADTI+Fj20uDT05v8ZYOLRPtwiTXlEPxtbf9Ll1CkW25GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GZHxVMMn; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752030568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E36d0dRXuFxtGkuMAWl1W+kzA/UOZREvhdFfO/DAcMs=;
	b=GZHxVMMnld16a5UKgeYZ73oAL2dA2U7ljojpwvUwVNzDYTvOXjP1IMgjYG/0rjyfvQgL5L
	LmJz9hDFA3hwFkKZT3n9qM/Ns/h/sd+bEVYisc6QK0HHpGn1KVO3Iwjp+P6LS7gR6SKMW1
	Z9MO6YkNS3VBelNqsmRmdbI9wXeCq9A=
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
Subject: [PATCH bpf-next v3 3/7] bpf: Remove attach_type in sockmap_link
Date: Wed,  9 Jul 2025 11:07:58 +0800
Message-ID: <20250709030802.850175-4-chen.dylane@linux.dev>
In-Reply-To: <20250709030802.850175-1-chen.dylane@linux.dev>
References: <20250709030802.850175-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use attach_type in bpf_link, and remove it in sockmap_link.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 net/core/sock_map.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index fbe9a33ddf1..5947b38e4f8 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1709,7 +1709,6 @@ EXPORT_SYMBOL_GPL(sock_map_close);
 struct sockmap_link {
 	struct bpf_link link;
 	struct bpf_map *map;
-	enum bpf_attach_type attach_type;
 };
 
 static void sock_map_link_release(struct bpf_link *link)
@@ -1721,7 +1720,7 @@ static void sock_map_link_release(struct bpf_link *link)
 		goto out;
 
 	WARN_ON_ONCE(sock_map_prog_update(sockmap_link->map, NULL, link->prog, link,
-					  sockmap_link->attach_type));
+					  link->attach_type));
 
 	bpf_map_put_with_uref(sockmap_link->map);
 	sockmap_link->map = NULL;
@@ -1772,7 +1771,7 @@ static int sock_map_link_update_prog(struct bpf_link *link,
 	}
 
 	ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
-					sockmap_link->attach_type);
+					link->attach_type);
 	if (ret)
 		goto out;
 
@@ -1817,7 +1816,7 @@ static int sock_map_link_fill_info(const struct bpf_link *link,
 	u32 map_id = sock_map_link_get_map_id(sockmap_link);
 
 	info->sockmap.map_id = map_id;
-	info->sockmap.attach_type = sockmap_link->attach_type;
+	info->sockmap.attach_type = link->attach_type;
 	return 0;
 }
 
@@ -1828,7 +1827,7 @@ static void sock_map_link_show_fdinfo(const struct bpf_link *link,
 	u32 map_id = sock_map_link_get_map_id(sockmap_link);
 
 	seq_printf(seq, "map_id:\t%u\n", map_id);
-	seq_printf(seq, "attach_type:\t%u\n", sockmap_link->attach_type);
+	seq_printf(seq, "attach_type:\t%u\n", link->attach_type);
 }
 
 static const struct bpf_link_ops sock_map_link_ops = {
@@ -1869,7 +1868,6 @@ int sock_map_link_create(const union bpf_attr *attr, struct bpf_prog *prog)
 	bpf_link_init(&sockmap_link->link, BPF_LINK_TYPE_SOCKMAP, &sock_map_link_ops, prog,
 		      attach_type);
 	sockmap_link->map = map;
-	sockmap_link->attach_type = attach_type;
 
 	ret = bpf_link_prime(&sockmap_link->link, &link_primer);
 	if (ret) {
-- 
2.48.1


