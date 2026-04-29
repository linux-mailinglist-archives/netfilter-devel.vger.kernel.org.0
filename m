Return-Path: <netfilter-devel+bounces-12286-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM8yE9f88WmElwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12286-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 14:43:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A26494334
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 14:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D390300138E
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Apr 2026 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04F63F6610;
	Wed, 29 Apr 2026 12:42:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3663C344B
	for <netfilter-devel@vger.kernel.org>; Wed, 29 Apr 2026 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466574; cv=none; b=IH0N/ndoDVxma5vCz4IJYtoiBqnwxLFiu5hrP91p/lOxN7b82cQvWzTqTt6MI6Ka/ush9FD9IlDk6CZz0xge7WXiNRjLlI0JBBDfjXLVAVLUxAcZPv+Rt/P01bMsdBEA9ZyjzbWy8g8TJSsW4tAemReg1M0l1259lunBeXfP7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466574; c=relaxed/simple;
	bh=QXWUlBAUujBwwYzY8mt/RfL11eo4QC65A+eSuN6H4V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipIkMZpl8qxFEC1yPBIngSXzAmjwn+Cfnog/IRuJCnzpXM+kWkXjlxDNftHLDEVvGFFbHQvUru/mAj5oc6l/zjcyJ3zIVRr85INPtEr+5IgEhEaEDpu/YCGV5CuTqYtRbIApzbBtAR2hmttJve3CC5XfMNz+gAfOZ0G3mk4p6w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id F0D0B6079C; Wed, 29 Apr 2026 14:42:48 +0200 (CEST)
Date: Wed, 29 Apr 2026 14:42:43 +0200
From: Florian Westphal <fw@strlen.de>
To: Jan Engelhardt <ej@inai.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: x_tables: disable 32bit compat
 interface in user namespaces
Message-ID: <afH8w6AjlZUQK0Ja@strlen.de>
References: <20260429095949.20910-1-fw@strlen.de>
 <950150qr-9p6p-q772-9796-p5o9o06r32q0@vanv.qr>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <950150qr-9p6p-q772-9796-p5o9o06r32q0@vanv.qr>
X-Rspamd-Queue-Id: C6A26494334
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12286-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,strlen.de:mid,inai.de:email]

Jan Engelhardt <ej@inai.de> wrote:
> >This feature is required to use 32bit arp/ip/ip6/ebtables binaries on
> >64bit kernels.  I don't think there are many users left.
> 
> This breaks the setup in a Debian x32 systemd-nspawn container with 
> xtables-legacy-multi.

Thats the intent.

