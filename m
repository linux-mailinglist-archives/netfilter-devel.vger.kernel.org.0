Return-Path: <netfilter-devel+bounces-11846-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICDoJ6D+3Gk3YwkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11846-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 16:33:04 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A883ED585
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 16:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EE3F302BA70
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 14:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9E3DDDD2;
	Mon, 13 Apr 2026 14:26:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A56BFCE
	for <netfilter-devel@vger.kernel.org>; Mon, 13 Apr 2026 14:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090384; cv=none; b=MwK2qMMujwc6YvKeuE7Oph1238ToMpVwKIiLR63l025DCbMneKSbSZz31FZa1rV0PkEowaw9EN7NJyun4PCvu7SZkf7EaxfapeU6P+BYGsgm3XFm3IoODwodUHCelM5d8l1JbZLkKQcMbl6kODLH2630rKxSPEXr+EPpIBASpw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090384; c=relaxed/simple;
	bh=38ONMHZin6AGukIFxXmEGOlhxnenE8QJ7jdXj/gi3Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1RUzP47ULBg0QCfVcWkMxVUv1ChiR92FH58rI3okEocCe23I7Se07S6+jVgAWI7eUOjl2+anwdPvPb0JXQa4I412z4ekd7dcLh9FtG0Q9UzRkYmqLDD275Wb1Gyv0y5zV2USebgHxvCc9QEzpuuT14GID4d9bkSB86PrAbuJvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D327660966; Mon, 13 Apr 2026 16:26:19 +0200 (CEST)
Date: Mon, 13 Apr 2026 16:26:19 +0200
From: Florian Westphal <fw@strlen.de>
To: Vladimir Vdovin <deliran@verdict.gg>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org,
	coreteam@netfilter.org, phil@nwl.cc
Subject: Re: [PATCH nf-next] netfilter: nf_conncount: make number of hash
 slots configurable
Message-ID: <adz9CyDXi2wSwvjM@strlen.de>
References: <20260413123712.42993-1-deliran@verdict.gg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413123712.42993-1-deliran@verdict.gg>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11846-lists,netfilter-devel=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,verdict.gg:email]
X-Rspamd-Queue-Id: 27A883ED585
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Vladimir Vdovin <deliran@verdict.gg> wrote:
> Some workloads with high conntrack rate
> generate high lock contention on insert_tree(), so
> constant 256 CONNCOUNT_SLOTS can be too small.

No.  Compile time options suck.  No distro is going
to alter the value away from the default.

Maybe change the code to size the array dynamically
based on e.g. number of online cpus?

