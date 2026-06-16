Return-Path: <netfilter-devel+bounces-13283-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 57G/GZ3iMGpRYQUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13283-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 07:43:57 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0700468C3D6
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 07:43:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b=ngjL2mdQ;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13283-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13283-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FCCC3022913
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 05:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450F73D75B6;
	Tue, 16 Jun 2026 05:43:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D793D7D80;
	Tue, 16 Jun 2026 05:43:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781588619; cv=none; b=L/hfk/2oW7zZNw/hg5d2SGIrUq9Doju82AvNzXcQFxhA8JttqjEYg0bxdfLKkLW2l3rjS22nIUpHamRKUE9074OoC79g0YoEcGGy6XB6B60usPMLnzz9kxCazBXnS46Pfz22y07bnoCIb1z6GzQqPDeclwKEMujKs+mfxsrTJ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781588619; c=relaxed/simple;
	bh=VSQU9cOEKrvQCM65ZGRkHFZDUETisknBmP9P7m6Dc+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKHDf66ZEfVift7Z2q7+1gAyt+sM8rtfhWW+5hBWF4ToLsJakLwsoZAxe+xi6t+k5ljniNeZy1JHbsCl2VzzBqfoGnZ1SIjpzsgc7eVanf2PSb/fTqdv7rrnR9OP8oHdKlBN3M9z4cWZJ1IYXBb60pA0+H6y93p+37z2FXG7lXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ngjL2mdQ; arc=none smtp.client-ip=209.97.182.222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=QUc0qs8GSG7QX1lLB/HeBhB/tBAfRhhTnJ
	jBoOVXWe4=; b=ngjL2mdQXrM6CpI+H9zJgZJ0yG82+foLH7e2MxPhpEzq+dNi7P
	RLadrZD+hEWN4Ro+OvfVulDzZ30Mktz7pxbNpORy4PYEOcNca15n2j2WECbMgLLU
	kJfe9Ule3hmjkefzn367umXTx7+8B7NOnoyItl1rqRkrX5jELhH+uK4Dk=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQBXMZlM4jBqXCpTAg--.51787S3;
	Tue, 16 Jun 2026 13:42:47 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org,
	kartikey406@gmail.com,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Guard conntrack opts error writes
Date: Tue, 16 Jun 2026 05:42:34 +0000
Message-Id: <70aeec0ab762aebe65129cf6052e132c7329edc2.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQBXMZlM4jBqXCpTAg--.51787S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXry5uFy7ZFWxGw47tF48tFb_yoW5Zr4DpF
	Z2k3s5Aryayrs0ya1Fya1xJw1Y9an5uw1UCryrJ39akrsxW3WYgFyIgr4jvF93CF4rAr43
	trs5W3Z8C3WkAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_GrWl
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRqjgcUUUUU=
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13283-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[chenyy23@mails.tsinghua.edu.cn,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:chenyy23@mails.tsinghua.edu.cn,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:kartikey406@gmail.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,etsalapatis.com,vger.kernel.org];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenyy23@mails.tsinghua.edu.cn,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mails.tsinghua.edu.cn:dkim,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,tsinghua.edu.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0700468C3D6

The conntrack lookup and allocation kfuncs take an opts pointer
together with an opts__sz argument. The verifier checks only the memory
range described by opts__sz, but the wrappers unconditionally write
opts->error whenever the internal lookup or allocation helper returns an
error.

For an invalid size smaller than the end of opts->error, that write can
land outside the verifier-checked range. Keep returning NULL for invalid
arguments, but only report the error through opts->error when the
supplied size includes the field.

This preserves error reporting for the supported 12-byte and 16-byte
layouts, and for other invalid sizes that still include opts->error.

Fixes: b4c2b9593a1c ("net/netfilter: Add unstable CT lookup helpers for XDP and TC-BPF")
Fixes: d7e79c97c00c ("net: netfilter: Add kfuncs to allocate and insert CT")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 net/netfilter/nf_conntrack_bpf.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 40c261cd0af38..3c182024ec509 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -65,6 +65,11 @@ enum {
 	NF_BPF_CT_OPTS_SZ = 16,
 };
 
+static bool bpf_ct_opts_has_error(u32 opts_len)
+{
+	return opts_len >= offsetofend(struct bpf_ct_opts, error);
+}
+
 static int bpf_nf_ct_tuple_parse(struct bpf_sock_tuple *bpf_tuple,
 				 u32 tuple_len, u8 protonum, u8 dir,
 				 struct nf_conntrack_tuple *tuple)
@@ -298,7 +303,8 @@ bpf_xdp_ct_alloc(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
 	nfct = __bpf_nf_ct_alloc_entry(dev_net(ctx->rxq->dev), bpf_tuple, tuple__sz,
 				       opts, opts__sz, 10);
 	if (IS_ERR(nfct)) {
-		opts->error = PTR_ERR(nfct);
+		if (bpf_ct_opts_has_error(opts__sz))
+			opts->error = PTR_ERR(nfct);
 		return NULL;
 	}
 
@@ -332,7 +338,8 @@ bpf_xdp_ct_lookup(struct xdp_md *xdp_ctx, struct bpf_sock_tuple *bpf_tuple,
 	caller_net = dev_net(ctx->rxq->dev);
 	nfct = __bpf_nf_ct_lookup(caller_net, bpf_tuple, tuple__sz, opts, opts__sz);
 	if (IS_ERR(nfct)) {
-		opts->error = PTR_ERR(nfct);
+		if (bpf_ct_opts_has_error(opts__sz))
+			opts->error = PTR_ERR(nfct);
 		return NULL;
 	}
 	return nfct;
@@ -364,7 +371,8 @@ bpf_skb_ct_alloc(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
 	net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
 	nfct = __bpf_nf_ct_alloc_entry(net, bpf_tuple, tuple__sz, opts, opts__sz, 10);
 	if (IS_ERR(nfct)) {
-		opts->error = PTR_ERR(nfct);
+		if (bpf_ct_opts_has_error(opts__sz))
+			opts->error = PTR_ERR(nfct);
 		return NULL;
 	}
 
@@ -398,7 +406,8 @@ bpf_skb_ct_lookup(struct __sk_buff *skb_ctx, struct bpf_sock_tuple *bpf_tuple,
 	caller_net = skb->dev ? dev_net(skb->dev) : sock_net(skb->sk);
 	nfct = __bpf_nf_ct_lookup(caller_net, bpf_tuple, tuple__sz, opts, opts__sz);
 	if (IS_ERR(nfct)) {
-		opts->error = PTR_ERR(nfct);
+		if (bpf_ct_opts_has_error(opts__sz))
+			opts->error = PTR_ERR(nfct);
 		return NULL;
 	}
 	return nfct;
-- 
2.34.1


