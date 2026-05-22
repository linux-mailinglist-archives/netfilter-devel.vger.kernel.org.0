Return-Path: <netfilter-devel+bounces-12752-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aO8CKJYlEGoYUQYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12752-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 11:44:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D28A5B168F
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 11:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C00F3301FB08
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 09:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162AC3A6B6E;
	Fri, 22 May 2026 09:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tSdABYGn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L4BTgCO7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tSdABYGn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L4BTgCO7"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E26234388A
	for <netfilter-devel@vger.kernel.org>; Fri, 22 May 2026 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442323; cv=none; b=jX3Gj2iB8dG+P1Lt6AQ6H3qpuIPhsocggstA0lrQcuy37a+WvtvGA0ws5sBLj+iqJV/1h6NECHt0Q3Ofh4p/yPfUSLk3T0pIiUCTuq4zXJipFIGqMWjtcW3vQnx5EWYCCbijl53GAwzETtrjBpaQcqs79e7youPpIuUxEs041Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442323; c=relaxed/simple;
	bh=1VU6ncW2hc/ljGJnqS8ZNXweAt7f4LuYILEtfGqX5l0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sp+mkvbmR9cx7gKEP+dec1jkUvVxZmo/gOipEdy22GFCqnI4waiARfWiMJDViGjcpQ8TlfDV5jb4qE3yNWyFO7Hb1en6z/+WfUe+oQ830Sf1RY6Zlekj8mHC5tWPlcJ6msd6rhIGrcJO5UXcW/MCNmp7Y1DhKrqerHZ6YFJ5e9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tSdABYGn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L4BTgCO7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tSdABYGn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L4BTgCO7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 200706BBB0;
	Fri, 22 May 2026 09:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779442319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpNBVVsPTHVGPdI/ZoLRsQRqsXWuHMECaWEuXWtOvCE=;
	b=tSdABYGnWBO9iQlNTvgxn4wCZqnBtZvi2Mc1rFtM/KHWQ1DcOsBVUqq1hcvPrVBsOvNZtv
	Px5tHBWB/ERbh2yyN8+Y8VMFpOUXUYfUZR+Z6k+q1VnoXNCt13pVyzSyqFOvsmxSnoHEXM
	l+LQYxNbXspszmQc9bZ3kImKpU0sQ7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779442319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpNBVVsPTHVGPdI/ZoLRsQRqsXWuHMECaWEuXWtOvCE=;
	b=L4BTgCO7Ir4r8TcnkeEq3jcQNR8vzleAB4rmkvNT8Fi/82QlE637aEk/vSYVnB0bnRBqXe
	QEHme0OIOI9joTAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779442319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpNBVVsPTHVGPdI/ZoLRsQRqsXWuHMECaWEuXWtOvCE=;
	b=tSdABYGnWBO9iQlNTvgxn4wCZqnBtZvi2Mc1rFtM/KHWQ1DcOsBVUqq1hcvPrVBsOvNZtv
	Px5tHBWB/ERbh2yyN8+Y8VMFpOUXUYfUZR+Z6k+q1VnoXNCt13pVyzSyqFOvsmxSnoHEXM
	l+LQYxNbXspszmQc9bZ3kImKpU0sQ7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779442319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HpNBVVsPTHVGPdI/ZoLRsQRqsXWuHMECaWEuXWtOvCE=;
	b=L4BTgCO7Ir4r8TcnkeEq3jcQNR8vzleAB4rmkvNT8Fi/82QlE637aEk/vSYVnB0bnRBqXe
	QEHme0OIOI9joTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A302593A8;
	Fri, 22 May 2026 09:31:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4vb7BI0iEGqRSgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 22 May 2026 09:31:57 +0000
Message-ID: <9e54bec7-0a03-4a99-8aa0-20301ab6b36f@suse.de>
Date: Fri, 22 May 2026 11:31:32 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nf] netfilter: ebtables: fix OOB read in
 compat_mtw_from_user
To: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Cc: Yuan Tan <yuantan098@gmail.com>, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Luxiao Xu <rakukuip@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>
References: <20260520080119.12627-1-fw@strlen.de>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260520080119.12627-1-fw@strlen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FREEMAIL_CC(0.00)[gmail.com,lzu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12752-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,strlen.de:email]
X-Rspamd-Queue-Id: 9D28A5B168F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 10:01 AM, Florian Westphal wrote:
> Luxiao Xu says:
> 
>   The function compat_mtw_from_user() converts ebtables extensions from
>   32-bit user structures to kernel native structures. However, it lacks
>   proper validation of the user-supplied match_size/target_size.
> 
>   When certain extensions are processed, the kernel-side translation
>   logic may perform memory accesses based on the extension's expected
>   size. If the user provides a size smaller than what the extension
>   requires, it results in an out-of-bounds read as reported by KASAN.
> 
>   This fix introduces a check to ensure match_size is at least as large
>   as the extension's required compatsize. This covers matches, watchers,
>   and targets, while maintaining compatibility with standard targets.
> 
> AFAIU this is relevant for matches that need to go though
> match->compat_from_user() call.  Those that use plain memcpy with the
> user-provided size are ok because the caller checks that size vs the
> start of the next rule entry offset (which itself is checked vs. total
> size copied from userspace).
> 
> The ->compat_from_user() callbacks assume they can read compatsize bytes,
> so they need this extra check.
> 
> Based on an earlier patch from Luxiao Xu.
> 
> Fixes: 81e675c227ec ("netfilter: ebtables: add CONFIG_COMPAT support")
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!

