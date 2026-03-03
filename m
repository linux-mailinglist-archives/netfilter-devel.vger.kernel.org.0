Return-Path: <netfilter-devel+bounces-10925-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMbUKC4sp2mIfgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10925-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Mar 2026 19:45:02 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C82F1F56B9
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Mar 2026 19:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4D7D301D077
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Mar 2026 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F68351C15;
	Tue,  3 Mar 2026 18:44:58 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB40175A93;
	Tue,  3 Mar 2026 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772563498; cv=none; b=MWIhAmqr7VhM1hvINjpvCNrIP2pEd3bnoVrT33sr3w6ucKngPIOYLJZbYMlnhoqMxPxeWdjVbSih8UqXDphjrWQiNzEgMCAGflfq7Ji2Bfj7J+XmApiXurS89R+cI+HDfQqFi7sr72yyJ0SXO3OCI4kf3DxyAvxvYWc+6LdUzN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772563498; c=relaxed/simple;
	bh=GP2WEtcClxhzHsK+mmjyuAuIYHCZJ+WREvzQ+wMugKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqZN/a6mg/3dWCZ9lSsQa3/Qq32q/85UISZNTv90FSMYcJUirops+RZHmSLnU/zsvKmkG5P7m+BfgR9R0SSZ5JmqRPep58ONNet8MwXZ/5GgIfhT1tsGw2A7/wmYs1HLU+sbDvp0165uyfbuGDKq/Wbv/e45OvyYUyjaTGOnO2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 9BB3760345; Tue, 03 Mar 2026 19:44:54 +0100 (CET)
Date: Tue, 3 Mar 2026 19:44:54 +0100
From: Florian Westphal <fw@strlen.de>
To: Jindrich Makovicka <makovick@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Genes Lists <lists@sapience.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
	coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>, stable@vger.kernel.org,
	regressions@lists.linux.dev,
	"Kris Karas (Bug Reporting)" <bugs-a21@moonlit-rail.com>
Subject: Re: [REGRESSION] 6.19.4 stable netfilter / nftables [resolved]
Message-ID: <aacsJnLwaAuKZIrf@strlen.de>
References: <a529a6a9a2755d45765f20b58c5c11e2f790eacb.camel@sapience.com>
 <45f03b0b-fe8f-4942-bad1-3fbde03d4be1@leemhuis.info>
 <143e1a402ad78dd7076516a6ceb637f378310b16.camel@sapience.com>
 <10537f2b74da2b8a5cb8dc939f723291db39ff84.camel@sapience.com>
 <2026022755-quail-graveyard-93e8@gregkh>
 <b231fcdb6c66a7b24dcef3ee5c35c5f612d5c1a7.camel@sapience.com>
 <9d110d860c0c7e110d018ea53a7666eba275da20.camel@gmail.com>
 <d43b9da4-99ee-4516-9bec-71a9de19618e@leemhuis.info>
 <ce07b65b86473acac101c4854f6201d05597d48c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ce07b65b86473acac101c4854f6201d05597d48c.camel@gmail.com>
X-Rspamd-Queue-Id: 0C82F1F56B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10925-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.107];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Action: no action

Jindrich Makovicka <makovick@gmail.com> wrote:
> > > commit 12b1681793e9b7552495290785a3570c539f409d
> > > Author: Pablo Neira Ayuso <pablo@netfilter.org>
> > > Date:   Fri Feb 6 13:33:46 2026 +0100
> > > 
> > >     netfilter: nft_set_rbtree: validate open interval overlap
> > > 
> > > Example set definition is here:
> > > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=221158
> > 
> > Does that problem happen with 7.0-rc2 as well? This is important to
> > know
> > to determine if this is a general problem or a backporting problem.
> > 
> 
> Yes, the same problem shows up with 7.0-rc2. I updated the bugzilla
> attachment to reproduce the bug just by feeding it to nft,
> 
> # uname -a
> Linux holly 7.0.0-rc2 #25 SMP PREEMPT_DYNAMIC Tue Mar  3 18:17:21 CET
> 2026 x86_64 GNU/Linux
> # nft -f test-full.nft
> test-full.nft:1643:1-25: Error: Could not process rule: File exists
> 12.14.179.24-12.14.179.31,
> ^^^^^^^^^^^^^^^^^^^^^^^^^

Pablo, it looks like the is a discrepancy between the comment and the
code.  Comment talks about 'open interval', but it checks that some
start interval was found instead of checking that the OPEN_INTERVAL
bit is raised:

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -556,7 +556,8 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
        /* - start element overlaps an open interval but end element is new:
         *   partial overlap, reported as -ENOEMPTY.
         */
-       if (!rbe_ge && priv->start_rbe_cookie && nft_rbtree_interval_end(new))
+       if (!rbe_ge && priv->start_rbe_cookie & NFT_RBTREE_OPEN_INTERVAL &&
+           nft_rbtree_interval_end(new))
                return -ENOTEMPTY;


Does that look correct to you?

