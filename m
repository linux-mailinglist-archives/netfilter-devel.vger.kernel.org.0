Return-Path: <netfilter-devel+bounces-13284-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tcf/Mq3rMGoEYwUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13284-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 08:22:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A31D68C7AF
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 08:22:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=htjfmaR3;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13284-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13284-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F3838316F311
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 Jun 2026 06:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC713DBD46;
	Tue, 16 Jun 2026 06:19:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670C23D9DAA;
	Tue, 16 Jun 2026 06:19:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781590767; cv=none; b=GyYO7kCWBK594soPQcnpWAFiLYS5jcVnEro+okY5Xu2dHz5uWV+Ijl7Gj2vetjw5tVpfraJfClpt3PNLVY2JmeXnmJ6Z7RuIbhIg3rmDCRi4gJqZUFOWpzUrNcNvmIZcgoTsNhsQCUcjckbGehoaPYPYLcjjNtFHBccO2Bm8/vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781590767; c=relaxed/simple;
	bh=Vo2k0LfQVac0ODGfCOErn06Hel+nUpmTzPJj2QnKDmg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uC2307kr76EarK6VvMWyd/igE7m16VX68cDQsgUQZRyoKiJi37uw/Tn1X4nrcOzEgwBjJQIFYIhx+GX3aDrwT/QEwB0fAWYQOeGyEMEDB8JTQB8o362ggWVvLG0t+3NUnGb1cq65EH2x19OleY/86SiAGAyIrvv4Ejiyd38iYCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htjfmaR3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD541F000E9;
	Tue, 16 Jun 2026 06:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781590766;
	bh=z6vwvm9C81RodtkTn+jwD/0+BlSWKsFhyWVVK8Ua9uc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=htjfmaR3GZyzSLoVBiZAF9YwFzYoSSh45+Ne0b//4YHYG8xQzoqxL6mr8hlwhmyHJ
	 SSSmX09DUawlYf7hE76Udk1OfYM7r4XIKZmW7m4JhMeRvCOMqu8DJAne/1uEPFIdtT
	 TEHvq8A3ysieu0KgPuYGtWdc5VTQRFerkjDpLzLR9fRV5pePnxlsrvxHxq0AcxrZLF
	 w4NRKzcKZYdIm0HkVYQzj/Ul1Zm6P+BmGqUxlrrzUVvmMqWmtQBURDZSk4itcKqoXh
	 K6Hfx9KNy7WhjiHddj+hcTS2IWscQ2aIpRBYv/bapCvAV/L9MO8dbDlc1ai0tLNnSB
	 0gqHAdzAMArlg==
Content-Type: multipart/mixed; boundary="===============5462730251977183201=="
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b1f9eebb7c2252b81dee09b0dc0d488e44c22d1d31f8fe51c803e199f2c87aaa@mail.kernel.org>
In-Reply-To: <c4c898dd23181b676ebf6b6b4d9c54f51bb69c75.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
References: <c4c898dd23181b676ebf6b6b4d9c54f51bb69c75.1781586477.git.chenyy23@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover small conntrack opts error writes
From: bot+bpf-ci@kernel.org
To: chenyy23@mails.tsinghua.edu.cn,bpf@vger.kernel.org,netfilter-devel@vger.kernel.org
Cc: chenyy23@mails.tsinghua.edu.cn,pablo@netfilter.org,fw@strlen.de,phil@nwl.cc,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,kartikey406@gmail.com,coreteam@netfilter.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 16 Jun 2026 06:19:25 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,netfilter.org,strlen.de,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,iogearbox.net,linux.dev,etsalapatis.com,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-13284-lists,netfilter-devel=lfdr.de,bpf-ci];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chenyy23@mails.tsinghua.edu.cn,m:bpf@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:kartikey406@gmail.com,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[36];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tsinghua.edu.cn:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2A31D68C7AF

--===============5462730251977183201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Cover small conntrack opts error writes
>
> Add a conntrack kfunc regression check for opts__sz values that do not
> cover opts->error. The BPF program initializes opts->error with a guard
> value, calls the lookup and allocation kfuncs with opts__sz set to
> sizeof(opts->netns_id), and verifies that the guard is still intact
> after the kfunc returns NULL.
>
> Without the conntrack wrapper guard, the kfunc error path overwrites
> that guard with -EINVAL even though the verifier checked only the first
> four bytes of the options object.
>
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

This is a regression test for the out-of-bounds opts->error write that
is fixed in the prior series commit 86b813c37ee5 ("bpf: Guard conntrack
opts error writes"), but it carries no Fixes: tags.

A regression test usually carries the same Fixes: tags as the fix it
covers, so it gets backported to stable alongside that fix. The two new
test cases map onto the two commits that introduced the kfuncs: the
small-opts lookup case covers the lookup kfunc and the small-opts alloc
case covers the alloc kfunc.

Should this include:

  Fixes: b4c2b9593a1c ("net/netfilter: Add unstable CT lookup helpers for XDP and TC-BPF")
  Fixes: d7e79c97c00c ("net: netfilter: Add kfuncs to allocate and insert CT")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27597459087
--===============5462730251977183201==--

