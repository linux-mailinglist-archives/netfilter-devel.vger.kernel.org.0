Return-Path: <netfilter-devel+bounces-4311-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C4D99692C
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Oct 2024 13:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CCB3B25579
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Oct 2024 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E119258B;
	Wed,  9 Oct 2024 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="iKwxuBZw"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF8B18DF71
	for <netfilter-devel@vger.kernel.org>; Wed,  9 Oct 2024 11:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474508; cv=none; b=duZM/nItLSYNMzv+Z7ooj2Dke1BfIQ1VAC2Om8zUuYljwDM/SFPvEYPdHIVDy4lxF7+MSSMXCCVCvD28YSlV2h72DPnyRsErwYEimSGZMjUhEp2G3z4lrwHCAtl+3JI3u4j0PNZ8DmCoZWxatza4IvQ/GAYtfyHBhQxZJT70lrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474508; c=relaxed/simple;
	bh=sXQbY0fYZxmm0cT/yJiIu4KW8TR5TZdEBf0XO+LMo2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RobykVR1oAZHIefNwCE77jC6Tqj7PgJIPjetbMTnHQTH+4j4Ae+G19a4IA/CtFNLxorc8xNfJiOngo32GK1ZrZPDZ5I9fTEysAeUUMrDScEWtAS10Qwz6zAgza5NrQ1Wm9YweRut73TgEFLIqi+wmvavPmQ+hXDHy3CVcDeZO0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=iKwxuBZw; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DQDe8+KuCiqJh82nLYcOjtzx5dF16NnlsudtZ40ZLkg=; b=iKwxuBZwDfS3mnGnpd21QakGlR
	cGKRzTbuiXtuY9zkK8gz4ZT96kvZnGdu6DYs5ML8i6+nUrhkKES+m/Sg5aUrF0rLIu9Zl7xcugYcj
	nYxkGN3ckGqtfQQ6p32tQKLN6cCLnwCv1cnoxnGYFHNCVIKTn9C5fERdbmaAcR6F43rp0/dY2QOYE
	5LDX5jdRlfoOYawIpaxNlP0QVc6CfCmb9YjDBZTLGgyIKHeGfVxaXVBZzMryqjtgkaxHuEdYswtnT
	hRRUGwk9AoQEByHmLFDD5DanAP2n+WWLtK8XD5K2bEC7WRLYHRdNKge7G0WqoaF993H2BZBWt0LZN
	9zMLGo7g==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1syVB2-000000008HC-0Erh;
	Wed, 09 Oct 2024 13:48:24 +0200
From: Phil Sutter <phil@nwl.cc>
To: netfilter-devel@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jan Engelhardt <jengelh@inai.de>
Subject: [iptables PATCH v2 7/8] nft: Embed compat extensions in rule userdata
Date: Wed,  9 Oct 2024 13:48:18 +0200
Message-ID: <20241009114819.15379-8-phil@nwl.cc>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009114819.15379-1-phil@nwl.cc>
References: <20241009114819.15379-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If enabled (via --compat flag or XTABLES_COMPAT env variable), attach
any extensions for which native nftables expressions are generated to
userdata. An earlier version of the tool trying to parse the
kernel-dumped ruleset may then fall back to these extensions if native
expression parsing fails.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Convert type and zip bit to flags
- Add compat ext for NFLOG, too
- Export parsing code into an initial patch
- Make the feature opt-in for users
---
 iptables/arptables-nft.8       | 12 ++++++
 iptables/ebtables-nft.8        | 12 ++++++
 iptables/iptables-restore.8.in | 12 ++++++
 iptables/iptables.8.in         | 12 ++++++
 iptables/nft-compat.c          | 74 ++++++++++++++++++++++++++++++++++
 iptables/nft-compat.h          | 25 ++++++++++++
 iptables/nft-ruleparse.c       |  2 +-
 iptables/nft.c                 | 63 ++++++++++++++++++++++-------
 iptables/nft.h                 |  3 ++
 iptables/xshared.c             |  7 ++++
 iptables/xshared.h             |  1 +
 iptables/xtables-arp.c         |  1 +
 iptables/xtables-eb.c          |  4 ++
 iptables/xtables-nft.8         | 11 +++++
 iptables/xtables-restore.c     | 15 ++++++-
 iptables/xtables.c             |  3 ++
 16 files changed, 240 insertions(+), 17 deletions(-)

