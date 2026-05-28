Return-Path: <netfilter-devel+bounces-12910-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDdPC3HRF2ohRwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-12910-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 07:24:01 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC87E5ECC2F
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 07:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD7DD3013AAC
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 May 2026 05:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76C31618C;
	Thu, 28 May 2026 05:22:38 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DA42C11F9
	for <netfilter-devel@vger.kernel.org>; Thu, 28 May 2026 05:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945758; cv=none; b=FnoW0xyoT9zAlDl5cIXF6Duv4RXbtq8H1l3h+HgY7E5DseSJDwgaDbMyXMah1XIgregxXz2J4+4ziM2sQbdbaiH1koiFMB8on8+XQLdtmLYvj9SrctFqLnw9TJwYvEg3/rWnVLhZ349W5Kz48ZO269dbR3IZmRZ9xB0gHJsukvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945758; c=relaxed/simple;
	bh=7UPw/V+LAVSuor63USgPv09byyI8x96rZTzcQF3nCLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ikKSpSXcz2b3cquESjq0tBg9RMzSl7ywhE667fLklJcxtmGBRMmi9F5dmz8axuUHnF0XeNtOPBmKpYLUfhArS+NG+tUq9UV5eeL9VBQqe5NRd6ThGGoFKnEuom9lcpVrB1AJduyqoYheeLcGV3Ce7jBrPJ8yRoPtZzpfrdl7OoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 18FBB60503; Thu, 28 May 2026 07:22:35 +0200 (CEST)
Date: Thu, 28 May 2026 07:22:34 +0200
From: Florian Westphal <fw@strlen.de>
To: Adrian =?utf-8?B?QmVuyJtl?= <adibente@gmail.com>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org, phil@nwl.cc,
	nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
	andrew+netdev@lunn.ch, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, daniel@makrotopia.org,
	coreteam@netfilter.org, linux-mediatek@lists.infradead.org
Subject: Re: [RFC PATCH net] netfilter: flowtable: fix offloaded ct timeout
 never being extended
Message-ID: <ahfRGvxRKoggA_26@strlen.de>
References: <20260526060138.3924-1-adibente@gmail.com>
 <ahaek23tB7D8tQUe@strlen.de>
 <CAC2HPwt_3D7k7tYr8OqNiguc-jMF3PEKtayFKmvOp37M2=QCZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAC2HPwt_3D7k7tYr8OqNiguc-jMF3PEKtayFKmvOp37M2=QCZA@mail.gmail.com>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12910-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,vger.kernel.org,nwl.cc,nbd.name,mediatek.com,kernel.org,lunn.ch,gmail.com,collabora.com,makrotopia.org,lists.infradead.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.961];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Queue-Id: BC87E5ECC2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Adrian Ben=C8=9Be <adibente@gmail.com> wrote:
> adjustment: changed min_timeout from u32 to s32 so the
> "expires >=3D min_timeout" comparison has both operands signed.
> Compiles clean.
>=20
> Tested on MT7986 with the WED-offloaded flows that originally
> reproduced the 300s drop. The flows now stay up well past 300s with
> normal offloaded traffic, solution works fine.
>=20
> I'll send v2 with this diff and Suggested-by: you, unless you'd
> rather submit it yourself.

No, please go ahead.

