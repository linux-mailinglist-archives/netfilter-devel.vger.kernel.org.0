Return-Path: <netfilter-devel+bounces-11223-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBCoDWLut2mfXQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11223-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 12:49:54 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F249D298EFF
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 12:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B56C30057B5
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Mar 2026 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFE52C08BB;
	Mon, 16 Mar 2026 11:48:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6192BE655;
	Mon, 16 Mar 2026 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661717; cv=none; b=kaO8RFQO3iZhOpHw4xCfZ3SQ28GcWTs64ieer6mqdPiyZ24wKITHy/d6VW05JPN1VUnK07ptXoOljlm3Dg1J8E2cmOZDBKjeFd9dIZ9auXPbrNYlm4AVQYe0gW3gY8G1dUWtp6lbutwU4KhE9IfdAMH33EDJ8BZGhIHWz4h6B2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661717; c=relaxed/simple;
	bh=7+gwXUc+u02+ycYjnHx2vbDXbRxeOfeDYvQey7dgw2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UMb2q9Uytdh0lK3Jg+WObbGW84taKeZqUxm3dqiZavN0icJHX6RR3A8K8P5KHzTlkifORK2uQA4pd2gVQiuL8xdz+Nvkzhfq5ZQCXGSgiD5yytlLlOQ5Gm7gQLStvOYn1WXIPkkgGo3RHIP5cXZGqFFKyNlREP9mCJTKBvCmyBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 47619605C3; Mon, 16 Mar 2026 12:48:34 +0100 (CET)
Date: Mon, 16 Mar 2026 12:48:33 +0100
From: Florian Westphal <fw@strlen.de>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_flow_table_offload: fix heap overflow
 in flow_action_entry_next()
Message-ID: <abfuEe_PpDCyA64B@strlen.de>
References: <aaxe-uH2Qr6qM4E9@v4bel>
 <aax2yZtJce0d19gd@strlen.de>
 <abfhRFfZ1LOgWEsf@strlen.de>
 <abfoTBGLhav-iPQb@v4bel>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abfoTBGLhav-iPQb@v4bel>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11223-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: F249D298EFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hyunwoo Kim <imv4bel@gmail.com> wrote:
> > Ping.  I'm not even sure if there is a bug to begin with, see Pablos
> 
> Sorry for the late reply.
> 
> To clarify, I triggered the overflow using a dummy device that accepts
> TC_SETUP_FT, as I don't have real offload-capable hardware. The 17 entry
> scenario requires double VLAN (QinQ) + IPv6 + SNAT + DNAT simultaneously,
> which is unlikely in real-world deployments, so it is hypothetical.

If you triggered it, its not hyptothetical and needs to be fixed.

> > Normally there should be a check that prevents such a configuration.
> > If thats missing, please add one instead of increasing this define.
> 
> So, should I send a v2 with a bounds check, or drop this patch?

Yes, please send a v2 that prevents the overflow at configuration time.

