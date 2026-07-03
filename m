Return-Path: <netfilter-devel+bounces-13626-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GUR0CLCzR2r8dgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13626-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 15:05:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 182FF702A70
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Jul 2026 15:05:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13626-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13626-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CB4B302C3F6
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Jul 2026 12:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BFF3D6476;
	Fri,  3 Jul 2026 12:57:51 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6863838A73F;
	Fri,  3 Jul 2026 12:57:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083471; cv=none; b=YaEu5ofr5YVIpx29O81P3TtBUhVRbR2kUV1Tg00OyDJTd/Xc+WfYfP8q1eJLYRRcaDhOSMxB2ui8ra/Fq9ukXf51t0iKtMd5ifRHdoxXoRLs/eeQgQ/SmvSzjr+/kClnMOpWK4x9Dk0BNZZg2qUm1PtVm1Zf82/oJvM9pXgBALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083471; c=relaxed/simple;
	bh=xG4CRMAZXD1Tv8UbdnuLSEYPPwzLRtZq7Ph/7fJvWaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrsfT9/3pu0BoqVMozg3+iEVbrSEvHlzzVvlF6iDGJF/7VtimvW4aUMb77waZhZOxIfwL6RTWG9ihXNLTRLPhiSIWdEQPcDoGlfbT9OR53z/1GdOqRS+kQyvSOIWfwrDVGdO20bapMQlO6gCp3+DHeVyyoezboCL+1Wh5L0wYvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7E29D6078D; Fri, 03 Jul 2026 14:57:48 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 8/9] ipvs: reset full ip_vs_seq structs in ip_vs_conn_new
Date: Fri,  3 Jul 2026 14:57:08 +0200
Message-ID: <20260703125709.16493-9-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260703125709.16493-1-fw@strlen.de>
References: <20260703125709.16493-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13626-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:from_mime,strlen.de:email,strlen.de:mid,vger.kernel.org:from_smtp,tsinghua.edu.cn:email,in_seq.delta:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 182FF702A70

From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

Commit 9a05475cebdd ("ipvs: avoid kmem_cache_zalloc in
ip_vs_conn_new") changed ip_vs_conn_new() to allocate an ip_vs_conn
object with kmem_cache_alloc().  The function then initializes many
fields explicitly, but only resets in_seq.delta and out_seq.delta in the
two struct ip_vs_seq members.

That leaves init_seq and previous_delta uninitialized.  This is normally
harmless while the corresponding IP_VS_CONN_F_IN_SEQ or
IP_VS_CONN_F_OUT_SEQ flag is clear.  For connections learned from a sync
message, however, ip_vs_proc_conn() preserves those flags from
IP_VS_CONN_F_BACKUP_MASK and passes opt=NULL when the message omits
IPVS_OPT_SEQ_DATA.  In that case the new connection can be hashed with
SEQ flags set but with the rest of in_seq/out_seq still containing stale
slab data.

When a packet for such a connection is later handled by an IPVS
application helper, vs_fix_seq() and vs_fix_ack_seq() use
previous_delta and init_seq to rewrite TCP sequence numbers.  A malformed
sync message can therefore make forwarded packets carry stale slab bytes
in their TCP seq/ack numbers, and can also corrupt the forwarded TCP
flow.

Reset both struct ip_vs_seq members completely before publishing the
connection.  This matches the existing "reset struct ip_vs_seq" comment
and keeps the sequence-adjustment gates inactive unless valid sequence
data is installed later.

Fixes: 9a05475cebdd ("ipvs: avoid kmem_cache_zalloc in ip_vs_conn_new")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: Claude-Code:GLM-5.2
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/ipvs/ip_vs_conn.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index cb36641f8d1c..6ed2622363f0 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -1420,8 +1420,8 @@ ip_vs_conn_new(const struct ip_vs_conn_param *p, int dest_af,
 	cp->app = NULL;
 	cp->app_data = NULL;
 	/* reset struct ip_vs_seq */
-	cp->in_seq.delta = 0;
-	cp->out_seq.delta = 0;
+	memset(&cp->in_seq, 0, sizeof(cp->in_seq));
+	memset(&cp->out_seq, 0, sizeof(cp->out_seq));
 
 	if (unlikely(flags & IP_VS_CONN_F_NO_CPORT)) {
 		int af_id = ip_vs_af_index(cp->af);
-- 
2.54.0


