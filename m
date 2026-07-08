Return-Path: <netfilter-devel+bounces-13710-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XD7ZMQ4STmolCgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13710-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 11:02:06 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A5D7236AF
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 11:02:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=IPMFtSyw;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13710-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13710-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9CD8301FD60
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B3F405C30;
	Wed,  8 Jul 2026 08:53:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A0405C27
	for <netfilter-devel@vger.kernel.org>; Wed,  8 Jul 2026 08:53:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500830; cv=none; b=S0z4d/Ww0TkX2dNsP/mupxNQG/qO+Xa0851QSCzOD3OAziXnxI8Pi2oBx+xmEW50VaNCwiQQHcMnqqza1cx0nptGagOy2CqyUqv8cmajfgc/Ri4P8HzB7elSAcWhBvopwjmh+5XAYWMC/YDm3gXRLhiyWP3OamyhIpZhhMGTgVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500830; c=relaxed/simple;
	bh=zOlEVYeGEnHUWgGiq13W7clte+Kjpp6lbmP5AtRSte4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cjY1Q4DI6/Tq76x03vEJfDFvAXNVaXVcTA1vMZL9otgtRnvOk9mg9EnKXaeVc6VSy8aiyWZHhYQteeOFWIyyIrBzt2EQWL5WDkIn5C+0G7mh1QiitRt9K+sotM/6o1xTgw1TdBGwCKzO/nUNoYiysmHFfs2gA0KW0SpIIBX0/xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IPMFtSyw; arc=none smtp.client-ip=91.218.175.180
Message-ID: <7298c8b1-be12-444d-b7ff-fd88bac48022@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783500814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hdkSyk5AuGaQo2OKjcPZNgt6Jx7S1vSumu70nXXh9iU=;
	b=IPMFtSyw5HezFJEHu/c2l5XBBfPimAsvCz5NU9Rs/W4y5iZxgvqAUdVX04q1HdFoqt+k+7
	9OEa2rwougvpcH7ICxzOhHoENlyyUlVJTUOGq/f9P7Wc5pVy52dLYRbu8LZILu4Z34d3NA
	8bA+vCxGYPfBxJtlW7lbT17x80Y6fSY=
Date: Wed, 8 Jul 2026 09:53:28 +0100
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH nf v2] ipvs: make destination flags atomic
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
 Simon Horman <horms@verge.net.au>, Julian Anastasov <ja@ssi.bg>,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>,
 Phil Sutter <phil@nwl.cc>, Alexander Frolkin <avf@eldamar.org.uk>
Cc: netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, stable@vger.kernel.org,
 Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>, Ao Wang <wangao@seu.edu.cn>,
 Xuewei Feng <fengxw06@126.com>, Qi Li <qli01@tsinghua.edu.cn>,
 Ke Xu <xuke@tsinghua.edu.cn>
References: <20260708060454.20534-1-zhaoyz24@mails.tsinghua.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260708060454.20534-1-zhaoyz24@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13710-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:zhaoyz24@mails.tsinghua.edu.cn,m:horms@verge.net.au,m:ja@ssi.bg,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:avf@eldamar.org.uk,m:netdev@vger.kernel.org,m:lvs-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:stable@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[vadim.fedorenko@linux.dev,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,mails.tsinghua.edu.cn,seu.edu.cn,126.com,tsinghua.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tsinghua.edu.cn:email,vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21A5D7236AF

On 08/07/2026 07:04, Yizhou Zhao wrote:
> IPVS destination schedulers read dest->flags from packet processing paths
> while holding only the RCU read lock.  The same word is updated by plain
> read-modify-write operations from connection accounting and destination
> update paths, for example ip_vs_bind_dest(), ip_vs_unbind_dest(), and
> __ip_vs_update_dest().
> 
> The RCU read lock protects the destination lifetime, but it does not
> serialize accesses to dest->flags.  A plain load can therefore race with a
> plain write, and concurrent plain read-modify-write updates can lose an
> AVAILABLE or OVERLOAD bit update.
> 
> KCSAN reports the race with a standard IPVS configuration using the SH
> scheduler and a destination with u_threshold set:
> 
>    BUG: KCSAN: data-race in __ip_vs_update_dest / ip_vs_sh_schedule
>    write to ... of 4 bytes by task ipvs_cfg:
>      __ip_vs_update_dest
>      ip_vs_edit_dest
>      do_ip_vs_set_ctl
>      __x64_sys_setsockopt
>    read to ... of 4 bytes by task ipvs_churn:
>      ip_vs_sh_schedule
>      ip_vs_schedule
>      tcp_conn_schedule
>      ip_vs_in_hook
>      tcp_connect
>      __x64_sys_connect
>    value changed: 0x00000003 -> 0x00000001
> 
> Convert dest->flags to atomic_t and use atomic_read(), atomic_or(), and
> atomic_and() for all destination flag tests and updates.  This preserves
> the existing 32-bit field size while making the flag updates atomic RMW
> operations and making readers use atomic accesses.  Valid minimum-sized
> IPVS configuration and scheduling paths are unchanged; only the
> synchronization of the destination status flags changes.
> 
> This is limited to synchronizing the flags word itself.  It does not add
> ordering for readers, and it does not make scheduler decisions operate on a
> fresh snapshot of all destination state; readers may still observe stale
> state in the usual IPVS fast path. This keeps the packet fast path free
> of additional barriers or locks.
> 
> Fixes: eba3b5a78799d ("ipvs: SH fallback and L4 hashing")
> Cc: stable@vger.kernel.org
> Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
> Reported-by: Ao Wang <wangao@seu.edu.cn>
> Reported-by: Xuewei Feng <fengxw06@126.com>
> Reported-by: Qi Li <qli01@tsinghua.edu.cn>
> Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
> Assisted-by: Claude-Code:GLM-5.2
> Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
> ---
> Changes in v2:
> - Clarify that the patch fixes the flags data race and RMW lost updates,
>    but does not prevent readers from observing stale scheduling state.
> - Fix checkpatch logical-continuation warnings.
> - Suggested by Julian Anastasov.
> - Link to v1: https://lore.kernel.org/netfilter-devel/20260707085706.96322-1-zhaoyz24@mails.tsinghua.edu.cn/
> ---
> diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> index 49297fec448a..bb969738ed73 100644
> --- a/include/net/ip_vs.h
> +++ b/include/net/ip_vs.h
> @@ -972,7 +972,7 @@ struct ip_vs_dest {
>   	u16			af;		/* address family */
>   	__be16			port;		/* port number of the server */
>   	union nf_inet_addr	addr;		/* IP address of the server */
> -	volatile unsigned int	flags;		/* dest status flags */
> +	atomic_t		flags;		/* dest status flags */
>   	atomic_t		conn_flags;	/* flags to copy to conn */
>   	atomic_t		weight;		/* server weight */
>   	atomic_t		last_weight;	/* server latest weight */

It would be quite interesting to look at pahole output of ip_vs_dest
structure after the modification, it may have some "areas to improve"
for the performance

