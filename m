Return-Path: <netfilter-devel+bounces-13393-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hxSpE9ktOWoVoAcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13393-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 14:43:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3856AF84B
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 14:43:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TgWuS52l;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13393-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13393-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA2C83026C93
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 12:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DA63ABDB3;
	Mon, 22 Jun 2026 12:41:51 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4647377543;
	Mon, 22 Jun 2026 12:41:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132111; cv=none; b=Lg0p+1cp+UwDa1k1o4QqP49lDVBdJq/0321Ez6IyNH0RY5GmWZonDxnzfGVdQlu6RgpqqO7aWRdTQCIyDeDBv3Ps+ugKzlxKwt8a9SKNZ/lluNO69J/tzPVM7h/RfidCXrxZffJZx8jVV8yBa2h4CMLQRNrMjai2zfkwLbgligc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132111; c=relaxed/simple;
	bh=jfDMjVa+wKbuMF1RPWDXVqXHPxX0b8oTycJboxEMxfc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=n9Plxk/Y/cfVBFvOMttDZpOj7Xray9bGaRhTNYiGQd1XbGU2WI7mmFPHIxpGiHdSTUtyKviOd7evTNgvipqWNBX7B6h8iHqAcbNH/hiCbXVXvOSxHkDchrc4n/Kk/YN/ftCYtVDfkHVMkwETB6I+CfuQGVXO6znhx2uDtIyQU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgWuS52l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307BF1F000E9;
	Mon, 22 Jun 2026 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782132110;
	bh=4iLJSoipRtnfr7If0YiOJXIrBoD2V1Vbzf8qdLxnze8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=TgWuS52l663sbBK8AHbsx0sACO/DY6gtEPvAMGDD52zZjBnTurCqDCAV3umZJYBMI
	 db2MUkFiQvD1HC4OHteQXFXL6LOmRgSdcuf3U86tcZCsHg8Jw2MkS/m+PDcuDIy50P
	 cAVUKxf++43rr+ZXz2U4l3aj3yLj+WIVRcNQlydgghCcb6YwzvlC3PkbDy0eqF68dF
	 EDdlV1NKJ+FaoPlLbeMtgbhucF9UOevE4qNZmgdj9QMzhluU9rUsOSaYzUv6F4srUs
	 ebx/An9RumMHSSbIju0SSEH0Vm9uYiZul73qVRbrOrbumDixsMCH265p0y6dzm9KTE
	 jo/1zZnvQg13g==
Content-Type: multipart/mixed; boundary="===============6336517358572342155=="
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <91d16e0bd3107b1ecd332465cb9b68bb1655446bfc17eb06748457b2f02a73ef@mail.kernel.org>
In-Reply-To: <20260622120515.137082-5-mahe.tardy@gmail.com>
References: <20260622120515.137082-5-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v8 4/7] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,edumazet@google.com,john.fastabend@gmail.com,jordan@jrife.io,kuba@kernel.org,martin.lau@linux.dev,netdev@vger.kernel.org,netfilter-devel@vger.kernel.org,pabeni@redhat.com,yonghong.song@linux.dev,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 12:41:50 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-13393-lists,netfilter-devel=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,vger.kernel.org,redhat.com,meta.com];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:martin.lau@kernel.org,m:eddyz87@gmail.com,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C3856AF84B

--===============6336517358572342155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> new file mode 100644
> index 000000000000..f4e5b883d4c8
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c

[ ... ]

> +static void read_icmp_errqueue(int sockfd, int expected_code)
> +{

[ ... ]

> +	for (; cm; cm = CMSG_NXTHDR(&msg, cm)) {
> +		if (cm->cmsg_level != IPPROTO_IP || cm->cmsg_type != IP_RECVERR)
> +			continue;

[ ... ]

> +	}
> +
> +	ASSERT_FAIL("no IP_RECVERR/IPV6_RECVERR control message found");

This isn't a bug, but the failure string names both IP_RECVERR and
IPV6_RECVERR:

	ASSERT_FAIL("no IP_RECVERR/IPV6_RECVERR control message found");

while the loop above only matches IPv4:

	if (cm->cmsg_level != IPPROTO_IP || cm->cmsg_type != IP_RECVERR)
		continue;

and the caller is AF_INET only (start_server(AF_INET, ...) with a
struct sockaddr_in).

Should the IPV6_RECVERR part of the string be dropped to match what the
code actually inspects?

> +}

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27951892371
--===============6336517358572342155==--

