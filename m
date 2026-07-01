Return-Path: <netfilter-devel+bounces-13574-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ftAvC1wkRWr47goAu9opvQ
	(envelope-from <netfilter-devel+bounces-13574-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 16:29:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 349686EEC28
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 16:29:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=nQHwP43j;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13574-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13574-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=h-partners.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19DCA3086839
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2026 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DF23081D6;
	Wed,  1 Jul 2026 14:11:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E9C2D97B5;
	Wed,  1 Jul 2026 14:11:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915104; cv=none; b=E2Amy6bpic58u+f3WavTDjyvgTSbIySaeVrETzmR5C4c4kUlQjYh19pvD3eFHo5KGtICvkei2j0h0H8EoqvMMdIeddCa4qrYkfnz66Qf474uN9WNf0ToAlNaehi2Y4RUHaJSZmSTd7TCmh6HjOKNfCTcXPIgcY69Bpef2FqECGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915104; c=relaxed/simple;
	bh=lytu4ePoZplkPP5X7jseREfSLpRPM/gW1fiky22Fzo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UHotOJoGzcbvipWv2FtoPVUY4DNcUNARy1N6QHixY8gfINulpvNH00ccpD2L2kZjvhPkOtfQOSYcGiB7Ll0OxyfusV9TUzr65PfjLxPBHcBd58g8EbX6hTsMEDGO1B456yoQnh9u75E2jcEhdC+Q3ID80z83MwxUKXAiaMAwy8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=nQHwP43j; arc=none smtp.client-ip=113.46.200.219
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=M6YMtlcTZfab2BdWyyC+R0AkMQZ+GO0jT1y4jHUR+dw=;
	b=nQHwP43jtBYMT6KRXPWWpI2361VDqHZhYw4pbFLK9ci6qmSdnWH9lDlhCOI9Ao3VgCkWRf3Es
	T6KhLfHB7hhg3HBbUtCC7YP7tdpu95gCARQKW0mqriYrCcEo09cjqQ0h9GxQwSqXFaGgmDkZHJR
	lQtAdQ73p6XhqaNTcgvw7fw=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gr1t44C3Tz1prKJ;
	Wed,  1 Jul 2026 22:02:20 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 60A954057F;
	Wed,  1 Jul 2026 22:11:32 +0800 (CST)
Received: from [10.136.112.147] (10.136.112.147) by
 kwepemr100001.china.huawei.com (7.202.195.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 1 Jul 2026 22:11:31 +0800
Message-ID: <b03bf7b7-c6d2-4063-9926-7b38eab6d45b@h-partners.com>
Date: Wed, 1 Jul 2026 22:11:29 +0800
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netfilter: nf_nat_masquerade: recalculate TCP TS
 offset when port is randomized
To: Jiayuan Chen <jiayuan.chen@linux.dev>, Pablo Neira Ayuso
	<pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter
	<phil@nwl.cc>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: gaoxingwang <gaoxingwang1@huawei.com>, huyizhen <huyizhen2@huawei.com>,
	<netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20260629093408.3927103-1-xietangxin@h-partners.com>
 <1813a806-9250-492a-981d-07eb7f597f68@linux.dev>
Content-Language: en-US
From: xietangxin <xietangxin@h-partners.com>
In-Reply-To: <1813a806-9250-492a-981d-07eb7f597f68@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100001.china.huawei.com (7.202.195.168)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[h-partners.com,quarantine];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13574-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:gaoxingwang1@huawei.com,m:huyizhen2@huawei.com,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[xietangxin@h-partners.com,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[h-partners.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xietangxin@h-partners.com,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,h-partners.com:dkim,h-partners.com:email,h-partners.com:mid,h-partners.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 349686EEC28



On 7/1/2026 9:44 AM, Jiayuan Chen wrote:
> 
> On 6/29/26 5:34 PM, xietangxin wrote:
>> Problem observed in Kubernetes environments where MASQUERADE target with
>> --random-fully is configured by default. after commit
>> 165573e41f2f ("tcp: secure_seq: add back ports to TS offset") TCP short
>> connection QPS dropped from ~20000 to ~10000. This added source and
>> destination ports into TS offset calculation.
>>
>> However, with MASQUERADE --random-fully, when multiple internal connections
>> (e.g sport 10000,20000) are mapped to the same external port (e.g 30000),
>> their TS offsets are calculated as ts_offset(10000) and ts_offset(20000).
>> If the server reuses the TIME_WAIT slot from the first connection, there is
>> a chance that ts_offset(20000) < ts_offset(10000), breaking TSval
>> monotonicity for the same 4-tuple and causing RST packets:
>>    Client -> Server 24870 -> 80 [SYN] TSval=2294041168
>>    Server -> Client 80 -> 24870 [ACK] TSecr=2846236456
>>    Client -> Server 24870 -> 80 [RST] Seq=855605690
>>
>> After nf_nat_setup_info() successfully assigns a new randomized
>> source port, recalculate the TS offset using the new port and
>> update the SYN packet's TSval accordingly.
>>
>> Test results on 4U4G VM with
>> `./wrk -t8 -c200 -H "Connection: close" -d10s --latency http://5.5.5.5:80`
>> Before:
>>    random:10712 req/s, random-fully:10986 req/s
>> After:
>>    random:21463 req/s, random-fully:19181 req/s
>>
>> Fixes: 165573e41f2f ("tcp: secure_seq: add back ports to TS offset")
>> Cc: stable@vger.kernel.org
> 
> 
> I'd treat it as a feature not a fix.

I prefer it as a bugfix, because after commit
165573e41f2f ("tcp: secure_seq: add back ports to TS offset") TCP short
connection QPS dropped from ~20000 to ~10000 with MASQUERADE --random-fully,

> 
> 
>> Closes:https://lore.kernel.org/all/92935c00-e0be-4591-ac44-5978c7804d57@yeah.net/
>> Signed-off-by: xietangxin <xietangxin@h-partners.com>
>> ---
>>   net/netfilter/nf_nat_masquerade.c | 91 ++++++++++++++++++++++++++++++-
>>   1 file changed, 89 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/netfilter/nf_nat_masquerade.c b/net/netfilter/nf_nat_masquerade.c
>> index 4de6e0a51701..8c9ca5a051cc 100644
>> --- a/net/netfilter/nf_nat_masquerade.c
>> +++ b/net/netfilter/nf_nat_masquerade.c
>> @@ -6,8 +6,11 @@
>>   #include <linux/netfilter.h>
>>   #include <linux/netfilter_ipv4.h>
>>   #include <linux/netfilter_ipv6.h>
>> +#include <linux/tcp.h>
>>   +#include <net/tcp.h>
>>   #include <net/netfilter/nf_nat_masquerade.h>
>> +#include <net/secure_seq.h>
>>     struct masq_dev_work {
>>       struct work_struct work;
>> @@ -24,6 +27,76 @@ static DEFINE_MUTEX(masq_mutex);
>>   static unsigned int masq_refcnt __read_mostly;
>>   static atomic_t masq_worker_count __read_mostly;
>>   +static __be32 *tcp_ts_option_ptr(const struct sk_buff *skb)
>> +{
>> +    const struct tcphdr *th;
>> +    unsigned char *ptr;
>> +    unsigned char opsize;
>> +    unsigned int optlen, offset;
>> +
>> +    th = tcp_hdr(skb);
>> +    optlen = (th->doff - 5) * 4;
>> +    ptr = (unsigned char *)(th + 1);
>> +    offset = 0;
>> +
>> +    while (offset < optlen) {
>> +        unsigned char opcode = ptr[offset];
>> +
>> +        if (opcode == TCPOPT_EOL)
>> +            break;
>> +        if (opcode == TCPOPT_NOP) {
>> +            offset++;
>> +            continue;
>> +        }
>> +
>> +        if (offset + 1 >= optlen)
>> +            break;
>> +
>> +        opsize = ptr[offset + 1];
>> +        if (opsize < 2 || offset + opsize > optlen)
>> +            break;
>> +
>> +        if (opcode == TCPOPT_TIMESTAMP && opsize == TCPOLEN_TIMESTAMP)
>> +            return (__be32 *)(ptr + offset + 2);
>> +
>> +        offset += opsize;
>> +    }
>> +
>> +    return NULL;
>> +}
>> +
>> +static void masquerade_update_tcp_ts_offset(struct nf_conn *ct, struct sk_buff *skb)
>> +{
>> +    __be32 *tsptr;
>> +    struct net *net;
>> +    struct tcphdr *th;
>> +    struct tcp_sock *tp;
>> +    union tcp_seq_and_ts_off st;
>> +    struct nf_conntrack_tuple *tuple;
>> +
>> +    th = tcp_hdr(skb);
>> +    net = nf_ct_net(ct);
>> +    tuple = &ct->tuplehash[IP_CT_DIR_REPLY].tuple;
>> +
> 
> why use reply not original, or do I miss something ?
> 
> 

We use IP_CT_DIR_REPLY here because we need the post-NAT (translated)
4-tuple to correctly recalculate the new ts_offset

Best regards,
Tangxin Xie


