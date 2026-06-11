Return-Path: <netfilter-devel+bounces-13213-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j1A5B6xiKmo6ogMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13213-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 09:24:28 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 347BF66F5B0
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 09:24:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13213-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13213-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B5FD3013266
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2026 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48DC1A0BD0;
	Thu, 11 Jun 2026 07:22:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679EE9443
	for <netfilter-devel@vger.kernel.org>; Thu, 11 Jun 2026 07:22:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162540; cv=none; b=HYIeSJzh5YxLSCXvjczpDt3g5VyPqedYb0FdvKa6JAkin6T2APT3wMQgLApXQ7HMhUUzTICPk14WpEo3ixWTG4pb7RllUgWENA3nq0K7cSy2RQ5et+FpEJcgY4+nr3j8V5PwVYZj5M/ZM0qGi+pZwC4aRFLZadXko1dYm1PqbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162540; c=relaxed/simple;
	bh=1LhFwP9LoyKSAz6ethO9kxk0y1yzDLcLpqLaoAR4QRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5fnRiQq5HQwS+0k556tmADlsBylfUpRmCRO0DlgJ/V7B2baEsVcUAdN02P71en8i1pnaz5coT0k4I+VfEZ0mOpp4JOXST1J0szxpjga3XE7GkeoVW+t6rW49aPbzQnlQfWJgg5VIICa2g2IK9gZOi4W85SHoxIisjaCLEWeiF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.76.78.106
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAD3E74KYipqbrJ6AA--.55049S3;
	Thu, 11 Jun 2026 15:21:58 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	kaber@trash.net,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com,
	n05ec@lzu.edu.cn
Subject: [PATCH nf 1/1] netfilter: xt_cluster: reject template conntracks in hash match
Date: Thu, 11 Jun 2026 15:21:42 +0800
Message-ID: <38ddd33608bec18ee19d6a0d91163b52f26d368b.1781060431.git.bronzed_45_vested@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1781060431.git.bronzed_45_vested@icloud.com>
References: <cover.1781060431.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAD3E74KYipqbrJ6AA--.55049S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13CryrKF45WryfArykGrg_yoW8WFW8pa
	4fGw13GrW2qFn8Kw1ktr929FWrWrZ5CryxW3Z0yF97GFnIqr4kJan3K393ZF1DJ3yY9FWY
	qFnF9w4Duwn8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQwPCWopHlER5QAAsz
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13213-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:kaber@trash.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,trash.net,gmail.com,lzu.edu.cn,icloud.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,icloud.com:mid,icloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 347BF66F5B0

From: Wyatt Feng <bronzed_45_vested@icloud.com>

xt_cluster_mt() treats any non-NULL nf_ct_get() result as a fully
initialized conntrack and passes it to xt_cluster_hash().

This causes a state confusion bug when the raw table CT target attaches
a template conntrack to skb->_nfct before normal conntrack processing.
Templates carry IPS_TEMPLATE status but do not have a valid tuple for
hashing yet, so xt_cluster_hash() can hit its WARN_ON() path on the
zeroed l3num field.

Reject template conntracks before hashing them. This matches existing
netfilter handling for template objects and avoids hashing incomplete
conntrack state.

Fixes: 0269ea493734 ("netfilter: xtables: add cluster match")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/netfilter/xt_cluster.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_cluster.c b/net/netfilter/xt_cluster.c
index 908fd5f2c3c8..76295053ef9a 100644
--- a/net/netfilter/xt_cluster.c
+++ b/net/netfilter/xt_cluster.c
@@ -107,7 +107,7 @@ xt_cluster_mt(const struct sk_buff *skb, struct xt_action_param *par)
 	}
 
 	ct = nf_ct_get(skb, &ctinfo);
-	if (ct == NULL)
+	if (ct == NULL || nf_ct_is_template(ct))
 		return false;
 
 	if (ct->master)
-- 
2.47.3


