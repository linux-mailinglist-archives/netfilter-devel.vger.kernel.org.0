Return-Path: <netfilter-devel+bounces-13887-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TSH1CqK1VGpnpwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13887-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 11:53:38 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D8749805
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 11:53:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b=KY6ELS50;
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13887-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13887-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 436BD3050417
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C75A3E5578;
	Mon, 13 Jul 2026 09:49:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5529C3DD500;
	Mon, 13 Jul 2026 09:49:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783936152; cv=none; b=sWK6u0HAHo0hgy17UUydmzuXm9mS6wAp0ADyXGNf2K39v6aZf6lmbtDleyRyXzsF+T9YX9lnkHQPT9vQbhGSc9gwHHMeeioJKz6GhQi/NJ/hktWalZFxd05IEtVnzS0TakRE3gMXsakx+Kn36eJ3luZwpMzNW2Sqi2fOWFzaR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783936152; c=relaxed/simple;
	bh=jtphKuvg7p9PEOep/6FkHrLO6n3TFt4uD55iIYPmFnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dW/YKFGMhwoRUBUL+fkkgZWpFJDcUH/irpFqEuzH7O41eOhkw76Y2OG0seDAhyIUzKgBR+ZwconLixwx1te6BwY4JOeiYFL6VGCWYR5oUF2gjZaIQixCkcdflZ4s89bxREE0GEnaFRsTikyZxnej5YgTXQ73CxoJYPFewqHqWIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=KY6ELS50; arc=none smtp.client-ip=13.75.44.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=pf85c
	2T2s+M6exqfybXObAef4n1XG3jCnvRQx6BAosk=; b=KY6ELS50/wuPCl2pviWfZ
	XP0tfCx5Fii9MZZDJNu94rPVKS3upWmcttERA56PiaTMZcn3IzQe4/wCQMTIbE7p
	pdbhsDDhbKqBBmV7JKBNOIyXt/lmDUW2Jc6fVEQ+DqE7TRx14DMnB67WDCzyg50O
	tiIc5gkctOjuE/WLvsk3lc=
Received: from localhost.localdomain (unknown [121.229.84.192])
	by web5 (Coremail) with SMTP id zAQGZQCXT79htFRqkRUmAw--.5011S2;
	Mon, 13 Jul 2026 17:48:18 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@verge.net.au>,
	Julian Anastasov <ja@ssi.bg>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>
Subject: [PATCH nf v3 0/2] ipvs: fix destination overload state updates
Date: Mon, 13 Jul 2026 17:48:00 +0800
Message-ID: <cover.1783931964.git.zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zAQGZQCXT79htFRqkRUmAw--.5011S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1Utw4fWFWDWr45Gr4fuFg_yoW5Jryrpa
	4Sya4ft34UJr9xKanxGF1xCryrCr1kury7ur9xJ34rJ34jqr15Kw4SkrWjk3W8Zr9Igry5
	tF1Ygw42kFn8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Av
	z4vE14v_GFWl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1U73PUUUUU==
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAgAHAWpUphggPAAAsY
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13887-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:horms@verge.net.au,m:ja@ssi.bg,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:zhaoyz24@mails.tsinghua.edu.cn,m:netdev@vger.kernel.org,m:lvs-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:stable@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,vger.kernel.org,netfilter.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mails.tsinghua.edu.cn:from_mime,mails.tsinghua.edu.cn:dkim,mails.tsinghua.edu.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B51D8749805

IPVS updates a destination's overload status from connection accounting
and destination configuration paths, while schedulers read it from packet
processing paths.

Patch 1, authored by Julian, updates the overload state whenever a
destination's connection thresholds change. It also limits the upper
threshold to the range that can be compared safely with the connection
counter.

Patch 2 moves overload state out of dest->flags, which it previously
shared with the independent availability state. It uses a separate bitset
and bitops so updates to the two states cannot clobber each other. KCSAN
reports the original race between __ip_vs_update_dest() and
ip_vs_sh_schedule(), as well as between ip_vs_bind_dest() and the SH
scheduler.

The series keeps reader-side synchronization lightweight. test_bit() does
not provide a fresh cross-field snapshot, so schedulers may still observe
stale destination state as they could before this change.

Changes in v3:
- Add Julian's fix to properly refresh OVERLOAD on destination edit and 
reject upper thresholds above INT_MAX before comparing them with the signed
connection counter as patch 1/2.
- Keep AVAILABLE in dest->flags and move OVERLOAD to a separate bitset.
- Link to v2: https://lore.kernel.org/netfilter-devel/20260708060454.20534-1-zhaoyz24@mails.tsinghua.edu.cn/

Julian Anastasov (1):
  ipvs: properly update the overload flag on dest edit

Yizhou Zhao (1):
  ipvs: use bitops for destination overload state

 include/net/ip_vs.h              | 10 ++++++++
 include/uapi/linux/ip_vs.h       |  6 -----
 net/netfilter/ipvs/ip_vs_conn.c  | 44 ++++++++++++++++++++++----------
 net/netfilter/ipvs/ip_vs_ctl.c   | 26 +++++++++++++------
 net/netfilter/ipvs/ip_vs_dh.c    |  4 +--
 net/netfilter/ipvs/ip_vs_fo.c    |  2 +-
 net/netfilter/ipvs/ip_vs_lblc.c  |  4 +--
 net/netfilter/ipvs/ip_vs_lblcr.c |  8 +++---
 net/netfilter/ipvs/ip_vs_lc.c    |  2 +-
 net/netfilter/ipvs/ip_vs_mh.c    |  2 +-
 net/netfilter/ipvs/ip_vs_nq.c    |  2 +-
 net/netfilter/ipvs/ip_vs_ovf.c   |  2 +-
 net/netfilter/ipvs/ip_vs_rr.c    |  2 +-
 net/netfilter/ipvs/ip_vs_sed.c   |  4 +--
 net/netfilter/ipvs/ip_vs_sh.c    |  2 +-
 net/netfilter/ipvs/ip_vs_twos.c  |  4 +--
 net/netfilter/ipvs/ip_vs_wlc.c   |  4 +--
 net/netfilter/ipvs/ip_vs_wrr.c   |  2 +-
 18 files changed, 81 insertions(+), 49 deletions(-)


base-commit: 2c7c88a412aa6d09cd04b414211b4ef8553b5309
-- 
2.34.1


