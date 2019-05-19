Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD594228FD
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 May 2019 23:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbfESVGL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 May 2019 17:06:11 -0400
Received: from mx1.riseup.net ([198.252.153.129]:55836 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfESVGL (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 May 2019 17:06:11 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id DB5481A02E0;
        Sun, 19 May 2019 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1558299970; bh=PhJCJ177Ypk7trwHyZvX/mBOLoPyRQ/so13vqHegqLc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UPae3iRitjHzu5g6oosFloGAZibS4krA/XAd+1aSjBR6XyElPb1RLU2yy85ep9alK
         tY2tiwQpk0cVm45Cj0oKdbXPnLD+3KsHqzXI1yRKuAy+farcLiSRefs4gbU7mSc7in
         lPZHtlBqzs8z0rcVyT72SP/LiWvCIV1faI3H+yys=
X-Riseup-User-ID: 9CB218310B1A6D4478D0180872FE4A9DA00685E61784E387904E00193F79EBD2
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 3D95C120236;
        Sun, 19 May 2019 14:06:10 -0700 (PDT)
Subject: Re: [PATCH nf-next v2 3/4] netfilter: synproxy: extract SYNPROXY
 infrastructure from {ipt,ip6t}_SYNPROXY
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
References: <20190519205259.2821-1-ffmancera@riseup.net>
 <20190519205259.2821-4-ffmancera@riseup.net>
 <20190519210038.sgd4byoow374dd7p@breakpoint.cc>
From:   Fernando Fernandez Mancera <ffmancera@riseup.net>
Openpgp: preference=signencrypt
Message-ID: <fc356493-5708-ce6f-8f0f-8c2c621a1313@riseup.net>
Date:   Sun, 19 May 2019 23:06:23 +0200
MIME-Version: 1.0
In-Reply-To: <20190519210038.sgd4byoow374dd7p@breakpoint.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Florian,

On 5/19/19 11:00 PM, Florian Westphal wrote:
> Fernando Fernandez Mancera <ffmancera@riseup.net> wrote:
>> ---
>>  include/net/netfilter/nf_synproxy.h |  76 +++
>>  net/ipv4/netfilter/ipt_SYNPROXY.c   | 394 +------------
>>  net/ipv6/netfilter/ip6t_SYNPROXY.c  | 420 +-------------
>>  net/netfilter/nf_synproxy.c         | 819 ++++++++++++++++++++++++++++
>>  4 files changed, 910 insertions(+), 799 deletions(-)
>>  create mode 100644 include/net/netfilter/nf_synproxy.h
>>  create mode 100644 net/netfilter/nf_synproxy.c
>>
>> diff --git a/include/net/netfilter/nf_synproxy.h b/include/net/netfilter/nf_synproxy.h
>> new file mode 100644
>> index 000000000000..97fb12ea5092
>> --- /dev/null
>> +++ b/include/net/netfilter/nf_synproxy.h
>> +/* Hook operations used by {ip,nf}tables SYNPROXY support */
>> +const struct nf_hook_ops ipv4_synproxy_ops[] = {
>> +	{
>> +		.hook		= ipv4_synproxy_hook,
>> +		.pf		= NFPROTO_IPV4,
>> +		.hooknum	= NF_INET_LOCAL_IN,
>> +		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
>> +	},
>> +	{
>> +		.hook		= ipv4_synproxy_hook,
>> +		.pf		= NFPROTO_IPV4,
>> +		.hooknum	= NF_INET_POST_ROUTING,
>> +		.priority	= NF_IP_PRI_CONNTRACK_CONFIRM - 1,
>> +	},
>> +};
> 
> Can this be avoided?
> 
> This should only be placed in a single .c file, not in a header.
> I also suspect this should be 'static const'.
> 
> Seems you can just move it to nf_synproxy.c, where its used.
> 

My fault, I thought it was used in ipt_SYNPROXY.c and ip6t_SYNPROXY.c.
Sorry I am going to change this in a v3 among others changes suggested
after reviews. Thanks!

>> +static const struct nf_hook_ops ipv6_synproxy_ops[] = {
> 
> likewise.
> 
