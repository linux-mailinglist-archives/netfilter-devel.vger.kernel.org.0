Return-Path: <netfilter-devel+bounces-12974-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DSjKsh1HWqebAkAu9opvQ
	(envelope-from <netfilter-devel+bounces-12974-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 01 Jun 2026 14:06:32 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F8161EDE5
	for <lists+netfilter-devel@lfdr.de>; Mon, 01 Jun 2026 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B94430AB72A
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jun 2026 11:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2784937649B;
	Mon,  1 Jun 2026 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="r4MUYpdH"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1013374735;
	Mon,  1 Jun 2026 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315180; cv=none; b=RAgkXNQ7T8HT48obbGwcCziy98nnOjx0Ss5hgFFA6ZgbrBImhF2xQEh7NPNKJc9Q7itohgLCCLs5n8nwnqevW5KWf/QJMXNFt9FoG80FpggDspA96EhINJ8OZ9t5tH9mL73ZpJZPF/HmKJN8htOl3jY1COy3BdtvGVK2PavsoKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315180; c=relaxed/simple;
	bh=LtXQFd8qAW5eu1H2e3dv7DDmHSxR7fn3LhoS+bjB+AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyb1daRYcHGKuPTKlzdjJG4StKRqY/irdql1xyjhIL3C7jfKGk+dBDQe3tAfhRMeIRaB5aWT2jN1y8/pthgKIhLGsVYfmYInt6s0T4bs275/iv8y6MVGisN7nt6fphYHxC/oafCPvgllrfdWYRxP3sxfJfLNH1A1f4lEScqSH8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=r4MUYpdH; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 98AE4601C2;
	Mon,  1 Jun 2026 13:59:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780315177;
	bh=xGmoyiyhuismkPR7NjOHfQ0YDs1Izznhfyjt3IDb/j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4MUYpdHOB5qJX747VcZ++Zi2Yud/le01/gaIHMu6i75gmHmbiue8PMftvL9wgvRK
	 5zh7HLgFLg56MmbIPZIjT1TtvPFgzOFtr+bvJtBr02o7mLu4wnTSF1QMiDs5mvl7nn
	 RkhBXqspFPR+fcSDPZlfkbhIgbVmj8qZhJfB40g4nwHTaAP54MhflaqaKBeguOYNZj
	 4ThDsvVIZVSoml9GbnDGDEuPf19qf6eZHchR0DzNsqUe3S3KA5PGJlEWQKlf30sbLi
	 zP8SJGJ1heaH+Q4ExUePHFihiuWzEMSZGQOafqgXVz3ukEX+Zhz4PAuENRInoj0NUG
	 LThe1nca58Z/w==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	horms@kernel.org
Subject: [PATCH net 7/9] netfilter: nft_ct: bail out on template ct in get eval
Date: Mon,  1 Jun 2026 13:59:21 +0200
Message-ID: <20260601115923.433946-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601115923.433946-1-pablo@netfilter.org>
References: <20260601115923.433946-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12974-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,netfilter.org:email,netfilter.org:mid,netfilter.org:dkim,syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:email]
X-Rspamd-Queue-Id: 03F8161EDE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiayuan Chen <jiayuan.chen@linux.dev>

I noticed this issue while looking at a historic syzbot report [1].

A rule like the one below is enough to trigger the bug:

    table ip t {
        chain pre {
            type filter hook prerouting priority raw;
            ct zone set 1
            ct original saddr 1.2.3.4 accept
        }
    }

The first expression attaches a per-cpu template ct via
nft_ct_set_zone_eval() (nf_ct_tmpl_alloc -> kzalloc, tuple is all
zero, nf_ct_l3num(ct) == 0). The next expression then calls
nft_ct_get_eval() on the same skb, treats the template as a real ct
and hits the 16-byte memcpy path. With dreg at NFT_REG32_15 this
overflows past struct nft_regs on the kernel stack; with smaller
dreg values it silently clobbers adjacent registers.

Reject template ct at the eval entry and in nft_ct_get_fast_eval(),
mirroring the check nft_ct_set_eval() already has. Additionally,
bound the address copy in NFT_CT_SRC / NFT_CT_DST by priv->len
instead of by nf_ct_l3num(ct): nf_ct_get_tuple() zeroes the tuple
before pkt_to_tuple() fills in only the protocol-relevant leading
bytes, so the trailing bytes of tuple->{src,dst}.u3.all are
well-defined zero. priv->len is validated at rule load, so the
copy size is now bounded by the destination register rather than
by an untrusted field on the conntrack.

[1]: https://syzkaller.appspot.com/bug?id=389cf09cb72926114fce90dc85a2c3231dcb647c

Fixes: 45d9bcda21f4 ("netfilter: nf_tables: validate len in nft_validate_data_load()")
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_ct.c      | 8 +++-----
 net/netfilter/nft_ct_fast.c | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index fa2cc556331c..357513c6dcea 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -78,7 +78,7 @@ static void nft_ct_get_eval(const struct nft_expr *expr,
 		break;
 	}
 
-	if (ct == NULL)
+	if (!ct || nf_ct_is_template(ct))
 		goto err;
 
 	switch (priv->key) {
@@ -180,12 +180,10 @@ static void nft_ct_get_eval(const struct nft_expr *expr,
 	tuple = &ct->tuplehash[priv->dir].tuple;
 	switch (priv->key) {
 	case NFT_CT_SRC:
-		memcpy(dest, tuple->src.u3.all,
-		       nf_ct_l3num(ct) == NFPROTO_IPV4 ? 4 : 16);
+		memcpy(dest, tuple->src.u3.all, priv->len);
 		return;
 	case NFT_CT_DST:
-		memcpy(dest, tuple->dst.u3.all,
-		       nf_ct_l3num(ct) == NFPROTO_IPV4 ? 4 : 16);
+		memcpy(dest, tuple->dst.u3.all, priv->len);
 		return;
 	case NFT_CT_PROTO_SRC:
 		nft_reg_store16(dest, (__force u16)tuple->src.u.all);
diff --git a/net/netfilter/nft_ct_fast.c b/net/netfilter/nft_ct_fast.c
index e684c8a91848..ecf7b3a404be 100644
--- a/net/netfilter/nft_ct_fast.c
+++ b/net/netfilter/nft_ct_fast.c
@@ -30,7 +30,7 @@ void nft_ct_get_fast_eval(const struct nft_expr *expr,
 		break;
 	}
 
-	if (!ct) {
+	if (!ct || nf_ct_is_template(ct)) {
 		regs->verdict.code = NFT_BREAK;
 		return;
 	}
-- 
2.47.3


