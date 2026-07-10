Return-Path: <netfilter-devel+bounces-13821-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t/2eH3m8UGpP4QIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13821-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 11:33:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAF173919B
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 11:33:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=i7T+bfRo;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13821-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13821-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 621B53008226
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Jul 2026 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561B3DCD87;
	Fri, 10 Jul 2026 09:27:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045E83CC7EC;
	Fri, 10 Jul 2026 09:27:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783675625; cv=none; b=QBkOwiSwlY99TX9aBKxpJ599U238O7i5l5kFTNPpXITl1G5IEG3qnh4BSqgcLG5Hl/RG0KhEM0fMWgRPsBsDJNIamZUGEPgF+tor+WD5GtZXJOeBr8CJ1WaI8Zqtn8bs3bkXe4oZRZ3hGynXQ5gGN1d9X6qiWyOGb+I4LC0BirI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783675625; c=relaxed/simple;
	bh=DXlxi6FvkGmt8WkwHNfC3lOzCxOOIwiRRE2SS37ftP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCewdRbLZVq0Xt/0sSJB9Zxe2uI0fFcg7D8GVp82QYPVJqKvTp6O/Bl9ALszqbp1AFdXM93mNurXoyBHw8qmIHF0sPsgX7u3AFnOypISzkCqeL52ZtoqhlDFJgmy1TnXzEhpGjlyWnQkTsN+V6pZBxYtaXT/Yd2oQAFsHWgwQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=i7T+bfRo; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 976DB6057A;
	Fri, 10 Jul 2026 11:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783675621;
	bh=YLWyZ3h1hshbu033MQgy1J8KKJjRd55U+F2x53SL5JA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i7T+bfRoG88EefZUHsKOmOdtF3eVsKYKfJECyEfDOpRo30HsnBHoFsVg5O4jMTL7V
	 gkXKEfYl0sOc8UYg0I7LJ0wCj8FtddNSstm31828+Qc1DaaH3fPIjTAlY9ccf3hT6W
	 m2oRaYmRL2zQc03YdsrzztyXYs/fv4LkPkbgFDBStXgoe0ssI67oz5TBlIlRy8FEhw
	 3WS+4g4w8nT1E9N+YZPwWt5biNw94eUChwAJ34zFzJz7DagMs1G8KWXei9GJcwo8sx
	 OAkUBdQjJXGIAu5V9szb/jlO5iT5g5Qar6vrTh25h1ksaavFW/P3Q1hKrcxQxviUaR
	 GVUHa5d9OUfLA==
Date: Fri, 10 Jul 2026 11:26:57 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Krishna Kumar <krikku@gmail.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, bridge@lists.linux.dev
Subject: Re: [PATCH v12 nf-next 3/7] netfilter: nf_flow_table_offload: Add
 nf_flow_rule_bridge()
Message-ID: <alC64Vg_xihR-huW@chamomile>
References: <20260707091045.967678-1-ericwouds@gmail.com>
 <20260707091045.967678-4-ericwouds@gmail.com>
 <ak4dAXHDmTDRr7-b@chamomile>
 <81c3bf65-b19b-4f80-aa8e-c0c4b3f5d6a7@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81c3bf65-b19b-4f80-aa8e-c0c4b3f5d6a7@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:ericwouds@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:razor@blackwall.org,m:idosch@nvidia.com,m:kuniyu@google.com,m:sdf.kernel@gmail.com,m:skhawaja@google.com,m:liuhangbin@gmail.com,m:krikku@gmail.com,m:mkarsten@uwaterloo.ca,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:bridge@lists.linux.dev,m:andrew@lunn.ch,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[netfilter.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,strlen.de,nwl.cc,blackwall.org,nvidia.com,gmail.com,uwaterloo.ca,vger.kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13821-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDAF173919B

Hi Eric,

On Wed, Jul 08, 2026 at 08:36:11PM +0200, Eric Woudstra wrote:
> On 7/8/26 11:48 AM, Pablo Neira Ayuso wrote:
> > On Tue, Jul 07, 2026 at 11:10:41AM +0200, Eric Woudstra wrote:
> >> Add nf_flow_rule_bridge().
> >>
> >> It only calls the common rule and adds the redirect.
> > 
> > I decided to use the new _unsupp() function, so we don't pretend
> > bridge hw offload is already supported. We will need a driver before
> > we can add this, this stub does not provide much. I guess your goal
> > was just to avoid a crash here.
> 
> No, I am already using hw_offload between bridged interfaces
> on the mt7986 succesfully for almost 2 years.
> It works dsa-port to direct interface (lan1 to eth1 on Bananapi R3) and
> between direct interfaces (eth0 to eth1 on Bananapi-R3-mini)

Do you utilize the existing mt7986 driver in-tree without changes to
achive this hardware offload? Or you have still have out-of-tree
patches that need to be merged to achive this?

> It can also be tested with my bridge_fastpath.sh selftest script.
> This script uses veth-device pairs to test the software fastpath.
> It can also use 2 real interfaces interconnected in a loop of copper,
> when chosen with commandline arguments. Then it tests software- and
> hardware-fastpath. It also tests many different scenarios.
> 
> So this is why I've added it, as it is already functional. If a software
> fastpath is setup correctly, the hardware fastpath is also functional.

Thanks for explaining.

I am targetting at a minimal subset of the flowtable bridge support at
this stage. There is a need to make progress with the
nf_conntrack_bridge counterpart before the flowtable bridge can get
more features (namely, bridge vlan filtering support).

