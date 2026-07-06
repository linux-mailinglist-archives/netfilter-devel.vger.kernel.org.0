Return-Path: <netfilter-devel+bounces-13661-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RNKHNiSGS2oLTAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13661-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 12:40:36 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B972770F580
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 12:40:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mails.tsinghua.edu.cn header.s=dkim header.b=l+Q1gYUw;
	dmarc=pass (policy=quarantine) header.from=mails.tsinghua.edu.cn;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13661-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13661-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D705E30609F5
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jul 2026 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6CA2046BA;
	Mon,  6 Jul 2026 10:17:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F59827EFE9;
	Mon,  6 Jul 2026 10:17:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333032; cv=none; b=CLiLkZP44CBZSkKxd9/a293STFk1R6zqT5dG5F5qV32lL1VkLA52Hg+M9tQRBvMmRjWuL5MYrp/OWDu2MN5eZW6u775Rn8qtt6ksDfycalHitX/YwUG0PW429M47/xTWr1d3pGv4f1q1MG0zzzkqg46MuPGmxU7NrqQNdt3eVoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333032; c=relaxed/simple;
	bh=VCwZrRwTQmEgvu4RfMg740sUgjTmkta7dux4gUN6ax8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FEx8Wr6p/iavK1dabVN165t0d8ZQMYjQpWvy3B0skW6/PLXAvXrEgJia7AtSNYx6zFg7fCXb7saajNWpL1jchIUc41GWc38SIG9F5De9YjZl6PmfpFip7z/fd1BE7IfvtMjXm1ZmsoqM27Yd/LlvzX9lEGQ0KGCqfmlREjXS0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=l+Q1gYUw; arc=none smtp.client-ip=209.97.182.222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=CGMXO
	jZBJ7c5b38ucaL2dUKfGAjGD3ZKFalqvM5Qhx8=; b=l+Q1gYUw0PCMQdJxmKhpb
	B5PFBSd0zMnfXpyCHPjiSODFQOF0PMPOq5qMd5x9Gv7CU28RsYXdlO34c6N/RZoM
	SPeYmPVU5xEyFB9qdInJFX9LZPsNHz0AK91U4nQKr4oZdoMi9Suy87UblvyHR3Z3
	ZYAVmhBiveLKc6HAYYHBX4=
Received: from localhost.localdomain (unknown [101.5.13.242])
	by web4 (Coremail) with SMTP id ywQGZQD3CJ6GgEtq_fjIAg--.37800S2;
	Mon, 06 Jul 2026 18:16:39 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: netdev@vger.kernel.org
Cc: coreteam@netfilter.org,
	davem@davemloft.net,
	edumazet@google.com,
	fengxw06@126.com,
	fw@strlen.de,
	horms@verge.net.au,
	ja@ssi.bg,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	pabeni@redhat.com,
	pablo@netfilter.org,
	phil@nwl.cc,
	qli01@tsinghua.edu.cn,
	stable@vger.kernel.org,
	wangao@seu.edu.cn,
	xuke@tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Subject: [PATCH nf v2 0/3] ipvs: use parsed transport offsets in state handlers
Date: Mon,  6 Jul 2026 18:16:21 +0800
Message-ID: <20260706101624.69471-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ywQGZQD3CJ6GgEtq_fjIAg--.37800S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7XFyUur43ur1rZw1fZwb_yoW8Jw13pa
	sa93yagrZrKFyIvrsrArs7Ga4rCan8Gay7XayrK3s5tFy0vr45tF90k3yrKayUurZ7t347
	Ar1Yvw43Zr4kJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xS
	Y4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUEkskUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQEAAWpLXR9AnAAAs+
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mails.tsinghua.edu.cn,quarantine];
	R_DKIM_ALLOW(-0.20)[mails.tsinghua.edu.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13661-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:coreteam@netfilter.org,m:davem@davemloft.net,m:edumazet@google.com,m:fengxw06@126.com,m:fw@strlen.de,m:horms@verge.net.au,m:ja@ssi.bg,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:lvs-devel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:pablo@netfilter.org,m:phil@nwl.cc,m:qli01@tsinghua.edu.cn,m:stable@vger.kernel.org,m:wangao@seu.edu.cn,m:xuke@tsinghua.edu.cn,m:yangyx22@mails.tsinghua.edu.cn,m:zhaoyz24@mails.tsinghua.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[netfilter.org,davemloft.net,google.com,126.com,strlen.de,verge.net.au,ssi.bg,kernel.org,vger.kernel.org,redhat.com,nwl.cc,tsinghua.edu.cn,seu.edu.cn,mails.tsinghua.edu.cn];
	DKIM_TRACE(0.00)[mails.tsinghua.edu.cn:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyz24@mails.tsinghua.edu.cn,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mails.tsinghua.edu.cn:from_mime,mails.tsinghua.edu.cn:dkim,mails.tsinghua.edu.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B972770F580

IPVS parses packets into struct ip_vs_iphdr before scheduling and state
handling.  For IPv6, iph.len contains the real transport-header offset
after ipv6_find_hdr() has skipped any extension headers.

TCP and SCTP state handlers still recompute their own transport offsets.
They use sizeof(struct ipv6hdr) for IPv6, so packets with extension
headers make the state machines read the wrong bytes.

Pass the parsed transport offset through the common IPVS state handling
callback, then use it in the TCP and SCTP state lookups.

Changes in v2:
- Pass the parsed transport offset through ip_vs_set_state() and the
  protocol callbacks.
- Fix TCP state handling as well as SCTP.
- Avoid reparsing the skb in SCTP state handling.
- Split the common plumbing, TCP fix and SCTP fix into a 3-patch series.

Yizhou Zhao (3):
  ipvs: pass parsed transport offset to state handlers
  ipvs: use parsed transport offset in TCP state lookup
  ipvs: use parsed transport offset in SCTP state lookup

 include/net/ip_vs.h                   |  3 ++-
 net/netfilter/ipvs/ip_vs_core.c       | 10 +++++-----
 net/netfilter/ipvs/ip_vs_proto_sctp.c | 18 +++++++-----------
 net/netfilter/ipvs/ip_vs_proto_tcp.c  | 11 +++--------
 net/netfilter/ipvs/ip_vs_proto_udp.c  |  3 ++-
 5 files changed, 19 insertions(+), 26 deletions(-)

-- 
2.34.1


