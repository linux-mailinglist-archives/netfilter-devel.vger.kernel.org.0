Return-Path: <netfilter-devel+bounces-10410-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MQaNkJZd2lneQEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10410-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jan 2026 13:08:34 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F3588033
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jan 2026 13:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 223C23005AAD
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jan 2026 12:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28EE313550;
	Mon, 26 Jan 2026 12:08:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAEC331207
	for <netfilter-devel@vger.kernel.org>; Mon, 26 Jan 2026 12:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429311; cv=none; b=IxCDYS3D834Yip1O+UJDIDgCQbPLz9QhKYspBkK2mzWEEwtFA5iUtvQ3zOdJCGOyV1IYSHIK9fSmFeRMSe03waCML4ERVaQdCdM28iOxZJ1Wn8KoyqVCP4M6R+tFZxj5RfKYgb3tB7F/g47SeRmkwpEJuFzEXlPyrKVw62nFsDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429311; c=relaxed/simple;
	bh=+opHtG6Eg7VYlzG5KZnzUI5x38ffcotbF1fKJ83Ocg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SA97RQg988+rnUfnVjCCpbG8ZvcICmi8OghAWOqofc+A29Wv7taQx9duNFLweuDFrLyBFDBWBkX89Eo0NNCPPT9NtVv2OGCvy0aAQCTVknVyg43gceCcLg8veuJ3N9DuAT2XjAsusDwX9aZbednnp6kD6z5PR2beKX9z097vis4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id ECDF26033F; Mon, 26 Jan 2026 13:08:21 +0100 (CET)
Date: Mon, 26 Jan 2026 13:08:21 +0100
From: Florian Westphal <fw@strlen.de>
To: Brian Witte <brianwitte@mailfence.com>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] datatype: fix ether address parsing of integer values
Message-ID: <aXdZNS1fL36NL5vB@strlen.de>
References: <20260126061746.368011-1-brianwitte@mailfence.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126061746.368011-1-brianwitte@mailfence.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10410-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mailfence.com:email,strlen.de:mid]
X-Rspamd-Queue-Id: 89F3588033
X-Rspamd-Action: no action

Brian Witte <brianwitte@mailfence.com> wrote:
> When parsing "ether daddr 0x64", integer_expr converts the hex value
> to decimal string "100". lladdr_type_parse then interprets this as
> hex, yielding 0x100 = 256 which exceeds the single-byte limit.

Yes, but it looks like it breaks backwards compatibility.

'ether daddr 99' is parsed as 00:00:00:00:00:99.
After your patch, its parsed as 00:00:00:00:00:63.

So I'm not sure we can fix this.

