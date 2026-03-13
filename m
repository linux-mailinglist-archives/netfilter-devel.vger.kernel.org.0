Return-Path: <netfilter-devel+bounces-11184-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNzMK8QotGkQiQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11184-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 16:09:56 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A8B2859AF
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 16:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56C273190C23
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Mar 2026 15:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501F3AC0E4;
	Fri, 13 Mar 2026 15:06:47 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B53A5E68;
	Fri, 13 Mar 2026 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414406; cv=none; b=IcVzO6xkOV8lKygUAsxloYfJ48aPRBvnaEOPWTblMVRLVJfiYWhOEZeVG4spE8I39q1yV9j4FxfV9T6rECjrRK+YRk0t5Bq2eMB1BnuMXjUB18j6xnqCSVvtiZXDT7POLYH5BaA9kTjaUDmB23Lb2vLymCkdZ1NwA1FAbBHHmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414406; c=relaxed/simple;
	bh=W4fdgwJqsut54VjIeMFTI4PrOmcai5Pkkt+QwedpaV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQoeheOSAlRgQR0meKhqJmqIzIdiYGuPBLNHqMfS6Qn7LQBijtE/ZsWuJi4m/oqJD6nFCGAbQZ9lUJBEl5gRKhsooETRX1rCAKBwD8gTfDmdDXDwHxfRaHfsXuiQ+A+37N2VizVzjaHUGMsbzFE1BMRPJRfobBmsjReG2CZ3Wwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 332D960709; Fri, 13 Mar 2026 16:06:43 +0100 (CET)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 05/11] netfilter: nf_flow_table_ip: reset mac header before vlan push
Date: Fri, 13 Mar 2026 16:06:08 +0100
Message-ID: <20260313150614.21177-6-fw@strlen.de>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313150614.21177-1-fw@strlen.de>
References: <20260313150614.21177-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11184-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:email,strlen.de:email,strlen.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76A8B2859AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Eric Woudstra <ericwouds@gmail.com>

With double vlan tagged packets in the fastpath, getting the error:

skb_vlan_push got skb with skb->data not at mac header (offset 18)

Call skb_reset_mac_header() before calling skb_vlan_push().

Fixes: c653d5a78f34 ("netfilter: flowtable: inline vlan encapsulation in xmit path")
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_flow_table_ip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 3fdb10d9bf7f..fd56d663cb5b 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -738,6 +738,7 @@ static int nf_flow_encap_push(struct sk_buff *skb,
 		switch (tuple->encap[i].proto) {
 		case htons(ETH_P_8021Q):
 		case htons(ETH_P_8021AD):
+			skb_reset_mac_header(skb);
 			if (skb_vlan_push(skb, tuple->encap[i].proto,
 					  tuple->encap[i].id) < 0)
 				return -1;
-- 
2.52.0


