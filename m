Return-Path: <netfilter-devel+bounces-13788-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rHu0MMCIT2ryiwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13788-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 13:40:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E7E7307C2
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 13:40:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=jeWqdXWL;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13788-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13788-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2BBF3001A4B
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 11:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5B3FFF91;
	Thu,  9 Jul 2026 11:40:41 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C13859D7
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 11:40:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783597241; cv=none; b=k4mtZIA3amOQ3lwI/Sazm5NxTerQfuSKu84qeFTKzdHG+XsqYnlBQ7oJzo0G7Ng4tduue7SzZpcnUYXZHlM0396DRK6QNK4kX3fwMLDrlp6sDVmcao44O70zM/SCDi3V9IHYRLDtVuUpbqJkRhyK3LIXHsdav68OHV+bizdQPhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783597241; c=relaxed/simple;
	bh=jhOXFRDhRDE9UWehd+Ep5Rn4mlTjoYo/MLMzmXqFtU4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=a9CButd/B+WSMwf1yVulo9bRgBlM+sh2DLPV2zOh4AxJtlYaxawyqhVcaXMx+zaL5lsl9juX0a0nStoJKZEW1jI1hM+MIBHM25ngkweGoIKFBCqNrJu4V9GLEYvAUd1KK1wqiVNIliUxPLbdxgxNiQ9jJYwGtf0f4hh3BBALsYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=jeWqdXWL; arc=none smtp.client-ip=217.70.190.124
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 73F6D6057E
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 13:40:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783597229;
	bh=BwRsCYCT+NIINNC1MMc6JKO8sohapTYaZBwEF761hFY=;
	h=From:To:Subject:Date:From;
	b=jeWqdXWLp5Z9fF1n5xisEyXqA/VEbeQTCOmzippKRawghEkTxq7vuwFkyAZWJsfgs
	 FPV1uBJY+J7tdDqX+yv/+GCjTFxBRL6R2R/+Qq5pu1Zz2WlJzLy0juuqbx8wHq0v44
	 I1nK+ehHlLaqb3CMx0Bn3KebDuWLbSuPa4QEiARpAoWsZ1qJn5NcBEpXbgN2ccaCyd
	 Zl2gwRVKEzyYFDi765zG22SrRUaU4SwDhORBuR6/kUM3apZFrWzS8uj91CPsUHjSk5
	 w8j0SqYgOiMY3WcyX7UcfGdshNpQK/zHn16OENFGlYPjACWshHWvdMFUd8ETvWo9xT
	 tmAUsq1ktReSA==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: flowtable: use correct direction to set up tunnel route
Date: Thu,  9 Jul 2026 13:40:25 +0200
Message-ID: <20260709114025.1294044-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13788-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[netfilter.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:from_mime,netfilter.org:email,netfilter.org:mid,netfilter.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4E7E7307C2

The layer 2 encapsulation and layer 3 tunnel information in the xmit
path is taken from the other tuple, because the tunnel information that
is included in the tuple for hashtable lookups is also used to perform
the egress encapsulation in the transmit path.

This patch uses the correct direction when setting up the tunnel, the
original proposed patch to address this fix uses the reversed direction.

While at it, remove the redundant check to call dst_release() to drop
the reference on the dst that was obtained from the forward path, which
is not useful in the direct xmit path unless tunneling is performed.

Fixes: fa7395c02d95 ("netfilter: flowtable: support IPIP tunnel with direct xmit")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_flow_table_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 2a829b5e8240..b66e65439341 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -127,18 +127,18 @@ static int flow_offload_fill_route(struct flow_offload *flow,
 
 	switch (route->tuple[dir].xmit_type) {
 	case FLOW_OFFLOAD_XMIT_DIRECT:
-		if (flow_tuple->tun_num) {
+		if (route->tuple[!dir].in.num_tuns) {
 			flow_tuple->dst_cache = dst;
 			flow_tuple->dst_cookie =
 				flow_offload_dst_cookie(flow_tuple);
+		} else {
+			dst_release(dst);
 		}
 		memcpy(flow_tuple->out.h_dest, route->tuple[dir].out.h_dest,
 		       ETH_ALEN);
 		memcpy(flow_tuple->out.h_source, route->tuple[dir].out.h_source,
 		       ETH_ALEN);
 		flow_tuple->out.ifidx = route->tuple[dir].out.ifindex;
-		if (!flow_tuple->tun_num)
-			dst_release(dst);
 		break;
 	case FLOW_OFFLOAD_XMIT_XFRM:
 	case FLOW_OFFLOAD_XMIT_NEIGH:
-- 
2.47.3


