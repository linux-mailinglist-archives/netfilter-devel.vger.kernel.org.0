Return-Path: <netfilter-devel+bounces-13848-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aHjONszUUWqjJQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13848-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 07:29:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52121740628
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 07:29:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=P9lB8qwl;
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13848-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13848-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4CAF30180B6
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2026 05:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EFE2EB859;
	Sat, 11 Jul 2026 05:29:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC9495E5
	for <netfilter-devel@vger.kernel.org>; Sat, 11 Jul 2026 05:29:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783747785; cv=none; b=kHdU7maiv3yHWKYeSGfbzjVrV8sxUFAKo/O1W6F+Gp5jxy0SQpsr1VqQKlW/gAN/Ig8Ova0rL1/VLEsCCaAksIocLeb7cgswK6FDR0ggE4MlhaTjL63Yi6WgjcBmLB8Kln/wYwrD58pekVhvo9VBuEViIcezrJa8KnEzbMPtgTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783747785; c=relaxed/simple;
	bh=yNeYlElKxqKHfm1D6vscwfvY7ckoOapW3juQCYhfHq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1QF5kY8TT5/fPmyP9m9j6mwzf1DWMYvTYYfNytEACSd1W4tOHrZWSBo0/IKV1r+UEUr0IptJlwuHLrEwWjAfIsj82AXAvRTG4kXeYzk+MBfpxCXHqmjDG97ZhHuecgkGV0GyA8Crr25B+Iu7ouA4jl0Hhzmrb2Ln6VWvFh2sZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P9lB8qwl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D961F000E9;
	Sat, 11 Jul 2026 05:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783747784;
	bh=yNeYlElKxqKHfm1D6vscwfvY7ckoOapW3juQCYhfHq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P9lB8qwlT+ERGA+68PyiQVsZDW4fwkNKZ1zkPdOBJ8H60p+QUDFzXZkIo+SZGMqea
	 gqVjfVa2hntDtj43qMlAHd6Rfwu6+Hk3Y+XqexdnPm39jlklCady33ysxloAZzFuwD
	 XkC8uLjzXuZSf+UvCavUz2mNQzHaDK69kNPTQqA4=
Date: Sat, 11 Jul 2026 07:29:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jaeyeong Lee <iostreampy@proton.me>
Cc: "pablo@netfilter.org" <pablo@netfilter.org>,
	"fw@strlen.de" <fw@strlen.de>, "phil@nwl.cc" <phil@nwl.cc>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"security@kernel.org" <security@kernel.org>
Subject: Re: netfilter: nf_nat_sip expectation UAF permits local privilege
 escalation
Message-ID: <2026071134-turkey-detonator-0d87@gregkh>
References: <aQrSf6maL27cH2V4V9ELFdSqdtCWQ-B5iZr8fjR2Wz7zAJ7L32oW50bdrePoTMnJ4CRjDrns-jNMNFHGWNUxYe3UcV91AK99Ilncjab2uDk=@proton.me>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQrSf6maL27cH2V4V9ELFdSqdtCWQ-B5iZr8fjR2Wz7zAJ7L32oW50bdrePoTMnJ4CRjDrns-jNMNFHGWNUxYe3UcV91AK99Ilncjab2uDk=@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:iostreampy@proton.me,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:netfilter-devel@vger.kernel.org,m:security@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,netfilter-devel@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13848-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:from_mime,linuxfoundation.org:dkim,vger.kernel.org:from_smtp,gregkh:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52121740628

On Fri, Jul 10, 2026 at 11:19:54PM +0000, Jaeyeong Lee wrote:
> ## Vulnerability Summary

<snip>

As you sent this to a public mailing list, there's no need for
security@kernel.org to be involved in it.

Also, please just submit a patch to resolve this issue so that it gets
fixed and you get full credit for resolving it.

thanks,

greg k-h

