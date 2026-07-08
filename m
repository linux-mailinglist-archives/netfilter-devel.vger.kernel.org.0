Return-Path: <netfilter-devel+bounces-13762-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kj0MI2R7TmqTNgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13762-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 18:31:32 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF1F728BB5
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 18:31:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nwl.cc header.s=mail2022 header.b=iomohwEa;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13762-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13762-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 361F2308BBF4
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D236430787;
	Wed,  8 Jul 2026 16:19:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C4370ACF
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Jul 2026 16:19:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527599; cv=none; b=b+m733lOpluZelhYi7M32ejvt/WeDtfpGzZx1Qx2r0d6RpjYKOMREJLeiuWplEIgQIKF/OZxGlsPJzeTd7yhoX660UwRli8pF5S92uZaNmgMpou0ZCKla7LxTK0tysT63XQyOw1VjUlnYB0DH5ENUw33Dx9xun9uFtVL+cuWBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527599; c=relaxed/simple;
	bh=JGP6Ea25woPEvgvs5+S0Qki7BLdthTBP+0lfx743egQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YoJywVp/mQQq4CWKR+6kZb9zbYNCRdHLvOCdIZhhsKede5uJK8QuSP+QEW651ipd84/WdeJPX5w379N9dG/E+vpYqDxtTrXcijQSVQbBE77bl2AqP4Ajsu4icUn0z9PkmnJOTqPlZ9/fRDHrCk7MbpRDNJp3e2gELeni8x+Go8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=iomohwEa; arc=none smtp.client-ip=151.80.46.58
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=20WI0nl9t/B2N0VeQ38NRwdt91ljw+gPnnUpbvs806s=; b=iomohwEa1oWVyLIRa4RgDogs7d
	ZpVR+LIxJsVu+25YfUjl2pQZsz6MzG6kWHBqiCEN3N9WrdZEBUJtFdSkzytjI6Lrnz+/W/zE0YAWd
	IlomwnAgjhfWHO0wjNCTgVtT+8rEU/qBzVS83orEYp9HgJmE+352hrBxPpyesBKJk1RjrHyS7+8y9
	OBVAuwQzLVInPdrhUtI2/Xcf0jbOV33wtDNz7xMcUo+AxebnLeZO84ZB/jjOMrXzQLuw2yzd0WoxH
	GafU4IAQ6cDxCEkyuGW7S4WOXQUHRtxGPCwRjABaonB7dY69UlZsLh30V0qL3a0KZJvwLFf4T9NgL
	vrwcfDLQ==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1whUzz-000000001sA-3Orj;
	Wed, 08 Jul 2026 18:19:47 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [nf-next PATCH 0/4] Address Sashiko review of NAT hook dump code
Date: Wed,  8 Jul 2026 18:19:36 +0200
Message-ID: <20260708161940.1477671-1-phil@nwl.cc>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13762-lists,netfilter-devel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,nwl.cc:mid,nwl.cc:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CAF1F728BB5

Patch 1 is mere preparation to add the missing case handling to
nfnl_hook_dump_nat(), the remaining three patches address the actual
concerns.

Link: https://sashiko.dev/#/patchset/20260702105003.13550-2-fw%40strlen.de

Phil Sutter (4):
  netfilter: nfnetlink_hook: Pass cb object to nfnl_hook_dump_nat()
  netfilter: nfnetlink_hook: Deref hook entry using READ_ONCE()
  netfilter: nfnetlink_hook: Handle multipart NAT hook dumps
  netfilter: nfnetlink_hook: Fix for concurrent NAT hooks dump and
    change

 net/netfilter/nfnetlink_hook.c | 43 ++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 12 deletions(-)

-- 
2.54.0


