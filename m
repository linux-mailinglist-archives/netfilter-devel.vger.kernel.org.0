Return-Path: <netfilter-devel+bounces-10998-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Jl/B4uNqWki/gAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10998-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Mar 2026 15:04:59 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9AD212FCC
	for <lists+netfilter-devel@lfdr.de>; Thu, 05 Mar 2026 15:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 583FF306B4FB
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Mar 2026 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94482390200;
	Thu,  5 Mar 2026 14:04:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1222258C
	for <netfilter-devel@vger.kernel.org>; Thu,  5 Mar 2026 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772719496; cv=none; b=BTPx1BXL+xmEXWdhYLSBove70RcbBGjF9nCMtRl7KdsmH2glLFvmxJ6NLE0jPU8cjFa8v9vVfxa8lO4QE1ou++OZrn5/xCKpPME4lc1aKP+thxe8FwEm+/9KD2Bi+lt/bo5/XqW1qJdljEM0ylHf9oWevCNkQTBHfZAf9I7JC9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772719496; c=relaxed/simple;
	bh=X2J8EIOJYWDk/DfTlE4fkmhtlkHN4PdU4f/uSt+s/n8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLQoiWO29Nl6Cy4+v4UPyOYC22HiQunuRyl8R9uEPF9YBqcGqK6we/tY1iniJicrkh6fI0etwz5sKH2K+bw8u7nLpoNblLAY0F7hGQv+bLnK6wwzK7cYwgjwpwMiw3RPuBhLGqESPZJgnrYt1VixCYKyZWbKKAgoKVCXnDqnwXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 9F8846047A; Thu, 05 Mar 2026 15:04:52 +0100 (CET)
Date: Thu, 5 Mar 2026 15:04:52 +0100
From: Florian Westphal <fw@strlen.de>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH] rule: fix NULL pointer dereference in do_list_flowtable
Message-ID: <aamNhIWHDeGQOXaf@strlen.de>
References: <20260302160539.248755-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302160539.248755-1-ant.v.moryakov@gmail.com>
X-Rspamd-Queue-Id: 9C9AD212FCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10998-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.449];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Action: no action

Anton Moryakov <ant.v.moryakov@gmail.com> wrote:
> Static analysis found a potential NULL pointer dereference in
> do_command_list() when handling CMD_OBJ_FLOWTABLE.
> 
> If cmd->handle.table.name is not specified, the table pointer remains
> NULL after the cache lookup block. However, do_list_flowtable() expects
> a valid table pointer and dereferences it via ft_cache_find().

Not following, table is never NULL in the function:

static int do_command_list(struct netlink_ctx *ctx, struct cmd *cmd)
{
	struct table *table = NULL; [..]

	if (cmd->handle.table.name != NULL) {
		table = table_cache_find(&ctx->nft->cache.table_cache,
					 cmd->handle.table.name,
					 cmd->handle.family);
		if (!table) {
			errno = ENOENT;
			return -1;
		}
	}

	switch (cmd->obj) {
[..]
	case CMD_OBJ_FLOWTABLE:
		return do_list_flowtable(ctx, cmd, table);

This has been the case for almost a year:

commit 853d3a2d3cbdc7aab16d3d33999d00b32a6db7ce
Date:   Thu Mar 20 14:31:42 2025 +0100
rule: return error if table does not exist


