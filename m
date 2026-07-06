Return-Path: <netfilter-devel+bounces-13669-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UsPaN0qyS2q9YgEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13669-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 15:48:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E17711791
	for <lists+netfilter-devel@lfdr.de>; Mon, 06 Jul 2026 15:48:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=P54UHUvT;
	dmarc=pass (policy=quarantine) header.from=h-partners.com;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13669-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13669-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5DFE33E1191
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jul 2026 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DE542464E;
	Mon,  6 Jul 2026 12:08:49 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E142424640;
	Mon,  6 Jul 2026 12:08:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783339729; cv=none; b=e0P9+LUubR8KpwdlTh8Bs0HM4MlcB3Yv4wPFhkNucQm/rzbDoi+s5kNH/TtpKG/48C7OfHsnQKPUMXZlks6Tucl+th3Zi9//cVcPNk3zWCPdY09dgr3uZAlW6Bo+JvvdaJjVhg3N4i26O30c/OHlnRcmWKOgblTrtDhCPLivNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783339729; c=relaxed/simple;
	bh=tRs3GVTaKzsZ4pdHTplCBL/FRJCM1VCYpeCmaeWDU2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=od5wuqgaoesNYbmSzJi7SUyEqOYVy5NwnabXDxR2hu5lzJ7owipS7fsXYGAvjcThFRqO2H0QkwNeuoEQ8T7sBKtFdtxYq7Ia7++1BJIQ0Id+BuLpI72ZsVzRfOy1x3u3/iZ0ORWraXQtkEuVsj/XCxbVxqzd9tAx/IPWjKG83Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=P54UHUvT; arc=none smtp.client-ip=113.46.200.223
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vC10ux4fJtQ16w2EzTd3hzZ1Dnuiiz7X0EywE4oxAms=;
	b=P54UHUvTOpJkTtH/lmfy0vUn1/WhBFUf4N2W5KI5Q/vjZFxwpf+PP4OyJlNBL9okxWu4TPgT6
	1IPJa9HGTEseaHIHEBvjZk1IxavKqPg1fuT9pQIvJKlMfZmdh9lSs3iF9RQ8+f5wY+jCV1b/i9S
	gnEs1kKLhkwbMBBfo/WEhdM=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gv2vz3HFnzmVbL;
	Mon,  6 Jul 2026 19:59:27 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 7C65D4055B;
	Mon,  6 Jul 2026 20:08:40 +0800 (CST)
Received: from [10.136.112.147] (10.136.112.147) by
 kwepemr100001.china.huawei.com (7.202.195.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 6 Jul 2026 20:08:39 +0800
Message-ID: <3620a5a9-9ced-4825-9bc4-6950be205749@h-partners.com>
Date: Mon, 6 Jul 2026 20:08:38 +0800
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] netfilter: nf_nat_masquerade: recalculate TCP TS
 offset when port is randomized
To: Florian Westphal <fw@strlen.de>
CC: Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>, "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, gaoxingwang <gaoxingwang1@huawei.com>, huyizhen
	<huyizhen2@huawei.com>, <netfilter-devel@vger.kernel.org>,
	<coreteam@netfilter.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260629093408.3927103-1-xietangxin@h-partners.com>
 <akKN4cywAsFRdefX@strlen.de>
 <0ad60f06-387e-49bc-9e26-3dcebf182cb4@h-partners.com>
 <akUhid7_3iHovivd@strlen.de>
Content-Language: en-US
From: xietangxin <xietangxin@h-partners.com>
In-Reply-To: <akUhid7_3iHovivd@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemr100001.china.huawei.com (7.202.195.168)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[h-partners.com,quarantine];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13669-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:gaoxingwang1@huawei.com,m:huyizhen2@huawei.com,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[xietangxin@h-partners.com,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[h-partners.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:from_mime,h-partners.com:email,h-partners.com:mid,h-partners.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68E17711791



On 7/1/2026 10:17 PM, Florian Westphal wrote:
> xietangxin <xietangxin@h-partners.com> wrote:
>> Shifting the helper down to nf_nat_l4proto_unique_tuple() as you suggested
>> encounters a structural roadblock. we don't have access to the skb there.
>> Adding skb to all intermediate callers (like nf_nat_setup_info, get_unique_tuple)
>> would severely pollute the core NAT APIs.
> 
> Right, propagating the skb is too much code churn.
> 
>> would it be acceptable to place this logic in nf_nat_inet_fn() before do_nat?
>>
>>  963 do_nat:
>>              ..here
> 
> This is hit for every packet, not just the first one after
> nf_nat_setup_info().  I suggest a slightly earlier spot in the
> same function.
> 
>  936                                 ret = e->hooks[i].hook(e->hooks[i].priv, skb,
>  937                                                        state);
>  938                                 if (ret != NF_ACCEPT)
>  939                                         return ret;
>  940                                 if (nf_nat_initialized(ct, maniptype))
>  941                                         goto do_nat;
>  942                         }
>  943 null_bind:
>  944                         ret = nf_nat_alloc_null_binding(ct, state->hook);
>  945                         if (ret != NF_ACCEPT)
>  946                                 return ret;
> 
>  .... Here.
> 
>  947                 } else {
> 
> This spot runs only for new connections, right after a nf_nat_setup_info() call.

Hi Florian,

Thanks for your guidance. I’ve successfully fix the helper location
as you suggested, and it works fine for local traffic.

However, I realized that I had completely overlooked the forwarding scenario
(where SNAT acts as a middlebox gateway, e.g. Host A -> Gateway B -> Server C).
In this gateway scenario, when random-fully is enabled, the test results show
a massive performance degradation: the QPS drops from ~19000 down to ~10000.

Since skb->sk is NULL on the forwarding gateway, my current approach of
updating tp->tsoffset in struct tcp_sock cannot be applied here.
To be honest, I am currently stuck on how to handle this forwarding scenario
within the netfilter architecture without adding redundant overhead to the fast path.

Could you please give some advice on how the community would prefer to resolve this?
For instance, should we look into extending the Conntrack NAT extension to
track and adjust the TCP timestamps?

Any suggestions would be highly appreciated!

-- 
Best regards,
Tangxin Xie


