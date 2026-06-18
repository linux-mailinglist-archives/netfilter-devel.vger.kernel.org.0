Return-Path: <netfilter-devel+bounces-13320-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TXbJIcbGM2qSGAYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13320-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 12:21:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0D969F404
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 12:21:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b=a0gbs1qh;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13320-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13320-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30829300BEBF
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 10:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD113EE1D1;
	Thu, 18 Jun 2026 10:19:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7383ED105;
	Thu, 18 Jun 2026 10:19:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777992; cv=none; b=i0acmVo8obXhMcPyZX/KBwt7EDbJy2bjk9DzUUi1SY4OdMGPRsdwzNTfJyYoD8JmpJqcFBUaLwOFIasFXaQvlMlA/+XJbggZZMmC54boUJWVu4Z5mdcJr5Uel6alJeu8ZQ20DW+jPdRhEC9A/O7ZUZMZ5ewY2bi9JrCoIUyFiYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777992; c=relaxed/simple;
	bh=b/X6ZNLGum2oS6sEsNNn+wpKuROst8BH4teA3a1TnvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nNy7MVDm47y9WBGnDPhRo/D8n3TaE6nUYbXLl7y+oqVcJ2TU1a1f0UkDypBZC/Tcd0kCOIkqjYD/RCBIFIr6yTu8+8/twKuSWffbQFGOHUZPAA4gVbHTratDwv2lW0VRnQHmYnTVkpeeXlkrRmkbixADTAcBvz5pqC0ifi0Z1U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=a0gbs1qh; arc=none smtp.client-ip=13.75.44.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=heiPlvi0bHJFp7LAke2GAwtGSzaSOGptO9
	dMWBxYmEg=; b=a0gbs1qhU2ZZaRGjVMGuBDv3YiFfFLoiwEX/zmY+DwHLPcHgFh
	nSsul/O0p4mglgisan65DGBhWr2ntzrNSJbd084W/AfdautmW9AZ68ifhsfgsPXU
	8xa3cH5ZU6kNAMtRvsZwpg8hLA+j2gMx27O3Z3B6k1BpFkDMita9RvDHI=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web5 (Coremail) with SMTP id zAQGZQB3L78IxjNq23+CAg--.46531S4;
	Thu, 18 Jun 2026 18:19:03 +0800 (CST)
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
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Cover small conntrack opts error writes
Date: Thu, 18 Jun 2026 10:18:44 +0000
Message-Id: <007dfd0341cd84560e4795a2a951cc56d4adff1d.1781765747.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1781765747.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781586477.git.chenyy23@mails.tsinghua.edu.cn> <cover.1781765747.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQB3L78IxjNq23+CAg--.46531S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCw17GFy5uF4xAw18Gw45KFg_yoWrAFWrpF
	yfZanFkryrJ3WUtw1xJFs2gF45tFs7XFyUGrs3Jw13Cr4kZa40vF42gF4jqF9xuFs5Zr1S
	kws5tFnxGrZ7uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAa
	c4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
	Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S
	6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxw
	ACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_Gw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
	4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRdWrJUUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13320-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tsinghua.edu.cn:email,mails.tsinghua.edu.cn:dkim,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B0D969F404

Add a conntrack kfunc regression check for opts__sz values that do not
cover opts->error. The BPF program initializes opts->error with a guard
value, calls the lookup and allocation kfuncs with opts__sz set to
sizeof(opts->netns_id), and verifies that the guard is still intact
after the kfunc returns NULL.

Without the conntrack wrapper guard, the kfunc error path overwrites
that guard with -EINVAL even though the verifier checked only the first
four bytes of the options object.

Fixes: b4c2b9593a1c ("net/netfilter: Add unstable CT lookup helpers for XDP and TC-BPF")
Fixes: d7e79c97c00c ("net: netfilter: Add kfuncs to allocate and insert CT")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |  6 +++++
 .../testing/selftests/bpf/progs/test_bpf_nf.c | 26 +++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
