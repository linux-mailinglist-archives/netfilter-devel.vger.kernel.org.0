Return-Path: <netfilter-devel+bounces-10567-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CzXHZgWgWlsEAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10567-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 02 Feb 2026 22:26:48 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B5DD1A7B
	for <lists+netfilter-devel@lfdr.de>; Mon, 02 Feb 2026 22:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C3CA63000BB7
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Feb 2026 21:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA68B3128BE;
	Mon,  2 Feb 2026 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="QrSo2tOS"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2872C0281
	for <netfilter-devel@vger.kernel.org>; Mon,  2 Feb 2026 21:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770067602; cv=none; b=AhDf+DveMlBK4eO+rGAZPh7U1e2FBnq/cOTQUUicWLLTIgJWiFeB3CEhZF0Ibv09XrhcFTBjnQuepaZDR7zhVDWgWUVNVUezQYNlQgQuSRitBja+dtsHLiKCwsrj1hsSm/2u0lyAdWmckXDNb7htQtPENf4m5A+s9hudSLS53ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770067602; c=relaxed/simple;
	bh=dXLyjbsJCL1wLpdTv/wHh/U8HI28mli3I/uMV4uG/bo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KzkO3/S28k2uNKcx2BfisJMrq14+72CQa/q7kxL9KS6dusd3OZTsyPferq3ffP9zzguIk6Q1QFX2QtiAsTjZo5BEfidsU/AALvAFle3wFihLLb0c4jdWLF55dbUKjlxgk0S/V5jxDNBqxSD5tJ+3TZgWiLQXSDUqEzU4r7Bt9eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=QrSo2tOS; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 6248D605BC
	for <netfilter-devel@vger.kernel.org>; Mon,  2 Feb 2026 22:26:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1770067591;
	bh=eGe+foIdD1xoLlusRY9MO5hPXkImoLr9NwMltL/fNbg=;
	h=From:To:Subject:Date:From;
	b=QrSo2tOSeXnITMRWA9qEY005QtkghQvUohhOdCrUrTkq/NVu0rk2LY2kK9LFuzSEq
	 cmduGct53dNBQvGk0XSY14eXUEiUrvrHNwueyi2tTtJBwOoRnP+GmH2DAkoHJ5SkI9
	 MfwbdHpEfxhbZhp1HYFk7AmHWRw5HlQ0S+B2dW66Vnlkvd8yVCUcGwceucwIdv55pn
	 npR+/azyh1+4zZQSFizSK+4fM4ezNwvHjuKwdUPULuaQ1BEO0XRFbMlMo+Ex8cxolb
	 rAah1c4S4xXm61tqtgyJj25CUthFG9qrWdf2L/hX6h0fZk69dUI6ylzwcMSYSoFgaW
	 MQd89+S9EDxbw==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v2 0/4] nf_tables: complete interval overlap detection
Date: Mon,  2 Feb 2026 22:26:23 +0100
Message-ID: <20260202212627.946625-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-10567-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:mid,netfilter.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93B5DD1A7B
X-Rspamd-Action: no action

Hi,

This is v2 of the series to complete interval overlap detection.

This iteration fixes an issue reported by Florian Westphal, which comes
from the following scenario:

 [1] nft add element inet filter saddr6limit { fee1::dead : "tarpit-pps" }
 [2] nft create element inet filter saddr6limit { fee1::dead : "tarpit-pps" }
 [3] nft add element inet filter saddr6limit { c01a::/64 : "tarpit-bps" } => EEXIST

[2] fails because start element hits EEXIST due to the NLM_F_CREATE flag.
Then [3] finds the the start_rbe_cookie from the previous command, this bogusly
reports EEXIST because the annotate start element is considered an open interval.
This is fixed by annotating the batch timestamp, this allows to reset the
start_rbe_cookie in every new batch.

Pablo Neira Ayuso (4):
  netfilter: nft_set_rbtree: fix bogus EEXIST with NLM_F_CREATE with null interval
  netfilter: nft_set_rbtree: check for partial overlaps in anonymous sets
  netfilter: nft_set_rbtree: validate element belonging to interval
  netfilter: nft_set_rbtree: validate open interval overlap

 include/net/netfilter/nf_tables.h |   4 +
 net/netfilter/nf_tables_api.c     |  26 +++-
 net/netfilter/nft_set_rbtree.c    | 239 ++++++++++++++++++++++++++++--
 3 files changed, 256 insertions(+), 13 deletions(-)

-- 
2.47.3


