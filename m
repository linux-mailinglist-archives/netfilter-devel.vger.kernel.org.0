Return-Path: <netfilter-devel+bounces-12350-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCd7CUSh82ly5QEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12350-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 20:36:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C38584A70CB
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 20:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A3873029AC9
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Apr 2026 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF2547CC87;
	Thu, 30 Apr 2026 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b="BH4EeMzB"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-12.smtp.spacemail.com (out-12.smtp.spacemail.com [198.54.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E7C47CC70;
	Thu, 30 Apr 2026 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574102; cv=none; b=T8z7XtMRoCrUDX3qzVBBw/p5Qwo1vHdehuZLo/x+R+UEo7qGkYZVcrhZRtCaYU7dwyksYnDVjhqNilBYlKCW8SblcWgp17SWK1OMJXLg51qLlUnMZ73yo2Z86+cLSGqcAsjjeWBrgQGbhxPeH6+X8839fFCZQOnfYquvsGUx0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574102; c=relaxed/simple;
	bh=swLMH6pLURjgirL9xBadXFGC5E5pIa70YvFJGr2fQdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJNr5icc4Hxd/899Zk2yOL9+kdWeLlcKwhKVaIglIZdkmn43ttNgxyogTxJ4E2Ve+df7I95DInrk/jf81zWEBUI5gXLungfc35c0tx8RMg+FwzkDBctN6t9qvGBTk4paKLeRT3zOfWAYkHfwSilMsKnOrEmiaSYuRCYqHi4spQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai; spf=pass smtp.mailfrom=rexion.ai; dkim=fail (0-bit key) header.d=rexion.ai header.i=@rexion.ai header.b=BH4EeMzB reason="key not found in DNS"; arc=none smtp.client-ip=198.54.127.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rexion.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rexion.ai
Received: from Kyren (unknown [49.207.224.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4g62fl0M0Yz8sd3;
	Thu, 30 Apr 2026 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rexion.ai;
	s=spacemail; t=1777573555;
	bh=Ug20lDJ3azlJTOlx8qs0QKzdbTa2xWSAosLLSGBJEeE=;
	h=From:To:Cc:Subject:Date:From;
	b=BH4EeMzB/5ZNqzC1qSp7bN29dC9UjlzTzUktuGZ5YX+SPqZb+05KYx7B9+7ZXG8t/
	 fwIDjrrBr7gbOoK86eQoWMPgulpuTMEWNP5DPtupauGaVspIfZew6GyICcu6GjEZDA
	 33PPBQDDf5haylTQ5lufQLraXvIEuY/Z/097LE0qj1dpRyodPNrJWZEuxmKjceLJVB
	 Y30g3BBoAXGIRVQetzv3KHrIGcN65GfZfPdi8FAft7ecMKsMEu0DRqyaQrOHnGxqGd
	 M7apYFFxJWS2oNHIGZM9+7TLB12Gw0TEJBhsjUBfxL5IRRktNud4pA+sWEXukeBlH9
	 o73byxgxaNo7Q==
From: HACKE-RC <rc@rexion.ai>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HACKE-RC <rc@rexion.ai>
Subject: [PATCH net-next v2 0/3] netfilter: conntrack: add shared port parser and use it in IRC and Amanda helpers
Date: Thu, 30 Apr 2026 23:55:40 +0530
Message-ID: <20260430182543.3931718-1-rc@rexion.ai>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: rc@rexion.ai
X-Rspamd-Queue-Id: C38584A70CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-12350-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[rexion.ai];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_PERMFAIL(0.00)[rexion.ai:s=spacemail];
	DKIM_TRACE(0.00)[rexion.ai:~];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_SPAM(0.00)[0.078];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rc@rexion.ai,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rexion.ai:mid]

Both nf_conntrack_irc and nf_conntrack_amanda parse port numbers
from application-layer protocol data using simple_strtoul(), which
relies on nul-terminated strings and returns unsigned long without
range checking. Port values above 65535 silently truncate when
stored in u16.

This v2 adds a shared nf_ct_helper_parse_port() function to the
conntrack helper core, modeled after the approach in 8cf6809cddcb
("netfilter: nf_conntrack_sip: don't use simple_strtoul"), then
converts both helpers to use it.

Changes since v1:
  - Added shared nf_ct_helper_parse_port() in the helper core
    instead of open-coding range checks in each helper (Pablo)
  - Parser does not rely on nul-terminated strings
  - Dropped simple_strtoul usage entirely for port parsing

HACKE-RC (3):
  netfilter: conntrack: add shared port parser for helpers
  netfilter: nf_conntrack_irc: use nf_ct_helper_parse_port()
  netfilter: nf_conntrack_amanda: use nf_ct_helper_parse_port()

 include/net/netfilter/nf_conntrack_helper.h |  3 +++
 net/netfilter/nf_conntrack_amanda.c         | 11 ++++----
 net/netfilter/nf_conntrack_helper.c         | 28 +++++++++++++++++++++
 net/netfilter/nf_conntrack_irc.c            |  4 ++-
 4 files changed, 40 insertions(+), 6 deletions(-)

-- 
2.54.0


