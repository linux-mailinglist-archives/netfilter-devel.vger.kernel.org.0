Return-Path: <netfilter-devel+bounces-11772-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INWAG06312lURwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11772-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 16:27:26 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEE63CC028
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 16:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA791308C536
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Apr 2026 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861DD3DBD56;
	Thu,  9 Apr 2026 14:22:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8B03DA7E0;
	Thu,  9 Apr 2026 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744521; cv=none; b=oho68U9mmS/ouVeo47cq6zc71kdkd/oV+Z29xI2l1d0mq9IM1+XrH8Wa8pjIDmc8Xg09G16clUSSA63B93sI7PYqzPnMVwFEaHdt0F3xuFByfGexLLIzJELBAXmjbdsVaEvw1hVNNz/ZQIZFhmF+LKUsTRO6tI1LGkjn0mc+KA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744521; c=relaxed/simple;
	bh=hgBEqVyt53AXPKU+9AYIC3cphVx6joVQQ0wDtlqImKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV2gF+nP+RcWyNaNwDEqzustMRXzmK25hC09fYnAdI23030rRr9cTd+mio7tJ5afcWk0FVOoxnHW+qbXDn7k/TcvqjfMbbqKGt2I845Tf3+SvISxWd02IiIvYb1QPCBrhR2xL7X3aCmiLSxRILCxxJb1cgeXJXhZtzyrBnY4RrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wAqGT-000000002Iq-2EUP;
	Thu, 09 Apr 2026 14:21:49 +0000
Date: Thu, 9 Apr 2026 15:21:45 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH RFC net-next 0/4] improve hw flow offload byte accounting
Message-ID: <ade1-dlugvWF7IzB@makrotopia.org>
References: <cover.1775739840.git.daniel@makrotopia.org>
 <adevKeasLkEB5zZ4@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adevKeasLkEB5zZ4@chamomile>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11772-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[nbd.name,phrozen.org,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,collabora.com,strlen.de,nwl.cc,vger.kernel.org,lists.infradead.org,netfilter.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	DMARC_NA(0.00)[makrotopia.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@makrotopia.org,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makrotopia.org:mid]
X-Rspamd-Queue-Id: BCEE63CC028
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 03:52:41PM +0200, Pablo Neira Ayuso wrote:
> On Thu, Apr 09, 2026 at 02:07:22PM +0100, Daniel Golle wrote:
> > Hardware flow counters report raw byte counts whose semantics
> > vary by vendor -- some count ingress L2 frames, others egress
> > L2, others L3. The nf_flow_table framework currently passes
> > these bytes straight to conntrack without conversion, and
> > sub-interfaces (VLAN, PPPoE) that are bypassed by hw offload
> > never see any counter updates at all.
> 
> I see, but that is part of the feature itself? Why pretend that these
> interface are really seeing traffic while they don't. This aspiration
> of trying to do all hardware offload fully transparent (when it is not
> the case, not mentioning semantic changes in how packet handling is
> done compared to the software plane) does not sound convincing to me.

Please explain what you mean by offloading not being fully
transparent. If the MAC hardware offloads VLAN encap/decap, for
example, we also maintain the counters correctly (it just so happens),
just the flow-offloading case results in a weird overall picture:
hardware interface counters keep increasing, encap interfaces (802.1Q,
PPPoE) don't. That makes it confusing and hard to understand what's
happening when only looking at the interface counters (ie. "what is
all that traffic on my physical WAN interface which isn't PPPoE? Can't
be that all of that is the modems management interface, SNMP, ...")

> 
> On top of this, this issue also exists in the software plane: Devices
> that are bypasses do not get their counters bumped.
> 
> Maybe if this is really a requirement, then this should address the
> issue for software too, but is it worth the effort to add
> infrastructure for this purpose?

To me it would feel more correct to see counters increasing also
for offloaded traffic on software interfaces such as PPPoE or VLAN.

I honestly didn't think about the software fastpath, and yes, I think
it should be addressed there too.

> > This series lets drivers declare what their counters represent,
> > so the framework can normalize to L3 for conntrack and
> > propagate per-layer stats to encap sub-interfaces.

This part could also been seen as an independent fix as currently
conntrack stats for the same traffic differ in case of software
offloading (pure L3 bytes) and hardware offloading (L2 ingress bytes
in case of mtk_ppe).

