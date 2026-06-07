Return-Path: <netfilter-devel+bounces-13108-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6CBFLDniJWp1NAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13108-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 07 Jun 2026 23:27:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27402651A17
	for <lists+netfilter-devel@lfdr.de>; Sun, 07 Jun 2026 23:27:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dah0oAdc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GgzvyVrj;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Dah0oAdc;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GgzvyVrj;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13108-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13108-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 316BF30048C1
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Jun 2026 21:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B4F3203B6;
	Sun,  7 Jun 2026 21:27:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A731715F
	for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2026 21:27:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780867639; cv=none; b=qW5VZbTPi0KJAmDUg06vQ4o9XGtxCJx37wvTD//qZ7nYVSoVjZ3rjYsuUoqUP2GqR8byQHk/HVRhrW860YOB/PoRwf68LH34dZ3zTYNQNlAqhCYuOYtue9a+tAjEMz6I+1CS4gYMDNFM85nunowk1onAan54Lv+chsoS1nahJdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780867639; c=relaxed/simple;
	bh=rP3OXPQOmzfdOFiSl6nk7FxuoG034U4hR2rzE0x2Rfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KfR8ynSX7bA4w/jF0V/XJ6e7i31k8WWML1lOjKBNCrJx1XXMo2I0V3fJixvHsg1WYHRl1V69XEPiBlddk6Lt0v5U5CB4N48gg5kUHmBtiMmPQ8q+kmhCEZUPv7a1xe3LyoT1PjNnvVV4h0z3XszOtyfYl2zlASLxD1oTBWKnyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dah0oAdc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GgzvyVrj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dah0oAdc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GgzvyVrj; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8608B6A900;
	Sun,  7 Jun 2026 21:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780867636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7mIFaSxwp1nM31lrLsxAp1j/TNU9+RaPeFN/tv5Bik=;
	b=Dah0oAdcYvrRsqllVds7khL/rmSZnUG3wO/3adJtXocXdBUUa4mWd8agcGVUwsXFB9xW2f
	9n1BdmN+zy1HT7wQBUZOeg8rBA1vL467B92ECjdebNu1iDSoxRS+NytURlDyx5iTTraC1x
	UyP4qqfpSpbfye9uKUN6KVNtg3QMmrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780867636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7mIFaSxwp1nM31lrLsxAp1j/TNU9+RaPeFN/tv5Bik=;
	b=GgzvyVrj8sY8KOTn227D3Jh9HGsSMMyn+5/a8VPtA+KxnQng4Z8i2vf6ybx85K9XUeDy9b
	FOTKOit//l1efDDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780867636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7mIFaSxwp1nM31lrLsxAp1j/TNU9+RaPeFN/tv5Bik=;
	b=Dah0oAdcYvrRsqllVds7khL/rmSZnUG3wO/3adJtXocXdBUUa4mWd8agcGVUwsXFB9xW2f
	9n1BdmN+zy1HT7wQBUZOeg8rBA1vL467B92ECjdebNu1iDSoxRS+NytURlDyx5iTTraC1x
	UyP4qqfpSpbfye9uKUN6KVNtg3QMmrs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780867636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7mIFaSxwp1nM31lrLsxAp1j/TNU9+RaPeFN/tv5Bik=;
	b=GgzvyVrj8sY8KOTn227D3Jh9HGsSMMyn+5/a8VPtA+KxnQng4Z8i2vf6ybx85K9XUeDy9b
	FOTKOit//l1efDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE8BA779A7;
	Sun,  7 Jun 2026 21:27:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LtfyLjPiJWq7RAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 07 Jun 2026 21:27:15 +0000
Message-ID: <ab136215-157e-491a-b9cb-ba9c1d3c982d@suse.de>
Date: Sun, 7 Jun 2026 23:27:03 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] netfilter: synproxy: fix unaligned access to TCP
 timestamp option
To: Rosen Penev <rosenp@gmail.com>, netfilter-devel@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 "open list:NETFILTER" <coreteam@netfilter.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260607164447.39700-1-rosenp@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260607164447.39700-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13108-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.de:mid,suse.de:from_mime,suse.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 27402651A17

On 6/7/26 6:44 PM, Rosen Penev wrote:
> synproxy_tstamp_adjust() reads and writes the TSval and TSecr fields of
> the TCP Timestamp option via direct __be32 pointer dereferences. These
> fields are at byte offsets 2 and 6 within the option, which are only
> 2-byte aligned — not 4-byte aligned for __be32 access.
> 
> Replace with get_unaligned_be32() / put_unaligned_be32() to safely
> handle the unaligned access on strict-alignment architectures.
> 
> Assisted-by: opencode:big-pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
Hi,

as mentioned on [1] this was already fixed in [2]..

[1] 
https://lore.kernel.org/netdev/a8cfeb06-6ffb-49f2-a14d-c5a50bc4e5be@suse.de/

[2] 
https://lore.kernel.org/netfilter-devel/20260525124450.6043-4-fmancera@suse.de/

Thanks,
Fernando.

