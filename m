Return-Path: <netfilter-devel+bounces-13597-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r/+BFJBPRmr/QQsAu9opvQ
	(envelope-from <netfilter-devel+bounces-13597-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 13:46:24 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A006F6F1D
	for <lists+netfilter-devel@lfdr.de>; Thu, 02 Jul 2026 13:46:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b=KpgdJCgr;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13597-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13597-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D26C53080765
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Jul 2026 11:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C9A17C203;
	Thu,  2 Jul 2026 11:29:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C99412281;
	Thu,  2 Jul 2026 11:29:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991773; cv=none; b=rfRF/EYSJp/AfCSvTJNk5xuUfoM2r55x7UTaPWc+C8lwhnTVZtnhEr8T3yw3tRSNRF5oI9/ZDKFHcQh6BHadb3Tgd9QiBBDCvRvFg92luXwMWxESrQkkAli1dq8lZJerTYuxJi+SLbrpNrabcXseMXKoVKQ2NTNCBIIgm2w3RYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991773; c=relaxed/simple;
	bh=Z2Wh8l1lRmL1Cxhy2lmQwUYEiYjg4j3h/E47SchTXHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=knIBECsIZv7I11ZCqYP4v78ocTOiI6ZmJ+RlUW8QZYCylGpAznZXT2+ELQrh3V2vFcSJ+xqzT8CsgiZ7pTGBkdHWl8+55v/49eayDKibGgEOrN6zF+yCVmSVoQlevztC3HMvsF0DLe+EbgsyKYhNtJze+t5cmJKyfEkhEnvpMW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=KpgdJCgr; arc=none smtp.client-ip=162.243.164.118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=C9TKY
	nA3qmzF02XBXR6y4i32x4cy+qMIfgYsWLQlNQY=; b=KpgdJCgrk+yOCcLJeyUVz
	aaHvrG5+So6Yt5YsV9SyUoBTgKkJHkGN97c8mEoBMhNE5f0CIFDJ9BlyCeiNx2cM
	MbSSb1bahjiN1EAJWQbeEhr5qnY41kLQcIJ1Hs/1Xek0jyDV5yoz7O3c6lkqWflh
	AznzHyiuqgMt+5B8wJcVKY=
Received: from localhost.localdomain (unknown [101.5.13.242])
	by web3 (Coremail) with SMTP id ygQGZQBntJFxS0ZqP4LfAg--.59204S2;
	Thu, 02 Jul 2026 19:28:49 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH net] ipvs: reset full ip_vs_seq structs in ip_vs_conn_new
Date: Thu,  2 Jul 2026 19:28:36 +0800
Message-ID: <20260702112837.81121-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQBntJFxS0ZqP4LfAg--.59204S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXry3AF1rKr15Cw4kWrWkCrg_yoW5Xr1DpF
	W2k3s29rZ7Xry5tF1kAFy7uFy5Crs5JrnF9rnIka43Z3WDWFyvyanYkw1akFyDArWvyayU
	tFWFg34DCa1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Av
	z4vE14v_Gw4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1rb15UUUUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgMQAWpGILZRlAAAsv
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
	TAGGED_FROM(0.00)[bounces-13597-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:zhaoyz24@mails.tsinghua.edu.cn,m:horms@verge.net.au,m:ja@ssi.bg,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,verge.net.au,ssi.bg,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mails.tsinghua.edu.cn:dkim,mails.tsinghua.edu.cn:mid,mails.tsinghua.edu.cn:from_mime,vger.kernel.org:from_smtp,in_seq.delta:url,tsinghua.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D6A006F6F1D

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


