Return-Path: <netfilter-devel+bounces-13332-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 00dUL2FWNGr+VAYAu9opvQ
	(envelope-from <netfilter-devel+bounces-13332-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 22:34:41 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 364E66A2903
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 22:34:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Uf3hlGAL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dxzvTx5i;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Uf3hlGAL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dxzvTx5i;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13332-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13332-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44FAE3021EBE
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jun 2026 20:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D842E737B;
	Thu, 18 Jun 2026 20:32:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9DC279DAD
	for <netfilter-devel@vger.kernel.org>; Thu, 18 Jun 2026 20:32:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781814763; cv=none; b=l1NjN2I1NfRiWM2faolIL9ytpJbzs00G/xSHJpqpUCKFIVS1DMdPJD9jME0w/0bT5Va2l1W58iFqGVc+ytyoSMPcc+hl+IpBgKG+cNsE5DYwORoVsNyEB92NsAatr6x6S2fEu8vUeUR2yJ19Lx0dyHb8AcLaP0knZPEtFAFgGJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781814763; c=relaxed/simple;
	bh=ewn19MGD+iBv6aBRlymeRy5oD9qwFmnVCisiUjEt6rM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xcb0g8nZeVHmOwktGS9wp00KIvWiUTQbVFdNP8WouNUOIKj46oNkxL8C12clRcGuzY5DmgLdU/m+uL1MOZwg6JczYv3W/ZFxPiWMuuERbjQmwz2Hge8PWTa8wDKAJu6OCNvf3YeLoKOC/8X8b5JKHpq7d4POSSGD4MCxgbU2mus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uf3hlGAL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dxzvTx5i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Uf3hlGAL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dxzvTx5i; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F1476D6C6;
	Thu, 18 Jun 2026 20:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781814760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dW9mtLrYPzjxAj3Wtyt2JABnroMHrRwB7k58oKmX0sc=;
	b=Uf3hlGALCViJURRkW4BMnGSE1YqTgz6nnuoGACasUn+wjBOJx4u5JP8MspU4oQspeq5Qy6
	PXP7gGWL86vjrnldBOJPPCUBqdzAuSRX7Pmdy9s3hwI4KaAAmDKinDuiXUapL1H99NEhMp
	85j+EWTifwtdLvuL+bbqhw4FSRIyCNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781814760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dW9mtLrYPzjxAj3Wtyt2JABnroMHrRwB7k58oKmX0sc=;
	b=dxzvTx5iXdo/EJ8j18W9n1sjkRLaESbptcgv/F8ePpCEQqhqtGfIVkMGsd5sB7GwN9GyIx
	O+KkO1U4FKmRAoDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781814760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dW9mtLrYPzjxAj3Wtyt2JABnroMHrRwB7k58oKmX0sc=;
	b=Uf3hlGALCViJURRkW4BMnGSE1YqTgz6nnuoGACasUn+wjBOJx4u5JP8MspU4oQspeq5Qy6
	PXP7gGWL86vjrnldBOJPPCUBqdzAuSRX7Pmdy9s3hwI4KaAAmDKinDuiXUapL1H99NEhMp
	85j+EWTifwtdLvuL+bbqhw4FSRIyCNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781814760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dW9mtLrYPzjxAj3Wtyt2JABnroMHrRwB7k58oKmX0sc=;
	b=dxzvTx5iXdo/EJ8j18W9n1sjkRLaESbptcgv/F8ePpCEQqhqtGfIVkMGsd5sB7GwN9GyIx
	O+KkO1U4FKmRAoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A2EA779A8;
	Thu, 18 Jun 2026 20:32:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BXYoB+hVNGoVewAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 18 Jun 2026 20:32:40 +0000
Message-ID: <621fb6a0-ff4c-47bf-9416-f188e1ca3e8a@suse.de>
Date: Thu, 18 Jun 2026 22:32:30 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9 nf-next] netfilter: conntrack: use
 DEBUG_NET_WARN_ON_ONCE on packet paths
To: Florian Westphal <fw@strlen.de>, Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org, phil@nwl.cc
References: <20260601193049.8131-1-fmancera@suse.de>
 <20260601193049.8131-5-fmancera@suse.de> <ajQmsQsCbwJb5P7W@chamomile>
 <ajQrwgb0GkKG-utR@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <ajQrwgb0GkKG-utR@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13332-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:phil@nwl.cc,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 364E66A2903

On 6/18/26 7:32 PM, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>>> diff --git a/net/netfilter/nf_conntrack_proto_icmp.c b/net/netfilter/nf_conntrack_proto_icmp.c
>>> index 32148a3a8509..0f39cb147c4f 100644
>>> --- a/net/netfilter/nf_conntrack_proto_icmp.c
>>> +++ b/net/netfilter/nf_conntrack_proto_icmp.c
>>> @@ -117,7 +117,8 @@ int nf_conntrack_inet_error(struct nf_conn *tmpl, struct sk_buff *skb,
>>>   	enum ip_conntrack_dir dir;
>>>   	struct nf_conn *ct;
>>>   
>>> -	WARN_ON(skb_nfct(skb));
>>> +	if (unlikely(skb_nfct(skb)))
>>> +		DEBUG_NET_WARN_ON_ONCE(1);
> 
> Should be
> DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb)));
> ?
> 

It makes sense, nice catch. Thanks!

>> nf_conntrack_in
>>   [ reset skb->nfct ]
>>   nf_conntrack_handle_icmp
>>    nf_conntrack_icmpv4_error
>>     nf_conntrack_inet_error
>>
>> There is nf_conntrack_inet_error() which performs the ct lookup.
>> There is resolve_normal_ct() too, but these two are coming later.
>>
>> [ ... snippet that resets skb->nfct ... ]
>> unsigned int
>> nf_conntrack_in(struct sk_buff *skb, const struct nf_hook_state *state)
>> {
>>          enum ip_conntrack_info ctinfo;
>>          struct nf_conn *ct, *tmpl;
>>          u_int8_t protonum;
>>          int dataoff, ret;
>>   
>>          tmpl = nf_ct_get(skb, &ctinfo);
>>          if (tmpl || ctinfo == IP_CT_UNTRACKED) {
>>                  /* Previously seen (loopback or untracked)?  Ignore. */
>>                  if ((tmpl && !nf_ct_is_template(tmpl)) ||
>>                       ctinfo == IP_CT_UNTRACKED)
>>                          return NF_ACCEPT;
>>                  skb->_nfct = 0; <---------  this is reset here.
>>          }
>> [ end of snippet ]
>>
>> I don't remember to have seen this WARN_ON, so remove it.
> 
> I would keep the DEBUG_NET_WARN_ON_ONCE(), else this gives a
> refcount leak.
> 
> Or, move it closer to the end:
> 
> 191         /* Update skb to refer to this connection */
> 	HERE.
> 192         nf_ct_set(skb, ct, ctinfo);
> 193         return NF_ACCEPT;
> 194 }
> 

As Pablo agreed too, let's keep it where it is. Thank you!

