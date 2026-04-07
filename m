Return-Path: <netfilter-devel+bounces-11687-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDW3GB4S1Wm30AcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11687-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:18:06 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 022863AFE44
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Apr 2026 16:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A88E300B9E5
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2026 14:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC573BA227;
	Tue,  7 Apr 2026 14:16:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3233B9DA4;
	Tue,  7 Apr 2026 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775571396; cv=none; b=RurYEi6ts3ZzhXieXh7ZABNKp9nTbofk7Rk8J3wA9Ppbx6oQEkY00N+TPWqQFTfuxzLogip2oZMN0Z8JyDuclEgGgdn38w8wzMWGSrMsmhI3Qz5FbuyEss2UhwWpCTVjaVisfeXj4cp57q6WjZZgQr3El+treSDm0WuOz0yS0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775571396; c=relaxed/simple;
	bh=qJwIJhT3+RHZ4PHoXNAPjUqakM53DB8qFmDfUnpQN/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVlVjORsdTncitOophdlMvoT3NuemPKTr2GeRYwYGu2AUN3unLDWesI/GOzUx4mLSrCDgvN6SU4/lIdNl//w4GsWnS0hPvR2IPH2GoMHEwRFYZKGXdvisAw0RumbDKbEM3cMgVcwpRwCXgXY0QZlTB/OleKapWcONmPAt55444g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 04D1B60690; Tue, 07 Apr 2026 16:16:32 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net-next 11/13] netfilter: nf_conntrack_h323: Correct indentation when H323_TRACE defined
Date: Tue,  7 Apr 2026 16:15:38 +0200
Message-ID: <20260407141540.11549-12-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260407141540.11549-1-fw@strlen.de>
References: <20260407141540.11549-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11687-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 022863AFE44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Laight <david.laight.linux@gmail.com>

The trace lines are indented using PRINT("%*.s", xx, " ").
Userspace will treat this as "%*.0s" and will output no characters
when 'xx' is zero, the kernel treats it as "%*s" and will output
a single ' ' - which is probably what is intended.

Change all the formats to "%*s" removing the default precision.
This gives a single space indent when level is zero.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_h323_asn1.c | 38 +++++++++++++-------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/net/netfilter/nf_conntrack_h323_asn1.c b/net/netfilter/nf_conntrack_h323_asn1.c
index 09e0f724644f..6830c9da3507 100644
--- a/net/netfilter/nf_conntrack_h323_asn1.c
+++ b/net/netfilter/nf_conntrack_h323_asn1.c
@@ -274,7 +274,7 @@ static unsigned int get_uint(struct bitstr *bs, int b)
 static int decode_nul(struct bitstr *bs, const struct field_t *f,
                       char *base, int level)
 {
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	return H323_ERROR_NONE;
 }
