Return-Path: <netfilter-devel+bounces-10605-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOlJCtw6g2ngjwMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10605-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 13:26:04 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED945E5C2E
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Feb 2026 13:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC59130490C0
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Feb 2026 12:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B293ED13F;
	Wed,  4 Feb 2026 12:24:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDAF399003;
	Wed,  4 Feb 2026 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770207858; cv=none; b=dxMII+GqKoQCnm/qvmyaSZeBUcPafr42EccbTEkAI8SxEM+FBA4dqmw/JiItL/mhXE2v79EFDNc+jD/MRNNPbR/MC52UgyOM/AIt6cE2uLYobzLvS47SflOvCF2SRKZ8RAJJoWfQSjylPcOO4WuBUUd6kpFt666Gaa6dBQ3c03o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770207858; c=relaxed/simple;
	bh=Q9NnF6+cxae/dB8rBRyaWmvIuUqCqZwtM7PnXOAT1wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J63WYhYcNrFhuIgAsy6dWerDyQSyyeSCvylaiDxxyyViy0BA8vayp+iKVDahsL9j5b/JURfh2/aFOfIbEwyFk4W7m1sMm8PENzaugqJmMSy+eYJ0qwFM3W456JAzacgTjTiJxJtRjvEI0dHuCS+meJlFw0U7BFeGmWxwe4GHwmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3D1296033F; Wed, 04 Feb 2026 13:24:15 +0100 (CET)
Date: Wed, 4 Feb 2026 13:24:14 +0100
From: Florian Westphal <fw@strlen.de>
To: sun jian <sun.jian.kdev@gmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: amanda: fix RCU pointer typing for
 nf_nat_amanda_hook
Message-ID: <aYM6Wr7D4-7VvbX6@strlen.de>
References: <20260203080109.2682183-1-sun.jian.kdev@gmail.com>
 <20260203145511.164485-1-sun.jian.kdev@gmail.com>
 <aYIOXk55_DRFKCqo@strlen.de>
 <CABFUUZG9LnhXc+nsQA28WHiiT33_5wQ82E1bBSBncWkxkXaKZA@mail.gmail.com>
 <aYIpcHBufnxrcv5O@strlen.de>
 <CABFUUZELXbEKyjMxOBfoL246dmtBSS_oe0zeWwnkmrXXpyv3Yg@mail.gmail.com>
 <CABFUUZFgXooeCgKGypByzePBsHpcPWqnY-Ea0qv4Vd7=yMOk+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABFUUZFgXooeCgKGypByzePBsHpcPWqnY-Ea0qv4Vd7=yMOk+A@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10605-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED945E5C2E
X-Rspamd-Action: no action

sun jian <sun.jian.kdev@gmail.com> wrote:
> To keep the code concise while stripping the RCU attribute, I'll use
> the typeof(*hook) * pattern

No, please leave this alone, the code is fine as-is, all sparse warnings
are due to missing annotations only.

