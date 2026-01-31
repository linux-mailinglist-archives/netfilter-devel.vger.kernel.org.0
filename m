Return-Path: <netfilter-devel+bounces-10548-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qP/ZD39xfmlSZAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10548-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 31 Jan 2026 22:17:51 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F017C3F92
	for <lists+netfilter-devel@lfdr.de>; Sat, 31 Jan 2026 22:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D28263012C4A
	for <lists+netfilter-devel@lfdr.de>; Sat, 31 Jan 2026 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202EE367F48;
	Sat, 31 Jan 2026 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEi0rZoN"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA847082F;
	Sat, 31 Jan 2026 21:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769894267; cv=none; b=L4N7skmvzLxuGNkDh78j8TrLwr9NAO/iaavjc+lUPIBGjIUSMZt+icuyrfNr0uj6gBf0Mtuguj8Aknpm6QSd08bLPE3fB6UsCO2prvWA/0Qy4rIrpZlLtTQ3aBCpKYWkZdzH3RkRtJ+SVDl8i6/ju+DFI5DqZc2MSSpIgdujbME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769894267; c=relaxed/simple;
	bh=tzp/4c6I7b/Oupolrn0O69jKkxK2Bb6x6WKlbg3eS8s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8Lc+i3PN7JVHQ6qBw/ZHnR4pErgyBFAq5MKRiFrtrB29n9prm3Lxo4zJfKMU33r6tDx9kxWZrxtPratiKBFaaVAtNgh0jaoLuTNtQm7Or2ruK331L5Bthsvvv+roTmSL9EWovfkx4E6uLCcNKaKabMkU4JhF2RCSh5p7lt/eNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEi0rZoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3A2C4CEF1;
	Sat, 31 Jan 2026 21:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769894266;
	bh=tzp/4c6I7b/Oupolrn0O69jKkxK2Bb6x6WKlbg3eS8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WEi0rZoNyDM0qNpmsSd58KYueY6PygYxo6GeLeyyeD5g4IIf6ZO0+Bnq6uiLXLB/6
	 1tNFVBlMSROpnR52TSYvL1fS0AeusBgpYbeiFMz9rbOcrsn+vB2k5gQM2q6plZ8TLs
	 nJV7KRtMbwHdNgS72MXprxfjjjmbkYUwTAqW7biEEaajVjrWeg9HhOeefg8t/oZYUy
	 GZ7J96a4WdTk47BL71t/2d6FDFdBoQjn3raqjSBBWB0dvndDdr8ugj8n3H7tTap0I6
	 i4ZdtwiEEcQ8OYWTwWuqBAfOnbGshE9qJfYsYjTbTp87ikg29WJN4XqaPgHEcDB2Ti
	 JNSgKvWSnNePA==
Date: Sat, 31 Jan 2026 13:17:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH v2 net-next 0/7] netfilter: updates for net-next
Message-ID: <20260131131745.0387502b@kernel.org>
In-Reply-To: <aX5tQtxzcYzbYW6o@strlen.de>
References: <20260129105427.12494-1-fw@strlen.de>
	<20260130081245.6cacdde2@kernel.org>
	<aX0B1xaFGL43xxUn@strlen.de>
	<CANn89iKUV07+84PVq0cHe3vMaSGNTQzhq9=xetg+_P2DmsPmQQ@mail.gmail.com>
	<aX5tQtxzcYzbYW6o@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10548-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8F017C3F92
X-Rspamd-Action: no action

On Sat, 31 Jan 2026 22:00:03 +0100 Florian Westphal wrote:
> Eric Dumazet <edumazet@google.com> wrote:
> > > Sigh.  Doesn't ring a bell, I will have a look.  
> > 
> > Could this be related to "netns: optimize netns cleaning by batching
> > unhash_nsid calls" ?  
> 
> Thanks Eric, that seems plausible.
> 
> Did not yet have much luck with reproducing this so far, I will
> look at this in more detail lon monday.

To be clear -- the patch Eric pointed out is _not_ merged yet.
It was pending in the test branch but it's not in net-next.

