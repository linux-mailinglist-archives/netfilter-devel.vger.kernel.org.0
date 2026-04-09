Return-Path: <netfilter-devel+bounces-11757-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBfEBEJ/12m7OwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-11757-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 12:28:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1D43C9285
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Apr 2026 12:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0877300B9CC
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Apr 2026 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7111139F174;
	Thu,  9 Apr 2026 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="FpmG6TVD"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837003368BA
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Apr 2026 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775730495; cv=none; b=u0UzpobN2RvfE1+P6LOmuuBWA0cAzoTNYeTb8zlyIVqxqOtVhhfQNdTxw/KYl54vYMV3SOJm8PwL4mmvkmH/DAKJE5FTjY9/YLF7lStSzKnMb3Xt+Hs1wv+gMs58SlHiSPFuuv18SOAZ1xbW6ui8qudgXjd0GYYmGGkfPmDQ8EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775730495; c=relaxed/simple;
	bh=HBpE0Qr3G9FdPjVxabBqZSm+dyf82OT76+ny3GIy2tE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=emtjcjcdCmUeq6ID/lNKVGAUXeVymiRjcuKkKugkgo9jAbFkd3DhLhgRzk3/6pZmnFWCxxVSy5wWp85HrCsbmVu+IW63Z0jEX+UWdjYI9aSh+rzF+32f6svg83FRydy9aj/9Hn36vE0pKnFMcZn2NB4f45GXiL4C4AiXSfuU9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=FpmG6TVD; arc=none smtp.client-ip=148.6.0.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp1.kfki.hu (Postfix) with ESMTP id 4frwv90cxBzGFDMN;
	Thu,  9 Apr 2026 12:21:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:message-id
	:in-reply-to:from:from:date:date:received:received:received
	:received; s=20151130; t=1775730067; x=1777544468; bh=sEXGiKqpGQ
	QuDYghIZvxIh6H4h5aPRg+dyptCQK5fd8=; b=FpmG6TVDUdHEYWvDfsGvXvBa/Q
	AC4AGSMTAXv0GXFMrHHYCpB5Y45LlpuJq/o4K5NsDLbJxXSM45vlAQuzkaFCzQZH
	9Yls8Dyhc1j5mvbMaS1BBnPUB7kpj59t7OAIbEUL4QTLXR+T8eEyEvYkKWtEGskn
	dISMnwFKXnycSB7Mo=
X-Virus-Scanned: Debian amavis at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
 by localhost (smtp1.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id YroY1A30pre3; Thu,  9 Apr 2026 12:21:07 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
	by smtp1.kfki.hu (Postfix) with ESMTP id 4frwv70HP7zGFDM8;
	Thu,  9 Apr 2026 12:21:07 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id F1A0F34316A; Thu,  9 Apr 2026 12:21:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id F02AD340D75;
	Thu,  9 Apr 2026 12:21:06 +0200 (CEST)
Date: Thu, 9 Apr 2026 12:21:06 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: Florian Westphal <fw@strlen.de>
cc: David Baum <davidbaum461@gmail.com>, netfilter-devel@vger.kernel.org, 
    kadlec@netfilter.org
Subject: Re: [PATCH] netfilter: ipset: harden payload calculation in
 call_ad()
In-Reply-To: <add5lL88z9oJqTJY@strlen.de>
Message-ID: <9d6f4d79-f645-a944-ad7c-121f8f91621f@blackhole.kfki.hu>
References: <20260313180132.75655-1-davidbaum461@gmail.com> <add5lL88z9oJqTJY@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[blackhole.kfki.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,netfilter.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11757-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@blackhole.kfki.hu,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 6D1D43C9285
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Florian,

On Thu, 9 Apr 2026, Florian Westphal wrote:

> David Baum <davidbaum461@gmail.com> wrote:
>> call_ad() computes the netlink error payload size with
>> min(SIZE_MAX, sizeof(*errmsg) + nlmsg_len(nlh)), but min(SIZE_MAX, x)
>> is always x, so the guard is a no-op.
>>
>> Replace it with an explicit negative-length check and
>> check_add_overflow() so the addition is validated before being passed
>> to nlmsg_new().
>
> Jozsef, are you ok with this patch?
> Full quote below.

Yes, the patch is fine. It seems I missed it :-(.

Acked-by: Jozsef Kadlecsik <kadlec@netfilter.org>

Best regards,
Jozsef

>> Signed-off-by: David Baum <davidbaum461@gmail.com>
>> ---
>>  net/netfilter/ipset/ip_set_core.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
>> index a2fe711cb5e3..11d3854d9b11 100644
>> --- a/net/netfilter/ipset/ip_set_core.c
>> +++ b/net/netfilter/ipset/ip_set_core.c
>> @@ -10,6 +10,7 @@
>>  #include <linux/module.h>
>>  #include <linux/moduleparam.h>
>>  #include <linux/ip.h>
>> +#include <linux/overflow.h>
>>  #include <linux/skbuff.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/rculist.h>
>> @@ -1763,13 +1764,18 @@ call_ad(struct net *net, struct sock *ctnl, struct sk_buff *skb,
>>  		struct nlmsghdr *rep, *nlh = nlmsg_hdr(skb);
>>  		struct sk_buff *skb2;
>>  		struct nlmsgerr *errmsg;
>> -		size_t payload = min(SIZE_MAX,
>> -				     sizeof(*errmsg) + nlmsg_len(nlh));
>> +		int nlmsg_payload_len = nlmsg_len(nlh);
>> +		size_t payload;
>>  		int min_len = nlmsg_total_size(sizeof(struct nfgenmsg));
>>  		struct nlattr *cda[IPSET_ATTR_CMD_MAX + 1];
>>  		struct nlattr *cmdattr;
>>  		u32 *errline;
>>
>> +		if (nlmsg_payload_len < 0 ||
>> +		    check_add_overflow(sizeof(*errmsg),
>> +				       (size_t)nlmsg_payload_len, &payload))
>> +			return -ENOMEM;
>> +
>>  		skb2 = nlmsg_new(payload, GFP_KERNEL);
>>  		if (!skb2)
>>  			return -ENOMEM;
>
>

