Return-Path: <netfilter-devel+bounces-13492-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +WnDHOn0P2ooawkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13492-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 18:06:01 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E280D6D23A3
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 18:06:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13492-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13492-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F4BA3019801
	for <lists+netfilter-devel@lfdr.de>; Sat, 27 Jun 2026 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B5313E00;
	Sat, 27 Jun 2026 16:05:58 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2C02D8370;
	Sat, 27 Jun 2026 16:05:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782576358; cv=none; b=aKtxKTXhOCJOKm+qqqWb7QsxKPIdXTwkP987mpRCAHwcsfFOmXDGj7sAzmq7LjFp4WFZA5eSN6ygMxRxLZonwldROVTXl8MZWTJsQOMHwOlA69NYxL57hIVWCkzG6umF6UxO48dQY5rCsEFvBSDGxVlHZpJhozBpIs1u6MHcHDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782576358; c=relaxed/simple;
	bh=xRGkFYnzldcuhbgkeMfPK5C8k68+70ktfJzOvruXRYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8wG2kwL1L8CTWHGa0p1TDmRiyJZUkIC98lcWtFuWSsYJZdd+9kFr+AJhqYdMqufbn0eDdZKUBJT0Rgt2j0NRKg1Hz4Udh9iRtAekT7nHP3T5cbNveVpBt910K8tkY9tlVrf0UnW3y0VCGhFCQ+NtO1PoUuCR0GGaqn4NCDY2nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=52.229.168.213
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnycO59D9qriK7AA--.4150S3;
	Sun, 28 Jun 2026 00:05:18 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org
Cc: horms@verge.net.au,
	ja@ssi.bg,
	pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	kaber@trash.net,
	nick@loadbalancer.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	roxy520tt@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] ipvs: preserve conn hash flags when late-binding dest
Date: Sun, 28 Jun 2026 00:05:02 +0800
Message-ID: <1b914f41d725bc064c9ba9830dc8169329737270.1782540466.git.roxy520tt@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782540466.git.roxy520tt@gmail.com>
References: <cover.1782540466.git.roxy520tt@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnycO59D9qriK7AA--.4150S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy5GrWDJw13tF4fCFy8Zrb_yoW5WrWUpF
	W8GFZxtFWktr13KFs2yF92va1fCFs7Jr129rZxtr93Z3s0qrn5tanakFWYy3WrCFWY9F13
	XF4avw1DC3WUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQELCWo-h9QDmAAAsf
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13492-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[lzu.edu.cn];
	FORGED_RECIPIENTS(0.00)[m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:horms@verge.net.au,m:ja@ssi.bg,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:kaber@trash.net,m:nick@loadbalancer.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:roxy520tt@gmail.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[verge.net.au,ssi.bg,netfilter.org,strlen.de,nwl.cc,trash.net,loadbalancer.org,gmail.com,lzu.edu.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[15];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E280D6D23A3

From: Zhiling Zou <roxy520tt@gmail.com>

Synced connections can be created before their destination exists. When
the destination is later added, ip_vs_try_bind_dest() binds it to the
existing connection through ip_vs_bind_dest().

ip_vs_bind_dest() copies destination connection flags into cp->flags.
For an already hashed connection, changing flags that define conn_tab
membership breaks the hash table invariants. In particular, adding
IP_VS_CONN_F_ONE_PACKET after the connection has been hashed can make
expiry skip unlinking it from conn_tab. Changing the forwarding method
can also make unlink use a different single or double hash-node layout
than the one used at insertion time.

Preserve the flags that define conn_tab hashing when binding a
destination to an already hashed connection.

Fixes: 26ec037f9841 ("IPVS: one-packet scheduling")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/netfilter/ipvs/ip_vs_conn.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index cb36641f8d1c..016273906aac 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -998,7 +998,11 @@ static inline int ip_vs_dest_totalconns(struct ip_vs_dest *dest)
 static inline void
 ip_vs_bind_dest(struct ip_vs_conn *cp, struct ip_vs_dest *dest)
 {
+	const unsigned int hash_flags = IP_VS_CONN_F_FWD_MASK |
+					IP_VS_CONN_F_NOOUTPUT |
+					IP_VS_CONN_F_ONE_PACKET;
 	unsigned int conn_flags;
+	__u32 old_flags;
 	__u32 flags;
 
 	/* if dest is NULL, then return directly */
@@ -1011,7 +1015,8 @@ ip_vs_bind_dest(struct ip_vs_conn *cp, struct ip_vs_dest *dest)
 	conn_flags = atomic_read(&dest->conn_flags);
 	if (cp->protocol != IPPROTO_UDP)
 		conn_flags &= ~IP_VS_CONN_F_ONE_PACKET;
-	flags = cp->flags;
+	old_flags = cp->flags;
+	flags = old_flags;
 	/* Bind with the destination and its corresponding transmitter */
 	if (flags & IP_VS_CONN_F_SYNC) {
 		/* if the connection is not template and is created
@@ -1023,6 +1028,13 @@ ip_vs_bind_dest(struct ip_vs_conn *cp, struct ip_vs_dest *dest)
 		flags &= ~(IP_VS_CONN_F_FWD_MASK | IP_VS_CONN_F_NOOUTPUT);
 	}
 	flags |= conn_flags;
+
+	/* Preserve conn_tab hashing invariants after late binding. */
+	if (old_flags & IP_VS_CONN_F_HASHED) {
+		flags &= ~hash_flags;
+		flags |= old_flags & hash_flags;
+	}
+
 	cp->flags = flags;
 	cp->dest = dest;
 
-- 
2.43.0


