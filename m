Return-Path: <netfilter-devel+bounces-10782-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0O1+MSXDkGlacwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10782-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Feb 2026 19:47:01 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 404FF13CF41
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Feb 2026 19:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E29A3301ECEB
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 Feb 2026 18:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B69A2F745E;
	Sat, 14 Feb 2026 18:46:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259F219319
	for <netfilter-devel@vger.kernel.org>; Sat, 14 Feb 2026 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771094816; cv=none; b=ZRlcACNW2faWoqmVamrwOJNFXqF56jcjusMuW3+sTbfnNKhJfMZw4e2Wgzaz/dJ/P7elJctVfc+DW+lzK/7JhkNWDPHqySfIDHA5kNIAsXor007sUMQBgimhykL+TtuwDr2WLgZqr4hJPC59WnxydXNkSuFIukQm/A+8XNQxTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771094816; c=relaxed/simple;
	bh=E3reMOSgoiiL+m3EiONOzoel5BX/AD3aa9dfafB4nP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9tAGPy9pKGoic5Qg8O/KrzjflOUYBCjjb0Z/0CnetF9bUhYjebLnHMasI7jbJS8Zd9Nbszy0KSPsmIqq04Xzd+bnGp5nryPxX3/lBxx3wQE+SOETqecv5zYhoZvgmRU5sPLBhd3uEP660fOhDJbAGw+wPqBWmEkN3i+we2oqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A6A1A60601; Sat, 14 Feb 2026 19:46:46 +0100 (CET)
Date: Sat, 14 Feb 2026 19:46:42 +0100
From: Florian Westphal <fw@strlen.de>
To: Alan Ross <alan@sleuthco.ai>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH] main: refuse to run under file capabilities
Message-ID: <aZDDEpXNzcE6_lGn@strlen.de>
References: <20260213225323.5749-1-alan@sleuthco.ai>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213225323.5749-1-alan@sleuthco.ai>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10782-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	URIBL_MULTI_FAIL(0.00)[strlen.de:server fail,sleuthco.ai:server fail,sea.lore.kernel.org:server fail];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 404FF13CF41
X-Rspamd-Action: no action

Alan Ross <alan@sleuthco.ai> wrote:
> Extend the existing setuid guard in main() to also detect
> file capabilities via getauxval(AT_SECURE).

Applied, thanks!