diff --git a/iptables/arptables-nft.8 b/iptables/arptables-nft.8
index c48a2cc2286ba..8d1eb9fb651ed 100644
--- a/iptables/arptables-nft.8
+++ b/iptables/arptables-nft.8
@@ -234,6 +234,18 @@ counters of a rule (during
 .B APPEND,
 .B REPLACE
 operations).
+.TP
+.B --compat
+When creating a rule, attach compatibility data to the rule's userdata section
+for use as aid in parsing the rule by an older version of the program. The old
+version obviously needs to support this, though.
+Specifying this option a second time instructs the program to default to the
+rule's compatibility data when parsing, which is mostly useful for debugging or
+testing purposes.
+
+The \fBXTABLES_COMPAT\fP environment variable can be used to override the
+default setting. The expected value is a natural number representing the number
+of times \fB--compat\fP was specified.
 
 .SS RULE-SPECIFICATIONS
 The following command line arguments make up a rule specification (as used 
diff --git a/iptables/ebtables-nft.8 b/iptables/ebtables-nft.8
index 8698165024de1..3088bb0cce366 100644
--- a/iptables/ebtables-nft.8
+++ b/iptables/ebtables-nft.8
@@ -360,6 +360,18 @@ to try to automatically load missing kernel modules.
 .B --concurrent
 This would use a file lock to support concurrent scripts updating the ebtables
 kernel tables. It is not needed with \fBebtables-nft\fP though and thus ignored.
+.TP
+.B --compat
+When creating a rule, attach compatibility data to the rule's userdata section
+for use as aid in parsing the rule by an older version of the program. The old
+version obviously needs to support this, though.
+Specifying this option a second time instructs the program to default to the
+rule's compatibility data when parsing, which is mostly useful for debugging or
+testing purposes.
+
+The \fBXTABLES_COMPAT\fP environment variable can be used to override the
+default setting. The expected value is a natural number representing the number
+of times \fB--compat\fP was specified.
 
 .SS
 RULE SPECIFICATIONS
diff --git a/iptables/iptables-restore.8.in b/iptables/iptables-restore.8.in
index aa816f794d6f3..df61b2a623f64 100644
--- a/iptables/iptables-restore.8.in
+++ b/iptables/iptables-restore.8.in
@@ -74,6 +74,18 @@ determine the executable's path.
 .TP
 \fB\-T\fP, \fB\-\-table\fP \fIname\fP
 Restore only the named table even if the input stream contains other ones.
+.TP
+\fB\-\-compat\fP (nft-variants only)
+When creating a rule, attach compatibility data to the rule's userdata section
+for use as aid in parsing the rule by an older version of the program. The old
+version obviously needs to support this, though.
+Specifying this option a second time instructs the program to default to the
+rule's compatibility data when parsing, which is mostly useful for debugging or
+testing purposes.
+
+The \fBXTABLES_COMPAT\fP environment variable can be used to override the
+default setting. The expected value is a natural number representing the number
+of times \fB--compat\fP was specified.
 .SH BUGS
 None known as of iptables-1.2.1 release
 .SH AUTHORS
diff --git a/iptables/iptables.8.in b/iptables/iptables.8.in
index 21fb891dc6373..41c45a4a6e991 100644
--- a/iptables/iptables.8.in
+++ b/iptables/iptables.8.in
@@ -397,6 +397,18 @@ corresponding to that rule's position in the chain.
 \fB\-\-modprobe=\fP\fIcommand\fP
 When adding or inserting rules into a chain, use \fIcommand\fP
 to load any necessary modules (targets, match extensions, etc).
+.TP
+\fB\-\-compat\fP (nft-variants only)
+When creating a rule, attach compatibility data to the rule's userdata section
+for use as aid in parsing the rule by an older version of the program. The old
+version obviously needs to support this, though.
+Specifying this option a second time instructs the program to default to the
+rule's compatibility data when parsing, which is mostly useful for debugging or
+testing purposes.
+
+The \fBXTABLES_COMPAT\fP environment variable can be used to override the
+default setting. The expected value is a natural number representing the number
+of times \fB--compat\fP was specified.
 
 .SH LOCK FILE
 iptables uses the \fI@XT_LOCK_NAME@\fP file to take an exclusive lock at
diff --git a/iptables/nft-compat.c b/iptables/nft-compat.c
index 1edf08851c579..632733ca0cade 100644
--- a/iptables/nft-compat.c
+++ b/iptables/nft-compat.c
@@ -22,6 +22,21 @@
 
 #include <libnftnl/udata.h>
 
+int nftnl_rule_expr_count(const struct nftnl_rule *r)
+{
+	struct nftnl_expr_iter *iter = nftnl_expr_iter_create(r);
+	int cnt = 0;
+
+	if (!iter)
+		return -1;
+
+	while (nftnl_expr_iter_next(iter))
+		cnt++;
+
+	nftnl_expr_iter_destroy(iter);
+	return cnt;
+}
+
 static struct rule_udata_ext *
 rule_get_udata_ext(const struct nftnl_rule *r, uint32_t *outlen)
 {
@@ -44,6 +59,65 @@ rule_get_udata_ext(const struct nftnl_rule *r, uint32_t *outlen)
 	return nftnl_udata_get(tb[UDATA_TYPE_COMPAT_EXT]);
 }
 
+static void
+pack_rule_udata_ext_data(struct rule_udata_ext *rue,
+			 const void *data, size_t datalen)
+{
+	size_t datalen_out = datalen;
+#ifdef HAVE_ZLIB
+	compress(rue->data, &datalen_out, data, datalen);
+	rue->flags |= RUE_FLAG_ZIP;
+#else
+	memcpy(rue->data, data, datalen);
+#endif
+	rue->size = datalen_out;
+}
+
+void rule_add_udata_ext(struct nft_handle *h, struct nftnl_rule *r,
+			uint16_t start_idx, uint16_t end_idx,
+			uint8_t flags, uint16_t size, const void *data)
+{
+	struct rule_udata_ext *ext = NULL;
+	uint32_t extlen = 0, newextlen;
+	char *newext;
+	void *udata;
+
+	if (!h->compat)
+		return;
+
+	ext = rule_get_udata_ext(r, &extlen);
+	if (!ext)
+		extlen = 0;
+
+	udata = nftnl_udata_buf_alloc(NFT_USERDATA_MAXLEN);
+	if (!udata)
+		xtables_error(OTHER_PROBLEM, "can't alloc memory!");
+
+	newextlen = sizeof(*ext) + size;
+	newext = xtables_malloc(extlen + newextlen);
+	if (extlen)
+		memcpy(newext, ext, extlen);
+	memset(newext + extlen, 0, newextlen);
+
+	ext = (struct rule_udata_ext *)(newext + extlen);
+	ext->start_idx	= start_idx;
+	ext->end_idx	= end_idx;
+	ext->flags	= flags;
+	ext->orig_size	= size;
+	pack_rule_udata_ext_data(ext, data, size);
+	newextlen = sizeof(*ext) + ext->size;
+
+	if (!nftnl_udata_put(udata, UDATA_TYPE_COMPAT_EXT,
+			     extlen + newextlen, newext) ||
+	    nftnl_rule_set_data(r, NFTNL_RULE_USERDATA,
+				nftnl_udata_buf_data(udata),
+				nftnl_udata_buf_len(udata)))
+		xtables_error(OTHER_PROBLEM, "can't alloc memory!");
+
+	free(newext);
+	nftnl_udata_buf_free(udata);
+}
+
 static struct nftnl_expr *
 __nftnl_expr_from_udata_ext(struct rule_udata_ext *rue, const void *data)
 {
diff --git a/iptables/nft-compat.h b/iptables/nft-compat.h
index 1147f08a0b6d5..59b3c0267f8d0 100644
--- a/iptables/nft-compat.h
+++ b/iptables/nft-compat.h
@@ -5,6 +5,8 @@
 
 #include <linux/netfilter/x_tables.h>
 
+int nftnl_rule_expr_count(const struct nftnl_rule *r);
+
 enum rule_udata_ext_flags {
 	RUE_FLAG_MATCH_TYPE	= (1 << 0),
 	RUE_FLAG_TARGET_TYPE	= (1 << 1),
@@ -21,6 +23,29 @@ struct rule_udata_ext {
 	unsigned char data[];
 };
 
+struct nft_handle;
+
+void rule_add_udata_ext(struct nft_handle *h, struct nftnl_rule *r,
+			uint16_t start_idx, uint16_t end_idx,
+			uint8_t flags, uint16_t size, const void *data);
+static inline void
+rule_add_udata_match(struct nft_handle *h, struct nftnl_rule *r,
+		     uint16_t start_idx, uint16_t end_idx,
+		     const struct xt_entry_match *m)
+{
+	rule_add_udata_ext(h, r, start_idx, end_idx,
+			   RUE_FLAG_MATCH_TYPE, m->u.match_size, m);
+}
+
+static inline void
+rule_add_udata_target(struct nft_handle *h, struct nftnl_rule *r,
+		      uint16_t start_idx, uint16_t end_idx,
+		      const struct xt_entry_target *t)
+{
+	rule_add_udata_ext(h, r, start_idx, end_idx,
+			   RUE_FLAG_TARGET_TYPE, t->u.target_size, t);
+}
+
 struct nft_xt_ctx;
 
 bool rule_has_udata_ext(const struct nftnl_rule *r);
diff --git a/iptables/nft-ruleparse.c b/iptables/nft-ruleparse.c
index 34270e46ae888..cdf1af4fab277 100644
--- a/iptables/nft-ruleparse.c
+++ b/iptables/nft-ruleparse.c
@@ -950,7 +950,7 @@ bool nft_rule_to_iptables_command_state(struct nft_handle *h,
 			ret = false;
 		expr = nftnl_expr_iter_next(ctx.iter);
 	}
-	if (!ret && rule_has_udata_ext(r)) {
+	if ((!ret || h->compat > 1) && rule_has_udata_ext(r)) {
 		fprintf(stderr,
 			"Warning: Rule parser failed, trying compat fallback\n");
 
diff --git a/iptables/nft.c b/iptables/nft.c
index 9888debca16b4..d563a011bec5d 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -9,6 +9,7 @@
  * This code has been sponsored by Sophos Astaro <http://www.sophos.com>
  */
 
+#include "config.h"
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/types.h>
@@ -60,6 +61,7 @@
 #include "nft-cache.h"
 #include "nft-shared.h"
 #include "nft-bridge.h" /* EBT_NOPROTO */
+#include "nft-compat.h"
 
 static void *nft_fn;
 
@@ -1046,9 +1048,11 @@ void __add_match(struct nftnl_expr *e, const struct xt_entry_match *m)
 	nftnl_expr_set(e, NFTNL_EXPR_MT_INFO, info, m->u.match_size - sizeof(*m));
 }
 
-static int add_nft_limit(struct nftnl_rule *r, struct xt_entry_match *m)
+static int add_nft_limit(struct nft_handle *h, struct nftnl_rule *r,
+			 struct xt_entry_match *m)
 {
 	struct xt_rateinfo *rinfo = (void *)m->data;
+	int i, ecnt = nftnl_rule_expr_count(r);
 	static const uint32_t mult[] = {
 		XT_LIMIT_SCALE*24*60*60,	/* day */
 		XT_LIMIT_SCALE*60*60,		/* hour */
@@ -1056,7 +1060,8 @@ static int add_nft_limit(struct nftnl_rule *r, struct xt_entry_match *m)
 		XT_LIMIT_SCALE,			/* sec */
 	};
 	struct nftnl_expr *expr;
-	int i;
+
+	rule_add_udata_match(h, r, ecnt, ecnt + 1, m);
 
 	expr = nftnl_expr_alloc("limit");
 	if (!expr)
@@ -1371,6 +1376,7 @@ static bool udp_all_zero(const struct xt_udp *u)
 static int add_nft_udp(struct nft_handle *h, struct nftnl_rule *r,
 		       struct xt_entry_match *m)
 {
+	int ret, ecnt = nftnl_rule_expr_count(r);
 	struct xt_udp *udp = (void *)m->data;
 
 	if (udp->invflags > XT_UDP_INV_MASK ||
@@ -1385,8 +1391,12 @@ static int add_nft_udp(struct nft_handle *h, struct nftnl_rule *r,
 	if (nftnl_rule_get_u32(r, NFTNL_RULE_COMPAT_PROTO) != IPPROTO_UDP)
 		xtables_error(PARAMETER_PROBLEM, "UDP match requires '-p udp'");
 
-	return add_nft_tcpudp(h, r, udp->spts, udp->invflags & XT_UDP_INV_SRCPT,
-			      udp->dpts, udp->invflags & XT_UDP_INV_DSTPT);
+	ret = add_nft_tcpudp(h, r, udp->spts, udp->invflags & XT_UDP_INV_SRCPT,
+			     udp->dpts, udp->invflags & XT_UDP_INV_DSTPT);
+
+	rule_add_udata_match(h, r, ecnt, nftnl_rule_expr_count(r), m);
+
+	return ret;
 }
 
 static int add_nft_tcpflags(struct nft_handle *h, struct nftnl_rule *r,
@@ -1423,6 +1433,7 @@ static int add_nft_tcp(struct nft_handle *h, struct nftnl_rule *r,
 		       struct xt_entry_match *m)
 {
 	static const uint8_t supported = XT_TCP_INV_SRCPT | XT_TCP_INV_DSTPT | XT_TCP_INV_FLAGS;
+	int ret, ecnt = nftnl_rule_expr_count(r);
 	struct xt_tcp *tcp = (void *)m->data;
 
 	if (tcp->invflags & ~supported || tcp->option ||
@@ -1438,23 +1449,27 @@ static int add_nft_tcp(struct nft_handle *h, struct nftnl_rule *r,
 		xtables_error(PARAMETER_PROBLEM, "TCP match requires '-p tcp'");
 
 	if (tcp->flg_mask) {
-		int ret = add_nft_tcpflags(h, r, tcp->flg_cmp, tcp->flg_mask,
-					   tcp->invflags & XT_TCP_INV_FLAGS);
+		ret = add_nft_tcpflags(h, r, tcp->flg_cmp, tcp->flg_mask,
+				       tcp->invflags & XT_TCP_INV_FLAGS);
 
 		if (ret < 0)
 			return ret;
 	}
 
-	return add_nft_tcpudp(h, r, tcp->spts, tcp->invflags & XT_TCP_INV_SRCPT,
-			      tcp->dpts, tcp->invflags & XT_TCP_INV_DSTPT);
+	ret = add_nft_tcpudp(h, r, tcp->spts, tcp->invflags & XT_TCP_INV_SRCPT,
+			     tcp->dpts, tcp->invflags & XT_TCP_INV_DSTPT);
+
+	rule_add_udata_match(h, r, ecnt, nftnl_rule_expr_count(r), m);
+
+	return ret;
 }
 
 static int add_nft_mark(struct nft_handle *h, struct nftnl_rule *r,
 			struct xt_entry_match *m)
 {
 	struct xt_mark_mtinfo1 *mark = (void *)m->data;
+	int op, ecnt = nftnl_rule_expr_count(r);
 	uint8_t reg;
-	int op;
 
 	add_meta(h, r, NFT_META_MARK, &reg);
 	if (mark->mask != 0xffffffff)
@@ -1467,6 +1482,8 @@ static int add_nft_mark(struct nft_handle *h, struct nftnl_rule *r,
 
 	add_cmp_u32(r, mark->mark, op, reg);
 
+	rule_add_udata_match(h, r, ecnt, nftnl_rule_expr_count(r), m);
+
 	return 0;
 }
 
@@ -1480,7 +1497,7 @@ int add_match(struct nft_handle *h, struct nft_rule_ctx *ctx,
 	case NFT_COMPAT_RULE_INSERT:
 	case NFT_COMPAT_RULE_REPLACE:
 		if (!strcmp(m->u.user.name, "limit"))
-			return add_nft_limit(r, m);
+			return add_nft_limit(h, r, m);
 		else if (!strcmp(m->u.user.name, "among"))
 			return add_nft_among(h, r, m);
 		else if (!strcmp(m->u.user.name, "udp"))
@@ -1517,10 +1534,14 @@ void __add_target(struct nftnl_expr *e, const struct xt_entry_target *t)
 	nftnl_expr_set(e, NFTNL_EXPR_TG_INFO, info, t->u.target_size - sizeof(*t));
 }
 
-static int add_meta_nftrace(struct nftnl_rule *r)
+static int add_meta_nftrace(struct nft_handle *h, struct nftnl_rule *r,
+			    struct xt_entry_target *t)
 {
+	int ecnt = nftnl_rule_expr_count(r);
 	struct nftnl_expr *expr;
 
+	rule_add_udata_target(h, r, ecnt, ecnt + 2, t);
+
 	expr = nftnl_expr_alloc("immediate");
 	if (expr == NULL)
 		return -ENOMEM;
@@ -1545,7 +1566,7 @@ int add_target(struct nft_handle *h, struct nftnl_rule *r,
 	struct nftnl_expr *expr;
 
 	if (strcmp(t->u.user.name, "TRACE") == 0)
-		return add_meta_nftrace(r);
+		return add_meta_nftrace(h, r, t);
 
 	expr = nftnl_expr_alloc("target");
 	if (expr == NULL)
@@ -1588,7 +1609,8 @@ int add_verdict(struct nftnl_rule *r, int verdict)
 	return 0;
 }
 
-static int add_log(struct nftnl_rule *r, struct iptables_command_state *cs);
+static int add_log(struct nft_handle *h, struct nftnl_rule *r,
+		   struct iptables_command_state *cs);
 
 int add_action(struct nft_handle *h, struct nftnl_rule *r,
 	       struct iptables_command_state *cs, bool goto_set)
@@ -1605,7 +1627,7 @@ int add_action(struct nft_handle *h, struct nftnl_rule *r,
 		else if (strcmp(cs->jumpto, XTC_LABEL_RETURN) == 0)
 			ret = add_verdict(r, NFT_RETURN);
 		else if (strcmp(cs->jumpto, "NFLOG") == 0)
-			ret = add_log(r, cs);
+			ret = add_log(h, r, cs);
 		else
 			ret = add_target(h, r, cs->target->t);
 	} else if (strlen(cs->jumpto) > 0) {
@@ -1618,10 +1640,14 @@ int add_action(struct nft_handle *h, struct nftnl_rule *r,
 	return ret;
 }
 
-static int add_log(struct nftnl_rule *r, struct iptables_command_state *cs)
+static int add_log(struct nft_handle *h, struct nftnl_rule *r,
+		   struct iptables_command_state *cs)
 {
 	struct nftnl_expr *expr;
 	struct xt_nflog_info *info = (struct xt_nflog_info *)cs->target->t->data;
+	int ecnt = nftnl_rule_expr_count(r);
+
+	rule_add_udata_target(h, r, ecnt, ecnt + 1, cs->target->t);
 
 	expr = nftnl_expr_alloc("log");
 	if (!expr)
@@ -4047,3 +4073,10 @@ void nft_assert_table_compatible(struct nft_handle *h,
 		      "%s%s%stable `%s' is incompatible, use 'nft' tool.",
 		      pfx, chain, sfx, table);
 }
+
+uint8_t compat_env_val(void)
+{
+	const char *val = getenv("XTABLES_COMPAT");
+
+	return val ? atoi(val) : 0;
+}
diff --git a/iptables/nft.h b/iptables/nft.h
index e2004ba6e8292..94d90bef44fb3 100644
--- a/iptables/nft.h
+++ b/iptables/nft.h
@@ -108,6 +108,7 @@ struct nft_handle {
 	struct nft_cache_req	cache_req;
 	bool			restore;
 	bool			noflush;
+	uint8_t			compat;
 	int8_t			config_done;
 	struct list_head	cmd_list;
 	bool			cache_init;
@@ -289,4 +290,6 @@ enum udata_type {
 
 int parse_udata_cb(const struct nftnl_udata *attr, void *data);
 
+uint8_t compat_env_val(void);
+
 #endif
diff --git a/iptables/xshared.c b/iptables/xshared.c
index 2a5eef09c75de..544b65e219a8f 100644
--- a/iptables/xshared.c
+++ b/iptables/xshared.c
@@ -1254,6 +1254,9 @@ void xtables_printhelp(struct iptables_command_state *cs)
 		printf(
 "[!] --fragment	-f		match second or further fragments only\n");
 
+	if (strstr(xt_params->program_version, "nf_tables"))
+	printf(
+"  --compat			append compatibility data to new rules\n");
 	printf(
 "  --modprobe=<command>		try to insert modules using this command\n"
 "  --set-counters -c PKTS BYTES	set the counter during insert/append\n"
@@ -1918,6 +1921,10 @@ void do_parse(int argc, char *argv[],
 
 			exit_tryhelp(2, p->line);
 
+		case 20: /* --compat */
+			p->compat++;
+			break;
+
 		case 1: /* non option */
 			if (optarg[0] == '!' && optarg[1] == '\0') {
 				if (invert)
diff --git a/iptables/xshared.h b/iptables/xshared.h
index a111e79793b54..fdf5d6089bc6e 100644
--- a/iptables/xshared.h
+++ b/iptables/xshared.h
@@ -300,6 +300,7 @@ struct xt_cmd_parse {
 	bool				restore;
 	int				line;
 	int				verbose;
+	uint8_t				compat;
 	bool				rule_ranges;
 	struct xt_cmd_parse_ops		*ops;
 };
diff --git a/iptables/xtables-arp.c b/iptables/xtables-arp.c
index 71518a9cbdb6a..fe45c370d21db 100644
--- a/iptables/xtables-arp.c
+++ b/iptables/xtables-arp.c
@@ -78,6 +78,7 @@ static struct option original_opts[] = {
 	{ "line-numbers", 0, 0, '0' },
 	{ "modprobe", 1, 0, 'M' },
 	{ "set-counters", 1, 0, 'c' },
+	{ "compat", 0, 0, 20 },
 	{ 0 }
 };
 
diff --git a/iptables/xtables-eb.c b/iptables/xtables-eb.c
index 45663a3ad0ee0..ff364ec76191f 100644
--- a/iptables/xtables-eb.c
+++ b/iptables/xtables-eb.c
@@ -131,6 +131,7 @@ struct option ebt_original_options[] =
 	{ "init-table"     , no_argument      , 0, 11  },
 	{ "concurrent"     , no_argument      , 0, 13  },
 	{ "check"          , required_argument, 0, 14  },
+	{ "compat"         , no_argument      , 0, 20  },
 	{ 0 }
 };
 
@@ -234,6 +235,7 @@ void nft_bridge_print_help(struct iptables_command_state *cs)
 "[!] --logical-out name[+]     : logical bridge output interface name\n"
 "--set-counters -c chain\n"
 "          pcnt bcnt           : set the counters of the to be added rule\n"
+"--compat                      : append compatibility data to new rules\n"
 "--modprobe -M program         : try to insert modules using this program\n"
 "--concurrent                  : use a file lock to support concurrent scripts\n"
 "--verbose -v                  : verbose mode\n"
@@ -568,6 +570,7 @@ int do_commandeb(struct nft_handle *h, int argc, char *argv[], char **table,
 		.line		= line,
 		.rule_ranges	= true,
 		.ops		= &h->ops->cmd_parse,
+		.compat		= compat_env_val(),
 	};
 	int ret = 0;
 
@@ -577,6 +580,7 @@ int do_commandeb(struct nft_handle *h, int argc, char *argv[], char **table,
 	do_parse(argc, argv, &p, &cs, &args);
 
 	h->verbose	= p.verbose;
+	h->compat	= p.compat;
 
 	t = nft_table_builtin_find(h, p.table);
 	if (!t)
diff --git a/iptables/xtables-nft.8 b/iptables/xtables-nft.8
index ae54476c6cf87..2ed67ba9d471c 100644
--- a/iptables/xtables-nft.8
+++ b/iptables/xtables-nft.8
@@ -100,6 +100,17 @@ When using \-j TRACE to debug packet traversal to the ruleset, note that you wil
 .B xtables\-monitor(8)
 in \-\-trace mode to obtain monitoring trace events.
 
+Some extensions are implemented via native nf_tables expressions instead of
+\fBnft_compat\fP module. This is transparent to the user as such parts of a
+rule are detected and parsed into an extension again before listing. Also,
+run-time behaviour is supposed to be identical. Implementing extensions this
+way is beneficial from a kernel maintainer's perspective as xtables extension
+modules may at some point become unused, so increasing extension conversion is
+to be expected. Since this may break older versions parsing the ruleset
+in-kernel (a possible scenario with containers sharing a network namespace),
+there is \fB--compat\fP flag which causes the replaced extensions to be
+appended to the rule in userdata storage for the parser to fall back to.
+
 .SH EXAMPLES
 One basic example is creating the skeleton ruleset in nf_tables from the
 xtables-nft tools, in a fresh machine:
diff --git a/iptables/xtables-restore.c b/iptables/xtables-restore.c
index 23cd349819f4f..e7802b9e140bd 100644
--- a/iptables/xtables-restore.c
+++ b/iptables/xtables-restore.c
@@ -37,6 +37,7 @@ static const struct option options[] = {
 	{.name = "ipv6",     .has_arg = false, .val = '6'},
 	{.name = "wait",          .has_arg = 2, .val = 'w'},
 	{.name = "wait-interval", .has_arg = 2, .val = 'W'},
+	{.name = "compat",   .has_arg = false, .val = 20 },
 	{NULL},
 };
 
@@ -54,6 +55,7 @@ static void print_usage(const char *name, const char *version)
 			"	   [ --noflush ]\n"
 			"	   [ --table=<TABLE> ]\n"
 			"	   [ --modprobe=<command> ]\n"
+			"	   [ --compat ]\n"
 			"	   [ --ipv4 ]\n"
 			"	   [ --ipv6 ]\n", name);
 }
@@ -284,6 +286,7 @@ void xtables_restore_parse(struct nft_handle *h,
 static int
 xtables_restore_main(int family, const char *progname, int argc, char *argv[])
 {
+	uint8_t compat = compat_env_val();
 	struct nft_xt_restore_parse p = {
 		.commit = true,
 		.cb = &restore_cb,
@@ -337,6 +340,9 @@ xtables_restore_main(int family, const char *progname, int argc, char *argv[])
 				if (!optarg && xs_has_arg(argc, argv))
 					optind++;
 				break;
+			case 20:
+				compat++;
+				break;
 			default:
 				fprintf(stderr,
 					"Try `%s -h' for more information.\n",
@@ -387,6 +393,7 @@ xtables_restore_main(int family, const char *progname, int argc, char *argv[])
 	}
 	h.noflush = noflush;
 	h.restore = true;
+	h.compat  = compat;
 
 	xtables_restore_parse(&h, &p);
 
@@ -419,11 +426,13 @@ static const struct nft_xt_restore_cb ebt_restore_cb = {
 static const struct option ebt_restore_options[] = {
 	{.name = "noflush", .has_arg = 0, .val = 'n'},
 	{.name = "verbose", .has_arg = 0, .val = 'v'},
+	{.name = "compat",  .has_arg = 0, .val = 20},
 	{ 0 }
 };
 
 int xtables_eb_restore_main(int argc, char *argv[])
 {
+	uint8_t compat = compat_env_val();
 	struct nft_xt_restore_parse p = {
 		.in = stdin,
 		.cb = &ebt_restore_cb,
@@ -441,9 +450,12 @@ int xtables_eb_restore_main(int argc, char *argv[])
 		case 'v':
 			verbose++;
 			break;
+		case 20: /* --compat */
+			compat++;
+			break;
 		default:
 			fprintf(stderr,
-				"Usage: ebtables-restore [ --verbose ] [ --noflush ]\n");
+				"Usage: ebtables-restore [ --verbose ] [ --noflush ] [ --compat ]\n");
 			exit(1);
 			break;
 		}
@@ -451,6 +463,7 @@ int xtables_eb_restore_main(int argc, char *argv[])
 
 	nft_init_eb(&h, "ebtables-restore");
 	h.noflush = noflush;
+	h.compat = compat;
 	xtables_restore_parse(&h, &p);
 	nft_fini_eb(&h);
 
diff --git a/iptables/xtables.c b/iptables/xtables.c
index 5d73481c25761..7d540880da471 100644
--- a/iptables/xtables.c
+++ b/iptables/xtables.c
@@ -82,6 +82,7 @@ static struct option original_opts[] = {
 	{.name = "goto",	  .has_arg = 1, .val = 'g'},
 	{.name = "ipv4",	  .has_arg = 0, .val = '4'},
 	{.name = "ipv6",	  .has_arg = 0, .val = '6'},
+	{.name = "compat",        .has_arg = 0, .val = 20},
 	{NULL},
 };
 
@@ -147,6 +148,7 @@ int do_commandx(struct nft_handle *h, int argc, char *argv[], char **table,
 		.restore	= restore,
 		.line		= line,
 		.ops		= &h->ops->cmd_parse,
+		.compat		= compat_env_val(),
 	};
 	struct iptables_command_state cs = {
 		.jumpto = "",
@@ -161,6 +163,7 @@ int do_commandx(struct nft_handle *h, int argc, char *argv[], char **table,
 
 	do_parse(argc, argv, &p, &cs, &args);
 	h->verbose = p.verbose;
+	h->compat  = p.compat;
 
 	if (!nft_table_builtin_find(h, p.table))
 		xtables_error(VERSION_PROBLEM,
-- 
2.43.0


