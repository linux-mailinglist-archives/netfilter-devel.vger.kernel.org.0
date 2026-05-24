Return-Path: <netfilter-devel+bounces-12797-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qp1lGmMyE2rb8wYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12797-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 19:16:19 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D74475C3477
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 19:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6312230086FF
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2026 17:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B6E257825;
	Sun, 24 May 2026 17:16:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F4814B950
	for <netfilter-devel@vger.kernel.org>; Sun, 24 May 2026 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779642976; cv=none; b=hfcj+yGmpBU1mAg8i/HFQYfUVfAaA47MJQMKPHTALjnjfjouEC3SqVFr8NhRtcgC4f+wdCIlhBNVk6jSxDIC8pkXnMfjWdDRNKt3YyfbqMWee7rHqkzUMPm9Lgc9PW7cFP4mlX/8JcbCwMxt2fAXAVwk5j7sEeRmA3N0EXiAdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779642976; c=relaxed/simple;
	bh=yZtPLFbdYZL7AYTzQWSTczVP2EYlG7BLjfJfaiWIyfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvogiIYpZrPdhW9Ta7xxDa9uJUH/Vx2bxF9T5QZ3lHIV0tqqRxe+GhOJKNuEU/uMiS3od1fowuBFrG9P2X9C77Q0PXxgCOqWbFTGAMALU4CIufaxf4PV9wyW5obJ8pWwPVL/1KrOhQ4JNh0Rkv5gzW0QHoYr1VaPldbYxF2rUPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 36BA160551; Sun, 24 May 2026 19:16:05 +0200 (CEST)
Date: Sun, 24 May 2026 19:16:04 +0200
From: Florian Westphal <fw@strlen.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	pablo@netfilter.org, phil@nwl.cc
Subject: Re: [PATCH 0/3 nf-next] netfilter: synproxy: timestamp adjustment
 fixes
Message-ID: <ahMyVJYynOoa32U5@strlen.de>
References: <20260523194743.5888-2-fmancera@suse.de>
 <7dcb73cb-11ab-4c9d-89bd-7418bdc86fdb@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7dcb73cb-11ab-4c9d-89bd-7418bdc86fdb@suse.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12797-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.de:email]
X-Rspamd-Queue-Id: D74475C3477
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> What do you all think? nf or nf-next for the 4 commits? I tried to reproduce
> an UAF but couldn't trigger it. Although, I was able to write to the stale
> pointer using tc mirred..

nf.  But I'm not sold on this series: dropping patckets outside
of rulesets should be a last resort.

