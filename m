Return-Path: <netfilter-devel+bounces-10719-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGwwB4RvjGlmngAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10719-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 13:01:08 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC01612408C
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 13:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C5743021717
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 12:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E113A31327D;
	Wed, 11 Feb 2026 12:01:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729930BF69
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Feb 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811260; cv=none; b=agaA7DCtxb8GsfbzTlX2O/oqA+V7WdieT7EYwhYgdKCGTEbVJi05wOz43jMjJuEOognaFXTtlf2IA5G1YsDWRObXl7GhLmRz6TCDgscDbCL0lcflg5Q2Bp/lcXvldZAw99PImxriV9qmO2MDvsceMl/B3bt4adShNp9HeCr8uH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811260; c=relaxed/simple;
	bh=06Ku5KSUQFjfmCPK/JBMC9fINF+3UA3jFK52ZPLiJEI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SL50uiGKjwip7TnZe8O09cAaBWTU44pJLHkPWyLf7fXddNl2ieR8KwNIYD38j4vLFTGDYiU5Jr5W+mskfaE5gGPVKLLt00r5z8JFMjYIz1qkDX9Q1QT8COG1JV+Q3KazVNwCBb/luxWw1oMTkpi+KOXosWTA3XDSvvPJgvOkAyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 84798605E7; Wed, 11 Feb 2026 13:00:56 +0100 (CET)
Date: Wed, 11 Feb 2026 13:00:56 +0100
From: Florian Westphal <fw@strlen.de>
To: netfilter-devel@vger.kernel.org
Subject: [ANN] nf-next remains OPEN
Message-ID: <aYxveCxwSezABhIa@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10719-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: DC01612408C
X-Rspamd-Action: no action

Hello,

while net-next remains closed until Feb 23rd, I would like to keep
nf-next open for new features.

So, if you had changes targetting nf-next that aren't in the
patchwork backlog[1] anymore, please consider resubmitting them.

I have queued the 'commit mutex deadlock during reset' series to
nf:testing, no need to send it again.

Thanks.

[1] https://patchwork.ozlabs.org/project/netfilter-devel/list/