index b33dba4b126e2..14d4c1793aed5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_nf.c
@@ -5,6 +5,8 @@
 #include "test_bpf_nf.skel.h"
 #include "test_bpf_nf_fail.skel.h"
 
+#define CT_OPTS_ERROR_GUARD 0x12345678
+
 static char log_buf[1024 * 1024];
 
 struct {
@@ -119,6 +121,10 @@ static void test_bpf_nf_ct(int mode)
 	ASSERT_EQ(skel->bss->test_einval_reserved_new, -EINVAL, "Test EINVAL for reserved in new struct not set to 0");
 	ASSERT_EQ(skel->bss->test_einval_netns_id, -EINVAL, "Test EINVAL for netns_id < -1");
 	ASSERT_EQ(skel->bss->test_einval_len_opts, -EINVAL, "Test EINVAL for len__opts != NF_BPF_CT_OPTS_SZ");
+	ASSERT_EQ(skel->bss->test_einval_len_opts_small_lookup, CT_OPTS_ERROR_GUARD,
+		  "Test no error write for lookup opts__sz before error field");
+	ASSERT_EQ(skel->bss->test_einval_len_opts_small_alloc, CT_OPTS_ERROR_GUARD,
+		  "Test no error write for alloc opts__sz before error field");
 	ASSERT_EQ(skel->bss->test_eproto_l4proto, -EPROTO, "Test EPROTO for l4proto != TCP or UDP");
 	ASSERT_EQ(skel->bss->test_enonet_netns_id, -ENONET, "Test ENONET for bad but valid netns_id");
 	ASSERT_EQ(skel->bss->test_enoent_lookup, -ENOENT, "Test ENOENT for failed lookup");
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
index 076fbf03a1268..df43649ecb785 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
@@ -10,6 +10,8 @@
 #define EINVAL 22
 #define ENOENT 2
 
+#define CT_OPTS_ERROR_GUARD 0x12345678
+
 #define NF_CT_ZONE_DIR_ORIG (1 << IP_CT_DIR_ORIGINAL)
 #define NF_CT_ZONE_DIR_REPL (1 << IP_CT_DIR_REPLY)
 
@@ -19,6 +21,8 @@ int test_einval_reserved = 0;
 int test_einval_reserved_new = 0;
 int test_einval_netns_id = 0;
 int test_einval_len_opts = 0;
+int test_einval_len_opts_small_lookup = 0;
+int test_einval_len_opts_small_alloc = 0;
 int test_eproto_l4proto = 0;
 int test_enonet_netns_id = 0;
 int test_enoent_lookup = 0;
@@ -124,6 +128,28 @@ nf_ct_test(struct nf_conn *(*lookup_fn)(void *, struct bpf_sock_tuple *, u32,
 	else
 		test_einval_len_opts = opts_def.error;
 
+	opts_def.error = CT_OPTS_ERROR_GUARD;
+	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
+		       sizeof(opts_def.netns_id));
+	if (ct) {
+		bpf_ct_release(ct);
+		test_einval_len_opts_small_lookup = -EINVAL;
+	} else {
+		test_einval_len_opts_small_lookup = opts_def.error;
+	}
+
+	opts_def.error = CT_OPTS_ERROR_GUARD;
+	ct = alloc_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
+		      sizeof(opts_def.netns_id));
+	if (ct) {
+		ct = bpf_ct_insert_entry(ct);
+		if (ct)
+			bpf_ct_release(ct);
+		test_einval_len_opts_small_alloc = -EINVAL;
+	} else {
+		test_einval_len_opts_small_alloc = opts_def.error;
+	}
+
 	opts_def.l4proto = IPPROTO_ICMP;
 	ct = lookup_fn(ctx, &bpf_tuple, sizeof(bpf_tuple.ipv4), &opts_def,
 		       sizeof(opts_def));
-- 
2.34.1


