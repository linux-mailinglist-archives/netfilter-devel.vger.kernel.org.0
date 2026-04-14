Return-Path: <netfilter-devel+bounces-11878-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OA/Niou3mnxogkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11878-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 14:08:10 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7D43F9CA8
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 14:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C2AC302171C
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Apr 2026 12:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DB13E5597;
	Tue, 14 Apr 2026 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHnPXdgh"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313D03E5ECB
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Apr 2026 12:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168065; cv=none; b=FsXljagQZ//AwONxWBcJPBsa0f+K3IpKsxUW6h/byvm9wc8sHDfWPTOjcea2Kb2heHJWAYNLYMYSv8ooAR1iDyMgK3XPAZLdjIeRGsL4DCBa+Jd7fyWlowLWDG4b/t6LpYUqVHDxSfteL4U7NK9Vxq9A0RVP743xbqntQt4HARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168065; c=relaxed/simple;
	bh=HXU24dwSM6A1AxV04g/pB5XxRZxXiy1LoONcd+loM3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bH5TIeL7RmQ/AW8UGf9LO/A6vtwKEEOL3T0BhtTSBecZdm20nKxe14lESCv08SJUoJXn344xr+iMVUrt32FTb3Wa7FD+ujXjPOXFDyMY/SlD8ARGUZ+7zkPDQhkwSxfIhrZxRTlSAj7R7MYSySwFnImCv+afCITPVsXZ9RUcAUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHnPXdgh; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6708cc2d6f6so6086186a12.0
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Apr 2026 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776168060; x=1776772860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2d7SDP4tYVNHF5RjK6Z4XWLo0StG4PwjgZJsw7TAjok=;
        b=iHnPXdghhNhZxQbXGPpMQAy/WghyKP2lAqDKIiIHKVP2ztJFDYMq53D48MDqEdRDO7
         6ViTDklUvBoUzzELRjXzMFeGMW8aH2tAUofR8+0D2flzvi0k0sDcF21Jla/JfFWLMGtC
         N19iii2ppBH+JXZsnOC1V/mfn/ZV0kgJPE0lBmm9z1tbJDqzqZ8DCML/yT1YGNrfYDpj
         cXQbZx8uP+MydG2v+QhdZ0+p3ACbAJcEwok93FL5OHndXiDkxBE9dzLDMbjzE46wgv2J
         anz+RbGttUpBQ21ZTv3zNiRyhk5CMV1NfSOpV8Hka03hd+MF61Kg1gT5bqQItvRRFtRv
         2MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168060; x=1776772860;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2d7SDP4tYVNHF5RjK6Z4XWLo0StG4PwjgZJsw7TAjok=;
        b=Yo75DiTvKvHd9GYmi8qT+TTZCaNWlpNdJzdZLBfytg3BIDFVbkqUFs+X+S30V5gSlB
         +Eo6XhzS+q08zuk5uWupKucR7PNQaJOdh3jvjsudy0/jyhW910LoVUHrW0iWwWqqE/yO
         tLMmZmV5nkJI80rLGaOOO3kzycZZWK1T1+o2TsMTGQAqv3J6jx7ubeMc+0Lnud+kqf7h
         KcNGayBoy+Ymq7FJqd8p7PafS67ZHAb9WY1zcPd0lR/+SBNUgUqqorjRDwZoJqMRmk76
         3GfTUwXsj+2TwcwTtKGog1GIOONX2fiGPoHFCTivJzljApIuMfNqYDs1ITYHv0VWlq9N
         QOeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+8M9n42kthP9fm5gz+FdlQIRyc7LmmFYKk4/tLUS+EPcHE9jUI7FiYimVwK4DqPSgGHzqZnc3HfRSfbtp9bAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylsvgbgjO2z2/kDg4GR7i37ftHPA6djpx0rnRhXWKjjmAouK97
	9tItIScpQEhQlJGmT+hZgAaUHJ3IK96FH5kafsFxOHcYZlTk5Yqsq0vp
X-Gm-Gg: AeBDiesT3Rowcmx9eYxbB+csuvANO1/dHL8vbqXigmO+o7MDQU4Pn5AKszTD2KOsRKO
	qjMUi25bQQWLjFxf3Rzjgp3uW/BISBZ4RsOjmua8ZKAYFgjMLHPyQ0aT5nKXgsxEjidB6jHYngs
	q5KjuSoIMT6LJhu4ndxMX1WAZZDE0sV/rTGFMbmImo9fQIRiuEwYFYPqC244NvlraQ4qteFP/eq
	fnSPCfkGHE0XqfbMHqk52BSjHP3tcWMnyDY9EXCXFRmu/WxSsgFs9vTVzA1GoPtsBPkyS2b+zwR
	58rAPBGVPxczflZYJPiHZL4xVTeoS2W/jDCn2rHcbO1BHmVSnHwbLrXbdlKckWMMxIO49PlfZfC
	J52iS7E2lAg4mS2udcM6fxz05lonhSMuzF/DeTY2DBHQDI0EKdwIUM0eEGn1tgOEroHHv64xaeU
	CHZ8lyJeivfDjP7rb2rjPfPnkpbRS/m9FA1bnl/Kv3XnZMBM6y/Ts8RRXu8EkzSRaKMBqifrUug
	BXkOUqDIBD5A7Z680QctXWOuENcAlvzZJHe6bclOWWsI0ZvO4AKrCjEW5e5qOPO6k/ZXinC59o9
	NmS7xjIZRZGOgW8wfhlQW8tOc8XOXCdA2w==
