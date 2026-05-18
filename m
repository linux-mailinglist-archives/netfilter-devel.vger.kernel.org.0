Return-Path: <netfilter-devel+bounces-12659-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHY0CNwVC2o5/wQAu9opvQ
	(envelope-from <netfilter-devel+bounces-12659-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 15:36:28 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A7C56DBC2
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 15:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 694DE300A66F
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 13:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD15F481AB9;
	Mon, 18 May 2026 13:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBLhTVGy"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70EC3783C3;
	Mon, 18 May 2026 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111290; cv=none; b=BoKTNR2I+uaESjJc6VoWTQcCnCiiaG6EepdrKx1ukVPChEfte/r2RcSCgh8ndREfHUOY9f/Z8bkw4QVUKtPTNrdnK+tq32zlmmStmvCdBNzhylURW4p57VOUrr9GsPd53YX70wj0AmuU3GqYIDfY1HvNlzVn5oqotRffHiMiu9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111290; c=relaxed/simple;
	bh=QHiUpXnAR/KqTW5o5Gu6p55NaGWmjO/7tdseJwmKPbs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jvpoWNj/tBXI90a9X1YitcJ+KAtrIjdK90azeug6aPbdc24v+i3yLWmeqNq0gCJWX7XQoDTUXdw4m/pGlz85evRplCrEXQ3tsmJV3IiVQ+15xJkDMPL0LQJ/gKMQvDhPoFTekr0WLzkELnkyMRssjuImp/2Zkjy0dB0lFug67uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBLhTVGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A0EC2BCB7;
	Mon, 18 May 2026 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111288;
	bh=QHiUpXnAR/KqTW5o5Gu6p55NaGWmjO/7tdseJwmKPbs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=uBLhTVGytskOjnipUOuezgFAj/4/8mdK5cg8QMC35aiIWds7nDPpLUmG0MyBSfamh
	 uk+03nCOhk89vgKMXXi9vSMSCHeMONJThpaLH2+gyYi5GSuZxCL2ZnkZZ2CNvLf6UC
	 03RbQE1pTwEHIs0kpMB/zUQo9Oljbo+SWoh1rJ+hvAj4kMmnbHz6kiF2r8eJBfGFun
	 SI2jho02WGy81wTZE3xt90XBj1IA2pXJsUOWVe+RANqmfxxgGsOgDMVUqyEVRH+osQ
	 gPvrCqD4D35VjpTgpJ6g1ymxIrSAu9YDtnk3Yq5vKPnXvITFFP4VL1oXYbgnGelcws
	 cK83aFgtTRhFw==
Content-Type: multipart/mixed; boundary="===============0789689690670714085=="
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <dc63930101e50f36995ef7b487096c6580e7eaa75594ab083ff6e0bc28eeb046@mail.kernel.org>
In-Reply-To: <20260518122842.218522-4-mahe.tardy@gmail.com>
References: <20260518122842.218522-4-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v6 3/6] bpf: add bpf_icmp_send kfunc
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,yonghong.song@linux.dev,jordan@jrife.io,netdev@vger.kernel.org,netfilter-devel@vger.kernel.org,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 18 May 2026 13:34:48 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12659-lists,netfilter-devel=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,vger.kernel.org,google.com,redhat.com,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netfilter-devel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[kernel.org:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 15A7C56DBC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============0789689690670714085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714..843fa775596b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -12464,6 +12466,110 @@ __bpf_kfunc int bpf_xdp_pull_data(struct xdp_md *x, u32 len)
>  	return 0;
>  }
>
> +static DEFINE_PER_CPU(bool, bpf_icmp_send_in_progress);
> +
> +/**
> + * bpf_icmp_send - Send an ICMP control message
> + * @skb_ctx: Packet that triggered the control message
> + * @type: ICMP type (only ICMP_DEST_UNREACH/ICMPV6_DEST_UNREACH supported)
> + * @code: ICMP code (0-15 for IPv4, 0-6 for IPv6)
> + *
> + * Sends an ICMP control message in response to the packet. The original packet
> + * is cloned before sending the ICMP message, so the BPF program can still let
> + * the packet pass if desired.
> + *
> + * Currently only ICMP_DEST_UNREACH (IPv4) and ICMPV6_DEST_UNREACH (IPv6) are
> + * supported.
> + *
> + * Recursion protection: If called from a context that would trigger recursion
> + * (e.g., root cgroup processing its own ICMP packets), returns -EBUSY on
> + * re-entry.
> + *
> + * Return: 0 on success, negative error code on failure:
> + *         -EINVAL: Invalid code parameter
> + *         -EBADMSG: Packet too short or malformed
> + *         -ENOMEM: Memory allocation failed
> + *         -EBUSY: Recursion detected
> + *         -EHOSTUNREACH: Routing failed
> + *         -EPROTONOSUPPORT: Non-IP protocol
> + *         -EOPNOTSUPP: Unsupported ICMP type
> + */
> +__bpf_kfunc int bpf_icmp_send(struct __sk_buff *skb_ctx, int type, int code)
> +{
> +	struct sk_buff *skb = (struct sk_buff *)skb_ctx;
> +	struct sk_buff *nskb;
> +	bool *in_progress;
> +
> +	in_progress = this_cpu_ptr(&bpf_icmp_send_in_progress);
> +	if (*in_progress)
> +		return -EBUSY;

Is the per-CPU recursion protection flag safe without disabling
preemption or bottom-halves?

Since cgroup_skb egress programs execute in process context, they can be
interrupted by network RX softirqs on the same CPU. If a task sets
*in_progress to true and is immediately preempted by a softirq that runs a
TC ingress program calling bpf_icmp_send(), it will read the same per-CPU
flag and spuriously fail with -EBUSY.

This was raised in v5 by the Sashiko AI bot:

    Since cgroup_skb egress programs execute in process context, they can be
    interrupted by network RX softirqs on the same CPU.

    If a task sets *in_progress to true and is immediately preempted by a
    softirq that runs a TC ingress program calling bpf_icmp_send(), will it
    read the same per-CPU flag and spuriously fail with -EBUSY?

    Does this critical section need to run with bottom-halves disabled?

https://lore.kernel.org/bpf/20260515202358.20252C2BCB0@smtp.kernel.org/

Would using two separate per-CPU flags (one for softirq context, one for
process context) or disabling bottom-halves around the critical section
address this race condition?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26034287312
--===============0789689690670714085==--

