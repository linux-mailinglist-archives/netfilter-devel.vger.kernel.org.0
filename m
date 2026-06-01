Return-Path: <netfilter-devel+bounces-12994-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Up5+CJcbHmqBhQkAu9opvQ
	(envelope-from <netfilter-devel+bounces-12994-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 02 Jun 2026 01:53:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C09B626717
	for <lists+netfilter-devel@lfdr.de>; Tue, 02 Jun 2026 01:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDAB030067A5
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jun 2026 23:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546613659FD;
	Mon,  1 Jun 2026 23:52:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEAC346A15
	for <netfilter-devel@vger.kernel.org>; Mon,  1 Jun 2026 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780357932; cv=none; b=GVilLnbP5iADKHQ2MYJO3w879fx5CUeciLfemLRLUnuOVc4+BfX4w7HxdAZI3mQ8qaj0n0iDhKTj1xfKYV+AiGvnYa1HLVb3c8GOwBRs+l4hr/ts9t20xjOAgpyf39yW1aQB71rraQQMuCv0crd7osHTjzoP1e1OPDbXqWQKOk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780357932; c=relaxed/simple;
	bh=4kw1qsnqnRBT5PzT3Jz5eYWQVWqmTLmTyljlsVurshc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D13S4qmOrgNvNAMZqV7CmgUqWg4/ed2mOT2JctyQutK964Z4N9XWEngqNJHCZ/MgArJMVL9ygMpzy24ejWmq0SYrTIrjiMk1vqMlWnNRVRnmpnFTV1o8EbbnJesUTqRbQpLOjtsbT4SL4T+NiQ7Z+GPqBjecm6FI1j2IH+lyzis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 80A44604DC; Tue, 02 Jun 2026 01:52:07 +0200 (CEST)
Date: Tue, 2 Jun 2026 01:52:06 +0200
From: Florian Westphal <fw@strlen.de>
To: boz baba <bababoz943@gmail.com>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [BUG] netfilter: nft_set_pipapo_avx2: rp not reset on goto
 next_match retry after expired/inactive last-field element
Message-ID: <ah4bJmm6z6ytowqD@strlen.de>
References: <CAAB7JCLAzOAZ0CA5CMSkmzwCLY2+DgHSEZe15omAW2-WBTPhbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAB7JCLAzOAZ0CA5CMSkmzwCLY2+DgHSEZe15omAW2-WBTPhbQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12994-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Queue-Id: 6C09B626717
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

boz baba <bababoz943@gmail.com> wrote:
> While auditing the pipapo set lookup in v6.1.133 (the bug is also present
> on current mainline as of this writing) I noticed a logic error in the

Why are you auditing ancient kernel releases?

> Affected file / function
> ------------------------
> 
>   net/netfilter/nft_set_pipapo_avx2.c :: nft_pipapo_avx2_lookup()
> 
> Relevant excerpt (line numbers from v6.1.133):
> 
>   1137 :  const u8 *rp = (const u8 *)key;
>   ...
>   1175 :  nft_pipapo_avx2_prepare();
>   1176 :
>   1177 :  next_match:
>   1178 :  nft_pipapo_for_each_field(f, i, m) {
>   1179 :      bool last = i == m->field_count - 1, first = !i;
>   ...
>   1188 :      NFT_SET_PIPAPO_AVX2_LOOKUP(8, 1);     /* consumes rp */
>   ...
>   1223 :      if (ret < 0)
>   1224 :          goto out;
>   1225 :
>   1226 :      if (last) {
>   1227 :          *ext = &f->mt[ret].e->ext;
>   1228 :          if (unlikely(nft_set_elem_expired(*ext) ||
>   1229 :                       !nft_set_elem_active(*ext, genmask))) {
>   1230 :              ret = 0;
>   1231 :              goto next_match;            /* <-- restarts loop */
>   1232 :          }
>   1233 :          goto out;
>   1234 :      }

This looks very different in mainline. AFAICS this bug was fixed?

