Return-Path: <netfilter-devel+bounces-10725-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKwjChycjGmPrgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10725-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 16:11:24 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA5F125759
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 16:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948C5301875E
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 15:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B332BD5A2;
	Wed, 11 Feb 2026 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lxwyi6tY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uws9b1i5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lxwyi6tY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Uws9b1i5"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8337C1DF980
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Feb 2026 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770822666; cv=none; b=kqM0LOBQimFEkeeL/qH0y/nNRb06vxtrZy8oyCnuarh8bxb7L6Re5623XSXTvGwcOy53hsY0UUwC1GyMw0MuW8g7VJ9gkzM035Ed7NmXjqwo5qsC86qpwmIPtToXVDIsHeBRUPm3hhUrayd9fejhKjXxiyh5CNN9Z+I9FriczH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770822666; c=relaxed/simple;
	bh=E7T8iSWnqQPQvFMmnh1aLf3Mmy2m/JpVT5HtqYE+jAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iO495HrkkzoEX3+BaomnTms9VkA0702B4toTx1Itld897sxM+nAyLWwgs49Bt4UQWLbMuO9tVEVY+FfRA3cPlc+FtSIg/+/uIbU18W5jZLzXMcNw2Qbwjognm/neGH2HP1CkeuFTN+NDOwneGw9D/iY2BVTMiLgs5ncialggTyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lxwyi6tY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uws9b1i5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lxwyi6tY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Uws9b1i5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC73B5BDC6;
	Wed, 11 Feb 2026 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770822662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SwCAU52+L35MKGdsO2bzm/4m8JLQBuZzK9SKkr8/tI=;
	b=lxwyi6tY8u4aJbfgHbnbFrQvo/lPFz42VPbdyhDzu0qF/uUBfeIQ0caup6FHiTCfO3IVoa
	CtQMUu6Rlxb1RVmC4zFu03cidNwMGFKs2XMabmxB1ICUXGpS9r1ktmxch7cuqm+WuocVTu
	Mgqp0IQIatwE9k/7Kxd7out4PqDGbZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770822662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SwCAU52+L35MKGdsO2bzm/4m8JLQBuZzK9SKkr8/tI=;
	b=Uws9b1i5MxI6iEjBNVBRTN+xEeNcfIte3bFCydicrXtLegRJ23/cF3HSULmb7RwAwO2Unl
	IuT8uj73pKKU63Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770822662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SwCAU52+L35MKGdsO2bzm/4m8JLQBuZzK9SKkr8/tI=;
	b=lxwyi6tY8u4aJbfgHbnbFrQvo/lPFz42VPbdyhDzu0qF/uUBfeIQ0caup6FHiTCfO3IVoa
	CtQMUu6Rlxb1RVmC4zFu03cidNwMGFKs2XMabmxB1ICUXGpS9r1ktmxch7cuqm+WuocVTu
	Mgqp0IQIatwE9k/7Kxd7out4PqDGbZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770822662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SwCAU52+L35MKGdsO2bzm/4m8JLQBuZzK9SKkr8/tI=;
	b=Uws9b1i5MxI6iEjBNVBRTN+xEeNcfIte3bFCydicrXtLegRJ23/cF3HSULmb7RwAwO2Unl
	IuT8uj73pKKU63Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF6703EA62;
	Wed, 11 Feb 2026 15:11:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /PhTLwWcjGkLGgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 11 Feb 2026 15:11:01 +0000
Message-ID: <207b2879-e022-4b50-837b-d536f8fcabcd@suse.de>
Date: Wed, 11 Feb 2026 16:10:49 +0100
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v3] ipv6: shorten reassembly timeout under fragment
 memory pressure
To: soukjin.bae@samsung.com, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org"
 <kuba@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
 "phil@nwl.cc" <phil@nwl.cc>, "coreteam@netfilter.org"
 <coreteam@netfilter.org>, "fw@strlen.de" <fw@strlen.de>,
 "pablo@netfilter.org" <pablo@netfilter.org>
References: <CGME20260211030048epcms1p54c6ed78458f57def8e3163032498ca00@epcms1p2>
 <20260211103243epcms1p2dd304fd11b28df04f4e680e8c90a7fc5@epcms1p2>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260211103243epcms1p2dd304fd11b28df04f4e680e8c90a7fc5@epcms1p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10725-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EA5F125759
X-Rspamd-Action: no action

On 2/11/26 11:32 AM, 배석진 wrote:
>   Changes in v3:
> - Fix build bot error and warnings
> - baseline update
> 
> 
> 
>  From c7940e3dd728fdc58c8199bc031bf3f8f1e8a20f Mon Sep 17 00:00:00 2001
> From: Soukjin Bae <soukjin.bae@samsung.com>
> Date: Wed, 11 Feb 2026 11:20:23 +0900
> Subject: [PATCH] ipv6: shorten reassembly timeout under fragment memory
>   pressure
> 
> Under heavy IPv6 fragmentation, incomplete fragment queues may persist
> for the full reassembly timeout even when fragment memory is under
> pressure.
> 
> This can lead to prolonged retention of fragment queues that are unlikely
> to complete, causing newly arriving fragmented packets to be dropped due
> to memory exhaustion.
> 
> Introduce an optional mechanism to shorten the IPv6 reassembly timeout
> when fragment memory usage exceeds the low threshold. Different timeout
> values are applied depending on the upper-layer protocol to balance
> eviction speed and completion probability.
> 
> Signed-off-by: Soukjin Bae <soukjin.bae@samsung.com>

Hello,

isn't this what net.ipv6.ip6frag_time does? In addition, the situation 
you described could be overcome by increasing the memory thresholds at 
net.ipv6.ip6frag_low_thresh and net.ipv6.ip6frag_high_thresh.

Please, let me know if I am missing something.

Thanks,
Fernando.

