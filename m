Return-Path: <netfilter-devel+bounces-13228-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N+4WC9nPK2r/FQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-13228-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 11:22:33 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F36678366
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 11:22:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13228-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13228-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FB0C3039C64
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jun 2026 09:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6D3793AD;
	Fri, 12 Jun 2026 09:22:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792836A009;
	Fri, 12 Jun 2026 09:22:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256146; cv=none; b=N7xCPn4zigzazt5OHFAkY/OYccx99ATJsm62CU/GSs6j9ztJQVwPR2izeO9YRdWQZa0Px5kCaAx1HEjxOQ0RaPRAtS0IONURaYxl392SFH6TubncsHSLGCzGRdQbhGEkrn7V6PB/Gbavc7q6qDuybwL3Xw5HAiiuJs/FiR4CGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256146; c=relaxed/simple;
	bh=dq4ZY9BknbSjPjIvik5Y/re2KvfeV9+X9cAKUvXwhoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kyAKFzYrG+4AWCKJ7MyH1Wx2+6mtdRJigOXFsyv+rLobO2tY/nmFoi7PTPkstu2ZoA4GjYhj5fGI2LLSlACPPR911Qfmu7wbLNKKnPO0/guLCuIiY2AJDEGrKwOcXrpB8rKQsgI/UkGhziDqyhpxII9e+TXnpTtxJbJvCls9rlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1E4E7607E1; Fri, 12 Jun 2026 11:22:21 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH v2 net-next 0/2] netdevsim: add fake FT/CLS_FLOWER offload
Date: Fri, 12 Jun 2026 11:22:07 +0200
Message-ID: <20260612092209.11966-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13228-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5F36678366

v2: fix up error reporting via extack
    shellcheck cleanups
    sort config toggles

1) Enable nf_tables offload control plane testing in netdevsim. Tag
   existing offload fn to allow error injection for testing rollback and abort
   logic.

2) Add nft_offload selftest to exercise the control plane and error
   unwind via fault injection.

Florian Westphal (2):
  netdevsim: tc: allow to test nf_tables offload control plane code
  selftests: netfilter: add phony nft_offload test

 drivers/net/netdevsim/bpf.c                   |   6 -
 drivers/net/netdevsim/tc.c                    |  20 ++-
 .../testing/selftests/net/netfilter/Makefile  |   1 +
 tools/testing/selftests/net/netfilter/config  |   6 +
 .../selftests/net/netfilter/nft_offload.sh    | 132 ++++++++++++++++++
 5 files changed, 158 insertions(+), 7 deletions(-)
 create mode 100755 tools/testing/selftests/net/netfilter/nft_offload.sh

-- 
2.53.0


