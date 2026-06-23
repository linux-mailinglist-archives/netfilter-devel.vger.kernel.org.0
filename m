Return-Path: <netfilter-devel+bounces-13419-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hbZBNIzvOmqDMAgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13419-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 22:41:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 630486BA135
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 22:41:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lwn.net header.s=20201203 header.b=AHeQRFYV;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13419-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13419-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lwn.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B5AA300A607
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2026 20:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43A83A6F06;
	Tue, 23 Jun 2026 20:41:35 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88F7367280;
	Tue, 23 Jun 2026 20:41:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247295; cv=none; b=QvriPlEQbh7A4tOVw5OXnsKGVImc0RtPK7DYsOUIHfbu/MHUZybTm0GjenIFPh8MVYzbqvbzXhpZkxhSN+UHyAxkqSstxfi9Mrxfe2RqsrubnG2X5erCUrs6XHjm6jh9/+883jBq4kOoStTVa/YL8Xgz7ihA3gqH0M7ygqAl+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247295; c=relaxed/simple;
	bh=TRvVLCE4WUSeDsaz0R1scaBP6Qb6DNcQEjs9LzVZSwo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mgGkpuQMXCYmuo0q+G60XEtycBF3ehtumrNW7ID3YIx+o+cwO1I6P1thY5pjQW1Jc1dPbARkXXlQmq76InYX8DyfnTYbuyPqv4hBmX9VZHsfZ7/3ZT6KgLKqRmzWmdJTFMBnXcyIZrbA8mZCrJQF/72nXginnxLXszYshfss2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AHeQRFYV; arc=none smtp.client-ip=45.79.88.28
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 130FE40E41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1782247294; bh=SR5FJlzO/zhOqtsG5QxAmkqqCAWbEuSh7STi7uLw1eY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AHeQRFYVbbL2R+ASwcQG/pkZSmI4cyJsi1YlebW+Skt0bNHeaW4ybvGYxtQFedSMb
	 wPwcLxhOvjmHmqFf/ZvIUYK8aGh/jH6Ym4++KWGK43hbbsQbG2AJK/RZij+fyV0kxZ
	 QHgr2YBvgNpZoicTAkY9JKD7jzEUWMQDtIePwAxZWBrK2q+Z0/BF/cSJTesRlxn1WS
	 pY1XekbAI7+119xHTjjDi8kBM/o4tzZO9Xs+f105NPm2fdBXmtSTpw4ZPO/KMwDvCE
	 TLrk7/6bWXhI4OQLC/t0So9OOyfroE5vvqcintj8npPmqv4v8HEJZHXxleqYKmFoIO
	 LquNsjdKv++uA==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 130FE40E41;
	Tue, 23 Jun 2026 20:41:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] kdoc: xforms_lists: handle DECLARE_PER_CPU() in kernel-doc
In-Reply-To: <20260614052452.1557987-1-rdunlap@infradead.org>
References: <20260614052452.1557987-1-rdunlap@infradead.org>
Date: Tue, 23 Jun 2026 14:41:33 -0600
Message-ID: <875x39at1e.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13419-lists,netfilter-devel=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[corbet@lwn.net,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rdunlap@infradead.org,m:linux-doc@vger.kernel.org,m:skhan@linuxfoundation.org,m:mchehab@kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[lwn.net:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,trenco.lwn.net:mid,lwn.net:dkim,lwn.net:email,lwn.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 630486BA135

Randy Dunlap <rdunlap@infradead.org> writes:

> Add support for DECLARE_PER_CPU() as a var (variable) as used in
> <linux/netfilter/x_tables.h>.
>
> Warning: include/linux/netfilter/x_tables.h:345 function parameter 'seqcount_t' not described in 'DECLARE_PER_CPU'
> Warning: include/linux/netfilter/x_tables.h:345 function parameter 'xt_recseq' not described in 'DECLARE_PER_CPU'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: netfilter-devel@vger.kernel.org
>
>  tools/lib/python/kdoc/xforms_lists.py |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linext-2026-0610.orig/tools/lib/python/kdoc/xforms_lists.py
> +++ linext-2026-0610/tools/lib/python/kdoc/xforms_lists.py
> @@ -118,6 +118,7 @@ class CTransforms:
>          (CMatch("__guarded_by"), ""),
>          (CMatch("__pt_guarded_by"), ""),
>          (CMatch("LIST_HEAD"), r"struct list_head \1"),
> +        (CMatch("DECLARE_PER_CPU"), r"\1 \2[PER_CPU]; }"),
>  
Applied, thanks.

jon