X-Received: by 2002:a05:6402:1cc5:b0:66d:d0c1:f87b with SMTP id 4fb4d7f45d1cf-67079508c00mr8427873a12.10.1776168059477;
        Tue, 14 Apr 2026 05:00:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-671a15577f9sm967915a12.17.2026.04.14.05.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 05:00:59 -0700 (PDT)
Message-ID: <0f0f217e-a32b-4c9a-ab65-1cac5c86c76f@gmail.com>
Date: Tue, 14 Apr 2026 14:00:57 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 nf] netfilter: nf_flow_table_ip: Introduce
 nf_flow_vlan_push()
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260414112120.248744-1-ericwouds@gmail.com>
 <ad4nQzsbeF1S53zt@chamomile>
From: Eric Woudstra <ericwouds@gmail.com>
Content-Language: en-US
In-Reply-To: <ad4nQzsbeF1S53zt@chamomile>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-11878-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B7D43F9CA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/14/26 1:38 PM, Pablo Neira Ayuso wrote:
> On Tue, Apr 14, 2026 at 01:21:20PM +0200, Eric Woudstra wrote:
>> Calling skb_reset_mac_header() before calling skb_vlan_push() does
>> remove the error:
>>
>> "skb_vlan_push got skb with skb->data not at mac header (offset 18)"
>>
>> But the inner vlan tag is still not inserted correctly.
>>
>> skb_vlan_push() uses __vlan_insert_inner_tag() to insert the tag
>> at offset ETH_HLEN. But the inner tag should only be pushed, without
>> offset, similar to nf_flow_pppoe_push().
> 
> It is doubled-tagged-vlan that is broken, right? I observed this once
> but I have been burdened into a few things.

That is correct, both q-in-q and q-in-ad (that may not be the correct
terms, but I think it is clear).

>> Fixes: c653d5a78f34 ("netfilter: flowtable: inline vlan encapsulation in xmit path")
>> Fixes: a3aca98aec9a ("netfilter: nf_flow_table_ip: reset mac header before vlan push")
>> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
>>
>> ---
>>
>>  net/netfilter/nf_flow_table_ip.c | 25 ++++++++++++++++++++++---
>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
>> index fd56d663cb5b..0086f8a1a0d6 100644
>> --- a/net/netfilter/nf_flow_table_ip.c
>> +++ b/net/netfilter/nf_flow_table_ip.c
>> @@ -544,6 +544,26 @@ static int nf_flow_offload_forward(struct nf_flowtable_ctx *ctx,
>>  	return 1;
>>  }
>>  
>> +static int nf_flow_vlan_push(struct sk_buff *skb, __be16 proto, u16 id)
>> +{
>> +	if (skb_vlan_tag_present(skb)) {
>> +		struct vlan_hdr *vhdr;
>> +
>> +		if (skb_cow_head(skb, VLAN_HLEN))
>> +			return -1;
>> +
>> +		__skb_push(skb, VLAN_HLEN);
>> +		skb_reset_network_header(skb);
>> +		vhdr = (struct vlan_hdr *)(skb->data);
>> +		vhdr->h_vlan_TCI = htons(id);
>> +		vhdr->h_vlan_encapsulated_proto = skb->protocol;
>> +		skb->protocol = proto;
>> +	} else {
>> +		__vlan_hwaccel_put_tag(skb, proto, id);
>> +	}
>> +	return 0;
>> +}
>> +
>>  static int nf_flow_pppoe_push(struct sk_buff *skb, u16 id)
>>  {
>>  	int data_len = skb->len + sizeof(__be16);
>> @@ -738,9 +758,8 @@ static int nf_flow_encap_push(struct sk_buff *skb,
>>  		switch (tuple->encap[i].proto) {
>>  		case htons(ETH_P_8021Q):
>>  		case htons(ETH_P_8021AD):
>> -			skb_reset_mac_header(skb);
>> -			if (skb_vlan_push(skb, tuple->encap[i].proto,
>> -					  tuple->encap[i].id) < 0)
>> +			if (nf_flow_vlan_push(skb, tuple->encap[i].proto,
>> +					      tuple->encap[i].id) < 0)
>>  				return -1;
>>  			break;
>>  		case htons(ETH_P_PPP_SES):
>> -- 
>> 2.53.0
>>


