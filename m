Return-Path: <netfilter-devel+bounces-12000-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EHRhBj4t4ml22gAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12000-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 14:53:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7561641B5A5
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 14:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C61103075E50
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Apr 2026 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4721F373C10;
	Fri, 17 Apr 2026 12:49:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4823A2D5923
	for <netfilter-devel@vger.kernel.org>; Fri, 17 Apr 2026 12:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776430159; cv=none; b=QTixVA1dN30/G6yiAe2WjAKPy6ETxDFSa6VWHFLTSDYaqmezMrA5NdqEb/jicnKIP933ML+CIP56sRXJS2iYvuowKThMnBSs6zOligNaNHmmTif7DyE1L4UFWjhLeqI6mC1Y8pKdx5r3tCqvLIJ9xjCw0E+boeXqckZeSjGOg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776430159; c=relaxed/simple;
	bh=rNgEHZbFc3zKt0mvwzF6iqtexFRd5porjihrs2W26Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U62ryGLgQ4x6Uhg52Y0qJyZOOzn2hzDS7pYpdL3DBbxiMps1wWAn7d2V6DbQ5h9YuI0Wfl9Bxau5mAs9l9xRE/xCsw/SzfDljKqxve/g+hDMQQ9g4vcD0ySp5c7Zu6RnzilX1kPVwpEfXzwyDnydpqv/nCkUhk0RNTkwiHJb9AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EC18460640; Fri, 17 Apr 2026 14:49:14 +0200 (CEST)
Date: Fri, 17 Apr 2026 14:49:14 +0200
From: Florian Westphal <fw@strlen.de>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, phil@nwl.cc,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, ebiederm@xmission.com,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, wangjiexun2025@gmail.com
Subject: Re: [PATCH nf 1/1] netfilter: xt_policy: fix strict mode inbound
 policy matching
Message-ID: <aeIsSl26ZZJZ1n7U@strlen.de>
References: <cover.1776141503.git.wangjiexun2025@gmail.com>
 <85a95e0ef783ed8f5f4a787138cca22f995d8056.1776141503.git.wangjiexun2025@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85a95e0ef783ed8f5f4a787138cca22f995d8056.1776141503.git.wangjiexun2025@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12000-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,xmission.com,gmail.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email]
X-Rspamd-Queue-Id: 7561641B5A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ren Wei <n05ec@lzu.edu.cn> wrote:
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> match_policy_in() walks sec_path entries from the last transform to the
> first one, but strict policy matching needs to consume info->pol[] in
> the same forward order as the rule layout.
> 
> Derive the strict-match policy position from the number of transforms
> already consumed so that multi-element inbound rules are matched
> consistently.

That hints that secpaths with len > 1 do not exist, or at least
have never been used.  This has always been broken.

For the patch

Acked-by: Florian Westphal <fw@strlen.de>

