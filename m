Return-Path: <netfilter-devel+bounces-11633-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMllFNAv0WlaGQcAu9opvQ
	(envelope-from <netfilter-devel+bounces-11633-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 04 Apr 2026 17:35:44 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45739BA23
	for <lists+netfilter-devel@lfdr.de>; Sat, 04 Apr 2026 17:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EC373004436
	for <lists+netfilter-devel@lfdr.de>; Sat,  4 Apr 2026 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC492ED15D;
	Sat,  4 Apr 2026 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b="Kd8lWSuW"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8436C2BE7AC;
	Sat,  4 Apr 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.238.174.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316922; cv=none; b=BXYbvBq7RGJPTAjeU3mlecpB9zdBjHXw0RR6jPFjVqnSnBj+CuTGgR2S73y7ezx4mBjE6GBVAqyDQtrSWqFh8hlZlEpn5MTgKio4nr/HMHnKTQVblFvxBgvJ0d/uF01/R99XYUc2J0jTHyC5S+3bI2OtImy+5rG0cuG+/0TO2Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316922; c=relaxed/simple;
	bh=iQlocxQMyMWHqFgoHwEOzI6MuxUgC3wX9JEWywdTnCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9YhfFlXQbLf/JmBKk3iG9hLQ663qiev6yh8JiXLEp7dEH0/MqxQKH6cP/+0EOBr7yOVUOEwKQs42yQ4hd7CYJztYFa/z2xWz5QXYufS18QDGi54Q4wAnOnfdzmEc+TNlRXw0Vao9S3EXyeJ5HXLqwgmxo4iv2ES23Jo1kJqRgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=Kd8lWSuW; arc=none smtp.client-ip=193.238.174.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ssi.bg
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 8982821C5B;
	Sat, 04 Apr 2026 18:35:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-transfer-encoding:date:from:from:message-id
	:mime-version:reply-to:subject:subject:to:to; s=ssi; bh=DpCpgUQF
	g/lpUnIpTL+BVB0jvTO+SegIe50A7nQF0t0=; b=Kd8lWSuW1FrGgFymepRR3pyj
	furZjOcuPjPoAErwd+Z11GEisBq0LNFK9yueWpcTxwW+ba6efRCNE5qs4XuPKJaf
	msyAdS4cEx+RZpgm9BNkqTjjzeXTjm/wdxxHcUZDjc4rM5I3mbCwdAHrk3/UgQ52
	YTeXzuq0Zp7yAyb8ROtVMXtvxWKcMlBDlMAnNgPEuwonsHUbtUKTRc7/7tpPrJBw
	SYtxgKAfn5GIyCYPqYqImKsM6B/Jkz4CNsVPA4aLcP9iBmN7UgKaCmepxlGfBlEy
	5cxOJQddyUejsTqerbh582R0Qm0xcNa0V3eyLb8c3LKQdcbO3UNpArJ04w3dajC3
	538wg0s+XqlJkFnLC/djt8jJ93cW21p5Vk1PsXOb6/sEnrSca0hA9w2Hp+J2Vu90
	wbTKIcvEOVmr4tcFIUWa/xIoM8kaIGxE9y45uKJFHhXmp4by5W7b0JXuGHw0vNsG
	cYeue34Qs/9wZYmnCw+RPYkjxEQUuFWZnbnFWlx9db8762+XXNhnuLDaaIoSAMFI
	0qfKrhJTNFZh1iigYxYOqCngq7EGtJnVe/KbRCKtyM3372LK2EjOkkg22s8VFEu3
	a6LRfeIaHGWAPU3OpGifRtIvOmBGUsr+5wvcE6FJCwVNQBiK3vveV8+9J6xLSWDN
	3Gp+096lz9e+qSFreNA=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Sat, 04 Apr 2026 18:35:15 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 911716084A;
	Sat,  4 Apr 2026 18:35:14 +0300 (EEST)
Received: from ja.home.ssi.bg (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.1/8.18.1) with ESMTP id 634FZDMh030099;
	Sat, 4 Apr 2026 18:35:13 +0300
Received: (from root@localhost)
	by ja.home.ssi.bg (8.18.1/8.18.1/Submit) id 634FZB2A030098;
	Sat, 4 Apr 2026 18:35:11 +0300
From: Julian Anastasov <ja@ssi.bg>
To: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
        lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Dust Li <dust.li@linux.alibaba.com>,
        Jiejian Wu <jiejian@linux.alibaba.com>
Subject: [PATCHv2 nf-next 0/3] IPVS changes, part 4 of 4 - extras
Date: Sat,  4 Apr 2026 18:34:36 +0300
Message-ID: <20260404153439.30077-1-ja@ssi.bg>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ssi.bg:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11633-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5F45739BA23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

        Hello,

        This patchset is part 4 of changes that accumulated in
recent time. It is for nf-next and should be applied when the
patches from part 1-3 are already applied. It contains extras
for the per-net tables.

        All patches here come from the work
"ipvs: per-net tables and optimizations" last posted
on 19 Oct 2025 as v6, with the following changes:

Patch 1 comes from v6/patch 10 with added get_conn_tab_size() helper

Patch 2 comes from v6/patch 13 with added text for the commit

Patch 3 comes from v6/patch 14 with updated docs

	As result, the following patches will:

* As the connection table is not with fixed size, show its current
  size to user space

* Add /proc/net/ip_vs_status to show current state of IPVS, per-net

cat /proc/net/ip_vs_status
Conns:	9401
Conn buckets:	524288 (19 bits, lfactor -5)
Conn buckets empty:	505633 (96%)
Conn buckets len-1:	18322 (98%)
Conn buckets len-2:	329 (1%)
Conn buckets len-3:	3 (0%)
Conn buckets len-4:	1 (0%)
Services:	12
Service buckets:	128 (7 bits, lfactor -3)
Service buckets empty:	116 (90%)
Service buckets len-1:	12 (100%)
Stats thread slots:	1 (max 16)
Stats chain max len:	16
Stats thread ests:	38400

It shows the table size, the load factor (2^n), how many are the empty
buckets, with percents from the all buckets, the number of buckets
with length 1..7 where len-7 catches all len>=7 (zero values are
not shown). The len-N percents ignore the empty buckets, so they
are relative among all len-N buckets. It shows that smaller lfactor
is needed to achieve len-1 buckets to be ~98%. Only real tests can
show if relying on len-1 buckets is a better option because the
hash table becomes too large with multiple connections. And as
every table uses random key, the services may not avoid collision
in all cases.

* add conn_lfactor and svc_lfactor sysctl vars, so that one can tune
  the connection/service hash table sizing

v2:
* patch 1: move RCU read lock into get_conn_tab_size() as
  suggested by Pablo and Florian
* patch 3: prefer rcu_access_pointer() over rcu_dereference_protected()
  as suggested by Florian

Julian Anastasov (3):
  ipvs: show the current conn_tab size to users
  ipvs: add ip_vs_status info
  ipvs: add conn_lfactor and svc_lfactor sysctl vars

 Documentation/networking/ipvs-sysctl.rst |  35 ++++
 net/netfilter/ipvs/ip_vs_ctl.c           | 247 ++++++++++++++++++++++-
 2 files changed, 278 insertions(+), 4 deletions(-)

-- 
2.53.0



