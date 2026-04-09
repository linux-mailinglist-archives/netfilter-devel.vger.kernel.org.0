Return-Path: <netfilter-devel+bounces-11763-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPPgNqOk12lfQwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11763-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 15:07:47 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CEB3CACBC
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 15:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E65130069A1
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Apr 2026 13:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830D83CF039;
	Thu,  9 Apr 2026 13:07:39 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC3B3CE494;
	Thu,  9 Apr 2026 13:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740059; cv=none; b=q4LGfBO4Vw4xhezY4CeqGJrzInEtTW6QWG1xv/22NjkOPaM+sDTo6qRuQbvv+ts4Dj/HJ6waOxq8j16KTtg0eNKIEXR84DIgqqICeM/bZU6+UtkU+tn+qsWIbq6lN+8Pz10MxnGTjMB1NCxWwlUJNqXrD/DlKPyZPsnGVvEWIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740059; c=relaxed/simple;
	bh=0baEriNkC/Y6wDoeOryOBErKLQExcCEELcjgBz/Ep94=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jIJhehL/0mAhoQCPlkCaKdVIA+ptN/FFs3imLGfWz+R71M0A+/erY2x5dpyrLXXcs0uhw5Scvdm1HWXdnmFdiYtyzvBEixnxKynqze2FpDZa9XXFYgHeZKTkMJMwFXYuTZkfL/vBEiVJUoYaFX+Z+3fGal2SyFWA6Y5vFM8+kAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wAp6T-000000001k1-21AP;
	Thu, 09 Apr 2026 13:07:25 +0000
Date: Thu, 9 Apr 2026 14:07:22 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH RFC net-next 0/4] improve hw flow offload byte accounting
Message-ID: <cover.1775739840.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11763-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[nbd.name,phrozen.org,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,netfilter.org,strlen.de,nwl.cc,vger.kernel.org,lists.infradead.org];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B8CEB3CACBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hardware flow counters report raw byte counts whose semantics
vary by vendor -- some count ingress L2 frames, others egress
L2, others L3. The nf_flow_table framework currently passes
these bytes straight to conntrack without conversion, and
sub-interfaces (VLAN, PPPoE) that are bypassed by hw offload
never see any counter updates at all.

This series lets drivers declare what their counters represent,
so the framework can normalize to L3 for conntrack and
propagate per-layer stats to encap sub-interfaces.

Questions:
 - Sub-interface stats accesses vlan_dev_priv() directly --
   should there be a generic netdev callback instead?
 - Are there hw offload drivers whose counters do not fit the
   ingress-L2 / egress-L2 / L3 model?

Daniel Golle (4):
  net: flow_offload: let drivers report byte counter semantics
  nf_flow_table: track sub-interface and bridge ifindex in flow tuple
  nf_flow_table: convert hw byte counts and update sub-interface stats
  net: ethernet: mtk_eth_soc: report INGRESS_L2 byte_type in flow stats

 .../net/ethernet/mediatek/mtk_ppe_offload.c   |   1 +
 include/net/flow_offload.h                    |   7 +
 include/net/netfilter/nf_flow_table.h         |   5 +
 net/netfilter/nf_flow_table_core.c            |   2 +
 net/netfilter/nf_flow_table_offload.c         | 174 +++++++++++++++++-
 net/netfilter/nf_flow_table_path.c            |   8 +
 6 files changed, 195 insertions(+), 2 deletions(-)

-- 
2.53.0

