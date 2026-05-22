Return-Path: <netfilter-devel+bounces-12756-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IymF5wyEGqVUwYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12756-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 12:40:28 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4DF5B252D
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 12:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA993010D96
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 10:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454D63CAA3B;
	Fri, 22 May 2026 10:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gCLxBYTH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oQ87CRuK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gCLxBYTH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="oQ87CRuK"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0FD38E13F
	for <netfilter-devel@vger.kernel.org>; Fri, 22 May 2026 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445921; cv=none; b=fYoXEpQV990pankTzU83iJiE5xRPq7/d328AwQAqGOJalh4r7hTU2D1vhnY1y7CW4yWgbBv5kfAteWzOx90ge1dM3yJf1XRi9taKbazsdYbpFbWMtfIdSWlHn8SPaqnjan5td7iXh4LRpS6EbBJYQrOruUStjFgdS85eSCciiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445921; c=relaxed/simple;
	bh=QkwbOjF0K4VX9m+D5JCG0tT6hsh7PFJ7NBw+H7lqEqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueQHSdbg9i6eiZbwCbp2QKkSh8DnkH7/qf8BmOn/+wuOidtOLnOabTGvZSjRlRA5FBmXNpR22wS5RYCLGX8EgcpzwIdHdPEmY7abXwjNh6vmWzKxuTmTBTFGot9cHqiuCVj7cl20tD9H7z2cVsAJPf9yY+2wxLHByn/tjCcNiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gCLxBYTH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oQ87CRuK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gCLxBYTH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=oQ87CRuK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1CF4367BF6;
	Fri, 22 May 2026 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779445918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UDe0q+CmzFBUNWfuGnEvLRFm56plwL+a5vdz9HGFkk=;
	b=gCLxBYTHfTsjt9kI5fiUzayyZUjnYA2bK9uVVSkdcaRdtyx0WXOtXPnEIqGRPTTSg/xHfJ
	y8ArFsaekRNS9d0aYx3W0mZUsljqgTRVnPzIPsnFJ3qk4T8VxuDVtaoSTDAfdGX0SXDmqK
	fgrc7hJQ5tNgDMlyKIHvx4LppBnYF4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779445918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UDe0q+CmzFBUNWfuGnEvLRFm56plwL+a5vdz9HGFkk=;
	b=oQ87CRuKsGOIFPq5aBYCTzODBxYLlDzXSPmyDDqRQABMgf884lmYorX7+HenBN+GmLM4qt
	wU8+uONrDfXBi+Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779445918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UDe0q+CmzFBUNWfuGnEvLRFm56plwL+a5vdz9HGFkk=;
	b=gCLxBYTHfTsjt9kI5fiUzayyZUjnYA2bK9uVVSkdcaRdtyx0WXOtXPnEIqGRPTTSg/xHfJ
	y8ArFsaekRNS9d0aYx3W0mZUsljqgTRVnPzIPsnFJ3qk4T8VxuDVtaoSTDAfdGX0SXDmqK
	fgrc7hJQ5tNgDMlyKIHvx4LppBnYF4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779445918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+UDe0q+CmzFBUNWfuGnEvLRFm56plwL+a5vdz9HGFkk=;
	b=oQ87CRuKsGOIFPq5aBYCTzODBxYLlDzXSPmyDDqRQABMgf884lmYorX7+HenBN+GmLM4qt
	wU8+uONrDfXBi+Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00D76593A8;
	Fri, 22 May 2026 10:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E6ukIJkwEGr3BQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 22 May 2026 10:31:53 +0000
Message-ID: <cb6d6451-922a-419a-87f5-3f2aca5b04ad@suse.de>
Date: Fri, 22 May 2026 12:31:46 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf] netfilter: xt_cpu: prefer raw_smp_processor_id
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org,
 syzbot+690d3e3ffa7335ac10eb@syzkaller.appspotmail.com
References: <20260519183430.20726-1-fw@strlen.de>
 <35756825-5349-468c-881f-e88b80f0729b@suse.de> <ahAvhJpc8RLhXEzV@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <ahAvhJpc8RLhXEzV@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12756-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel,690d3e3ffa7335ac10eb];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BA4DF5B252D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 12:27 PM, Florian Westphal wrote:
> Fernando Fernandez Mancera <fmancera@suse.de> wrote:
>> I see I can use the compat layer to configure NFQUEUE target see:
>>
>> # Warning: table ip filter is managed by iptables-nft, do not touch!
>> table ip filter {
>> 	chain FORWARD {
>> 		type filter hook forward priority filter; policy accept;
>> 		tcp dport 80 counter packets 0 bytes 0 xt target "NFQUEUE"
>> 	}
> 
> Please send a patch.

Sure!

Thanks Florian!

