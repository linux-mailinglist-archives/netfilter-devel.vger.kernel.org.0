Return-Path: <netfilter-devel+bounces-1116-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C38C86BC6C
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Feb 2024 01:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CBF1F22E9A
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Feb 2024 00:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722E1C2E;
	Thu, 29 Feb 2024 00:01:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B85188;
	Thu, 29 Feb 2024 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709164912; cv=none; b=Az+QCItC+hWcXpcNPuN535Vi4PZVYtG5i2KYh+xE/Np8nOTQYp4PQWEi121TAzD++oh0Ra8BrbsU6AjN55kL/7UWXFC1l05JVkheCVPU7oWFzsbfNXHLUSPtm0cNSCK7naNZjDGLbmOXGVJ1RQMt6erjmoaRlgCiNjZeHrgFydc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709164912; c=relaxed/simple;
	bh=o6VmqquYpHB/hN62sZqy6avWrnbokEYTX1h667ZRpdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gp/zKZu0EuyfqmwT268CX8lT6PYJpOLxw4ZS5kPzGAlHcwcPmEwfWJ+WO0B1iyHYyTO/fTdJibA7Dp/FO5EhJnsdC6KksZpiKVhDjDTZa5fo7Z0OYkxdEmCSwolvKdDX9QgShXRK/GCsJo3s6t4C0BB6LlpJ7xewBVNAuQiaBsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 1/3] netfilter: nf_tables: allow NFPROTO_INET in nft_(match/target)_validate()
Date: Thu, 29 Feb 2024 01:01:33 +0100
Message-Id: <20240229000135.8780-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240229000135.8780-1-pablo@netfilter.org>
References: <20240229000135.8780-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

Commit d0009effa886 ("netfilter: nf_tables: validate NFPROTO_* family") added
some validation of NFPROTO_* families in the nft_compat module, but it broke
the ability to use legacy iptables modules in dual-stack nftables.

While with legacy iptables one had to independently manage IPv4 and IPv6
tables, with nftables it is possible to have dual-stack tables sharing the
rules. Moreover, it was possible to use rules based on legacy iptables
match/target modules in dual-stack nftables.

As an example, the program from [2] creates an INET dual-stack family table
using an xt_bpf based rule, which looks like the following (the actual output
was generated with a patched nft tool as the current nft tool does not parse
dual stack tables with legacy match rules, so consider it for illustrative
purposes only):

table inet testfw {
  chain input {
    type filter hook prerouting priority filter; policy accept;
    bytecode counter packets 0 bytes 0 accept
  }
}

After d0009effa886 ("netfilter: nf_tables: validate NFPROTO_* family") we get
EOPNOTSUPP for the above program.

Fix this by allowing NFPROTO_INET for nft_(match/target)_validate(), but also
restrict the functions to classic iptables hooks.

Changes in v3:
  * clarify that upstream nft will not display such configuration properly and
    that the output was generated with a patched nft tool
  * remove example program from commit description and link to it instead
  * no code changes otherwise

Changes in v2:
  * restrict nft_(match/target)_validate() to classic iptables hooks
  * rewrite example program to use unmodified libnftnl

Fixes: d0009effa886 ("netfilter: nf_tables: validate NFPROTO_* family")
Link: https://lore.kernel.org/all/Zc1PfoWN38UuFJRI@calendula/T/#mc947262582c90fec044c7a3398cc92fac7afea72 [1]
Link: https://lore.kernel.org/all/20240220145509.53357-1-ignat@cloudflare.com/ [2]
Reported-by: Jordan Griege <jgriege@cloudflare.com>
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_compat.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 1f9474fefe84..d3d11dede545 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -359,10 +359,20 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET &&
 	    ctx->family != NFPROTO_BRIDGE &&
 	    ctx->family != NFPROTO_ARP)
 		return -EOPNOTSUPP;
 
+	ret = nft_chain_validate_hooks(ctx->chain,
+				       (1 << NF_INET_PRE_ROUTING) |
+				       (1 << NF_INET_LOCAL_IN) |
+				       (1 << NF_INET_FORWARD) |
+				       (1 << NF_INET_LOCAL_OUT) |
+				       (1 << NF_INET_POST_ROUTING));
+	if (ret)
+		return ret;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
@@ -610,10 +620,20 @@ static int nft_match_validate(const struct nft_ctx *ctx,
 
 	if (ctx->family != NFPROTO_IPV4 &&
 	    ctx->family != NFPROTO_IPV6 &&
+	    ctx->family != NFPROTO_INET &&
 	    ctx->family != NFPROTO_BRIDGE &&
 	    ctx->family != NFPROTO_ARP)
 		return -EOPNOTSUPP;
 
+	ret = nft_chain_validate_hooks(ctx->chain,
+				       (1 << NF_INET_PRE_ROUTING) |
+				       (1 << NF_INET_LOCAL_IN) |
+				       (1 << NF_INET_FORWARD) |
+				       (1 << NF_INET_LOCAL_OUT) |
+				       (1 << NF_INET_POST_ROUTING));
+	if (ret)
+		return ret;
+
 	if (nft_is_base_chain(ctx->chain)) {
 		const struct nft_base_chain *basechain =
 						nft_base_chain(ctx->chain);
-- 
2.30.2


