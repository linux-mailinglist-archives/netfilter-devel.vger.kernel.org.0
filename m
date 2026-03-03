Return-Path: <netfilter-devel+bounces-10923-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPiYN2/ypmkzawAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10923-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Mar 2026 15:38:39 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4211F1A1A
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Mar 2026 15:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46D28305CABB
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Mar 2026 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA194301C9;
	Tue,  3 Mar 2026 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pnYZdilU"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EB120459A;
	Tue,  3 Mar 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548398; cv=none; b=PohAlt6dOjxQIU8vCyv9/6HbHLyL2fCJQ66rK3F7nIFllFodUMDtD3upNRkLlhVJBBWk6Fzjx0GOyMtpePNH+tLJQIAH5jFFyn7Wh6Cztt89LxskAc8AktSfP/6v8GHtPwmp3RNGCZ0p9tOgUWs/qp63Kyt9ZeTQNXCwI3dqdKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548398; c=relaxed/simple;
	bh=PjWyDSd5WomT81wByfr6IDXbpi/XzD1CgaiR0aNlW7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=alebMjNwD4w6oQMOw8ONAKta9eZBFCfZCc676O7lnycIyImzOiNDpPjKzGGxaef+PPYRelGCRcwwuqcASJDBTo6saRtnLhbjvOmMop3lEZ4zAeQD9RpkGWWJpkWfsR/n//SBA5EGTYhwadfaSKDF9elN3yVphO/HULHAhp7NUK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pnYZdilU; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CUQAAVECoBJi0Kov1oaEaou0IrJG+pWBgq47m69jWOc=; b=pnYZdilUNkk2nna/V/4oLWzEq7
	XewgrN54GhFjueQ2vnc51G/QbZ/vnmr4egV/lMWTk8JPaHnwJPz7Y0n8Z1jDNuZCJIXLSJTtMFZ01
	X/n8yK6xjeBF6j5CVpqYK+CHcsaBzbklgpokTwe569Tj5f6cNhJNc2u1GbZlJezf5DzHKx6s3dYkP
	BSy5ML8WoIzQCwiMGgX8HI+P0K1JoERHE68WFkgns8pQaNjGejEw59LjQ01fbXPemuqgEga+YPBNq
	QumQWb07J5GVO3bAK9uSnRg+ifD/Ww0TjIH3Detv0da/1r3y1i45kFw15Ozgju+mCvQ0VXbpXxftH
	vGjrcVPg==;
Received: from [179.221.50.217] (helo=[192.168.0.108])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vxQoB-008USJ-20; Tue, 03 Mar 2026 15:33:11 +0100
Message-ID: <17499d82-ad03-44a9-ab3a-429d2ebea02f@igalia.com>
Date: Tue, 3 Mar 2026 11:33:04 -0300
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfilter: nf_tables: fix use-after-free on ops->dev
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: fw@strlen.de, phil@nwl.cc, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
References: <20260302212605.689909-1-koike@igalia.com>
 <aaYYiPTO5JYOlhhY@chamomile>
Content-Language: en-US
From: Helen Koike <koike@igalia.com>
In-Reply-To: <aaYYiPTO5JYOlhhY@chamomile>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2C4211F1A1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TAGGED_FROM(0.00)[bounces-10923-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[koike@igalia.com,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.961];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hi Pablo,

Thanks for your quick reply, please see my comments below.

On 3/2/26 8:08 PM, Pablo Neira Ayuso wrote:
> On Mon, Mar 02, 2026 at 06:26:05PM -0300, Helen Koike wrote:
>> struct nf_hook_ops has a pointer to dev, which can be used by
>> __nf_unregister_net_hook() after it has been freed by tun_chr_close().
>>
>> Fix it  by calling dev_hold() when saving dev to ops struct.
> 
> Sorry, I don't think this patch works, dev_hold()/dev_put() use
> per_cpu area.

In my understanding, being a percpu_ref shouldn't affect the behavior, 
since after a percpu_ref_kill() it switches to the usual mode with 
shared atomic_t counter.

But if I understood correctly from your comment below, the proper 
solution would be to fix the order that the hooks are released, is my 
understanding correct?

> 
> The nf_tables_flowtable_event() function used to release the hook, but
> now things have changed since there is auto-hook registration.

I'll investigate this further. Thanks a lot for the pointer (and sorry 
for the noise).

Regards,
Helen

> 
>> Reported-by: syzbot+bb9127e278fa198e110c@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=bb9127e278fa198e110c
>> Signed-off-by: Helen Koike <koike@igalia.com>
>> ---
>>   net/netfilter/nf_tables_api.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
>> index fd7f7e4e2a43..00b5f900a51d 100644
>> --- a/net/netfilter/nf_tables_api.c
>> +++ b/net/netfilter/nf_tables_api.c
>> @@ -352,6 +352,7 @@ static void nft_netdev_hook_free_ops(struct nft_hook *hook)
>>   
>>   	list_for_each_entry_safe(ops, next, &hook->ops_list, list) {
>>   		list_del(&ops->list);
>> +		dev_put(ops->dev);
>>   		kfree(ops);
>>   	}
>>   }
>> @@ -2374,6 +2375,7 @@ static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
>>   			err = -ENOMEM;
>>   			goto err_hook_free;
>>   		}
>> +		dev_hold(dev);
>>   		ops->dev = dev;
>>   		list_add_tail(&ops->list, &hook->ops_list);
>>   	}
>> -- 
>> 2.53.0
>>