@@ -282,7 +282,7 @@ static int decode_nul(struct bitstr *bs, const struct field_t *f,
 static int decode_bool(struct bitstr *bs, const struct field_t *f,
                        char *base, int level)
 {
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	INC_BIT(bs);
 	if (nf_h323_error_boundary(bs, 0, 0))
@@ -295,7 +295,7 @@ static int decode_oid(struct bitstr *bs, const struct field_t *f,
 {
 	int len;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	BYTE_ALIGN(bs);
 	if (nf_h323_error_boundary(bs, 1, 0))
@@ -314,7 +314,7 @@ static int decode_int(struct bitstr *bs, const struct field_t *f,
 {
 	unsigned int len;
 
-	PRINT("%*.s%s", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s", level * TAB_SIZE, " ", f->name);
 
 	switch (f->sz) {
 	case BYTE:		/* Range == 256 */
@@ -361,7 +361,7 @@ static int decode_int(struct bitstr *bs, const struct field_t *f,
 static int decode_enum(struct bitstr *bs, const struct field_t *f,
                        char *base, int level)
 {
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	if ((f->attr & EXT) && get_bit(bs)) {
 		INC_BITS(bs, 7);
@@ -379,7 +379,7 @@ static int decode_bitstr(struct bitstr *bs, const struct field_t *f,
 {
 	unsigned int len;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	BYTE_ALIGN(bs);
 	switch (f->sz) {
@@ -415,7 +415,7 @@ static int decode_numstr(struct bitstr *bs, const struct field_t *f,
 {
 	unsigned int len;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	/* 2 <= Range <= 255 */
 	if (nf_h323_error_boundary(bs, 0, f->sz))
@@ -435,7 +435,7 @@ static int decode_octstr(struct bitstr *bs, const struct field_t *f,
 {
 	unsigned int len;
 
-	PRINT("%*.s%s", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s", level * TAB_SIZE, " ", f->name);
 
 	switch (f->sz) {
 	case FIXD:		/* Range == 1 */
@@ -483,7 +483,7 @@ static int decode_bmpstr(struct bitstr *bs, const struct field_t *f,
 {
 	unsigned int len;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	switch (f->sz) {
 	case BYTE:		/* Range == 256 */
@@ -515,7 +515,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	const struct field_t *son;
 	unsigned char *beg = NULL;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	/* Decode? */
 	base = (base && (f->attr & DECODE)) ? base + f->offset : NULL;
@@ -537,7 +537,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 	/* Decode the root components */
 	for (i = opt = 0, son = f->fields; i < f->lb; i++, son++) {
 		if (son->attr & STOP) {
-			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
+			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
 			      son->name);
 			return H323_ERROR_STOP;
 		}
@@ -555,7 +555,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 			if (nf_h323_error_boundary(bs, len, 0))
 				return H323_ERROR_BOUND;
 			if (!base || !(son->attr & DECODE)) {
-				PRINT("%*.s%s\n", (level + 1) * TAB_SIZE,
+				PRINT("%*s%s\n", (level + 1) * TAB_SIZE,
 				      " ", son->name);
 				bs->cur += len;
 				continue;
@@ -608,7 +608,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 		}
 
 		if (son->attr & STOP) {
-			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
+			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
 			      son->name);
 			return H323_ERROR_STOP;
 		}
@@ -622,7 +622,7 @@ static int decode_seq(struct bitstr *bs, const struct field_t *f,
 		if (nf_h323_error_boundary(bs, len, 0))
 			return H323_ERROR_BOUND;
 		if (!base || !(son->attr & DECODE)) {
-			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
+			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
 			      son->name);
 			bs->cur += len;
 			continue;
@@ -648,7 +648,7 @@ static int decode_seqof(struct bitstr *bs, const struct field_t *f,
 	const struct field_t *son;
 	unsigned char *beg = NULL;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	/* Decode? */
 	base = (base && (f->attr & DECODE)) ? base + f->offset : NULL;
@@ -703,7 +703,7 @@ static int decode_seqof(struct bitstr *bs, const struct field_t *f,
 			if (nf_h323_error_boundary(bs, len, 0))
 				return H323_ERROR_BOUND;
 			if (!base || !(son->attr & DECODE)) {
-				PRINT("%*.s%s\n", (level + 1) * TAB_SIZE,
+				PRINT("%*s%s\n", (level + 1) * TAB_SIZE,
 				      " ", son->name);
 				bs->cur += len;
 				continue;
@@ -744,7 +744,7 @@ static int decode_choice(struct bitstr *bs, const struct field_t *f,
 	const struct field_t *son;
 	unsigned char *beg = NULL;
 
-	PRINT("%*.s%s\n", level * TAB_SIZE, " ", f->name);
+	PRINT("%*s%s\n", level * TAB_SIZE, " ", f->name);
 
 	/* Decode? */
 	base = (base && (f->attr & DECODE)) ? base + f->offset : NULL;
@@ -785,7 +785,7 @@ static int decode_choice(struct bitstr *bs, const struct field_t *f,
 	/* Transfer to son level */
 	son = &f->fields[type];
 	if (son->attr & STOP) {
-		PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ", son->name);
+		PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ", son->name);
 		return H323_ERROR_STOP;
 	}
 
@@ -797,7 +797,7 @@ static int decode_choice(struct bitstr *bs, const struct field_t *f,
 		if (nf_h323_error_boundary(bs, len, 0))
 			return H323_ERROR_BOUND;
 		if (!base || !(son->attr & DECODE)) {
-			PRINT("%*.s%s\n", (level + 1) * TAB_SIZE, " ",
+			PRINT("%*s%s\n", (level + 1) * TAB_SIZE, " ",
 			      son->name);
 			bs->cur += len;
 			return H323_ERROR_NONE;
-- 
2.52.0


